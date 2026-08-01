---
tipo: changelog-bd
estado: completado
tags: [bd, postgresql]
---

Índice: [[Índice]]

## Conceptos Predecesores [Dev-Demo-Producción]
``` SQL
CREATE TABLE "ConceptosPredecesores" (
"Id" INT GENERATED ALWAYS AS IDENTITY,
"IdConceptoPredecesor" INT NOT NULL,
"IdProgramacion" INT NOT NULL,
"IdUsuarioRegistro" INT not NULL,
"FechaRegistro" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,

-- 🔑 Primary Key explícita con nombre
CONSTRAINT "PK_ConceptosPredecesores"
PRIMARY KEY ("Id"),

-- 🔗 Foreign Keys
CONSTRAINT "FK_ConceptosPredecesores_ConceptoPredecesor"
FOREIGN KEY ("IdConceptoPredecesor")
REFERENCES "PresupuestosConceptos" ("Id"),

CONSTRAINT "FK_ConceptosPredecesores_Programacion"
FOREIGN KEY ("IdProgramacion")
REFERENCES "PresupuestosConceptosProgramaciones" ("Id"),

CONSTRAINT "FK_ConceptosPredecesores_UsuarioRegistro"
FOREIGN KEY ("IdUsuarioRegistro")
REFERENCES "Usuarios" ("Id"),

-- 🚫 Evitar duplicados
CONSTRAINT "UQ_ConceptoPredecesor_Programacion"
UNIQUE ("IdConceptoPredecesor", "IdProgramacion")
);

-- ⚡ Índices
CREATE INDEX "IX_ConceptosPredecesores_IdProgramacion"
ON "ConceptosPredecesores" ("IdProgramacion");

CREATE INDEX "IX_ConceptosPredecesores_IdConceptoPredecesor"
ON "ConceptosPredecesores" ("IdConceptoPredecesor");

CREATE INDEX "IX_ConceptosPredecesores_IdUsuarioRegistro"
ON "ConceptosPredecesores" ("IdUsuarioRegistro");

-- Script relaciones existentes conceptos predecesoras


INSERT INTO public."ConceptosPredecesores"
(
    "IdConceptoPredecesor",
    "IdProgramacion",
    "IdUsuarioRegistro",
    "FechaRegistro"
)
SELECT
    pcp."IdConceptoPredecesor",
    pcp."Id",
    pcp."IdUsuarioRegistro",
    pcp."FechaRegistro"
FROM public."PresupuestosConceptosProgramaciones" pcp
WHERE pcp."IdConceptoPredecesor" IS NOT NULL
ON CONFLICT ("IdConceptoPredecesor", "IdProgramacion") DO NOTHING;
```

## Explosión Insumo Paged [Dev-Demo-Producción]
``` SQL
fn_ExplosionesInsumos_Read_Paged
fn_ExplosionesInsumos_Read_Agrupado_Insumo_Paged
```
## Permisos Empresas [Dev-Demo-Producción]
``` SQL
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (3,'Configuración Fiscal - RD','modulo_empresas_configuracion_fiscal_rd',3,3);
```

## Aditivas y Deductivas [Dev-Demo-Producción]
``` SQL
fn_calculosaditivasestatus
fn_CalculosDeductivasEstatus
```

## Presupuestos Conceptos [Dev-Demo-Producción]
``` SQL
fn_presupuestosconceptos_read
```

## Cambios Mario [Dev-Demo-Producción]
``` SQL
fn_presupuestospartidas_read
fn_Presupuestos_Read

fn_explosioninsumoavance_analisis_concepto_read_paged
fn_explosioninsumoavance_analisis_partida_read_paged
fn_ExplosionInsumoAvance_Read_Paged
```