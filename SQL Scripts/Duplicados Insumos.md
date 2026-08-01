## Elimina duplicados

Código Insumo
IdCorporativo
CreadoPorInsumo = false

``` SQL
-- =============================================================
-- SCRIPT: Eliminación de duplicados en "Insumos"
-- Clave de duplicado : "Codigo" + "IdCorporativo"
-- Filtro adicional   : "CreadoPorConcepto" = false
-- Estrategia:
--   1. Por cada grupo, conservar el registro con el Id más bajo.
--   2. Intentar eliminar los demás en orden ascendente de Id.
--   3. Si un Id falla (FK u otro error), pasar al siguiente
--      del mismo grupo e intentar eliminarlo.
--   4. Si NINGÚN duplicado del grupo pudo eliminarse, el grupo
--      completo queda en el reporte final.
-- =============================================================


-- ────────────────────────────────────────────────────────────
-- 0. VISTA PREVIA: duplicados existentes antes de ejecutar
-- ────────────────────────────────────────────────────────────
SELECT
    i."Codigo",
    i."IdCorporativo",
    COUNT(*)                                  AS cantidad,
    array_agg(i."Id" ORDER BY i."Id")         AS ids
FROM "Insumos" i
WHERE i."CreadoPorConcepto" = false
GROUP BY i."Codigo", i."IdCorporativo"
HAVING COUNT(*) > 1
ORDER BY cantidad DESC;


-- ────────────────────────────────────────────────────────────
-- 1. LÓGICA PRINCIPAL
-- ────────────────────────────────────────────────────────────
DO $$
DECLARE
    rec              RECORD;
    id_a_eliminar    BIGINT;   -- ajusta el tipo si tu PK no es BIGINT
    eliminado_alguno BOOLEAN;
    eliminados       INT := 0;
    grupos_ok        INT := 0;
    grupos_fallidos  INT := 0;
    total_grupos     INT := 0;
BEGIN

    -- Tabla temporal: grupos donde NO se pudo eliminar ningún duplicado
    CREATE TEMP TABLE IF NOT EXISTS _grupos_sin_eliminar (
        "Codigo"         TEXT,
        "IdCorporativo"  INT,
        id_conservado    BIGINT,
        ids_bloqueados   BIGINT[],
        ts               TIMESTAMPTZ DEFAULT NOW()
    ) ON COMMIT DROP;

    -- ── Recorrer cada grupo de duplicados ───────────────────
    FOR rec IN
        SELECT
            i."Codigo",
            i."IdCorporativo",
            -- Id que se conserva (el más antiguo del grupo)
            MIN(i."Id")                               AS id_a_conservar,
            -- Todos los Ids del grupo en orden ascendente
            array_agg(i."Id" ORDER BY i."Id")         AS todos_los_ids
        FROM "Insumos" i
        WHERE i."CreadoPorConcepto" = false
        GROUP BY i."Codigo", i."IdCorporativo"
        HAVING COUNT(*) > 1
    LOOP
        total_grupos     := total_grupos + 1;
        eliminado_alguno := false;

        RAISE NOTICE '──────────────────────────────────────────';
        RAISE NOTICE 'Grupo: Codigo=% | IdCorporativo=%  →  conservar Id=%',
                     rec."Codigo", rec."IdCorporativo", rec.id_a_conservar;

        -- ── Intentar cada Id candidato a eliminar ───────────
        FOREACH id_a_eliminar IN ARRAY rec.todos_los_ids
        LOOP
            -- Saltar el que se va a conservar
            CONTINUE WHEN id_a_eliminar = rec.id_a_conservar;

            BEGIN
                DELETE FROM "Insumos"
                WHERE "Id" = id_a_eliminar
                  AND "CreadoPorConcepto" = false;

                eliminado_alguno := true;
                eliminados       := eliminados + 1;

                RAISE NOTICE '  ✓ Eliminado Id=%', id_a_eliminar;

            EXCEPTION
                WHEN foreign_key_violation THEN
                    RAISE NOTICE '  ✗ Omitido Id=% (FK violation)', id_a_eliminar;

                WHEN OTHERS THEN
                    RAISE NOTICE '  ✗ Omitido Id=% (Error: %)', id_a_eliminar, SQLERRM;
            END;

        END LOOP;

        -- ── Registrar grupos donde no se pudo eliminar nada ─
        IF NOT eliminado_alguno THEN
            grupos_fallidos := grupos_fallidos + 1;

            INSERT INTO _grupos_sin_eliminar(
                "Codigo", "IdCorporativo", id_conservado, ids_bloqueados
            )
            VALUES (
                rec."Codigo",
                rec."IdCorporativo",
                rec.id_a_conservar,
                -- Todos excepto el conservado
                ARRAY(
                    SELECT UNNEST(rec.todos_los_ids)
                    EXCEPT
                    SELECT rec.id_a_conservar
                )
            );

            RAISE NOTICE '  !! Ningún duplicado pudo eliminarse en este grupo.';
        ELSE
            grupos_ok := grupos_ok + 1;
        END IF;

    END LOOP;

    -- ── Resumen ──────────────────────────────────────────────
    RAISE NOTICE '════════════════════════════════════════';
    RAISE NOTICE 'Grupos procesados          : %', total_grupos;
    RAISE NOTICE 'Grupos resueltos           : %', grupos_ok;
    RAISE NOTICE 'Grupos sin resolver        : %', grupos_fallidos;
    RAISE NOTICE 'Registros eliminados total : %', eliminados;
    RAISE NOTICE '════════════════════════════════════════';

END;
$$;


-- ────────────────────────────────────────────────────────────
-- 2. GRUPOS QUE NO PUDIERON RESOLVERSE
--    (ningún duplicado pudo eliminarse; requieren revisión manual)
-- ────────────────────────────────────────────────────────────
SELECT
    g."Codigo",
    g."IdCorporativo",
    g.id_conservado,
    g.ids_bloqueados,
    g.ts AS procesado_en
FROM _grupos_sin_eliminar g
ORDER BY g."Codigo";


-- ────────────────────────────────────────────────────────────
-- 3. VERIFICACIÓN FINAL
--    Solo deben quedar los grupos que no pudieron resolverse
-- ────────────────────────────────────────────────────────────
SELECT
    i."Codigo",
    i."IdCorporativo",
    COUNT(*)                              AS cantidad,
    array_agg(i."Id" ORDER BY i."Id")    AS ids_restantes
FROM "Insumos" i
WHERE i."CreadoPorConcepto" = false
GROUP BY i."Codigo", i."IdCorporativo"
HAVING COUNT(*) > 1
ORDER BY cantidad DESC;
```

## Elimina duplicados y relación

``` SQL
-- =============================================================
-- SCRIPT: Unificación de duplicados bloqueados por FK
-- Autónomo: genera _grupos_sin_eliminar internamente y luego
--   procede a reasignar FK y eliminar los duplicados bloqueados.
-- Tablas hijas identificadas (todas usan columna "IdInsumo"):
--   1.  AddControlNucleoAvanceObraOrigenes
--   2.  CentrosCostosExistenciasInsumos
--   3.  CotizacionInsumosAgrupados
--   4.  DevolucionesInsumosDetalles
--   5.  ExplosionesInsumos
--   6.  ExplosionesInsumosAgrupados
--   7.  InsumosAuxiliares
--   8.  PresupuestosConceptos
--   9.  PresupuestosInsumosPrecios
--  10.  PresupuestosMatriz
--  11.  PresupuestosMatrizConceptos
--  12.  RecepcionesInsumosDetalles
--  13.  RequisicionesDetallesAuxiliares
--  14.  SalidasInsumosDetalles
-- Estrategia:
--   1. Por cada grupo, intentar eliminar cada duplicado.
--      Si falla por FK, pasar al siguiente del mismo grupo.
--   2. Si NINGUNO del grupo pudo eliminarse, registrarlo
--      en _grupos_sin_eliminar para reasignar FK después.
--   3. Reasignar IdInsumo en las 14 tablas hijas y eliminar.
-- =============================================================


-- ────────────────────────────────────────────────────────────
-- 1. CREAR Y POBLAR _grupos_sin_eliminar
--    Intenta eliminar directamente; solo registra los grupos
--    donde NINGÚN duplicado pudo borrarse.
-- ────────────────────────────────────────────────────────────
DO $$
DECLARE
    rec              RECORD;
    id_a_eliminar    BIGINT;
    eliminado_alguno BOOLEAN;
    ids_fallidos     BIGINT[];   -- acumula los que fallan en el grupo
    total_grupos     INT := 0;
    total_eliminados INT := 0;
    total_bloqueados INT := 0;
BEGIN

    DROP TABLE IF EXISTS _grupos_sin_eliminar;

    CREATE TEMP TABLE _grupos_sin_eliminar (
        "Codigo"         TEXT,
        "IdCorporativo"  INT,
        id_conservado    BIGINT,
        ids_bloqueados   BIGINT[],
        ts               TIMESTAMPTZ DEFAULT NOW()
    );

    FOR rec IN
        SELECT
            i."Codigo",
            i."IdCorporativo",
            MIN(i."Id")                           AS id_a_conservar,
            array_agg(i."Id" ORDER BY i."Id")     AS todos_los_ids
        FROM "Insumos" i
        WHERE i."CreadoPorConcepto" = false
        GROUP BY i."Codigo", i."IdCorporativo"
        HAVING COUNT(*) > 1
    LOOP
        total_grupos     := total_grupos + 1;
        eliminado_alguno := false;
        ids_fallidos     := ARRAY[]::BIGINT[];

        RAISE NOTICE '──────────────────────────────────────────';
        RAISE NOTICE 'Grupo: Codigo=% | IdCorporativo=%  →  conservar Id=%',
                     rec."Codigo", rec."IdCorporativo", rec.id_a_conservar;

        FOREACH id_a_eliminar IN ARRAY rec.todos_los_ids
        LOOP
            CONTINUE WHEN id_a_eliminar = rec.id_a_conservar;

            BEGIN
                DELETE FROM "Insumos"
                WHERE  "Id"                = id_a_eliminar
                  AND  "CreadoPorConcepto" = false;

                eliminado_alguno := true;
                total_eliminados := total_eliminados + 1;

                RAISE NOTICE '  ✓ Eliminado Id=%', id_a_eliminar;

            EXCEPTION
                WHEN foreign_key_violation THEN
                    -- Acumular el Id fallido para registrarlo si el grupo queda bloqueado
                    ids_fallidos := array_append(ids_fallidos, id_a_eliminar);
                    RAISE NOTICE '  ✗ Omitido Id=% (FK violation) — pasando al siguiente', id_a_eliminar;

                WHEN OTHERS THEN
                    ids_fallidos := array_append(ids_fallidos, id_a_eliminar);
                    RAISE NOTICE '  ✗ Omitido Id=% (Error: %) — pasando al siguiente', id_a_eliminar, SQLERRM;
            END;

        END LOOP;

        -- Solo registrar el grupo si NINGUNO pudo eliminarse
        IF NOT eliminado_alguno THEN
            total_bloqueados := total_bloqueados + 1;

            INSERT INTO _grupos_sin_eliminar(
                "Codigo", "IdCorporativo", id_conservado, ids_bloqueados
            )
            VALUES (
                rec."Codigo",
                rec."IdCorporativo",
                rec.id_a_conservar,
                ids_fallidos   -- array acumulado, ordenado y completo
            );

            RAISE NOTICE '  !! Grupo completamente bloqueado — requiere reasignación FK';
        ELSE
            IF array_length(ids_fallidos, 1) > 0 THEN
                RAISE NOTICE '  ~ Grupo parcialmente resuelto. Ids aún con FK: %', ids_fallidos;
            END IF;
        END IF;

    END LOOP;

    RAISE NOTICE '════════════════════════════════════════';
    RAISE NOTICE 'Grupos procesados    : %', total_grupos;
    RAISE NOTICE 'Registros eliminados : %', total_eliminados;
    RAISE NOTICE 'Grupos bloqueados    : %', total_bloqueados;
    RAISE NOTICE '════════════════════════════════════════';

END;
$$;

-- Vista previa de grupos que requieren reasignación FK
SELECT
    g."Codigo",
    g."IdCorporativo",
    g.id_conservado,
    g.ids_bloqueados
FROM _grupos_sin_eliminar g
ORDER BY g."Codigo";


-- ────────────────────────────────────────────────────────────
-- 2. UNIFICACIÓN: reasignar FK en las 14 tablas y eliminar
-- ────────────────────────────────────────────────────────────
DO $$
DECLARE
    rec           RECORD;
    id_bloqueado  BIGINT;
    actualizados  INT := 0;   -- se reinicia en cada UPDATE
    eliminados    INT := 0;
    fallidos      INT := 0;
BEGIN

    DROP TABLE IF EXISTS _log_unificacion;

    CREATE TEMP TABLE _log_unificacion (
        "Codigo"         TEXT,
        "IdCorporativo"  INT,
        id_conservado    BIGINT,
        id_bloqueado     BIGINT,
        tabla_hija       TEXT,
        filas_afectadas  INT,
        resultado        TEXT,
        ts               TIMESTAMPTZ DEFAULT NOW()
    );

    FOR rec IN
        SELECT
            g."Codigo",
            g."IdCorporativo",
            g.id_conservado,
            g.ids_bloqueados
        FROM _grupos_sin_eliminar g
    LOOP

        RAISE NOTICE '══════════════════════════════════════════';
        RAISE NOTICE 'Grupo: Codigo=% | IdCorporativo=%',
                     rec."Codigo", rec."IdCorporativo";
        RAISE NOTICE '  Conservar Id=%  |  Bloqueados=%',
                     rec.id_conservado, rec.ids_bloqueados;

        FOREACH id_bloqueado IN ARRAY rec.ids_bloqueados
        LOOP
            RAISE NOTICE '  ── Procesando Id bloqueado: %', id_bloqueado;

            -- ── 1. PresupuestosInsumosPrecios ────────────────
            BEGIN
                UPDATE "PresupuestosInsumosPrecios"
                SET    "IdInsumo" = rec.id_conservado
                WHERE  "IdInsumo" = id_bloqueado;
                GET DIAGNOSTICS actualizados = ROW_COUNT;
                RAISE NOTICE '    ✓ PresupuestosInsumosPrecios: % fila(s)', actualizados;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'PresupuestosInsumosPrecios', actualizados, 'OK', NOW());
            EXCEPTION WHEN OTHERS THEN
                RAISE NOTICE '    ✗ PresupuestosInsumosPrecios: %', SQLERRM;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'PresupuestosInsumosPrecios', 0, SQLERRM, NOW());
            END;

            -- ── 2. AddControlNucleoAvanceObraOrigenes ───────
            BEGIN
                UPDATE "AddControlNucleoAvanceObraOrigenes"
                SET    "IdInsumo" = rec.id_conservado
                WHERE  "IdInsumo" = id_bloqueado;
                GET DIAGNOSTICS actualizados = ROW_COUNT;
                RAISE NOTICE '    ✓ AddControlNucleoAvanceObraOrigenes: % fila(s)', actualizados;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'AddControlNucleoAvanceObraOrigenes', actualizados, 'OK', NOW());
            EXCEPTION WHEN OTHERS THEN
                RAISE NOTICE '    ✗ AddControlNucleoAvanceObraOrigenes: %', SQLERRM;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'AddControlNucleoAvanceObraOrigenes', 0, SQLERRM, NOW());
            END;

            -- ── 3. CentrosCostosExistenciasInsumos ──────────
            BEGIN
                UPDATE "CentrosCostosExistenciasInsumos"
                SET    "IdInsumo" = rec.id_conservado
                WHERE  "IdInsumo" = id_bloqueado;
                GET DIAGNOSTICS actualizados = ROW_COUNT;
                RAISE NOTICE '    ✓ CentrosCostosExistenciasInsumos: % fila(s)', actualizados;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'CentrosCostosExistenciasInsumos', actualizados, 'OK', NOW());
            EXCEPTION WHEN OTHERS THEN
                RAISE NOTICE '    ✗ CentrosCostosExistenciasInsumos: %', SQLERRM;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'CentrosCostosExistenciasInsumos', 0, SQLERRM, NOW());
            END;

            -- ── 4. CotizacionInsumosAgrupados ────────────────
            BEGIN
                UPDATE "CotizacionInsumosAgrupados"
                SET    "IdInsumo" = rec.id_conservado
                WHERE  "IdInsumo" = id_bloqueado;
                GET DIAGNOSTICS actualizados = ROW_COUNT;
                RAISE NOTICE '    ✓ CotizacionInsumosAgrupados: % fila(s)', actualizados;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'CotizacionInsumosAgrupados', actualizados, 'OK', NOW());
            EXCEPTION WHEN OTHERS THEN
                RAISE NOTICE '    ✗ CotizacionInsumosAgrupados: %', SQLERRM;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'CotizacionInsumosAgrupados', 0, SQLERRM, NOW());
            END;

            -- ── 5. DevolucionesInsumosDetalles ───────────────
            BEGIN
                UPDATE "DevolucionesInsumosDetalles"
                SET    "IdInsumo" = rec.id_conservado
                WHERE  "IdInsumo" = id_bloqueado;
                GET DIAGNOSTICS actualizados = ROW_COUNT;
                RAISE NOTICE '    ✓ DevolucionesInsumosDetalles: % fila(s)', actualizados;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'DevolucionesInsumosDetalles', actualizados, 'OK', NOW());
            EXCEPTION WHEN OTHERS THEN
                RAISE NOTICE '    ✗ DevolucionesInsumosDetalles: %', SQLERRM;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'DevolucionesInsumosDetalles', 0, SQLERRM, NOW());
            END;

            -- ── 6. ExplosionesInsumos ────────────────────────
            BEGIN
                UPDATE "ExplosionesInsumos"
                SET    "IdInsumo" = rec.id_conservado
                WHERE  "IdInsumo" = id_bloqueado;
                GET DIAGNOSTICS actualizados = ROW_COUNT;
                RAISE NOTICE '    ✓ ExplosionesInsumos: % fila(s)', actualizados;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'ExplosionesInsumos', actualizados, 'OK', NOW());
            EXCEPTION WHEN OTHERS THEN
                RAISE NOTICE '    ✗ ExplosionesInsumos: %', SQLERRM;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'ExplosionesInsumos', 0, SQLERRM, NOW());
            END;

            -- ── 7. ExplosionesInsumosAgrupados ───────────────
            BEGIN
                UPDATE "ExplosionesInsumosAgrupados"
                SET    "IdInsumo" = rec.id_conservado
                WHERE  "IdInsumo" = id_bloqueado;
                GET DIAGNOSTICS actualizados = ROW_COUNT;
                RAISE NOTICE '    ✓ ExplosionesInsumosAgrupados: % fila(s)', actualizados;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'ExplosionesInsumosAgrupados', actualizados, 'OK', NOW());
            EXCEPTION WHEN OTHERS THEN
                RAISE NOTICE '    ✗ ExplosionesInsumosAgrupados: %', SQLERRM;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'ExplosionesInsumosAgrupados', 0, SQLERRM, NOW());
            END;

            -- ── 8. InsumosAuxiliares ─────────────────────────
            BEGIN
                UPDATE "InsumosAuxiliares"
                SET    "IdInsumo" = rec.id_conservado
                WHERE  "IdInsumo" = id_bloqueado;
                GET DIAGNOSTICS actualizados = ROW_COUNT;
                RAISE NOTICE '    ✓ InsumosAuxiliares: % fila(s)', actualizados;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'InsumosAuxiliares', actualizados, 'OK', NOW());
            EXCEPTION WHEN OTHERS THEN
                RAISE NOTICE '    ✗ InsumosAuxiliares: %', SQLERRM;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'InsumosAuxiliares', 0, SQLERRM, NOW());
            END;

            -- ── 9. PresupuestosConceptos ─────────────────────
            BEGIN
                UPDATE "PresupuestosConceptos"
                SET    "IdInsumo" = rec.id_conservado
                WHERE  "IdInsumo" = id_bloqueado;
                GET DIAGNOSTICS actualizados = ROW_COUNT;
                RAISE NOTICE '    ✓ PresupuestosConceptos: % fila(s)', actualizados;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'PresupuestosConceptos', actualizados, 'OK', NOW());
            EXCEPTION WHEN OTHERS THEN
                RAISE NOTICE '    ✗ PresupuestosConceptos: %', SQLERRM;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'PresupuestosConceptos', 0, SQLERRM, NOW());
            END;

            -- ── 10. PresupuestosMatriz ───────────────────────
            BEGIN
                UPDATE "PresupuestosMatriz"
                SET    "IdInsumo" = rec.id_conservado
                WHERE  "IdInsumo" = id_bloqueado;
                GET DIAGNOSTICS actualizados = ROW_COUNT;
                RAISE NOTICE '    ✓ PresupuestosMatriz: % fila(s)', actualizados;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'PresupuestosMatriz', actualizados, 'OK', NOW());
            EXCEPTION WHEN OTHERS THEN
                RAISE NOTICE '    ✗ PresupuestosMatriz: %', SQLERRM;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'PresupuestosMatriz', 0, SQLERRM, NOW());
            END;

            -- ── 11. PresupuestosMatrizConceptos ─────────────
            BEGIN
                UPDATE "PresupuestosMatrizConceptos"
                SET    "IdInsumo" = rec.id_conservado
                WHERE  "IdInsumo" = id_bloqueado;
                GET DIAGNOSTICS actualizados = ROW_COUNT;
                RAISE NOTICE '    ✓ PresupuestosMatrizConceptos: % fila(s)', actualizados;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'PresupuestosMatrizConceptos', actualizados, 'OK', NOW());
            EXCEPTION WHEN OTHERS THEN
                RAISE NOTICE '    ✗ PresupuestosMatrizConceptos: %', SQLERRM;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'PresupuestosMatrizConceptos', 0, SQLERRM, NOW());
            END;

            -- ── 12. RecepcionesInsumosDetalles ───────────────
            BEGIN
                UPDATE "RecepcionesInsumosDetalles"
                SET    "IdInsumo" = rec.id_conservado
                WHERE  "IdInsumo" = id_bloqueado;
                GET DIAGNOSTICS actualizados = ROW_COUNT;
                RAISE NOTICE '    ✓ RecepcionesInsumosDetalles: % fila(s)', actualizados;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'RecepcionesInsumosDetalles', actualizados, 'OK', NOW());
            EXCEPTION WHEN OTHERS THEN
                RAISE NOTICE '    ✗ RecepcionesInsumosDetalles: %', SQLERRM;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'RecepcionesInsumosDetalles', 0, SQLERRM, NOW());
            END;

            -- ── 13. RequisicionesDetallesAuxiliares ──────────
            BEGIN
                UPDATE "RequisicionesDetallesAuxiliares"
                SET    "IdInsumo" = rec.id_conservado
                WHERE  "IdInsumo" = id_bloqueado;
                GET DIAGNOSTICS actualizados = ROW_COUNT;
                RAISE NOTICE '    ✓ RequisicionesDetallesAuxiliares: % fila(s)', actualizados;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'RequisicionesDetallesAuxiliares', actualizados, 'OK', NOW());
            EXCEPTION WHEN OTHERS THEN
                RAISE NOTICE '    ✗ RequisicionesDetallesAuxiliares: %', SQLERRM;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'RequisicionesDetallesAuxiliares', 0, SQLERRM, NOW());
            END;

            -- ── 14. SalidasInsumosDetalles ───────────────────
            BEGIN
                UPDATE "SalidasInsumosDetalles"
                SET    "IdInsumo" = rec.id_conservado
                WHERE  "IdInsumo" = id_bloqueado;
                GET DIAGNOSTICS actualizados = ROW_COUNT;
                RAISE NOTICE '    ✓ SalidasInsumosDetalles: % fila(s)', actualizados;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'SalidasInsumosDetalles', actualizados, 'OK', NOW());
            EXCEPTION WHEN OTHERS THEN
                RAISE NOTICE '    ✗ SalidasInsumosDetalles: %', SQLERRM;
                INSERT INTO _log_unificacion VALUES (
                    rec."Codigo", rec."IdCorporativo", rec.id_conservado, id_bloqueado,
                    'SalidasInsumosDetalles', 0, SQLERRM, NOW());
            END;

            -- ── Eliminar el duplicado ahora liberado ─────────
            BEGIN
                DELETE FROM "Insumos"
                WHERE  "Id"                = id_bloqueado
                  AND  "CreadoPorConcepto" = false;

                eliminados := eliminados + 1;
                RAISE NOTICE '    ✓ Insumo Id=% eliminado correctamente', id_bloqueado;

            EXCEPTION
                WHEN foreign_key_violation THEN
                    fallidos := fallidos + 1;
                    RAISE NOTICE '    ✗ Insumo Id=% aún bloqueado por FK (revisar manualmente)', id_bloqueado;
                WHEN OTHERS THEN
                    fallidos := fallidos + 1;
                    RAISE NOTICE '    ✗ Insumo Id=% error: %', id_bloqueado, SQLERRM;
            END;

        END LOOP;
    END LOOP;

    RAISE NOTICE '════════════════════════════════════════';
    RAISE NOTICE 'Insumos eliminados  : %', eliminados;
    RAISE NOTICE 'Aún bloqueados      : %', fallidos;
    RAISE NOTICE '════════════════════════════════════════';

END;
$$;


-- ────────────────────────────────────────────────────────────
-- 3. LOG DETALLADO: reasignaciones realizadas por tabla
-- ────────────────────────────────────────────────────────────
SELECT
    l."Codigo",
    l."IdCorporativo",
    l.id_conservado,
    l.id_bloqueado,
    l.tabla_hija,
    l.filas_afectadas,
    l.resultado,
    l.ts
FROM _log_unificacion l
ORDER BY l."Codigo", l.id_bloqueado, l.tabla_hija;


-- ────────────────────────────────────────────────────────────
-- 4. SOLO TABLAS CON FILAS REASIGNADAS (resumen ejecutivo)
-- ────────────────────────────────────────────────────────────
SELECT
    l.tabla_hija,
    SUM(l.filas_afectadas) AS total_filas_reasignadas,
    COUNT(*)               AS operaciones
FROM _log_unificacion l
WHERE l.resultado = 'OK'
  AND l.filas_afectadas > 0
GROUP BY l.tabla_hija
ORDER BY total_filas_reasignadas DESC;


-- ────────────────────────────────────────────────────────────
-- 5. VERIFICACIÓN FINAL
--    No deben quedar duplicados con CreadoPorConcepto = false
-- ────────────────────────────────────────────────────────────
SELECT
    i."Codigo",
    i."IdCorporativo",
    COUNT(*)                              AS cantidad,
    array_agg(i."Id" ORDER BY i."Id")    AS ids_restantes
FROM "Insumos" i
WHERE i."CreadoPorConcepto" = false
GROUP BY i."Codigo", i."IdCorporativo"
HAVING COUNT(*) > 1
ORDER BY cantidad DESC;
``` 

## Remplaza por UUID

``` SQL
-- =============================================================
-- SCRIPT: Renombrar duplicados agregando UUID al campo "Codigo"
-- Aplica a: registros con CreadoPorConcepto = false que aún
--           tienen duplicados por Codigo + IdCorporativo.
-- Estrategia:
--   - El registro con Id más bajo (el conservado) mantiene
--     su Codigo original sin cambios.
--   - Todos los demás reciben el sufijo "-{uuid}" para
--     volverlos únicos: "CODIGO-a1b2c3d4-..."
-- =============================================================


-- ────────────────────────────────────────────────────────────
-- 0. VISTA PREVIA: duplicados que serán renombrados
-- ────────────────────────────────────────────────────────────
SELECT
    i."Codigo",
    i."IdCorporativo",
    COUNT(*)                              AS cantidad,
    array_agg(i."Id" ORDER BY i."Id")    AS ids_restantes
FROM "Insumos" i
WHERE i."CreadoPorConcepto" = false
GROUP BY i."Codigo", i."IdCorporativo"
HAVING COUNT(*) > 1
ORDER BY cantidad DESC;


-- ────────────────────────────────────────────────────────────
-- 1. RENOMBRAR: agregar sufijo UUID a los duplicados
-- ────────────────────────────────────────────────────────────
DO $$
DECLARE
    rec            RECORD;
    id_a_renombrar BIGINT;
    nuevo_codigo   TEXT;
    renombrados    INT := 0;
    fallidos       INT := 0;
BEGIN

    CREATE TEMP TABLE IF NOT EXISTS _log_renombrados (
        "Id"             BIGINT,
        "IdCorporativo"  INT,
        codigo_original  TEXT,
        codigo_nuevo     TEXT,
        resultado        TEXT,
        ts               TIMESTAMPTZ DEFAULT NOW()
    ) ON COMMIT DROP;

    FOR rec IN
        SELECT
            i."Codigo",
            i."IdCorporativo",
            MIN(i."Id")                           AS id_conservado,
            array_agg(i."Id" ORDER BY i."Id")     AS todos_los_ids
        FROM "Insumos" i
        WHERE i."CreadoPorConcepto" = false
        GROUP BY i."Codigo", i."IdCorporativo"
        HAVING COUNT(*) > 1
    LOOP

        RAISE NOTICE '──────────────────────────────────────────';
        RAISE NOTICE 'Grupo: Codigo=% | IdCorporativo=%  →  conservar Id=%',
                     rec."Codigo", rec."IdCorporativo", rec.id_conservado;

        FOREACH id_a_renombrar IN ARRAY rec.todos_los_ids
        LOOP
            -- El conservado (id más bajo) no se toca
            CONTINUE WHEN id_a_renombrar = rec.id_conservado;

            -- Nuevo código: "ORIGINAL-xxxxxxxx" (8 chars del UUID)
            nuevo_codigo := rec."Codigo" || '-' || LEFT(gen_random_uuid()::TEXT, 8);

            BEGIN
                UPDATE "Insumos"
                SET    "Codigo" = nuevo_codigo
                WHERE  "Id"     = id_a_renombrar
                  AND  "CreadoPorConcepto" = false;

                renombrados := renombrados + 1;

                RAISE NOTICE '  ✓ Id=% | % → %',
                             id_a_renombrar, rec."Codigo", nuevo_codigo;

                INSERT INTO _log_renombrados(
                    "Id", "IdCorporativo",
                    codigo_original, codigo_nuevo, resultado
                ) VALUES (
                    id_a_renombrar, rec."IdCorporativo",
                    rec."Codigo", nuevo_codigo, 'OK'
                );

            EXCEPTION WHEN OTHERS THEN
                fallidos := fallidos + 1;

                RAISE NOTICE '  ✗ Id=% error: %', id_a_renombrar, SQLERRM;

                INSERT INTO _log_renombrados(
                    "Id", "IdCorporativo",
                    codigo_original, codigo_nuevo, resultado
                ) VALUES (
                    id_a_renombrar, rec."IdCorporativo",
                    rec."Codigo", nuevo_codigo, SQLERRM
                );
            END;

        END LOOP;
    END LOOP;

    RAISE NOTICE '════════════════════════════════════════';
    RAISE NOTICE 'Registros renombrados : %', renombrados;
    RAISE NOTICE 'Errores               : %', fallidos;
    RAISE NOTICE '════════════════════════════════════════';

END;
$$;


-- ────────────────────────────────────────────────────────────
-- 2. LOG: qué códigos cambiaron y a qué valor
-- ────────────────────────────────────────────────────────────
SELECT
    l."Id",
    l."IdCorporativo",
    l.codigo_original,
    l.codigo_nuevo,
    l.resultado,
    l.ts
FROM _log_renombrados l
ORDER BY l.codigo_original, l."Id";


-- ────────────────────────────────────────────────────────────
-- 3. VERIFICACIÓN FINAL
--    No debe devolver filas si todos fueron renombrados
-- ────────────────────────────────────────────────────────────
SELECT
    i."Codigo",
    i."IdCorporativo",
    COUNT(*)                              AS cantidad,
    array_agg(i."Id" ORDER BY i."Id")    AS ids_restantes
FROM "Insumos" i
WHERE i."CreadoPorConcepto" = false
GROUP BY i."Codigo", i."IdCorporativo"
HAVING COUNT(*) > 1
ORDER BY cantidad DESC;
```

## Remplaza por UUID Creado por Concepto

``` SQL
-- =============================================================
-- SCRIPT: Renombrar duplicados agregando UUID corto al "Codigo"
-- Aplica a: registros con CreadoPorConcepto = TRUE que aún
--           tienen duplicados por Codigo + IdCorporativo.
-- Estrategia:
--   - El registro con Id más bajo mantiene su Codigo original.
--   - Todos los demás reciben el sufijo "-{8 chars uuid}":
--     "CODIGO-550e8400"
-- =============================================================


-- ────────────────────────────────────────────────────────────
-- 0. VISTA PREVIA: duplicados que serán renombrados
-- ────────────────────────────────────────────────────────────
SELECT
    i."Codigo",
    i."IdCorporativo",
    COUNT(*)                              AS cantidad,
    array_agg(i."Id" ORDER BY i."Id")    AS ids_restantes
FROM "Insumos" i
WHERE i."CreadoPorConcepto" = true
GROUP BY i."Codigo", i."IdCorporativo"
HAVING COUNT(*) > 1
ORDER BY cantidad DESC;


-- ────────────────────────────────────────────────────────────
-- 1. RENOMBRAR: agregar sufijo UUID corto a los duplicados
-- ────────────────────────────────────────────────────────────
DO $$
DECLARE
    rec            RECORD;
    id_a_renombrar BIGINT;
    nuevo_codigo   TEXT;
    renombrados    INT := 0;
    fallidos       INT := 0;
BEGIN

    CREATE TEMP TABLE IF NOT EXISTS _log_renombrados_concepto (
        "Id"             BIGINT,
        "IdCorporativo"  INT,
        codigo_original  TEXT,
        codigo_nuevo     TEXT,
        resultado        TEXT,
        ts               TIMESTAMPTZ DEFAULT NOW()
    ) ON COMMIT DROP;

    FOR rec IN
        SELECT
            i."Codigo",
            i."IdCorporativo",
            MIN(i."Id")                           AS id_conservado,
            array_agg(i."Id" ORDER BY i."Id")     AS todos_los_ids
        FROM "Insumos" i
        WHERE i."CreadoPorConcepto" = true
        GROUP BY i."Codigo", i."IdCorporativo"
        HAVING COUNT(*) > 1
    LOOP

        RAISE NOTICE '──────────────────────────────────────────';
        RAISE NOTICE 'Grupo: Codigo=% | IdCorporativo=%  →  conservar Id=%',
                     rec."Codigo", rec."IdCorporativo", rec.id_conservado;

        FOREACH id_a_renombrar IN ARRAY rec.todos_los_ids
        LOOP
            -- El conservado (id más bajo) no se toca
            CONTINUE WHEN id_a_renombrar = rec.id_conservado;

            -- Nuevo código: "ORIGINAL-xxxxxxxx" (8 chars del UUID)
            nuevo_codigo := rec."Codigo" || '-' || LEFT(gen_random_uuid()::TEXT, 8);

            BEGIN
                UPDATE "Insumos"
                SET    "Codigo" = nuevo_codigo
                WHERE  "Id"     = id_a_renombrar
                  AND  "CreadoPorConcepto" = true;

                renombrados := renombrados + 1;

                RAISE NOTICE '  ✓ Id=% | % → %',
                             id_a_renombrar, rec."Codigo", nuevo_codigo;

                INSERT INTO _log_renombrados_concepto(
                    "Id", "IdCorporativo",
                    codigo_original, codigo_nuevo, resultado
                ) VALUES (
                    id_a_renombrar, rec."IdCorporativo",
                    rec."Codigo", nuevo_codigo, 'OK'
                );

            EXCEPTION WHEN OTHERS THEN
                fallidos := fallidos + 1;

                RAISE NOTICE '  ✗ Id=% error: %', id_a_renombrar, SQLERRM;

                INSERT INTO _log_renombrados_concepto(
                    "Id", "IdCorporativo",
                    codigo_original, codigo_nuevo, resultado
                ) VALUES (
                    id_a_renombrar, rec."IdCorporativo",
                    rec."Codigo", nuevo_codigo, SQLERRM
                );
            END;

        END LOOP;
    END LOOP;

    RAISE NOTICE '════════════════════════════════════════';
    RAISE NOTICE 'Registros renombrados : %', renombrados;
    RAISE NOTICE 'Errores               : %', fallidos;
    RAISE NOTICE '════════════════════════════════════════';

END;
$$;


-- ────────────────────────────────────────────────────────────
-- 2. LOG: qué códigos cambiaron y a qué valor
-- ────────────────────────────────────────────────────────────
SELECT
    l."Id",
    l."IdCorporativo",
    l.codigo_original,
    l.codigo_nuevo,
    l.resultado,
    l.ts
FROM _log_renombrados_concepto l
ORDER BY l.codigo_original, l."Id";


-- ────────────────────────────────────────────────────────────
-- 3. VERIFICACIÓN FINAL
--    No debe devolver filas si todos fueron renombrados
-- ────────────────────────────────────────────────────────────
SELECT
    i."Codigo",
    i."IdCorporativo",
    COUNT(*)                              AS cantidad,
    array_agg(i."Id" ORDER BY i."Id")    AS ids_restantes
FROM "Insumos" i
WHERE i."CreadoPorConcepto" = true
GROUP BY i."Codigo", i."IdCorporativo"
HAVING COUNT(*) > 1
ORDER BY cantidad DESC;
```