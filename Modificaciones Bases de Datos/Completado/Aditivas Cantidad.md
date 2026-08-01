---
tipo: changelog-bd
estado: completado
tags: [bd, postgresql]
---

Índice: [[Índice]]

``` SQL
CREATE OR REPLACE FUNCTION fn_cantidad_aditiva(
    p_idInsumo              INTEGER,
    p_fechaCorte            DATE,
    p_idPresupuestoConcepto INTEGER DEFAULT NULL,
    p_idPresupuestoPartida  INTEGER DEFAULT NULL
)
RETURNS NUMERIC
LANGUAGE plpgsql
AS
$$
DECLARE
    cantidad NUMERIC;
BEGIN
    IF p_idPresupuestoConcepto IS NOT NULL THEN
        SELECT
            SUM(ad."Cantidad")
        INTO cantidad
        FROM "Aditivas" a
        JOIN "AditivasDetalles" ad
            ON ad."IdAditivaAgrupador" = a."Id"
        JOIN "ExplosionesInsumos" ei
            ON ei."Id" = ad."IdExplosionInsumo"
        JOIN LATERAL (
            SELECT
                tad."Tipo",
                ae."FechaRegistro"
            FROM "AditivasEstatus" ae
            JOIN "TiposEstatusAdDe" tad
                ON tad."Id" = ae."IdEstatus"
            WHERE ae."IdAditiva" = a."Id"
            ORDER BY
                ae."FechaRegistro" DESC,
                ae."Id" DESC
            LIMIT 1
        ) AS aut ON TRUE
        WHERE ei."IdPresupuestoConcepto" = p_idPresupuestoConcepto
          AND ei."IdInsumo" = p_idInsumo
          AND aut."Tipo" = 1100
          AND a."Activo"
          AND a."FechaRegistro" <= p_fechaCorte;

    ELSIF p_idPresupuestoPartida IS NOT NULL THEN
        SELECT
            SUM(ad."Cantidad")
        INTO cantidad
        FROM "Aditivas" a
        JOIN "AditivasDetalles" ad
            ON ad."IdAditivaAgrupador" = a."Id"
        JOIN "ExplosionesInsumos" ei
            ON ei."Id" = ad."IdExplosionInsumo"
        JOIN "Explosiones" e
            ON e."Id" = ei."IdExplosion"
        JOIN "ExplosionesInsumosAgrupados" eia
            ON eia."IdExplosion" = e."Id"
        JOIN LATERAL (
            SELECT
                tad."Tipo",
                ae."FechaRegistro"
            FROM "AditivasEstatus" ae
            JOIN "TiposEstatusAdDe" tad
                ON tad."Id" = ae."IdEstatus"
            WHERE ae."IdAditiva" = a."Id"
            ORDER BY
                ae."FechaRegistro" DESC,
                ae."Id" DESC
            LIMIT 1
        ) AS aut ON TRUE
        WHERE eia."IdPresupuestoPartida" = p_idPresupuestoPartida
          AND eia."IdInsumo" = p_idInsumo
          AND ei."IdInsumo" = p_idInsumo
          AND aut."Tipo" = 1100
          AND a."Activo"
          AND a."FechaRegistro" <= p_fechaCorte;

    ELSE
        cantidad := 0;
    END IF;

    RETURN COALESCE(cantidad, 0);
END;
$$;

```

``` SQL
CREATE OR REPLACE FUNCTION fn_cantidad_deductiva(
    p_idInsumo              INTEGER,
    p_fechaCorte            DATE,
    p_idPresupuestoConcepto INTEGER DEFAULT NULL,
    p_idPresupuestoPartida  INTEGER DEFAULT NULL
)
RETURNS NUMERIC
LANGUAGE plpgsql
AS
$$
DECLARE
    cantidad NUMERIC;
BEGIN
    IF p_idPresupuestoConcepto IS NOT NULL THEN
        SELECT
            SUM(dd."Cantidad")
        INTO cantidad
        FROM "Deductivas" d
        JOIN "DeductivasDetalles" dd
            ON dd."IdDeductivaAgrupador" = d."Id"
        JOIN "ExplosionesInsumos" ei
            ON ei."Id" = dd."IdExplosionInsumo"
        JOIN LATERAL (
            SELECT
                tad."Tipo",
                de."FechaRegistro"
            FROM "DeductivasEstatus" de
            JOIN "TiposEstatusAdDe" tad
                ON tad."Id" = de."IdEstatus"
            WHERE de."IdDeductiva" = d."Id"
            ORDER BY
                de."FechaRegistro" DESC,
                de."Id" DESC
            LIMIT 1
        ) AS aut ON TRUE
        WHERE ei."IdPresupuestoConcepto" = p_idPresupuestoConcepto
          AND ei."IdInsumo" = p_idInsumo
          AND aut."Tipo" = 1100
          AND d."Activo"
          AND d."FechaRegistro" <= p_fechaCorte;

    ELSIF p_idPresupuestoPartida IS NOT NULL THEN
        SELECT
            SUM(dd."Cantidad")
        INTO cantidad
        FROM "Deductivas" d
        JOIN "DeductivasDetalles" dd
            ON dd."IdDeductivaAgrupador" = d."Id"
        JOIN "ExplosionesInsumos" ei
            ON ei."Id" = dd."IdExplosionInsumo"
        JOIN "Explosiones" e
            ON e."Id" = ei."IdExplosion"
        JOIN "ExplosionesInsumosAgrupados" eia
            ON eia."IdExplosion" = e."Id"
        JOIN LATERAL (
            SELECT
                tad."Tipo",
                de."FechaRegistro"
            FROM "DeductivasEstatus" de
            JOIN "TiposEstatusAdDe" tad
                ON tad."Id" = de."IdEstatus"
            WHERE de."IdDeductiva" = d."Id"
            ORDER BY
                de."FechaRegistro" DESC,
                de."Id" DESC
            LIMIT 1
        ) AS aut ON TRUE
        WHERE eia."IdPresupuestoPartida" = p_idPresupuestoPartida
          AND eia."IdInsumo" = p_idInsumo
          AND ei."IdInsumo" = p_idInsumo
          AND aut."Tipo" = 1100
          AND d."Activo"
          AND d."FechaRegistro" <= p_fechaCorte;

    ELSE
        cantidad := 0;
    END IF;

    RETURN COALESCE(cantidad, 0);
END;
$$;

```

``` SQL
CREATE OR REPLACE FUNCTION fn_cantidad_orden_compra(
    p_idPresupuestoPartida INTEGER,
    p_idInsumo             INTEGER,
    p_fechaCorte           DATE
)
RETURNS NUMERIC
LANGUAGE plpgsql
AS
$$
DECLARE
    cantidad NUMERIC;
BEGIN
    SELECT
        SUM(ocd."Cantidad")
    INTO cantidad
    FROM "OrdenesCompras" oc
    JOIN "OrdenesComprasDetalles" ocd
        ON ocd."IdOrdenCompra" = oc."Id"
    JOIN "RequisicionesDetalles" rd
        ON rd."Id" = ocd."IdRequisicionDetalle"
    JOIN "ExplosionesInsumosAgrupados" eia
        ON eia."Id" = rd."IdExplosionInsumoAgrupado"
    JOIN LATERAL (
        SELECT
            teoc."Tipo",
            oce."FechaRegistro"
        FROM "OrdenesComprasEstatus" oce
        JOIN "TiposEstatusOrdenesCompras" teoc
            ON teoc."Id" = oce."IdEstatus"
        WHERE oce."IdOrdenCompra" = oc."Id"
        ORDER BY
            oce."FechaRegistro" DESC,
            oce."Id" DESC
        LIMIT 1
    ) AS aut ON TRUE
    WHERE eia."IdPresupuestoPartida" = p_idPresupuestoPartida
      AND eia."IdInsumo"             = p_idInsumo
      AND aut."Tipo"                 = '1100'
      AND oc."Activo"
      AND oc."FechaRegistro"         <= p_fechaCorte;

    RETURN COALESCE(cantidad, 0);
END;
$$;

```

``` SQL
CREATE OR REPLACE FUNCTION fn_cantidad_explosion_subcontrato(
    p_idInsumo              INTEGER,
    p_fechaCorte            DATE,
    p_idPresupuestoConcepto INTEGER DEFAULT NULL,
    p_idPresupuestoPartida  INTEGER DEFAULT NULL
)
RETURNS NUMERIC
LANGUAGE plpgsql
AS
$$
DECLARE
    cantidad NUMERIC;
BEGIN
    IF p_idPresupuestoConcepto IS NOT NULL THEN
        SELECT
            SUM(esd."Cantidad")
        INTO cantidad
        FROM "ExplosionesSubcontratos" es
        JOIN "ExplosionesSubcontratosDetalles" esd
            ON esd."IdExplosionSubcontrato" = es."Id"
        JOIN "ExplosionesInsumos" ei
            ON esd."IdExplosionInsumo" = ei."Id"
        JOIN LATERAL (
            SELECT
                tees."Tipo",
                ese."FechaRegistro"
            FROM "ExplosionesSubcontratosEstatus" ese
            JOIN "TiposEstatusExplosionesSubcontratos" tees
                ON tees."Id" = ese."IdEstatus"
            WHERE ese."IdExplosionSubcontrato" = es."Id"
            ORDER BY
                ese."FechaRegistro" DESC,
                ese."Id" DESC
            LIMIT 1
        ) AS aut ON TRUE
        WHERE ei."IdPresupuestoConcepto" = p_idPresupuestoConcepto
          AND ei."IdInsumo"              = p_idInsumo
          AND aut."Tipo"                 = '1100'
          AND es."Activo"
          AND es."FechaRegistro"         <= p_fechaCorte;

    ELSIF p_idPresupuestoPartida IS NOT NULL THEN
        SELECT
            SUM(esd."Cantidad")
        INTO cantidad
        FROM "ExplosionesSubcontratos" es
        JOIN "ExplosionesSubcontratosDetalles" esd
            ON esd."IdExplosionSubcontrato" = es."Id"
        JOIN "ExplosionesInsumos" ei
            ON esd."IdExplosionInsumo" = ei."Id"
        JOIN "Explosiones" e
            ON e."Id" = ei."IdExplosion"
        JOIN "ExplosionesInsumosAgrupados" eia
            ON eia."IdExplosion" = e."Id"
        JOIN LATERAL (
            SELECT
                tees."Tipo",
                ese."FechaRegistro"
            FROM "ExplosionesSubcontratosEstatus" ese
            JOIN "TiposEstatusExplosionesSubcontratos" tees
                ON tees."Id" = ese."IdEstatus"
            WHERE ese."IdExplosionSubcontrato" = es."Id"
            ORDER BY
                ese."FechaRegistro" DESC,
                ese."Id" DESC
            LIMIT 1
        ) AS aut ON TRUE
        WHERE eia."IdPresupuestoPartida" = p_idPresupuestoPartida
          AND eia."IdInsumo"             = p_idInsumo
          AND ei."IdInsumo"              = p_idInsumo
          AND aut."Tipo"                 = '1100'
          AND es."Activo"
          AND es."FechaRegistro"         <= p_fechaCorte;

    ELSE
        cantidad := 0;
    END IF;

    RETURN COALESCE(cantidad, 0);
END;
$$;


```

``` SQL
CREATE OR REPLACE FUNCTION fn_cantidad_estimacion(
    p_idInsumo              INTEGER,
    p_fechaCorte            DATE,
    p_idPresupuestoConcepto INTEGER DEFAULT NULL,
    p_idPresupuestoPartida  INTEGER DEFAULT NULL
)
RETURNS NUMERIC
LANGUAGE plpgsql
AS
$$
DECLARE
    cantidad NUMERIC;
BEGIN
    IF p_idPresupuestoConcepto IS NOT NULL THEN
        SELECT
            SUM(eid."Cantidad")
        INTO cantidad
        FROM "Estimaciones" est
        JOIN "EstimacionesInsumos" ei
            ON ei."IdEstimacion" = est."Id"
        JOIN "EstimacionesInsumosDetalles" eid
            ON eid."IdEstimacionInsumo" = ei."Id"
        JOIN "ExplosionesSubcontratosDetalles" esd
            ON esd."Id" = ei."IdSubcontratoDetalle"
        JOIN "ExplosionesInsumos" exi
            ON esd."IdExplosionInsumo" = exi."Id"
        JOIN LATERAL (
            SELECT
                tee."Tipo",
                ee."FechaRegistro"
            FROM "EstimacionesEstatus" ee
            JOIN "TiposEstatusEstimaciones" tee
                ON tee."Id" = ee."IdEstatus"
            WHERE ee."IdEstimacion" = est."Id"
            ORDER BY
                ee."FechaRegistro" DESC,
                ee."Id" DESC
            LIMIT 1
        ) AS aut ON TRUE
        WHERE exi."IdPresupuestoConcepto" = p_idPresupuestoConcepto
          AND exi."IdInsumo"              = p_idInsumo
          AND aut."Tipo"                  = '1100'
          AND est."Activo"
          AND est."FechaRegistro"         <= p_fechaCorte;

    ELSIF p_idPresupuestoPartida IS NOT NULL THEN
        SELECT
            SUM(eid."Cantidad")
        INTO cantidad
        FROM "Estimaciones" est
        JOIN "EstimacionesInsumos" ei
            ON ei."IdEstimacion" = est."Id"
        JOIN "EstimacionesInsumosDetalles" eid
            ON eid."IdEstimacionInsumo" = ei."Id"
        JOIN "ExplosionesSubcontratosDetalles" esd
            ON esd."Id" = ei."IdSubcontratoDetalle"
        JOIN "ExplosionesInsumos" exi
            ON esd."IdExplosionInsumo" = exi."Id"
        JOIN "Explosiones" expl
            ON expl."Id" = exi."IdExplosion"
        JOIN "ExplosionesInsumosAgrupados" eia
            ON eia."IdExplosion" = expl."Id"
        JOIN LATERAL (
            SELECT
                tee."Tipo",
                ee."FechaRegistro"
            FROM "EstimacionesEstatus" ee
            JOIN "TiposEstatusEstimaciones" tee
                ON tee."Id" = ee."IdEstatus"
            WHERE ee."IdEstimacion" = est."Id"
            ORDER BY
                ee."FechaRegistro" DESC,
                ee."Id" DESC
            LIMIT 1
        ) AS aut ON TRUE
        WHERE eia."IdPresupuestoPartida" = p_idPresupuestoPartida
          AND eia."IdInsumo"             = p_idInsumo
          AND exi."IdInsumo"             = p_idInsumo
          AND aut."Tipo"                 = '1100'
          AND est."Activo"
          AND est."FechaRegistro"        <= p_fechaCorte;

    ELSE
        cantidad := 0;
    END IF;

    RETURN COALESCE(cantidad, 0);
END;
$$;
```