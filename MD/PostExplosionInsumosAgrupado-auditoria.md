---
tipo: auditoria-codigo
estado: completado
tags:
  - insumos
  - presupuestos
  - auditoria
  - backend
  - agrupado
---

Relacionado: [[PostExplosionInsumos-auditoria]]

# Auditoría — `PostExplosionInsumosAgrupado` (`API/Controllers/Presupuestos/PresupuestoExplosionInsumoAgrupadoController.cs`)

## Contexto

El endpoint `POST {id}/Explosion/Agrupado` es el hermano de `POST {id}/Explosion` (ya auditado y corregido en `PostExplosionInsumos-auditoria.md`): en vez de generar la explosión de insumos a nivel de **concepto**, la genera a nivel de **partida** (suma cantidades de todos los conceptos de cada partida). Vive en la misma `partial class PresupuestoController`, comparte casi todos los servicios inyectados con el endpoint hermano, y replica su misma estructura general (carga → loop → agrupación → upsert). Sin embargo el código **diverge** del hermano en varios puntos — algunos son solo diferencias de implementación, pero otros son bugs reales, confirmados con el usuario:

- El bloque que debía eliminar registros huérfanos (sin movimientos) tiene el `Delete` **comentado** desde el commit `75e2aded` ("Fix: Explosion Insumos", 2025-10-31, sin descripción) — hoy es un no-op. **Confirmado como bug a corregir.**
- La actualización de precio de insumo cuando cambia (y la regla de MOD/`ImporteMatrizCondicion`) que sí existe en el endpoint hermano, **no existe aquí**. **Confirmado como bug a corregir.**

Esta auditoría documenta todos los hallazgos (bugs + oportunidades de refactor) y el fix aplicado.

---

## Bugs (comportamiento incorrecto)

### 🔴 1. Falta de atomicidad (mismo bug crítico que el endpoint hermano)

El método hace `SaveChanges` parciales en varios puntos — creación/actualización de `Explosione` (sección 3), `Add` de precios nuevos dentro del loop (línea 157), `Update` individual de `partida` en batch **antes** de la validación de cantidad negativa (línea 351) — antes de llegar a esa validación. Si falla la validación o cualquier paso posterior, el método retorna `BadRequestCustom(...)` (línea 354) pero las partidas ya quedaron marcadas `Actualizado = true` en BD (sección 6, líneas 287-288, ejecutada *antes* de la sección 8 donde ocurre la validación). Como la query del paso 5 filtra `!x.Actualizado` (línea 118), una llamada posterior a este mismo endpoint **ya no reprocesará esas partidas** — quedan huérfanas, igual que el bug #1 ya documentado y corregido en el endpoint hermano.

**Fix:** se reutiliza `IUnitOfWork`/`ExplosionProcesoException` (creados para el endpoint hermano) — el cuerpo se envuelve en `_unitOfWork.ExecuteInTransactionAsync(...)` y el `return BadRequestCustom(...)` se reemplaza por `throw new ExplosionProcesoException(...)`.

### 🔴 2. `Delete` comentado — registros huérfanos nunca se limpian

Línea 210: `//await _explosionInsumoAgrupadoService.Delete(registro.Id);`. El bloque completo (líneas 187-215) calcula `tieneMovimientos` para cada registro existente de un concepto que pasó a ser "contratable tipo 1" (suministro y colocación), pero **no hace nada con el resultado** — ni elimina, ni marca, ni loguea. Efecto: los registros de `ExplosionesInsumosAgrupados` para esos conceptos quedan huérfanos para siempre (nunca se limpian, ni siquiera cuando no tienen movimientos asociados), inflando/ensuciando los reportes que dependen de esta tabla.

**Fix:** se reactiva el delete, en batch: pre-carga de movimientos de los 4 módulos en una sola consulta por servicio (`GetByIdsExplosionInsumo`/`GetByExplosionInsumos`, ya existentes desde el fix del hermano) y un nuevo `DeleteRangeAsync` batch en `ExplosionInsumoAgrupadoService`.

### 🔴 3. Precio de insumo nunca se actualiza cuando cambia

Sección 5a (líneas 140-182): a diferencia del endpoint hermano (que compara `precioInsumo.Precio != precioConcepto` y actualiza si cambió), aquí — cuando ya existe un precio registrado — el código simplemente hace `idPrecio = precioInsumo.Id;` (línea 162) sin comparar ni actualizar nunca. Efecto: una vez creado el primer precio para un insumo en el presupuesto, la explosión agrupada seguirá usando ese precio para siempre, aunque el precio del concepto cambie. Esto no es solo un tema de performance — genera **datos económicos desactualizados** en los reportes agrupados por partida.

**Fix:** se iguala la lógica del endpoint hermano.

### 🔴 4. Falta la regla de precio para MOD (`ImporteMatrizCondicion`)

Líneas 149-155: el precio nuevo siempre se calcula como `concepto.Precio ?? 0`. El endpoint hermano aplica una excepción: si `concepto.Contratable && concepto.IdTipoSubcontrato == 2` (mano de obra), usa `concepto.ImporteMatrizCondicion` en su lugar. Esa regla **no existía aquí**, por lo que los precios de insumos MOD creados desde este endpoint podían quedar mal calculados desde su creación.

**Fix:** se agrega la misma regla que el endpoint hermano.

### 🟡 5. Comentario incorrecto sobre `UpdateRange` — N+1 evitable ya disponible

Línea 285: *"IPresupuestoPartidaService no expone UpdateRange, se actualiza individualmente"*. **Esto era falso** — `IPresupuestoPartidaService.UpdateRange(List<PresupuestosPartida>)` **sí existe** (`Services/PresupuestosPartidas/IPresupuestoPartidaService.cs:11`, implementado en `PresupuestoPartidaService.cs:35-38`, delega a `_presupuestoPartidaCustomRepository.UpdateRange`).

**Fix:** el `foreach` con `Update` individual se reemplaza por `await _presupuestoPartidaService.UpdateRange(partidasParaActualizar);` — cero trabajo nuevo, el método bulk ya existía.

### 🟡 6. Falta de validación de `presupuesto` nulo

Línea 48: igual que el bug #2 del endpoint hermano, `_presupuestoService.GetById(id)` no se valida contra `null` antes de usar `presupuesto.Codigo` (línea 81) — riesgo de `NullReferenceException` en vez de un 404 controlado.

**Fix:** `if (presupuesto == null) return _helperResponse.NotFoundCustom();`.

### 🟡 7. Semántica HTTP inconsistente

Línea 391: siempre responde `CreatedCustom` (201), incluso en la rama de actualización de una explosión ya existente (líneas 103-111). Mismo bug #4 ya corregido en el endpoint hermano.

**Fix:** `esNuevaExplosion ? CreatedCustom(...) : SuccessPutCustom()`.

### 🟡 8. Código muerto / redundante

Líneas 90-96: `mapResult.IdUsuarioRegistro`, `FechaRegistro`, `IdUsuarioModifico`, `FechaModifico`, `Actualizada`, `Activo` se reasignan sobre `mapResult` justo después de `ToExplosionFromCreateDto()`, duplicando exactamente lo ya fijado en `modelo` (líneas 80-87). Mismo bug #5 ya documentado/corregido en el hermano.

**Fix:** eliminado.

### 🟢 9. Filtro de "movimientos" en 5b no considera `Contratable` (documentado, no corregido)

Línea 191: `explosionExistentePreLoop.Where(x => x.IdPresupuestoPartida == partida.Id && x.IdInsumo == concepto.IdInsumo)` no filtra por `Contratable`, a diferencia del upsert principal en la sección 8 (línea 336: `e.Contratable == item.Contratable`). Con el delete reactivado (hallazgo #2), este filtro podría emparejar registros de `Contratable` distinto (mismo insumo+partida, perteneciente a otro concepto). Se conserva el criterio original (no se modifica) — pendiente de confirmar con negocio si debería incluir `Contratable`, igual que el hallazgo #3 del endpoint hermano.

---

## 🟢 Oportunidades de refactor (no bugs, generaban carga innecesaria en BD)

1. **Precios (`_presupuestoInsumoPrecioService.Add`)** — una vez por concepto con insumo directo sin precio (línea 157) y una vez más por nodo del árbol dentro de `ProcesarInsumosAgrupados`. Resuelto migrando a `AddBulk`/`UpdateBulk` (ya existentes, mismo patrón de acumuladores que el endpoint hermano).
2. **Movimientos (4 servicios) en la rama 5b** (líneas 197-200) — 4 queries awaited por registro, sin pre-carga. Resuelto pre-cargando una vez por servicio con los métodos bulk `GetByIdsExplosionInsumo`/`GetByExplosionInsumos`.
3. **`_presupuestoPartidaService.Update` por partida** (líneas 287-288) — ver hallazgo #5, reemplazado por `UpdateRange`.

### Diferencia de diseño documentada (no es bug, es arquitectura distinta del hermano)

A diferencia del endpoint hermano, aquí **no se filtra por `!p.Actualizado`** ni se marca `Actualizado = true` en `PresupuestosMatriz`/`PresupuestosMatrizConcepto` (secciones 5c/5d y `ProcesarInsumosAgrupados`). El hermano es incremental a nivel de concepto; este endpoint recalcula completo cada vez que una partida no procesada se reprocesa (granularidad a nivel partida vía `partidasList.Where(x => !x.Actualizado)`, línea 118). El upsert final (sección 8) sobrescribe `Cantidad` en vez de sumar, así que esto **parece correcto tal como está** — se documenta como nota arquitectónica, no como bug, dado que no se detectó riesgo de doble conteo. **No se modificó.**

### Arquitectura (mismo hallazgo ya documentado en el hermano)

Lógica de negocio compleja vive en el controlador, contradiciendo "Avoid business logic inside Controllers" del `CLAUDE.md`. Recomendación a futuro: mover a `ExplosionInsumoAgrupadoService.GenerarExplosionAgrupadaAsync(id, userId)`. Fuera de alcance de este fix (igual que en el hermano).

---

## Resumen de severidad

| # | Hallazgo | Severidad | Estado |
|---|---|---|---|
| 1 | Falta de atomicidad (transacción) | 🔴 Crítico | Corregido (reuso de `IUnitOfWork` + `ExplosionProcesoException`) |
| 2 | `Delete` comentado (registros huérfanos) | 🔴 Crítico | Corregido (`DeleteRangeAsync` nuevo + batch) |
| 3 | Precio no se actualiza al cambiar | 🔴 Alto | Corregido |
| 4 | Falta regla MOD (`ImporteMatrizCondicion`) | 🔴 Alto | Corregido |
| 5 | Comentario falso + `UpdateRange` no usado | 🟡 Medio | Corregido |
| 6 | `presupuesto` nulo no validado | 🟡 Medio | Corregido |
| 7 | Siempre `CreatedCustom` (201) | 🟡 Medio | Corregido |
| 8 | Código muerto (reasignación redundante) | 🟢 Bajo | Corregido |
| 9 | Filtro sin `Contratable` en 5b | 🟢 Bajo (latente) | Documentado, no corregido (pendiente de negocio) |
| — | N+1 precios / movimientos / partidas | 🟡 Medio (performance) | Corregido |

---

## Archivos modificados

- `EF/Repositories/InterfacesCustom/IExplosionInsumoAgrupadoCustomRepository.cs` + `EF/Repositories/ExplosionInsumoAgrupadoRepository.cs` — nuevo `DeleteRangeAsync(List<int> ids)`.
- `Services/ExplosionesInsumosAgrupados/IExplosionInsumoAgrupadoService.cs` + `Services/ExplosionesInsumosAgrupados/ExplosionInsumoAgrupadoService.cs` — idem, delega al repo.
- `API/Controllers/Presupuestos/PresupuestoExplosionInsumoAgrupadoController.cs` — `PostExplosionInsumosAgrupado` y `ProcesarInsumosAgrupados` reescritos.

Sin infraestructura nueva más allá del método bulk anterior — se reutiliza `IUnitOfWork`, `ExplosionProcesoException`, y los métodos bulk de precios y movimientos ya creados para el endpoint hermano (`PostExplosionInsumos-auditoria.md`).

## Verificación

- `dotnet build` sin errores.
- Ejecutar el endpoint contra un presupuesto con partidas grandes y confirmar que ya no aparece el error transitorio bajo carga normal.
- Forzar un fallo (insumo con cantidad negativa) y verificar que ninguna partida queda marcada `Actualizado = true` tras el rollback.
- Confirmar que un concepto que pasa a contratable-tipo-1 sin movimientos asociados ahora sí elimina su registro huérfano en `ExplosionesInsumosAgrupados`.
- Confirmar que cambiar el precio de un concepto y volver a correr el endpoint actualiza el precio en la explosión agrupada (antes quedaba congelado).
- Confirmar que un concepto MOD (`Contratable && IdTipoSubcontrato == 2`) crea el precio usando `ImporteMatrizCondicion`.
- Probar creación de explosión nueva (201) vs. actualización de una existente (200).
