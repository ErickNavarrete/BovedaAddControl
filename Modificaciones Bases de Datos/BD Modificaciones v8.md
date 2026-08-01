---
tipo: changelog-bd
estado: activo
tags: [bd, postgresql]
---

Índice: [[Índice]]

## Presupuestos Partidad [Dev-Demo-Producción]
``` SQL
ALTER TABLE "PresupuestosPartidas"
ADD COLUMN "Bloqueado" BOOLEAN NOT NULL DEFAULT FALSE;

--FUNCIONES y VIEWS
presupuestospartidasview
fn_PresupuestosPartidas_Read_Paged
fn_presupuestospartidas_read
```

## Empresas [Dev-Demo-Producción]
``` SQL
DROP INDEX IF EXISTS public.unique_empresas_rfc;
CREATE UNIQUE INDEX unique_empresas_rfc_corporativo
ON public."Empresas"
USING btree ("RFC", "IdCorporativo")
WHERE ("Activo" = true);
```

## Insumos [Dev-Demo]
``` SQL
CREATE UNIQUE INDEX uix_insumos_corporativo_codigo
	ON "Insumos" ("IdCorporativo", "Codigo")
	WHERE "Activo" = true;
```
## Otros Gastos [Dev-Demo-Producción]
``` SQL
ALTER TABLE public."OtrosGastos" ALTER COLUMN "ConceptoGasto" TYPE varchar(80) USING "ConceptoGasto"::varchar(80);
```

## Explosión Insumos [Dev-Demo-Producción]
``` SQL
explosionesinsumosview
fn_explosionesinsumos_read_paged
fn_ExplosionesInsumosAgrupados_Read_Paged
```
## Tareas [Dev-Demo-Produccion]
``` SQL
INSERT INTO public."TiposEstatusTareas"("Nombre", "IdUsuarioRegistro", "FechaRegistro", "IdUsuarioModifico", "FechaModifico", "Activo")VALUES ('Completado', 1, current_timestamp, 1, current_timestamp, true);

fn_TareasPorVencer_Read_Paged
```
## AddControlNucleo Notificaciones [Dev-Demo-Produccion]
``` SQL
ALTER TABLE "AddControlNucleoNotificaciones"
ADD COLUMN "Autorizado" BOOLEAN NOT NULL DEFAULT FALSE;
```
## Monedas [DevFeature]
``` SQL
ALTER TABLE "Monedas" ADD COLUMN "Orden" INTEGER NOT NULL DEFAULT 99;
update "Monedas" m set "Orden" = 0 where m."Clave" = 'MXN';
update "Monedas" m set "Orden" = 1 where m."Clave" = 'DOP';
update "Monedas" m set "Orden" = 2 where m."Clave" = 'USD';
update "Monedas" m set "Orden" = 3 where m."Clave" = 'EUR';
update "Monedas" m set "Orden" = 4 where m."Clave" = 'COP';

--fn_monedas_read_paged
--ExplosionesSubcontratosDetallesView
--fn_ExplosionesSubcontratosDetalles_Read_Paged
```
