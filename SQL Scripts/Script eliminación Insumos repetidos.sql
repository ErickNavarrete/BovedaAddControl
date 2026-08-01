-- =============================================================
-- SCRIPT: Eliminación de registros duplicados en "Insumos"
-- Criterio: IdCorporativo = 51 y CreadoPorConcepto = false
-- Estrategia:
--   1. Por cada grupo de duplicados, conservar UN registro
--      (se prioriza el de mayor "Id" asumiendo que es el más
--       reciente; ajusta el ORDER BY según tu lógica de negocio).
--   2. Intentar eliminar los demás; si alguno falla por FK
--      (está referenciado en otra tabla), se registra en un log
--      y se continúa con los siguientes.
-- =============================================================

-- ────────────────────────────────────────────────────────────
-- 0. VISTA PREVIA: cuántos duplicados existen antes de correr
-- ────────────────────────────────────────────────────────────
SELECT
    i."Codigo",
    COUNT(*)            AS cantidad,
    array_agg(i."Id" ORDER BY i."Id") AS ids
FROM "Insumos" i
WHERE i."IdCorporativo" = 51
  AND i."CreadoPorConcepto" = false
GROUP BY i."Codigo"
HAVING COUNT(*) > 1
ORDER BY cantidad DESC;


-- ────────────────────────────────────────────────────────────
-- 1. FUNCIÓN que elimina duplicados con manejo de errores
-- ────────────────────────────────────────────────────────────
DO $$
DECLARE
    rec             RECORD;
    id_a_eliminar   BIGINT;   -- ajusta el tipo si tu PK no es BIGINT
    eliminados      INT  := 0;
    omitidos        INT  := 0;
    total_intentos  INT  := 0;
BEGIN

    -- Tabla temporal para registrar los que NO se pudieron eliminar
    CREATE TEMP TABLE IF NOT EXISTS _log_omitidos (
        "Codigo"        TEXT,
        "Id"            BIGINT,   -- ajusta el tipo según tu PK
        motivo          TEXT,
        ts              TIMESTAMPTZ DEFAULT NOW()
    ) ON COMMIT DROP;

    -- ── Recorrer cada grupo de duplicados ───────────────────
    FOR rec IN
        SELECT
            i."Codigo",
            -- El que se CONSERVA (el de Id más bajo = el más antiguo).
            -- Cambia MIN() por MAX() si prefieres quedarte con el más reciente.
            MIN(i."Id") AS id_a_conservar,
            -- Todos los Ids del grupo
            array_agg(i."Id") AS todos_los_ids
        FROM "Insumos" i
        WHERE i."IdCorporativo" = 51
          AND i."CreadoPorConcepto" = false
        GROUP BY i."Codigo"
        HAVING COUNT(*) > 1
    LOOP

        -- ── Intentar eliminar cada Id que NO es el conservado ──
        FOREACH id_a_eliminar IN ARRAY rec.todos_los_ids
        LOOP
            CONTINUE WHEN id_a_eliminar = rec.id_a_conservar;

            total_intentos := total_intentos + 1;

            BEGIN
                DELETE FROM "Insumos"
                WHERE "Id" = id_a_eliminar;

                eliminados := eliminados + 1;

                RAISE NOTICE 'Eliminado: Codigo=% | Id=%', rec."Codigo", id_a_eliminar;

            EXCEPTION
                WHEN foreign_key_violation THEN
                    omitidos := omitidos + 1;

                    INSERT INTO _log_omitidos("Codigo", "Id", motivo)
                    VALUES (rec."Codigo", id_a_eliminar,
                            'FK violation: referenciado en otra tabla');

                    RAISE NOTICE 'OMITIDO (FK): Codigo=% | Id=%', rec."Codigo", id_a_eliminar;

                WHEN OTHERS THEN
                    omitidos := omitidos + 1;

                    INSERT INTO _log_omitidos("Codigo", "Id", motivo)
                    VALUES (rec."Codigo", id_a_eliminar,
                            SQLERRM);

                    RAISE NOTICE 'OMITIDO (error): Codigo=% | Id=% | Error=%',
                                 rec."Codigo", id_a_eliminar, SQLERRM;
            END;

        END LOOP;
    END LOOP;

    -- ── Resumen final ────────────────────────────────────────
    RAISE NOTICE '════════════════════════════════════════';
    RAISE NOTICE 'Total intentos  : %', total_intentos;
    RAISE NOTICE 'Eliminados OK   : %', eliminados;
    RAISE NOTICE 'Omitidos (error): %', omitidos;
    RAISE NOTICE '════════════════════════════════════════';

END;
$$;


-- ────────────────────────────────────────────────────────────
-- 2. Ver los registros que NO pudieron eliminarse
-- ────────────────────────────────────────────────────────────
SELECT * FROM _log_omitidos ORDER BY "Codigo";


-- ────────────────────────────────────────────────────────────
-- 3. VERIFICACIÓN: deben quedar 0 grupos con COUNT > 1
--    (excepto los que quedaron por tener referencias activas)
-- ────────────────────────────────────────────────────────────
SELECT
    i."Codigo",
    COUNT(*)            AS cantidad,
    array_agg(i."Id" ORDER BY i."Id") AS ids
FROM "Insumos" i
WHERE i."IdCorporativo" = 51
  AND i."CreadoPorConcepto" = false
GROUP BY i."Codigo"
HAVING COUNT(*) > 1
ORDER BY cantidad DESC;