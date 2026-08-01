## Frentes [Dev]
``` SQL
CREATE UNIQUE INDEX idx_frentes_centrocosto_codigo
ON "Frentes" ("IdCentroCosto", "Codigo")
WHERE "Activo" = true;

-- SCRIPT POR SI HAY DUPLICADOS
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

## Tipos Centros de Costo [Dev]
``` SQL
ALTER TABLE "TiposCentrosCostos"
ADD CONSTRAINT uq_tiposcentroscostos_nombre_corporativo
UNIQUE ("Nombre", "IdCorporativo");

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