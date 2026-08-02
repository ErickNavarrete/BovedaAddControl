---
tipo: auditoria-codigo
estado: completado
tags:
  - insumos
  - presupuestos
  - auditoria
  - backend
---

Relacionado: [[Duplicados Insumos]], [[Script elimina duplicados Insumos]]

# Auditoría — `PostExplosionInsumos` (`API/Controllers/Presupuestos/PresupuestoExplosionInsumosController.cs`)

## Contexto

El endpoint `POST {id}/Explosion` genera/actualiza la explosión de insumos de un presupuesto, iterando sobre todos los "conceptos" no actualizados (hasta 800–2,000 registros por presupuesto), recorriendo un árbol recursivo de insumos por cada uno, y persistiendo los resultados. Con presupuestos grandes (800–2,000 conceptos), el endpoint empieza a fallar con:

> An exception has been raised that is likely due to a transient failure.

Esta es la excepción textual que EF Core produce cuando **no hay una estrategia de reintento (`EnableRetryOnFailure`) configurada** y ocurre un problema transitorio (timeout de conexión, agotamiento del pool, blip de red) durante una operación. El objetivo de este trabajo es (1) documentar los bugs y oportunidades de refactor encontrados en el método, y (2) mitigar la causa raíz del error transitorio **desde el controlador**, sin tocar `Program.cs` ni `appsettings.json` (eso queda fuera de alcance por ahora, ver Parte 2). El alcance acordado es: corregir los bugs directos del controlador + envolver la operación en una única transacción, usando un único archivo de soporte nuevo (`IUnitOfWork` en la capa `EF`) para poder iniciar/confirmar/revertir la transacción sin exponer el `DbContext`. No se mueve la lógica de negocio a la capa Service en este cambio (queda como recomendación futura).

---

## Parte 1 — Hallazgos de la auditoría

### 🔴 Bugs (comportamiento incorrecto)

1. **Falta de atomicidad — el bug más severo.** El método hace `SaveChanges` parciales en varios puntos (creación/actualización de la `Explosione` en el paso 2, `UpdateRange`/`UpdateBulk`/`Update` de conceptos/matriz en el paso 5) **antes** de llegar a la validación de cantidad negativa (línea 397-401). Si esa validación falla — o si ocurre *cualquier* error después del paso 5 — el método retorna `BadRequestCustom(...)` pero los conceptos y nodos de matriz **ya quedaron marcados `Actualizado = true` en la base de datos**. Como la query del paso 1 (línea 139) filtra `!x.Actualizado`, una llamada posterior al mismo endpoint **ya no volverá a procesar esos conceptos** — quedan huérfanos, sin insumos explotados correctamente, y sin forma de reprocesarlos vía este endpoint. Esto es un bug de integridad de datos, no solo de resiliencia.
2. **Falta de validación de `presupuesto` nulo** (línea 72-73). Si `id` no corresponde a un presupuesto existente, `_presupuestoService.GetById(id)` puede devolver `null`, y el acceso a `presupuesto.Codigo` (líneas 102-103) lanzará `NullReferenceException` en lugar de un 404 controlado.
3. **Inconsistencia en el filtro de insumos para mano de obra (`IdTipoSubcontrato == 2`)** (líneas 257-263 vs. `ProcesarInsumos`): el filtro que excluye insumos de `ManoDeObra` (y `HerramientaMenor` si aplica) se aplica a los insumos directos de la matriz (sección 4c), pero **no se propaga al recorrido recursivo del árbol** (sección 4d / `ProcesarInsumos`). Marcado para validar con negocio — no se toca en este cambio, solo se documenta como hallazgo pendiente de confirmación.
4. **Semántica HTTP inconsistente**: el endpoint siempre responde `CreatedCustom` (201), incluso cuando la explosión ya existía y solo se actualizó (rama `else` del paso 2, línea 124-132). Según la convención del proyecto (`HelperResponse`), una actualización debería responder con `SuccessPutCustom` (200), reservando 201 para la creación real.
5. **Código muerto / redundante** (líneas 111-117): tras `modelo.ToExplosionFromCreateDto()`, se reasignan exactamente los mismos campos que ya se habían fijado en `modelo` (líneas 99-109). Es una duplicación sin efecto, candidata a limpieza.

### 🟡 Oportunidades de refactor (no bugs, pero generan carga innecesaria en BD)

Confirmado por auditoría de código de repos/servicios: el método ya fue parcialmente optimizado (usa `UpdateRange`, `UpdateBulk`, `AddRangeAsync`, `UpdateRangeAsync`, y pre-carga listas en memoria antes del loop). Sin embargo **quedan 4 puntos que aún hacen una ida a BD por cada iteración**, en vez de batch:

- `_presupuestoInsumoPrecioService.Add` / `.Update` — una vez por concepto con insumo directo sin precio cacheado (líneas 183, 192) y una vez más por nodo del árbol dentro de `ProcesarInsumos` (línea 486).
- 4 queries (`_aditivaService`, `_deductivaService`, `_subcontratoService`, `_explosionInsumoAvanceService`) + `_explosionInsumoService.Delete` — una vez por cada `registro` dentro de la rama "contratable tipo 1" (líneas 229-241). No hay pre-carga como se hizo con `explosionExistentePreLoop`.
- `_presupuestoMatrizConceptoService.Update` — una vez por cada nodo del árbol de conceptos (línea 333); a diferencia de `PresupuestoMatrizService`, este servicio **no tiene un método bulk** equivalente.

Con presupuestos de 800–2,000 conceptos, esto puede generar miles de round-trips secuenciales dentro de una sola request. **Se incluyen en este cambio** — ver Parte 3 para el detalle de los métodos bulk nuevos.

### Arquitectura (violación de reglas del propio CLAUDE.md)

El método completo (~380 líneas) vive en el controlador, con lógica de negocio compleja (recorrido de árbol, cálculo de cantidades, reglas de subcontratación). Esto contradice la regla del proyecto "Avoid business logic inside Controllers" y "Controllers should only orchestrate requests and responses". La recomendación a futuro es mover esta orquestación a `ExplosionInsumoService` (p. ej. `GenerarExplosionAsync(id, userId)`), dejando el controlador solo con la llamada al servicio + manejo de respuesta. **Fuera de alcance de este cambio.**

---

## Parte 2 — Causa raíz del error transitorio y solución (alcance acordado)

### Causa raíz confirmada

- `API/Program.cs:89` registra el `DbContext` así: `AddDbContextPool<AddControlErpContext>(options => options.UseNpgsql(connString))` — **sin `EnableRetryOnFailure`, sin `CommandTimeout` explícito, sin ninguna estrategia de ejecución.**
- `EF/DataContext/AddControlErpContext.cs:708` tiene `OnConfiguring` vacío — no hay configuración de resiliencia tampoco ahí.
- `API/appsettings.json:10` — cadena de conexión con `Maximum Pool Size=17`, `Timeout=30` (apertura de conexión), `CommandTimeout=60`.
- No existe ningún patrón de transacción (`BeginTransactionAsync`, `IExecutionStrategy`, `TransactionScope`) en `EF/` ni `Services/` — sería una construcción nueva para el proyecto.
- El controlador mantiene **una sola conexión abierta** (contexto Scoped) durante toda la duración de la request, mientras ejecuta cientos/miles de round-trips secuenciales. Con un pool de solo 17 conexiones y sin política de reintento, cualquier timeout de comando (60s), agotamiento de pool (por requests concurrentes) o blip de red de la BD administrada de DigitalOcean se propaga como excepción sin reintento — exactamente el mensaje reportado.

### Solución a implementar (alcance: solo controlador + 1 archivo de soporte en EF)

**No se modifica `Program.cs` ni `appsettings.json` en este cambio** — quedan documentados como recomendación pendiente (ver "Fuera de alcance" más abajo), ya que sin `EnableRetryOnFailure` el sistema seguirá sin reintentar automáticamente ante un fallo transitorio. Lo que sí se corrige ahora es la consecuencia más grave de no tener una transacción: los datos quedando a medio procesar cuando algo falla (bug #1).

**1. Nueva abstracción `IUnitOfWork` en la capa `EF`** (respeta la regla "no exponer `DbContext` fuera de `EF`" — solo se expone un método de ejecución, no el contexto). Es el único archivo nuevo fuera del controlador:

- `EF/UnitOfWork/IUnitOfWork.cs`:
```csharp
public interface IUnitOfWork
{
    Task ExecuteInTransactionAsync(Func<Task> operation);
}
```
- `EF/UnitOfWork/UnitOfWork.cs`:
```csharp
public class UnitOfWork : IUnitOfWork
{
    private readonly AddControlErpContext _context;
    public UnitOfWork(AddControlErpContext context) => _context = context;

    public async Task ExecuteInTransactionAsync(Func<Task> operation)
    {
        var strategy = _context.Database.CreateExecutionStrategy();
        await strategy.ExecuteAsync(async () =>
        {
            await using var transaction = await _context.Database.BeginTransactionAsync();
            try
            {
                await operation();
                await transaction.CommitAsync();
            }
            catch
            {
                await transaction.RollbackAsync();
                throw;
            }
        });
    }
}
```
- Registrar en `API/Extensions/ServiceCollectionExtensions.cs`: `builder.Services.AddScoped<IUnitOfWork, UnitOfWork>();`

**2. Envolver `PostExplosionInsumos` en la transacción**

Inyectar `IUnitOfWork _unitOfWork` en `PresupuestoController` (mismo patrón que los demás servicios inyectados). Envolver el cuerpo del método (pasos 2 al 8, es decir desde la obtención/creación de la `Explosione` hasta el upsert final) en:
```csharp
await _unitOfWork.ExecuteInTransactionAsync(async () => { /* lógica actual */ });
```

Para la validación de cantidad negativa (línea 397-401), que hoy hace un `return` en medio de la lógica: reemplazar por lanzar la excepción `ExplosionProcesoException` (`Tools/Comun`) con el mensaje del insumo. Esto permite que la transacción haga rollback automáticamente al propagarse la excepción, y se captura con un `catch (ExplosionProcesoException ex)` específico (antes del `catch (Exception ex)` genérico) para responder `BadRequestCustom(ex.Message)`.

Esto **corrige el bug #1 de atomicidad**: si algo falla en cualquier punto (validación, error transitorio, excepción inesperada), ningún conceptos queda marcado `Actualizado = true` a medias — todo o nada.

### Riesgo a tener en cuenta

Sin `EnableRetryOnFailure`, si el error transitorio ocurre *dentro* de la transacción, esta hará rollback pero **no reintentará automáticamente** — el usuario tendría que reintentar la request manualmente. Esto es aceptable dado el alcance elegido (no se toca `Program.cs`), pero es la razón por la que el primer punto de "Fuera de alcance" abajo sigue siendo relevante para una siguiente iteración.

### Fuera de alcance de este cambio (documentado, no implementado)

- **`API/Program.cs:89`** — agregar `EnableRetryOnFailure` a `UseNpgsql(...)` para que los fallos transitorios se reintenten automáticamente en vez de solo hacer rollback.
- **`API/appsettings.json:10`** — revisar `Maximum Pool Size=17` (bajo para esta carga) y `CommandTimeout=60`, a validar con el equipo de infraestructura por el impacto en el plan de conexiones de DigitalOcean.
- Mover la orquestación completa a `ExplosionInsumoService` (regla de arquitectura del proyecto).

---

## Parte 3 — Eliminación de los 4 puntos N+1 (incluido en este cambio)

A pedido tuyo, esto sí se incluye ahora. **Importante:** eliminar un N+1 real requiere un método bulk en la capa `EF`/`Services` — no es posible resolverlo solo dentro del controlador. Todos los métodos nuevos siguen patrones **ya existentes** en el propio proyecto (no se introduce ninguna arquitectura nueva):

### 3.1 Precios de insumo (`_presupuestoInsumoPrecioService.Add`/`.Update` por concepto y por nodo del árbol)

**Buena noticia: `AddBulk`/`UpdateBulk` ya existen** en `IPresupuestoInsumoPrecioService` (`Services/PresupuestosInsumosPrecios/PresupuestoInsumoPrecioService.cs:55-73`) — no hace falta crear nada nuevo aquí, solo dejar de llamar `Add`/`Update` uno por uno desde el controlador y usar estos métodos.

Cambio en el controlador: en vez de resolver `idPrecio` al vuelo (sección 4a y `ProcesarInsumos`), se acumulan las solicitudes:
- `preciosNuevosPendientes: Dictionary<int /*IdInsumo*/, WritePresupuestoInsumoPrecioDto>` — para insumos sin precio existente (deduplicado por `IdInsumo`).
- `preciosParaActualizar: List<BulkUpdatePresupuestoInsumoPrecioDto>` — para precios existentes cuyo valor cambió.

Se asigna un `IdPrecio` temporal (`0`) en el `WriteExplosionInsumoDto` mientras se procesa el loop/árbol. Al terminar el loop (antes de la sección 5), se resuelve en dos llamadas:
```csharp
if (preciosNuevosPendientes.Count > 0)
{
    var nuevos = preciosNuevosPendientes.Values.Select(p => p.ToPresupuestoInsumoPrecioFromCreateDto()).ToList();
    var creados = await _presupuestoInsumoPrecioService.AddBulk(nuevos);

    var mapaIdPorInsumo = creados.ToDictionary(x => x.IdInsumo, x => x.Id);
    foreach (var item in explosionInsumos.Where(x => x.IdPrecio == 0))
        item.IdPrecio = mapaIdPorInsumo[item.IdInsumo];
}

if (preciosParaActualizar.Count > 0)
    await _presupuestoInsumoPrecioService.UpdateBulk(preciosParaActualizar);
```

**Efecto secundario positivo (no solo performance):** en el código actual, `preciosList` se carga **una sola vez antes del loop** y nunca se actualiza cuando se crea un precio nuevo a mitad del loop. Esto significa que si el mismo `IdInsumo` sin precio aparece en más de un concepto o nodo del árbol dentro de la misma request, el código actual genera **una fila de precio duplicada por cada aparición** (bug no documentado antes, detectado al diseñar este fix). El enfoque deduplicado por `IdInsumo` corrige esto de forma incidental.

### 3.2 Chequeo de movimientos + delete (rama "contratable tipo 1")

Se necesita un método bulk "¿existen movimientos para estos `IdExplosionInsumo`?" en los 4 servicios ya usados, siguiendo el patrón exacto de sus métodos `GetByIdExplosionInsumo(int)` existentes (solo se pluraliza a `List<int>` + `.Contains`):

| Archivo a editar                                                                                                                   | Método nuevo                                                                        |
| ---------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| `EF/Repositories/InterfacesCustom/IAditivaCustomRepository.cs` + `AditivaRepository.cs:82`                                         | `Task<List<AditivasDetalle>> GetByIdsExplosionInsumo(List<int> ids)`                |
| `Services/Aditivas/IAditivaService.cs` + `AditivaService.cs`                                                                       | idem, delega al repo                                                                |
| `EF/Repositories/InterfacesCustom/IDeductivaCustomRepository.cs` + `DeductivaRepository.cs:82`                                     | `Task<List<DeductivasDetalle>> GetByIdsExplosionInsumo(List<int> ids)`              |
| `Services/Deductivas/IDeductivaService.cs` + `DeductivaService.cs`                                                                 | idem                                                                                |
| `EF/Repositories/InterfacesCustom/IExplosionSubcontratoDetalleCustomRepository.cs` + `ExplosionSubcontratoDetalleRepository.cs:60` | `Task<List<ExplosionesSubcontratosDetalle>> GetByIdsExplosionInsumo(List<int> ids)` |
| `Services/ExplosionesSubcontratosDetalles/IExplosionSubcontratoDetalleService.cs` + impl                                           | idem                                                                                |
| `EF/Repositories/InterfacesCustom/IExplosionInsumoAvanceCustomRepository.cs` + `ExplosionInsumoAvanceRepository.cs:277`            | `Task<List<ExplosionesInsumosAvance>> GetByIdsExplosionInsumo(List<int> ids)`       |
| `Services/ExplosionesInsumosAvances/IExplosionInsumoAvanceService.cs` + impl                                                       | idem                                                                                |

Implementación tipo (idéntica para las 4, solo cambia la entidad/DbSet):
```csharp
public async Task<List<AditivasDetalle>> GetByIdsExplosionInsumo(List<int> idsExplosionInsumo)
{
    return await _context.AditivasDetalles.Where(x => idsExplosionInsumo.Contains(x.IdExplosionInsumo)).ToListAsync();
}
```

Además, para el `Delete` por registro (`_explosionInsumoService.Delete(registro.Id)`), se agrega un bulk delete siguiendo el **mismo patrón que ya existe** en `AditivaRepository.DeleteRange`/`DeductivaRepository.DeleteRange` (hard delete físico — el proyecto ya tiene este precedente para estas tablas de detalle, aunque contradice la regla general de soft-delete de `CLAUDE.md`; se documenta pero se sigue el precedente existente en este mismo subsistema en vez de introducir un tercer comportamiento):

- `EF/Repositories/InterfacesCustom/IExplosionInsumoCustomRepository.cs` + `ExplosionInsumoRepository.cs` — nuevo `Task<bool> DeleteRangeAsync(List<int> ids)`.
- `Services/ExplosionesInsumos/IExplosionInsumoService.cs` + `ExplosionInsumoService.cs` — idem, delega al repo.

```csharp
public async Task<bool> DeleteRangeAsync(List<int> ids)
{
    var entities = await _context.ExplosionesInsumos.Where(x => ids.Contains(x.Id)).ToListAsync();
    if (entities.Any())
    {
        _context.ExplosionesInsumos.RemoveRange(entities);
        await _context.SaveChangesAsync();
    }
    return true;
}
```

En el controlador: antes del loop principal se pre-cargan los 4 listados completos (una sola vez, filtrando por los ids de `explosionExistentePreLoop`, igual que ya se hace hoy con esa misma lista). Dentro de la rama "tipo 1", el chequeo `.Any()` se hace en memoria contra esos 4 listados, y en vez de `Delete` inmediato se acumula el id en `idsExplosionInsumoParaEliminar`; al final del loop principal se llama `DeleteRangeAsync` una sola vez.

### 3.3 `PresupuestoMatrizConcepto.Update` por nodo (sin bulk)

Se agrega `UpdateBulk`, copiando exactamente el patrón ya usado en `PresupuestoMatrizRepository.cs:368-373`:

- `EF/Repositories/InterfacesCustom/IPresupuestoMatrizConceptoCustomRepository.cs` + `PresupuestoMatrizConceptoRepository.cs` — nuevo `Task<bool> UpdateBulk(List<PresupuestosMatrizConcepto> entities)`.
- `Services/PresupuestosMatrizConceptos/IPresupuestoMatrizConceptoService.cs` + `PresupuestoMatrizConceptoService.cs` — idem, delega al repo.

```csharp
public async Task<bool> UpdateBulk(List<PresupuestosMatrizConcepto> entities)
{
    _context.PresupuestosMatrizConceptos.UpdateRange(entities);
    await _context.SaveChangesAsync();
    return true;
}
```

En el controlador: `await _presupuestoMatrizConceptoService.UpdateBulk(matrizConceptosParaActualizar);` reemplaza el `foreach` con `Update` individual.

---

## Archivos a modificar

**Controlador y soporte de transacción:**
1. `EF/UnitOfWork/IUnitOfWork.cs` (nuevo) — interfaz.
2. `EF/UnitOfWork/UnitOfWork.cs` (nuevo) — implementación con `CreateExecutionStrategy` + transacción.
3. `API/Extensions/ServiceCollectionExtensions.cs` — registrar `IUnitOfWork` como Scoped.
4. `Tools/Comun/ExplosionProcesoException.cs` (nuevo) — excepción de negocio para abortar+rollback con mensaje.
5. `API/Controllers/Presupuestos/PresupuestoController.cs` — inyectar `IUnitOfWork` en el constructor.
6. `API/Controllers/Presupuestos/PresupuestoExplosionInsumosController.cs` — ver Anexo para el método completo reescrito.

**Eliminación de N+1 (Parte 3):**
7. `EF/Repositories/InterfacesCustom/IAditivaCustomRepository.cs` + `AditivaRepository.cs` + `Services/Aditivas/IAditivaService.cs` + `AditivaService.cs` — `GetByIdsExplosionInsumo`.
8. `EF/Repositories/InterfacesCustom/IDeductivaCustomRepository.cs` + `DeductivaRepository.cs` + `Services/Deductivas/IDeductivaService.cs` + `DeductivaService.cs` — `GetByIdsExplosionInsumo`.
9. `EF/Repositories/InterfacesCustom/IExplosionSubcontratoDetalleCustomRepository.cs` + `ExplosionSubcontratoDetalleRepository.cs` + `Services/ExplosionesSubcontratosDetalles/IExplosionSubcontratoDetalleService.cs` + impl — `GetByIdsExplosionInsumo`.
10. `EF/Repositories/InterfacesCustom/IExplosionInsumoAvanceCustomRepository.cs` + `ExplosionInsumoAvanceRepository.cs` + `Services/ExplosionesInsumosAvances/IExplosionInsumoAvanceService.cs` + impl — `GetByIdsExplosionInsumo`.
11. `EF/Repositories/InterfacesCustom/IExplosionInsumoCustomRepository.cs` + `ExplosionInsumoRepository.cs` + `Services/ExplosionesInsumos/IExplosionInsumoService.cs` + `ExplosionInsumoService.cs` — `DeleteRangeAsync`.
12. `EF/Repositories/InterfacesCustom/IPresupuestoMatrizConceptoCustomRepository.cs` + `PresupuestoMatrizConceptoRepository.cs` + `Services/PresupuestosMatrizConceptos/IPresupuestoMatrizConceptoService.cs` + `PresupuestoMatrizConceptoService.cs` — `UpdateBulk`.

**Bugs corregidos directamente en el controlador (ver Anexo):**
- Validación nula de `presupuesto` (bug #2).
- Código redundante eliminado (bug #5).
- `CreatedCustom` → `SuccessPutCustom` en la rama de actualización (bug #4).
- `return BadRequestCustom` reemplazado por `throw ExplosionProcesoException` para permitir rollback (bug #1).

## Verificación

- Ejecutar el endpoint contra un presupuesto grande (800–2,000 conceptos) en un ambiente de pruebas y confirmar que ya no aparece el error transitorio bajo carga normal.
- Forzar un fallo dentro del bloque (p. ej. un insumo con cantidad negativa) y verificar en BD que **ningún** concepto quedó marcado `Actualizado = true` tras el rollback — antes del fix, sí quedaban marcados.
- Probar el flujo de creación de una explosión nueva (debe responder 201) vs. actualización de una existente (debe responder 200).
- Revisar logs de `HelperLogError` para confirmar que las excepciones de reintento agotado (si llegan a ocurrir) siguen quedando registradas correctamente.
- Verificar que los precios de insumos nuevos se sigan creando correctamente (una sola fila por `IdInsumo`, sin duplicados) tras el cambio a `AddBulk`, y que los existentes se actualicen bien vía `UpdateBulk`.
- Verificar que la rama "contratable tipo 1" siga eliminando exactamente los mismos registros que antes (comparar antes/después con un presupuesto de prueba que tenga conceptos de este tipo con y sin movimientos asociados).
- Confirmar que `matrizConceptosParaActualizar` se persiste correctamente con `UpdateBulk` (mismo resultado que el `foreach` anterior, comparando los flags `Actualizado` tras la corrida).

---

## Anexo — Código propuesto completo (para análisis, aún no aplicado)

### 1. `EF/UnitOfWork/IUnitOfWork.cs` (nuevo)

```csharp
namespace EF.UnitOfWork
{
    public interface IUnitOfWork
    {
        /// <summary>
        /// Ejecuta la operación dentro de una única transacción de base de datos,
        /// usando la execution strategy del DbContext (compatible con AddDbContextPool).
        /// Si "operation" lanza cualquier excepción, se hace rollback y la excepción se repropaga.
        /// </summary>
        Task ExecuteInTransactionAsync(Func<Task> operation);
    }
}
```

### 2. `EF/UnitOfWork/UnitOfWork.cs` (nuevo)

```csharp
using EF.DataContext;
using Microsoft.EntityFrameworkCore;

namespace EF.UnitOfWork
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly AddControlErpContext _context;

        public UnitOfWork(AddControlErpContext context)
        {
            _context = context;
        }

        public async Task ExecuteInTransactionAsync(Func<Task> operation)
        {
            var strategy = _context.Database.CreateExecutionStrategy();

            await strategy.ExecuteAsync(async () =>
            {
                await using var transaction = await _context.Database.BeginTransactionAsync();
                try
                {
                    await operation();
                    await transaction.CommitAsync();
                }
                catch
                {
                    await transaction.RollbackAsync();
                    throw;
                }
            });
        }
    }
}
```

### 3. `Tools/Comun/ExplosionProcesoException.cs` (nuevo)

```csharp
namespace Tools.Comun
{
    /// <summary>
    /// Excepción de negocio para PostExplosionInsumos. Permite abortar el procesamiento
    /// (con rollback de la transacción) y propagar un mensaje específico al cliente,
    /// sin usar "return" dentro del delegado de ExecuteInTransactionAsync.
    /// </summary>
    public class ExplosionProcesoException : Exception
    {
        public ExplosionProcesoException(string? mensaje = null) : base(mensaje ?? string.Empty) { }
    }
}
```

### 4. `API/Extensions/ServiceCollectionExtensions.cs` (agregar registro)

```csharp
// Junto a los demás AddScoped de este archivo
builder.Services.AddScoped<IUnitOfWork, UnitOfWork>();
```
(agregar `using EF.UnitOfWork;` al inicio del archivo)

### 5. `API/Controllers/Presupuestos/PresupuestoController.cs` (constructor — diff)

```csharp
// Campo nuevo, junto a los demás "private readonly" (después de _helperUpload)
private readonly IUnitOfWork _unitOfWork;

// Parámetro nuevo en el constructor (después del último parámetro existente)
public PresupuestoController(IPresupuestoService presupuestoService,
    /* ...resto de parámetros existentes sin cambios... */
    IUnitOfWork unitOfWork)
{
    /* ...asignaciones existentes sin cambios... */
    _unitOfWork = unitOfWork;
}
```
(agregar `using EF.UnitOfWork;` al inicio de `PresupuestoController.cs`)

### 6. `API/Controllers/Presupuestos/PresupuestoExplosionInsumosController.cs` — `PostExplosionInsumos` reescrito completo

```csharp
[HttpPost("{id}/Explosion")]
public async Task<IActionResult> PostExplosionInsumos(int id)
{
    try
    {
        // ─── 1. CARGA DE DATOS DEL PRESUPUESTO ───────────────────────────────────
        var presupuesto = await _presupuestoService.GetById(id);

        // FIX bug #2: validar presupuesto nulo antes de usarlo (evita NullReferenceException)
        if (presupuesto == null)
            return _helperResponse.NotFoundCustom();

        var conceptosList = (await _presupuestoConceptoService.GetByIdPresupuesto(id)).ToList();
        var basicosList = (await _presupuestoMatrizConceptoService.GetByIdPresupuesto(id)).ToList();
        var matrizInsumosList = (await _presupuestoMatrizService.GetByPresupuesto(id)).ToList();
        var preciosList = (await _presupuestoInsumoPrecioService.GetByPresupuesto(id)).ToList();

        if (conceptosList.Count == 0 && matrizInsumosList.Count == 0)
            return _helperResponse.NotFoundCustom();

        // Variables capturadas por la transacción, usadas para construir la respuesta al final
        Explosione response = null;
        bool esNuevaExplosion = false;

        // ─── TODO el procesamiento corre dentro de una única transacción ─────────
        // Si cualquier paso falla (incluida la validación de cantidad negativa),
        // se revierte TODO — incluyendo los flags "Actualizado" — evitando el bug de atomicidad.
        await _unitOfWork.ExecuteInTransactionAsync(async () =>
        {
            // ─── 2. OBTENCIÓN O CREACIÓN DE LA EXPLOSIÓN ─────────────────────────
            response = await _explosionService.GetByIdPresupuesto(id);

            if (response == null)
            {
                esNuevaExplosion = true;

                var modelo = new WriteExplosionDto
                {
                    IdPresupuesto = id,
                    Codigo = "EX-" + presupuesto.Codigo,
                    Descripcion = presupuesto.Codigo,
                    IdUsuarioRegistro = Auth.Id,
                    FechaRegistro = DateTime.Now,
                    IdUsuarioModifico = Auth.Id,
                    FechaModifico = DateTime.Now,
                    Actualizada = true
                };

                // FIX bug #5: se elimina la reasignación redundante de los mismos campos
                // que ya se fijaron en "modelo" (antes se repetían aquí sin efecto).
                var mapResult = modelo.ToExplosionFromCreateDto();
                mapResult.Activo = true;

                response = await _explosionService.Add(mapResult);

                if (response == null)
                    throw new ExplosionProcesoException();
            }
            else
            {
                response.Actualizada = true;
                response.FechaModifico = DateTime.Now;
                response.IdUsuarioModifico = Auth.Id;

                await _explosionService.Update(response);
            }

            // ─── 3. PREPARACIÓN DEL LOOP ─────────────────────────────────────────
            var explosionInsumos = new List<WriteExplosionInsumoDto>();
            var conceptosNoActualizados = conceptosList.Where(x => !x.Actualizado).ToList();
            var explosionExistentePreLoop = (await _explosionInsumoService.GetByIdExplosion(response.Id)).ToList();

            var conceptosParaActualizar = new List<PresupuestosConcepto>();
            var matrizInsumosParaActualizar = new List<PresupuestosMatriz>();
            var matrizConceptosParaActualizar = new List<PresupuestosMatrizConcepto>();

            // Parte 3.1 — acumuladores de precios (reemplazan Add/Update por-item)
            var preciosNuevosPendientes = new Dictionary<int /*IdInsumo*/, WritePresupuestoInsumoPrecioDto>();
            var preciosParaActualizar = new List<BulkUpdatePresupuestoInsumoPrecioDto>();

            // Parte 3.2 — pre-carga en UNA sola consulta por servicio (antes: 4 queries por cada
            // "registro" dentro del loop). Se acota a los ids ya existentes en la explosión,
            // igual que "explosionExistentePreLoop".
            var idsExplosionInsumoPreLoop = explosionExistentePreLoop.Select(x => x.Id).ToList();
            var todasAditivas = idsExplosionInsumoPreLoop.Count > 0
                ? await _aditivaService.GetByIdsExplosionInsumo(idsExplosionInsumoPreLoop)
                : new List<AditivasDetalle>();
            var todasDeductivas = idsExplosionInsumoPreLoop.Count > 0
                ? await _deductivaService.GetByIdsExplosionInsumo(idsExplosionInsumoPreLoop)
                : new List<DeductivasDetalle>();
            var todosSubcontratos = idsExplosionInsumoPreLoop.Count > 0
                ? await _subcontratoService.GetByIdsExplosionInsumo(idsExplosionInsumoPreLoop)
                : new List<ExplosionesSubcontratosDetalle>();
            var todosAvances = idsExplosionInsumoPreLoop.Count > 0
                ? await _explosionInsumoAvanceService.GetByIdsExplosionInsumo(idsExplosionInsumoPreLoop)
                : new List<ExplosionesInsumosAvance>();
            var idsExplosionInsumoParaEliminar = new List<int>();

            // ─── 4. LOOP PRINCIPAL: PROCESAMIENTO DE CONCEPTOS ───────────────────
            foreach (var concepto in conceptosNoActualizados)
            {
                concepto.Actualizado = true;
                conceptosParaActualizar.Add(concepto);

                // ── 4a. Insumo directo del concepto ──────────────────────────────
                if (concepto.IdInsumo != null && concepto.IdInsumo > 0)
                {
                    var precioInsumo = preciosList.FirstOrDefault(x => x.IdInsumo == concepto.IdInsumo);
                    int idPrecio;

                    var precioConcepto = concepto.Precio ?? 0;
                    if (concepto.Contratable && concepto.IdTipoSubcontrato == 2)
                        precioConcepto = concepto.ImporteMatrizCondicion;

                    if (precioInsumo == null)
                    {
                        // Antes: Add inmediato (1 round-trip por concepto, con posible fila duplicada
                        // si el mismo insumo reaparecía sin precio en otro concepto/nodo del árbol).
                        // Ahora: se deduplica por IdInsumo y se resuelve todo junto tras el loop (3.1).
                        if (!preciosNuevosPendientes.ContainsKey(concepto.IdInsumo.Value))
                        {
                            preciosNuevosPendientes[concepto.IdInsumo.Value] = new WritePresupuestoInsumoPrecioDto
                            {
                                IdInsumo = concepto.IdInsumo ?? 0,
                                IdMoneda = concepto.IdMoneda,
                                IdPresupuesto = id,
                                Precio = precioConcepto,
                            };
                        }
                        idPrecio = 0; // placeholder, se resuelve por IdInsumo después del loop
                    }
                    else
                    {
                        if (precioInsumo.Precio != precioConcepto)
                        {
                            precioInsumo.Precio = precioConcepto;
                            if (!preciosParaActualizar.Any(x => x.Id == precioInsumo.Id))
                                preciosParaActualizar.Add(new BulkUpdatePresupuestoInsumoPrecioDto { Id = precioInsumo.Id, Precio = precioConcepto });
                        }
                        idPrecio = precioInsumo.Id;
                    }

                    explosionInsumos.Add(new WriteExplosionInsumoDto
                    {
                        IdExplosion = response.Id,
                        IdInsumo = concepto.IdInsumo ?? 0,
                        IdPrecio = idPrecio,
                        IdPresupuesto = id,
                        IdPresupuestoConcepto = concepto?.Id ?? 0,
                        Cantidad = (concepto?.Cantidad ?? 0),
                        IdUsuarioRegistro = Auth.Id,
                        FechaRegistro = DateTime.Now,
                        IdUsuarioModifico = Auth.Id,
                        FechaModifico = DateTime.Now,
                        NoConsiderado = false,
                        Autorizado = true,
                        Contratable = true
                    });
                }

                // ── 4b. Concepto contratable tipo suministro y colocación (IdTipoSubcontrato = 1) ──
                if (concepto?.Contratable == true && concepto?.IdTipoSubcontrato == 1)
                {
                    var registrosActuales = explosionExistentePreLoop
                        .Where(x => x.IdPresupuestoConcepto == concepto.Id)
                        .ToList();

                    foreach (var registro in registrosActuales)
                    {
                        // Antes: 4 queries awaited por registro. Ahora: chequeo en memoria
                        // contra los 4 listados pre-cargados una sola vez (3.2).
                        bool tieneMovimientos = todasAditivas.Any(x => x.IdExplosionInsumo == registro.Id)
                            || todasDeductivas.Any(x => x.IdExplosionInsumo == registro.Id)
                            || todosSubcontratos.Any(x => x.IdExplosionInsumo == registro.Id)
                            || todosAvances.Any(x => x.IdExplosionInsumo == registro.Id);

                        if (!tieneMovimientos)
                            idsExplosionInsumoParaEliminar.Add(registro.Id);
                    }

                    continue;
                }

                // ── 4c. Insumos directos de la matriz del concepto ────────────────
                var idConceptoDirectos = concepto?.Id ?? 0;
                var insumosDirectos = matrizInsumosList
                    .Where(p => p.IdConcepto == idConceptoDirectos && !p.Actualizado)
                    .AsEnumerable();

                if (concepto?.Contratable == true && concepto?.IdTipoSubcontrato == 2)
                {
                    insumosDirectos = insumosDirectos.Where(x => x.IdInsumoNavigation.IdTipoNavigation.ManoDeObra == false);

                    if (concepto.HerramientaMenor)
                        insumosDirectos = insumosDirectos.Where(x => x.IdInsumoNavigation.IdTipoNavigation.HerramientaMenor == false);
                }

                foreach (var insumo in insumosDirectos.ToList())
                {
                    var precioInsumo = preciosList.FirstOrDefault(x => x.Id == insumo.IdPrecio);

                    explosionInsumos.Add(new WriteExplosionInsumoDto
                    {
                        IdExplosion = response.Id,
                        IdInsumo = insumo.IdInsumo,
                        IdPrecio = precioInsumo?.Id ?? 0,
                        IdPresupuesto = id,
                        IdPresupuestoConcepto = concepto?.Id ?? 0,
                        Cantidad = insumo.Cantidad * (concepto?.Cantidad ?? 0),
                        IdUsuarioRegistro = Auth.Id,
                        FechaRegistro = DateTime.Now,
                        IdUsuarioModifico = Auth.Id,
                        FechaModifico = DateTime.Now,
                        NoConsiderado = false,
                        Autorizado = true,
                        Contratable = false
                    });

                    insumo.Actualizado = true;
                    matrizInsumosParaActualizar.Add(insumo);
                }

                // ── 4d. Árbol de insumos básicos (explosión recursiva) ────────────
                // NOTA: hallazgo #3 (filtro MOD/HerramientaMenor no propagado aquí) queda
                // documentado y pendiente de confirmar con negocio — no se modifica en este cambio.
                var idConceptoActual = concepto?.Id ?? 0;
                var padresIniciales = basicosList
                    .Where(p => p.IdPadre == null && p.IdConcepto == idConceptoActual)
                    .ToList();

                foreach (var padre in padresIniciales)
                {
                    await ProcesarInsumos(
                        basicosList, matrizInsumosList, padre,
                        concepto?.Cantidad ?? 0, explosionInsumos,
                        concepto?.Id ?? 0, id, response.Id, preciosList,
                        matrizInsumosParaActualizar, matrizConceptosParaActualizar,
                        preciosNuevosPendientes, preciosParaActualizar);

                    padre.Actualizado = true;
                    matrizConceptosParaActualizar.Add(padre);
                }
            }

            // ─── 5. APLICAR ACTUALIZACIONES EN BATCH ─────────────────────────────
            if (conceptosParaActualizar.Count > 0)
                await _presupuestoConceptoService.UpdateRange(conceptosParaActualizar);

            if (matrizInsumosParaActualizar.Count > 0)
                await _presupuestoMatrizService.UpdateBulk(matrizInsumosParaActualizar);

            // Parte 3.3 — antes: Update individual por nodo (foreach + N round-trips).
            if (matrizConceptosParaActualizar.Count > 0)
                await _presupuestoMatrizConceptoService.UpdateBulk(matrizConceptosParaActualizar);

            // Parte 3.2 — eliminar en batch los registros de explosión sin movimientos.
            if (idsExplosionInsumoParaEliminar.Count > 0)
                await _explosionInsumoService.DeleteRangeAsync(idsExplosionInsumoParaEliminar);

            // Parte 3.1 — resolver los precios nuevos/actualizados en batch y parchar los
            // placeholders (IdPrecio == 0) en "explosionInsumos" antes de agrupar (paso 6).
            if (preciosNuevosPendientes.Count > 0)
            {
                var nuevos = preciosNuevosPendientes.Values.Select(p => p.ToPresupuestoInsumoPrecioFromCreateDto()).ToList();
                var creados = await _presupuestoInsumoPrecioService.AddBulk(nuevos);

                var mapaIdPorInsumo = creados.ToDictionary(x => x.IdInsumo, x => x.Id);
                foreach (var item in explosionInsumos.Where(x => x.IdPrecio == 0))
                    item.IdPrecio = mapaIdPorInsumo[item.IdInsumo];
            }

            if (preciosParaActualizar.Count > 0)
                await _presupuestoInsumoPrecioService.UpdateBulk(preciosParaActualizar);

            // ─── 6. AGRUPACIÓN DE INSUMOS ────────────────────────────────────────
            var listaAgrupada = explosionInsumos.GroupBy(x => new
            {
                x.IdInsumo,
                x.IdPrecio,
                x.IdPresupuestoConcepto,
                x.NoConsiderado,
                x.Autorizado,
                x.Contratable
            }).Select(g => new WriteExplosionInsumoDto
            {
                IdInsumo = g.Key.IdInsumo,
                IdPrecio = g.Key.IdPrecio,
                IdPresupuestoConcepto = g.Key.IdPresupuestoConcepto,
                Cantidad = g.Sum(x => x.Cantidad),
                IdExplosion = g.First().IdExplosion,
                IdPresupuesto = g.First().IdPresupuesto,
                IdUsuarioRegistro = g.First().IdUsuarioRegistro,
                FechaRegistro = g.First().FechaRegistro,
                IdUsuarioModifico = g.First().IdUsuarioModifico,
                FechaModifico = g.First().FechaModifico,
                NoConsiderado = g.Key.NoConsiderado,
                Autorizado = g.Key.Autorizado,
                Contratable = g.Key.Contratable
            }).ToList();

            // ─── 7. UPSERT DE INSUMOS EN LA EXPLOSIÓN ────────────────────────────
            var explosionExistenteInsumos = (await _explosionInsumoService.GetByIdExplosion(response.Id)).ToList();
            var todosMovimientos = (await _explosionInsumoMovService.GetByExplosion(response.Id)).ToList();

            var registrosParaInsertar = new List<WriteExplosionInsumoDto>();
            var entidadesParaActualizar = new List<ExplosionesInsumo>();

            foreach (var item in listaAgrupada)
            {
                var registroExistente = explosionExistenteInsumos.FirstOrDefault(e =>
                    e.IdInsumo == item.IdInsumo &&
                    e.IdPresupuestoConcepto == item.IdPresupuestoConcepto &&
                    e.NoConsiderado == false &&
                    e.Contratable == item.Contratable);

                if (registroExistente != null)
                {
                    var movimiento = todosMovimientos.FirstOrDefault(m => m.IdExplosionInsumo == registroExistente.Id);

                    decimal cantidadFinal = item.Cantidad
                        + (movimiento?.CantidadAditiva ?? 0)
                        - (movimiento?.CantidadDeductiva ?? 0)
                        - (movimiento?.CantidadContratada ?? 0);

                    if (cantidadFinal < 0)
                    {
                        var insumo = await _insumoService.GetById(item.IdInsumo);

                        // FIX bug #1: en vez de "return" (que dejaría los batches del paso 5
                        // ya confirmados fuera de la transacción), se lanza la excepción para
                        // que ExecuteInTransactionAsync haga rollback de TODO antes de responder.
                        throw new ExplosionProcesoException(
                            $"La cantidad final para el insumo {insumo.Nombre} no puede ser negativa.");
                    }

                    registroExistente.Cantidad = item.Cantidad;
                    registroExistente.IdUsuarioModifico = Auth.Id;
                    registroExistente.FechaModifico = DateTime.Now;
                    registroExistente.NoConsiderado = item.NoConsiderado;
                    registroExistente.Autorizado = item.Autorizado;
                    registroExistente.Contratable = item.Contratable;
                    entidadesParaActualizar.Add(registroExistente);
                }
                else
                {
                    registrosParaInsertar.Add(item);
                }
            }

            // ─── 8. PERSISTENCIA EN BATCH ─────────────────────────────────────────
            if (entidadesParaActualizar.Count > 0)
                await _explosionInsumoService.UpdateRangeAsync(entidadesParaActualizar);

            if (registrosParaInsertar.Count > 0)
            {
                var mapList = registrosParaInsertar.Select(p => p.ToExplosionInsumoFromCreateDto()).ToList();
                var responseExplosion = await _explosionInsumoService.AddRangeAsync(mapList);

                if (responseExplosion == null || responseExplosion.Count == 0)
                    throw new ExplosionProcesoException("No se pudieron insertar los registros.");
            }
        });

        await HelperLogMovimiento.HandleMovimientoAsync(Auth.Id, Accion.Registro.ToString(), "Explosiones", Auth.Nombre, _logMovimientoService, "Explosiones", id.SerializeJson());

        // FIX bug #4: 201 solo si se creó una explosión nueva; 200 si se actualizó una existente.
        return esNuevaExplosion
            ? _helperResponse.CreatedCustom(response.ToExplosionDto())
            : _helperResponse.SuccessPutCustom();
    }
    catch (ExplosionProcesoException ex)
    {
        return _helperResponse.BadRequestCustom(ex.Message);
    }
    catch (Exception ex)
    {
        await HelperLogError.HandleErrorAsync(Auth.Id, null, Accion.Registro.ToString(), "Explosiones", ex, id.SerializeJson(), _logErrorService);
        return _helperResponse.BadRequestCustom();
    }
}
```

### 7. `ProcesarInsumos` reescrito (método recursivo privado, mismo archivo)

Cambia la firma: recibe los dos acumuladores de precios por referencia (mismas instancias que en el método principal) en vez de resolver el precio del insumo del nodo con `Add`/lookup inmediato.

```csharp
private async Task ProcesarInsumos(
    List<PresupuestosMatrizConcepto> matrizConceptos,
    List<PresupuestosMatriz> matrizInsumos,
    PresupuestosMatrizConcepto nodoActual,
    decimal cantidadAcumulada,
    List<WriteExplosionInsumoDto> explosionInsumos,
    int idConceptoRaiz,
    int idPresupuesto,
    int idExplosion,
    List<PresupuestosInsumosPrecio> precios,
    List<PresupuestosMatriz> matrizInsumosParaActualizar,
    List<PresupuestosMatrizConcepto> matrizConceptosParaActualizar,
    Dictionary<int, WritePresupuestoInsumoPrecioDto> preciosNuevosPendientes,
    List<BulkUpdatePresupuestoInsumoPrecioDto> preciosParaActualizar)
{
    var nuevaCantidadAcumulada = cantidadAcumulada * nodoActual.Cantidad;

    if (nodoActual.IdInsumo != null && nodoActual.IdInsumo > 0)
    {
        var precioInsumo = precios.FirstOrDefault(x => x.IdInsumo == nodoActual.IdInsumo);
        int idPrecio;

        if (precioInsumo == null)
        {
            // Igual que en 4a: se deduplica por IdInsumo y se resuelve en batch tras el loop principal.
            if (!preciosNuevosPendientes.ContainsKey(nodoActual.IdInsumo.Value))
            {
                preciosNuevosPendientes[nodoActual.IdInsumo.Value] = new WritePresupuestoInsumoPrecioDto
                {
                    IdInsumo = nodoActual.IdInsumo ?? 0,
                    IdMoneda = nodoActual.IdMoneda,
                    IdPresupuesto = idPresupuesto,
                    Precio = nodoActual.Precio,
                };
            }
            idPrecio = 0; // placeholder
        }
        else
        {
            idPrecio = precioInsumo.Id;
        }

        explosionInsumos.Add(new WriteExplosionInsumoDto
        {
            IdExplosion = idExplosion,
            IdInsumo = nodoActual.IdInsumo ?? 0,
            IdPrecio = idPrecio,
            IdPresupuesto = idPresupuesto,
            IdPresupuestoConcepto = idConceptoRaiz,
            Cantidad = nuevaCantidadAcumulada,
            IdUsuarioRegistro = Auth.Id,
            FechaRegistro = DateTime.Now,
            IdUsuarioModifico = Auth.Id,
            FechaModifico = DateTime.Now,
            NoConsiderado = false,
            Autorizado = true,
            Contratable = true
        });
    }

    var insumos = matrizInsumos
        .Where(p => p.IdMatrizConcepto == nodoActual.Id && !p.Actualizado)
        .ToList();

    foreach (var insumo in insumos)
    {
        explosionInsumos.Add(new WriteExplosionInsumoDto
        {
            IdExplosion = idExplosion,
            IdInsumo = insumo.IdInsumo,
            IdPrecio = insumo.IdPrecio,
            IdPresupuesto = idPresupuesto,
            IdPresupuestoConcepto = idConceptoRaiz,
            Cantidad = insumo.Cantidad * nuevaCantidadAcumulada,
            IdUsuarioRegistro = Auth.Id,
            FechaRegistro = DateTime.Now,
            IdUsuarioModifico = Auth.Id,
            FechaModifico = DateTime.Now,
            NoConsiderado = false,
            Autorizado = true,
            Contratable = false
        });

        insumo.Actualizado = true;
        matrizInsumosParaActualizar.Add(insumo);
    }

    var hijos = matrizConceptos
        .Where(x => x.IdPadre == nodoActual.Id)
        .ToList();

    foreach (var hijo in hijos)
    {
        await ProcesarInsumos(
            matrizConceptos, matrizInsumos, hijo,
            nuevaCantidadAcumulada, explosionInsumos,
            idConceptoRaiz, idPresupuesto, idExplosion, precios,
            matrizInsumosParaActualizar, matrizConceptosParaActualizar,
            preciosNuevosPendientes, preciosParaActualizar);

        hijo.Actualizado = true;
        matrizConceptosParaActualizar.Add(hijo);
    }
}
```

Notas sobre este código:
- El hallazgo #3 (filtro MOD/HerramientaMenor no propagado en `ProcesarInsumos`) queda documentado y **no se modifica** en este cambio — pendiente de confirmar con negocio.
- El caso de `precioInsumo.Precio != precioConcepto` **no existía dentro de `ProcesarInsumos`** en el código original (solo comparaba, nunca actualizaba el precio del nodo del árbol si ya existía) — se conserva ese mismo comportamiento aquí, no se agrega una actualización que no estaba antes.
- Falta agregar los `using` correspondientes en `PresupuestoExplosionInsumosController.cs`: `EF.UnitOfWork`, `Tools.Comun` (para `ExplosionProcesoException`), y los namespaces de `AditivasDetalle`, `DeductivasDetalle`, `ExplosionesSubcontratosDetalle`, `ExplosionesInsumosAvance` si no están ya importados (los servicios correspondientes ya se usan en el archivo, así que probablemente ya están).
- El namespace exacto de `Tools/Comun/ExplosionProcesoException.cs` debe confirmarse contra la convención real del proyecto para excepciones custom (no existe ninguna hoy, así que este sería el primer caso — si el equipo prefiere otra carpeta, ajustar la ubicación).
- Los métodos nuevos (`GetByIdsExplosionInsumo` ×4, `DeleteRangeAsync`, `UpdateBulk` para `PresupuestoMatrizConcepto`) deben agregarse primero en `EF`/`Services` (Parte 3) antes de que este código del controlador compile.
