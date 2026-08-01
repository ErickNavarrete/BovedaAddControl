## Permisos Empresas [Dev-Demo-Producción]
``` SQL
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (3,'Descuentos, retenciones o adicionales','modulo_empresas_desc_ret_ad',1,1);
```

## Permisos Roberto [Dev-Demo-Producción]
``` SQL
--PRESUPUESTOS
INSERT INTO public."Modulos"(
    "IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")
    VALUES (2, 'Presupuestos', 'modulo_presupuestos', 3, 3, 'menu_gestion_obra_presupuestacion');

INSERT INTO public."ModulosAcciones"(
"IdModulo", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico")
VALUES (200, 'Acceso', 'modulo_presupuestos_acceso', 3, 3);

INSERT INTO public."ModulosAcciones"(
"IdModulo", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico")
VALUES (200, 'Acceso', 'modulo_presupuestos_editar', 3, 3);

INSERT INTO public."ModulosAcciones"(
"IdModulo", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico")
VALUES (200, 'Acceso', 'modulo_presupuestos_ejercido_concepto', 3, 3);

INSERT INTO public."ModulosAcciones"(
"IdModulo", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico")
VALUES (200, 'Acceso', 'modulo_presupuestos_ejercido_insumo', 3, 3);

---OTROS GASTOS
INSERT INTO public."Modulos"(
"IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")
VALUES (2, 'Otros Gastos', 'modulo_otro_gasto', 3, 3, 'menu_gestion_obra_presupuestacion');

  
INSERT INTO public."ModulosAcciones"(
"IdModulo", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico")
VALUES (201, 'Acceso', 'modulo_otro_gasto_acceso', 3, 3);

---EXPLOSION INSUMOS
INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")
VALUES
(2, 'Explosion Insumos', 'modulo_explosion_insumos', 3, 3, 'menu_gestion_obra_presupuestacion');

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (202,'Acceso','modulo_explosion_insumos_acceso',3,3);
```

## Presupuestos Matriz Conceptos [Dev-Demo-Producción]
``` SQL
fn_presupuestosmatrizconceptos_read
```
## Salida de Insumos [Dev-Demo-Producción]
``` SQL
-- 1. Agregar la columna
ALTER TABLE public."SalidasInsumosDetalles"
ADD COLUMN "IdPresupuestoPartida" int4 DEFAULT NULL;

-- 2. Crear índice (mejora performance de la FK)
CREATE INDEX idx_salidasinsumosdetalles_idpresupuestopartida
ON public."SalidasInsumosDetalles" ("IdPresupuestoPartida");

-- 3. Agregar la llave foránea
ALTER TABLE public."SalidasInsumosDetalles"
ADD CONSTRAINT fk_salidasinsumosdetalles_presupuestopartida
FOREIGN KEY ("IdPresupuestoPartida")
REFERENCES public."PresupuestosPartidas"("Id");

-- 4. VIEW
public.salidasinsumosdetallesview
public.fn_SalidasInsumosDetalles_Read_Paged
```

## Explosión de Insumos [Dev-Demo-Producción]
``` SQL
fn_ExplosionesInsumos_Read_Paged
```
## Presupuestos Análisis Insumos [Dev-Demo-Producción]
``` SQL
fn_cantidad_aditiva --Prod
fn_cantidad_deductiva --Prod
fn_cantidad_orden_compra --Prod
fn_cantidad_recepcion_insumo --Prod
fn_cantidad_requisicion --Prod
fn_cantidad_salida_insumo --Prod
fn_cantidad_explosion_subcontrato --Prod
fn_cantidad_estimacion --Prod

fn_importe_orden_compra --Prod
fn_importe_recepcion_insumo --Prod
fn_importe_estimacion --Prod
fn_importe_explosion_subcontrato --Prod

fn_presupuesto_analisis_read_paged --Prod
fn_presupuesto_analisis_insumo_read --Prod
fn_presupuesto_analisis_insumo_agrupado_read --Prod
fn_presupuesto_analisis_partida_agrupado_read --Prod
fn_presupuesto_analisis_concepto_agrupado_read_paged --Prod
``` 

## Presupuestos Matriz [Dev-Demo-Producción]
``` SQL
fn_presupuestosmatriz_read
```
## Presupuestos Partidas Jerarquía [Dev-Demo-Producción]
``` SQL
fn_presupuestospartidas_jerarquia_read_paged
```

## Programa de Obra [Dev-Demo-Producción]
``` SQL
fn_presupuesto_programacion_read
```