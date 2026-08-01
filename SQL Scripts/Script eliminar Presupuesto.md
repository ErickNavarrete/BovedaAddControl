## Script
``` SQL
DO $$

DECLARE

v_id INTEGER := 189; -- ← Cambia solo este valor

BEGIN

  

DELETE FROM "ExplosionesInsumosAgrupados" WHERE "IdPresupuesto" = v_id;

RAISE NOTICE 'ExplosionesInsumosAgrupados eliminados para Id: %', v_id;

  

DELETE FROM "PresupuestosMatriz" WHERE "IdPresupuesto" = v_id;

RAISE NOTICE 'PresupuestosMatriz eliminados para Id: %', v_id;

  

DELETE FROM "PresupuestosInsumosPrecios" WHERE "IdPresupuesto" = v_id;

RAISE NOTICE 'PresupuestosInsumosPrecios eliminados para Id: %', v_id;

  

DELETE FROM "PresupuestosEstatus" WHERE "IdPresupuesto" = v_id;

RAISE NOTICE 'PresupuestosEstatus eliminados para Id: %', v_id;

  

DELETE FROM "PresupuestosMonedas" WHERE "IdPresupuesto" = v_id;

RAISE NOTICE 'PresupuestosMonedas eliminados para Id: %', v_id;

  

DELETE FROM "PresupuestosConceptos" WHERE "IdPresupuesto" = v_id;

RAISE NOTICE 'PresupuestosConceptos eliminados para Id: %', v_id;

  

DELETE FROM "PresupuestosPartidas" WHERE "IdPresupuesto" = v_id;

RAISE NOTICE 'PresupuestosPartidas eliminados para Id: %', v_id;

  

DELETE FROM "Presupuestos" WHERE "Id" = v_id;

RAISE NOTICE 'Presupuesto principal eliminado. Id: %', v_id;

  

RAISE NOTICE '✓ Eliminación completada para presupuesto Id: %', v_id;

  

END $$;```