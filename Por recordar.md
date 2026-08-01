## SQL Tips

``` SQL
SELECT
column_name,
data_type
FROM information_schema.columns
WHERE table_name = 'BitacoraCentrosCostos'
ORDER BY ordinal_position;

-- CONCAT
SELECT 'bcc."' || column_name || '",'
FROM information_schema.columns
WHERE table_name = 'BitacoraCentrosCostos'
ORDER BY ordinal_position;

SELECT 'FamiliaInsumo' || column_name || ' ' || data_type || ' ,'
FROM information_schema.columns
WHERE table_name = 'FamiliasInsumos'
ORDER BY ordinal_position;

SELECT '"Monedas"."' || column_name || '"' || 'AS "Moneda' || column_name || '",'
FROM information_schema.columns
WHERE table_name = 'explosionesinsumosview'
ORDER BY ordinal_position;


--OBTENEMOS LAS VIEWS
SELECT table_name
FROM information_schema.views
WHERE table_schema = 'public';

--OBTENEMOS LAS FUNCIONES
SELECT routine_name
FROM information_schema.routines
WHERE routine_schema = 'public'
AND routine_type = 'FUNCTION';

--TABLAS
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
AND table_type = 'BASE TABLE'
ORDER BY table_name;

-- VER CONEXIONES
SELECT count(*) FROM pg_stat_activity;
SHOW max_connections;
```

## Colores

COLORES.
Azul 1: #1E3C7C
Azul 2: #29245c 
Naranja: #F26522

#3D4B64 Azul
#ffa5004d Naranja
#D4D4D4 Gris
#f4f4f4 Gris fondo.