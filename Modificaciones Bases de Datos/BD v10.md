---
tipo: changelog-bd
estado: activo
tags: [bd, postgresql]
---

Índice: [[Modificaciones Bases de Datos/Índice]]

## Frentes [Dev-Demo-Producción]

``` SQL
BEGIN;

-- Numera los duplicados; el más antiguo (menor Id) se queda igual,
-- los demás reciben un sufijo -dupN
WITH duplicados AS (
    SELECT "Id",
           "Codigo",
           ROW_NUMBER() OVER (
               PARTITION BY "IdCentroCosto", "Codigo"
               ORDER BY "Id"
           ) AS rn
    FROM "Frentes"
    WHERE "Activo" = true
)
UPDATE "Frentes" f
SET "Codigo" = f."Codigo" || '-dup' || d.rn
FROM duplicados d
WHERE f."Id" = d."Id"
  AND d.rn > 1;

-- Verifica que ya no queden duplicados antes de confirmar
-- (esta consulta debe devolver 0 filas)
SELECT "IdCentroCosto", "Codigo", COUNT(*)
FROM "Frentes"
WHERE "Activo" = true
GROUP BY "IdCentroCosto", "Codigo"
HAVING COUNT(*) > 1;

-- Si todo se ve bien:
CREATE UNIQUE INDEX idx_frentes_centrocosto_codigo
ON "Frentes" ("IdCentroCosto", "Codigo")
WHERE "Activo" = true;

COMMIT;
-- Si algo salió mal, ejecuta ROLLBACK; en lugar de COMMIT;
```

## Tipos Centros de Costo [Dev-Demo-Producción]

``` SQL
BEGIN;

-- Numera los duplicados; el más antiguo (menor Id) se conserva igual,
-- los demás reciben un sufijo con 4 caracteres de un UUID en el Nombre
WITH duplicados AS (
    SELECT "Id",
           ROW_NUMBER() OVER (
               PARTITION BY "Nombre", "IdCorporativo"
               ORDER BY "Id"
           ) AS rn
    FROM "TiposCentrosCostos"
)
UPDATE "TiposCentrosCostos" t
SET "Nombre" = t."Nombre" || '-' || substring(gen_random_uuid()::text, 1, 4)
FROM duplicados d
WHERE t."Id" = d."Id"
  AND d.rn > 1;

-- Verifica que ya no queden duplicados (debe devolver 0 filas)
SELECT "Nombre", "IdCorporativo", COUNT(*)
FROM "TiposCentrosCostos"
GROUP BY "Nombre", "IdCorporativo"
HAVING COUNT(*) > 1;

-- Si todo se ve bien, aplica la restricción:
ALTER TABLE "TiposCentrosCostos"
ADD CONSTRAINT uq_tiposcentroscostos_nombre_corporativo
UNIQUE ("Nombre", "IdCorporativo");

COMMIT;
-- Si algo salió mal, ejecuta ROLLBACK; en lugar de COMMIT;
```

## Tipos Insumos [Dev-Demo-Producción]

``` SQL
ALTER TABLE "TiposInsumos"
ADD CONSTRAINT uq_tiposinsumos_codigo_corporativo
UNIQUE ("Codigo", "IdCorporativo");

BEGIN;

-- Numera los duplicados; el más antiguo (menor Id) se conserva igual,
-- los demás reciben un sufijo con 4 caracteres de un UUID en el Codigo
WITH duplicados AS (
    SELECT "Id",
           ROW_NUMBER() OVER (
               PARTITION BY "Codigo", "IdCorporativo"
               ORDER BY "Id"
           ) AS rn
    FROM "TiposInsumos"
)
UPDATE "TiposInsumos" t
SET "Codigo" = t."Codigo" || '-' || substring(gen_random_uuid()::text, 1, 4)
FROM duplicados d
WHERE t."Id" = d."Id"
  AND d.rn > 1;

-- Verifica que ya no queden duplicados (debe devolver 0 filas)
SELECT "Codigo", "IdCorporativo", COUNT(*)
FROM "TiposInsumos"
GROUP BY "Codigo", "IdCorporativo"
HAVING COUNT(*) > 1;

-- Si todo se ve bien, aplica la restricción:
ALTER TABLE "TiposInsumos"
ADD CONSTRAINT uq_tiposinsumos_codigo_corporativo
UNIQUE ("Codigo", "IdCorporativo");

COMMIT;
-- Si algo salió mal, ejecuta ROLLBACK; en lugar de COMMIT;
```
