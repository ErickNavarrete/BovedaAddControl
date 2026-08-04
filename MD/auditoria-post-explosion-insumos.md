# Auditoría + optimización de rendimiento: `PostExplosionInsumos` / `PostExplosionInsumosAgrupado`

## Contexto

Auditoría de por qué `PostExplosionInsumos` (`API/Controllers/Presupuestos/PresupuestoExplosionInsumosController.cs:63-513`) debe correr dentro de `_unitOfWork.ExecuteInTransactionAsync`, junto con dos optimizaciones de rendimiento aplicadas al mismo método (no afectan la transacción ni el comportamiento del endpoint).

El mismo razonamiento y las mismas dos optimizaciones se aplicaron también a su endpoint hermano `PostExplosionInsumosAgrupado` (`API/Controllers/Presupuestos/PresupuestoExplosionInsumoAgrupadoController.cs:43-473`), que agrupa insumos por partida en vez de por concepto pero sigue exactamente la misma estructura (carga inicial, loop de procesamiento dentro de `ExecuteInTransactionAsync`, upsert final). Ver sección "Aplicación a `PostExplosionInsumosAgrupado`" al final de este documento para el detalle específico de ese controlador.

---

## Por qué la transacción es correcta (no debe quitarse)

**Implementación** (`EF/UnitOfWork/UnitOfWork.cs:15-33`): `ExecuteInTransactionAsync` usa `CreateExecutionStrategy()` + `BeginTransactionAsync()`; hace `CommitAsync()` al terminar sin errores y, ante **cualquier** excepción, hace `RollbackAsync()` y re-lanza (`throw;`, no la traga). Es una transacción real de EF Core, no un wrapper cosmético.

**Por qué aplica aquí:** todos los servicios invocados dentro del bloque (`_explosionService`, `_presupuestoConceptoService`, `_presupuestoMatrizService`, `_presupuestoMatrizConceptoService`, `_explosionInsumoService`, `_presupuestoInsumoPrecioService`, `_insumoService`, etc.) son `AddScoped` y sus repositorios inyectan la misma instancia de `AddControlErpContext` (scoped por request). Como `UnitOfWork` también es `AddScoped` y recibe ese mismo `DbContext`, el `BeginTransactionAsync` envuelve **todos** los `SaveChangesAsync` que disparan esos 6+ servicios sobre 6+ tablas (`Explosiones`, `PresupuestosConceptos`, `PresupuestosMatriz`, `PresupuestosMatrizConceptos`, `ExplosionesInsumos`, `PresupuestosInsumosPrecios`).

**Qué se rompería sin ella:** el método marca flags `Actualizado = true` en memoria sobre `conceptosList`/`matrizInsumosList`/`basicosList` (líneas 193, 326, 354) y los persiste en batch (`UpdateRange`/`UpdateBulk`, líneas 364-372) **antes** de la validación de cantidad negativa (línea 457) y de la inserción final de `ExplosionesInsumos` (línea 493-496). Si el proceso fallara después de esos updates pero antes de completar el upsert final:
- Los conceptos/insumos quedarían marcados `Actualizado = true` para siempre, sin que exista el registro `ExplosionesInsumo` correspondiente.
- El filtro `conceptosNoActualizados` (línea 153) los saltaría en toda ejecución futura → insumos permanentemente subcontados, silenciosamente, sin error visible.
- Precios insertados vía `AddBulk` (línea 383) podrían persistir aunque su vinculación (`IdPrecio`) a las filas de explosión fallara después.

Este es exactamente el escenario que una transacción de BD está diseñada para prevenir: todo-o-nada ante fallas parciales en una secuencia de escrituras relacionadas.

**Precedente en el propio código:** `PresupuestoExplosionInsumoAgrupadoController.cs:88` (el endpoint hermano "Agrupado") aplica el mismo patrón, con el mismo comentario de intención y el mismo mecanismo de disparo de rollback (`ExplosionProcesoException`, lanzada en vez de `return` para garantizar que el `throw` atraviese la transacción). Es el único patrón `ExecuteInTransactionAsync` en todo el repo, reservado deliberadamente para este tipo de recálculo multi-tabla atómico — a diferencia de otros endpoints bulk (`PresupuestoBulkController.PostConceptosBulk`, `PresupuestoMatrizController.PutMatrizBulk`) que hacen múltiples escrituras secuenciales **sin** transacción y sin protección ante fallos parciales.

**Conclusión:** la transacción no es opcional ni un adorno defensivo genérico — es la única barrera contra un bug de atomicidad real. Debe mantenerse.

---

## Optimización 1 — Eliminar el reload redundante de `ExplosionesInsumo`

Entre la carga inicial (`explosionExistentePreLoop`, línea 157) y el paso 7 (línea ~425), lo único que cambió en la tabla `ExplosionesInsumos` fue el `DeleteRangeAsync(idsExplosionInsumoParaEliminar)` del paso 5 — y esos IDs ya están en memoria. Se reemplazó la consulta a la BD por un filtro en memoria, eliminando un round-trip completo por cada ejecución del endpoint.

```csharp
// Antes
var explosionExistenteInsumos = (await _explosionInsumoService.GetByIdExplosion(response.Id)).ToList();

// Después
var explosionExistenteInsumos = explosionExistentePreLoop
    .Where(x => !idsExplosionInsumoParaEliminar.Contains(x.Id))
    .ToList();
```

---

## Optimización 2 — Lookups en memoria en vez de escaneos lineales

Varias colecciones ya cargadas una sola vez se recorrían con `.Where()`/`.FirstOrDefault()`/`.Any()` **dentro de loops y de la recursión** del árbol de insumos (`ProcesarInsumos`), lo cual era O(n×m) en vez de O(n+m). Se construyeron lookups/diccionarios una sola vez antes del loop principal (`ToLookup` para claves nullable/uno-a-muchos, ya que indexar una clave inexistente devuelve secuencia vacía en vez de lanzar excepción; `Dictionary` solo para `Id`, que es PK garantizada única):

- `preciosPorInsumo`, `preciosPorId` (antes: 2 escaneos de `preciosList` por concepto/insumo).
- `matrizInsumosPorConcepto`, `matrizInsumosPorMatrizConcepto` (antes: escaneo de `matrizInsumosList` por concepto y por nodo del árbol).
- `basicosPorConceptoRaiz`, `basicosPorPadre` (antes: escaneo de `basicosList` por concepto y por nodo del árbol).
- `explosionExistentePreLoopPorConcepto` (antes: escaneo por concepto).
- `idsConMovimientos` (`HashSet<int>`, antes: 4 `.Any()` encadenados por registro).
- `explosionExistenteInsumosPorClave`, `movimientosPorExplosionInsumo` (antes: escaneo por cada insumo agrupado en el upsert final).

El método recursivo `ProcesarInsumos` recibía listas completas (`matrizConceptos`, `matrizInsumos`, `precios`) solo para hacer `.Where()`/`.FirstOrDefault()` en cada nivel — se reemplazaron esos parámetros por los lookups correspondientes (`matrizConceptosPorPadre`, `matrizInsumosPorMatrizConcepto`, `preciosPorInsumo`), pasados igual que antes en cada llamada recursiva.

Ningún cambio altera el resultado ni el comportamiento del endpoint — son puramente algorítmicos (reducen complejidad de escaneo), no tocan la transacción ni ninguna escritura a la base de datos.

---

## Aplicación a `PostExplosionInsumosAgrupado`

`PresupuestoExplosionInsumoAgrupadoController.cs` comparte la misma razón de ser para la transacción (sección anterior) — es el único otro lugar del repo que usa `_unitOfWork.ExecuteInTransactionAsync`, con el mismo mecanismo de rollback vía `ExplosionProcesoException`. Se aplicaron las mismas dos optimizaciones, adaptadas a su estructura de doble loop (partida → concepto, en vez de un solo loop por concepto):

- **Reload redundante eliminado** (paso 8, antes línea 384): `explosionExistenteInsumos` ya no vuelve a consultar `_explosionInsumoAgrupadoService.GetByIdExplosion`; se filtra en memoria `explosionExistentePreLoop` quitando `idsExplosionInsumoAgrupadoParaEliminar` (los únicos IDs que cambiaron en la tabla `ExplosionesInsumosAgrupados` entre la carga inicial y ese punto).
- **Lookups en memoria** construidos una sola vez antes del loop principal: además de los mismos lookups de precios/matriz/árbol (`preciosPorInsumo`, `preciosPorId`, `matrizInsumosPorConcepto`, `matrizInsumosPorMatrizConcepto`, `basicosPorConceptoRaiz`, `basicosPorPadre`, `idsConMovimientos`), se agregó `conceptosPorPartida` (`todosConceptosList.ToLookup(x => x.IdPartida)`) porque este controlador tiene un loop adicional por partida que antes escaneaba `todosConceptosList` completo por cada partida. También se reemplazó el escaneo de `explosionExistentePreLoop` por partida+insumo (rama 5b) y el upsert final (`explosionExistenteInsumosPorClave`, `movimientosPorExplosionInsumoAgrupado`) por el mismo patrón de lookup/tupla usado en el controlador no agrupado.
- El método recursivo `ProcesarInsumosAgrupados` recibe ahora `ILookup` en vez de las listas completas (`matrizConceptosPorPadre`, `matrizInsumosPorMatrizConcepto`, `preciosPorInsumo`), igual que `ProcesarInsumos` en el controlador hermano.

No se modificó ninguna condición de negocio existente (incluyendo el hallazgo ya documentado en el código sobre el filtro de la rama 5b que no considera `Contratable`) — los cambios son estrictamente de rendimiento.
