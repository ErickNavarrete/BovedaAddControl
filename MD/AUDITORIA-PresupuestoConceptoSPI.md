---
tipo: auditoria-codigo
estado: activo
tags: [presupuestos, auditoria, backend]
---

# Auditoría: `PresupuestoConceptoProgramacionService.GetPresupuestoConceptoSPIResumen`

## Contexto

Auditoría de código del método `GetPresupuestoConceptoSPIResumen` y de los helpers privados que orquesta (`calcularValores`, `calcularAvanceProgramado`, `calcularAvanceProgramadoSemanal`, `calcularAvanceObraGastos`, `calcularOtrosGastos`), ubicados en
`Services/PresupuestosConceptosProgramaciones/PresupuestoConceptoProgramacionService.cs`.

Cada hallazgo fue verificado contra el código real (DTOs, repositorios, controller) en lugar de inferirse. Este documento **no modifica código** — es un plan de modificaciones pendientes para análisis y ejecución posterior.

Endpoint expuesto: `GET Conceptos/SPI` en `API/Controllers/Presupuestos/PresupuestoConceptoController.cs:747-762`, request DTO `Tools/PresupuestosConceptos/PresupuestoConceptoSPIAllRequestDto.cs`.

---

## Bugs confirmados

### 1. División por cero no protegida — `calcularValores` (línea 353)

```csharp
data.cantidadDias = data.cantidadConcepto / data.PresupuestoConceptoProgramacion.DiasDuracion;
```

- **Ubicación:** `PresupuestoConceptoProgramacionService.cs:353`
- **Evidencia:** `DiasDuracion` es `decimal` (`EF/DataContext/PresupuestosConceptosProgramacione.cs:18`, precision 18,6) y se usa **sin** protección contra cero, a diferencia de `semanasTotales` dos líneas arriba (línea 333), que sí usa `Math.Max(1, ...)`. `Services/Mappers/GanttMapper.cs:143,286` aplica `Math.Max(1, (int)Math.Round(x.DiasDuracion))` para este mismo campo, lo que confirma que `DiasDuracion == 0` ocurre en datos reales.
- **Impacto:** división decimal entre cero lanza `DivideByZeroException`. Como corre dentro del `foreach (var r in data)` (línea 141) sobre todos los conceptos del centro de costo, un solo concepto con `DiasDuracion = 0` tumba el resumen SPI completo del proyecto. No hay try/catch local; el controller solo devuelve un `BadRequestCustom` genérico sin indicar cuál concepto falló.
- **Fix propuesto:** aplicar `Math.Max(1, ...)` (o validar/loggear) igual que se hace para `semanasTotales`.

### 2. Falta de null-check en la cadena de fallback — `calcularAvanceObraGastos` (líneas 575, 578)

```csharp
var centroCosto = await _centroCostoService.GetById(idCentroCosto);
var empresa = await _empresaService.GetById(centroCosto.IdEmpresa);
```

- **Ubicación:** `PresupuestoConceptoProgramacionService.cs:575,578`
- **Evidencia:** Cada otra validación en este mismo árbol de decisión (`empresaACN`, `proyectFound`, `obraGastos`) verifica null/vacío y cae a `calcularOtrosGastos`, pero `centroCosto` y `empresa` no. `CentroCostoRepository.GetById` (`EF/Repositories/CentroCostoRepository.cs:79-88`) filtra `Activo == true` vía `FirstOrDefaultAsync`.
- **Impacto:** un centro de costo dado de baja (soft-delete, `Activo = false`) cuya configuración de AddControlNucleo (`centroCostoConfig`) siga activa provoca que `GetById` regrese `null` → `NullReferenceException` en `centroCosto.IdEmpresa`.
- **Fix propuesto:** agregar los mismos checks `if (x == null) { await calcularOtrosGastos(...); return; }` que ya usa el resto del método, tanto para `centroCosto` como para `empresa`.

### 3. Dependencia implícita no documentada entre `avanceObraOrigen` y `avanceProgramado`

- **Ubicación:** `PresupuestoConceptoProgramacionService.cs:230-302`, `Tools/PresupuestosConceptos/PresupuestoConceptoSPIAllRequestDto.cs`, `PresupuestoConceptoController.cs:753`
- **Evidencia:** `PresupuestoConceptoSPIAllRequestDto` define ambos flags como independientes, default `false`, sin validación cruzada; el controller los pasa tal cual al servicio.
- **Impacto:** si el caller pide `avanceObraOrigen=true` con `avanceProgramado=false`:
  - `response.AvanceProgramadoMes.Detalle` queda vacío (línea 145-162 solo corre si `avanceProgramado`).
  - El match por mes en línea 246 (`AvanceObraGasto.Detalle[].AvanceEjecutado/AvanceEjecutadoAcumulado`) siempre falla contra una lista vacía → quedan en su valor default.
  - `response.PresupuestoEjercido` (líneas 262-299) termina con `Programado = 0` / `ProgramadoAcumulado = 0` en todos los meses, porque el loop que siembra esos valores (262-274) itera sobre la lista vacía, y las únicas entradas que se agregan vienen de la rama `AvanceObraGasto` con `Programado` hardcodeado a `0` (línea 294).
  - El API responde 200 con datos técnicamente válidos pero engañosos (todo "programado" en cero), sin error ni advertencia.
- **Fix propuesto:** forzar `avanceProgramado = true` internamente cuando `avanceObraOrigen = true`, o documentar/validar explícitamente la dependencia (p. ej. rechazar la combinación inválida en el controller).

---

## Oportunidades de refactorización

### 4. Patrón N+1 de consultas

`calcularAvanceProgramado` / `calcularAvanceProgramadoSemanal` ejecutan un `await _customRepository.GetSumExplosionInsumoAvance(...)` por cada mes/semana, por cada concepto, de forma secuencial dentro del `foreach` externo de `GetPresupuestoConceptoSPIResumen` — O(conceptos × meses) round-trips a la BD. Además, ambos métodos vuelven a traer el historial completo de avances vía `_explosionInsumoAvanceService.GetByExplosionInsumo` (líneas 428, 528); si se piden `avanceProgramado` y `avanceProgramadoSemanal` juntos, se duplica la misma consulta por concepto.

**Sugerencia:** traer los avances del centro de costo/proyecto en un solo query y agrupar en memoria por concepto+periodo.

### 5. Lógica duplicada

`calcularAvanceProgramado` vs `calcularAvanceProgramadoSemanal`, y el bucketing mensual de `calcularAvanceObraGastos` vs `calcularOtrosGastos`, son casi idénticos (mismo patrón de loop, solo cambia la unidad de periodo o la fuente de datos).

**Sugerencia:** extraer un helper común de "bucketing por periodo" para reducir duplicación y el riesgo de que las dos copias diverjan.

### 6. Clave de agregación inconsistente

El merge mensual usa un string formateado (`x.Mes == ap.Mes`, líneas 151 y 246) mientras el semanal usa la fecha real (`x.SemanaDate == ap.SemanaDate`, línea 170). `MesDate` (DateTime) ya existe en el DTO y sería una clave más robusta, inmune a cambios de cultura/locale que afecten el formato de mes abreviado.

### 7. Convención de nombres

Los métodos privados (`calcularValores`, `calcularAvanceProgramado`, `calcularAvanceProgramadoSemanal`, `calcularAvanceObraGastos`, `calcularOtrosGastos`, `normalizar`) están en camelCase, pero el estándar del proyecto (CLAUDE.md, regla #10) exige PascalCase para métodos.

### 8. Mezcla decimal/double para dinero

`AvanceObraGasto`/`AvanceObraGastoDetalleDto` (`CostoEjercido`, `AvanceEjecutado`, `CPI`) usan `double` (líneas 235-238, 675) mientras el resto del pipeline SPI usa `decimal`. Antes de cambiarlo habría que confirmar si es intencional (p. ej. por consumidores downstream) o un descuido — no se revisó la definición completa de `AvanceObraGastoDto`.

### 9. Rama muerta

`data.semanasTotales > 0` (línea 336) siempre es verdadero porque `semanasTotales` ya se calculó con `Math.Max(1, ...)` dos líneas antes — el `: 0` nunca se ejecuta.

### 10. Sin validación de fechas invertidas

Si `FechaInicio > FechaFin` en la programación de un concepto, `semanasTotales`/`semanasFechaCorte` absorben el error silenciosamente (floor a 1/0) en vez de señalar un problema de datos.

---

## Próximos pasos

- [ ] Fix bug 1 — proteger `cantidadDias` contra `DiasDuracion = 0` (`Math.Max(1, ...)`)
- [ ] Fix bug 2 — agregar null-checks a `centroCosto`/`empresa` en `calcularAvanceObraGastos`
- [ ] Fix bug 3 — decidir y aplicar: forzar `avanceProgramado=true` cuando `avanceObraOrigen=true`, o validar/rechazar la combinación
- [ ] Refactor 4 — eliminar el patrón N+1 de consultas en `calcularAvanceProgramado`/`calcularAvanceProgramadoSemanal`
- [ ] Refactor 5 — extraer helper común de bucketing por periodo
- [ ] Refactor 6 — unificar la clave de agregación mensual a `MesDate`
- [ ] Refactor 7 — renombrar métodos privados a PascalCase
- [ ] Refactor 8 — confirmar con el equipo si `double` en `AvanceObraGasto*` es intencional; si no, migrar a `decimal`
- [ ] Refactor 9 — limpiar la rama muerta en `calcularValores`
- [ ] Refactor 10 — decidir si se valida `FechaInicio > FechaFin` en la capa de programación de conceptos

## Verificación (al implementar los fixes)

- **Bug 1:** probar con un concepto con `DiasDuracion = 0` y confirmar que ya no lanza excepción.
- **Bug 2:** probar con un centro de costo soft-deleted (`Activo = false`) que tenga configuración activa de AddControlNucleo, confirmar que cae a `calcularOtrosGastos` en vez de NRE.
- **Bug 3:** probar `GET Conceptos/SPI?avanceObraOrigen=true&avanceProgramado=false` y confirmar que ya no se ve un desglose mensual con `Programado` en 0 de forma engañosa (según la solución elegida).
- Correr los tests existentes de este servicio si existen; si no existen, considerar agregar casos unitarios con xUnit+Moq mockeando `IPresupuestoConceptoProgramacionCustomRepository` y los servicios inyectados.
