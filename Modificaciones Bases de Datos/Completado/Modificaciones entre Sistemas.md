## Base de Datos

### Modulo Permisos
``` SQL
ALTER TABLE public."Modulos"
ADD COLUMN "Padre" VARCHAR NULL;

INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")
VALUES
(1, 'Catálogos', 'menu_catalogos', 3, 3, NULL),
(1, 'Recurrentes', 'menu_catalogos_recurrentes', 3, 3, 'menu_catalogos'),
(1, 'Adicionales', 'menu_catalogos_adicionales', 3, 3, 'menu_catalogos'),
(1, 'Gestión de Obra', 'menu_gestion_obra', 3, 3, NULL),
(1, 'Almacén', 'menu_gestion_obra_almacen', 3, 3, 'menu_gestion_obra'),
(1, 'Facturación', 'menu_facturacion', 3, 3, NULL),
(1, 'Catálogos', 'menu_facturacion_catalogos', 3, 3, 'menu_facturacion'),
(1, 'Mano de Obra', 'menu_mano_obra', 3, 3, NULL),
(1, 'Catálogos', 'menu_mano_obra_catalogos', 3, 3, 'menu_mano_obra'),
(1, 'Herramientas', 'menu_herramientas', 3, 3, NULL),
(1, 'Perzonalización', 'menu_perzonalizacion', 3, 3, NULL),
(1, 'Licitación', 'menu_licitacion', 3, 3, NULL),
(1, 'CRM', 'menu_crm', 3, 3, NULL),
(1, 'Catálogos', 'menu_crm_catalogos', 3, 3, 'menu_crm'),
(1, 'Configuración', 'menu_configuracion', 3, 3, NULL),
(1, 'Seguridad', 'menu_configuracion_seguridad', 3, 3, 'menu_configuracion'),
(1, 'Gestión de Tareas', 'menu_herramientas_gestion', 3, 3, 'menu_herramientas'),
(1, 'Presupuestacion', 'menu_gestion_obra_presupuestacion', 3, 3, 'menu_gestion_obra'),

(2, 'Gestión de Obra', 'menu_gestion_obra', 3, 3, NULL),
(2, 'Almacén', 'menu_gestion_obra_almacen', 3, 3, 'menu_gestion_obra'),
(2, 'Herramientas', 'menu_herramientas', 3, 3, NULL),
(2, 'Configuración', 'menu_configuracion', 3, 3, NULL),
(2, 'Seguridad', 'menu_configuracion_seguridad', 3, 3, 'menu_configuracion'),
(2, 'Gestión de Tareas', 'menu_herramientas_gestion', 3, 3, 'menu_herramientas'),
(2, 'Presupuestacion', 'menu_gestion_obra_presupuestacion', 3, 3, 'menu_gestion_obra');


UPDATE public."Modulos" SET "Padre" = 'menu_configuracion'            WHERE "IdSistema" = 1 AND "Tag" = 'modulo_empresas';
UPDATE public."Modulos" SET "Padre" = 'menu_configuracion_seguridad'  WHERE "IdSistema" = 1 AND "Tag" = 'modulo_usuarios';
UPDATE public."Modulos" SET "Padre" = 'menu_configuracion_seguridad'  WHERE "IdSistema" = 1 AND "Tag" = 'modulo_roles';
UPDATE public."Modulos" SET "Padre" = 'menu_catalogos_recurrentes'    WHERE "IdSistema" = 1 AND "Tag" = 'modulo_centros_costos';
UPDATE public."Modulos" SET "Padre" = 'menu_catalogos_recurrentes'    WHERE "IdSistema" = 1 AND "Tag" = 'modulo_clientes';
UPDATE public."Modulos" SET "Padre" = 'menu_catalogos_recurrentes'    WHERE "IdSistema" = 1 AND "Tag" = 'modulo_insumos';
UPDATE public."Modulos" SET "Padre" = 'menu_catalogos_recurrentes'    WHERE "IdSistema" = 1 AND "Tag" = 'modulo_deudores_acreedores';
UPDATE public."Modulos" SET "Padre" = 'menu_catalogos_recurrentes'    WHERE "IdSistema" = 1 AND "Tag" = 'modulo_proveedores';
UPDATE public."Modulos" SET "Padre" = 'menu_catalogos_adicionales'    WHERE "IdSistema" = 1 AND "Tag" = 'modulo_tipos_centros_costos';
UPDATE public."Modulos" SET "Padre" = 'menu_catalogos_adicionales'    WHERE "IdSistema" = 1 AND "Tag" = 'modulo_tipo_insumos';
UPDATE public."Modulos" SET "Padre" = 'menu_catalogos_adicionales'    WHERE "IdSistema" = 1 AND "Tag" = 'modulo_divisas';
UPDATE public."Modulos" SET "Padre" = 'menu_catalogos_adicionales'    WHERE "IdSistema" = 1 AND "Tag" = 'modulo_familias_conceptos';
UPDATE public."Modulos" SET "Padre" = 'menu_catalogos_adicionales'    WHERE "IdSistema" = 1 AND "Tag" = 'modulo_conceptos';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra'             WHERE "IdSistema" = 2 AND "Tag" = 'modulo_requisiciones';
UPDATE public."Modulos" SET "Padre" = 'menu_facturacion'              WHERE "IdSistema" = 1 AND "Tag" = 'modulo_emitir_facturas';
UPDATE public."Modulos" SET "Padre" = 'menu_facturacion'              WHERE "IdSistema" = 1 AND "Tag" = 'modulo_facturas';
UPDATE public."Modulos" SET "Padre" = 'menu_facturacion_catalogos'    WHERE "IdSistema" = 1 AND "Tag" = 'modulo_tipo_contribuyente';
UPDATE public."Modulos" SET "Padre" = 'menu_facturacion_catalogos'    WHERE "IdSistema" = 1 AND "Tag" = 'modulo_tipo_ingreso';
UPDATE public."Modulos" SET "Padre" = 'menu_mano_obra'                WHERE "IdSistema" = 1 AND "Tag" = 'modulo_empleados';
UPDATE public."Modulos" SET "Padre" = 'menu_mano_obra_catalogos'      WHERE "IdSistema" = 1 AND "Tag" = 'modulo_tipos_empleados';
UPDATE public."Modulos" SET "Padre" = 'menu_mano_obra_catalogos'      WHERE "IdSistema" = 1 AND "Tag" = 'modulo_puestos';
UPDATE public."Modulos" SET "Padre" = 'menu_mano_obra'                WHERE "IdSistema" = 1 AND "Tag" = 'modulo_nominas';
UPDATE public."Modulos" SET "Padre" = 'menu_mano_obra_catalogos'      WHERE "IdSistema" = 1 AND "Tag" = 'modulo_impuestos';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra_presupuestacion' WHERE "IdSistema" = 1 AND "Tag" = 'modulo_presupuestos';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra'             WHERE "IdSistema" = 1 AND "Tag" = 'modulo_requisiciones';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra_presupuestacion' WHERE "IdSistema" = 1 AND "Tag" = 'modulo_explosion_insumo';
UPDATE public."Modulos" SET "Padre" = 'menu_perzonalizacion'          WHERE "IdSistema" = 1 AND "Tag" = 'modulo_reportes';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra'             WHERE "IdSistema" = 1 AND "Tag" = 'modulo_orden_compra';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra_almacen'     WHERE "IdSistema" = 1 AND "Tag" = 'modulo_devolucion_insumo';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra_almacen'     WHERE "IdSistema" = 1 AND "Tag" = 'modulo_salida_insumo';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra_almacen'     WHERE "IdSistema" = 1 AND "Tag" = 'modulo_recepcion_insumo';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra'             WHERE "IdSistema" = 1 AND "Tag" = 'modulo_estimacion';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra'             WHERE "IdSistema" = 1 AND "Tag" = 'modulo_subcontrato_obra';
UPDATE public."Modulos" SET "Padre" = 'menu_herramientas_gestion'     WHERE "IdSistema" = 1 AND "Tag" = 'modulo_listas';
UPDATE public."Modulos" SET "Padre" = 'menu_herramientas_gestion'     WHERE "IdSistema" = 1 AND "Tag" = 'modulo_tarjetas';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra'             WHERE "IdSistema" = 2 AND "Tag" = 'modulo_orden_compra';
UPDATE public."Modulos" SET "Padre" = 'menu_crm_catalogos'            WHERE "IdSistema" = 1 AND "Tag" = 'modulo_campanias';
UPDATE public."Modulos" SET "Padre" = 'menu_crm_catalogos'            WHERE "IdSistema" = 1 AND "Tag" = 'modulo_profesion';
UPDATE public."Modulos" SET "Padre" = 'menu_crm_catalogos'            WHERE "IdSistema" = 1 AND "Tag" = 'modulo_departamento';
UPDATE public."Modulos" SET "Padre" = 'menu_crm_catalogos'            WHERE "IdSistema" = 1 AND "Tag" = 'modulo_estado_civil';
UPDATE public."Modulos" SET "Padre" = 'modulo_insumos'                WHERE "IdSistema" = 1 AND "Tag" = 'modulo_insumos_auxiliares';
UPDATE public."Modulos" SET "Padre" = 'menu_licitacion'               WHERE "IdSistema" = 1 AND "Tag" = 'modulo_solicitud_cotizacion_proveedor';
UPDATE public."Modulos" SET "Padre" = 'menu_licitacion'               WHERE "IdSistema" = 1 AND "Tag" = 'modulo_analisis_precio';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra'             WHERE "IdSistema" = 1 AND "Tag" = 'modulo_avance_fisico';
UPDATE public."Modulos" SET "Padre" = 'menu_herramientas_gestion'     WHERE "IdSistema" = 1 AND "Tag" = 'modulo_tablero';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra'             WHERE "IdSistema" = 2 AND "Tag" = 'modulo_subcontrato_obra';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra'             WHERE "IdSistema" = 2 AND "Tag" = 'modulo_avance_fisico';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra_presupuestacion' WHERE "IdSistema" = 2 AND "Tag" = 'modulo_programa_obra';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra_presupuestacion' WHERE "IdSistema" = 2 AND "Tag" = 'modulo_aditivas';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra_almacen'     WHERE "IdSistema" = 2 AND "Tag" = 'modulo_recepcion_insumo';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra_almacen'     WHERE "IdSistema" = 2 AND "Tag" = 'modulo_salida_insumo';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra_almacen'     WHERE "IdSistema" = 2 AND "Tag" = 'modulo_devolucion_insumo';
UPDATE public."Modulos" SET "Padre" = 'menu_configuracion_seguridad'  WHERE "IdSistema" = 2 AND "Tag" = 'modulo_usuarios';
UPDATE public."Modulos" SET "Padre" = 'menu_configuracion'            WHERE "IdSistema" = 2 AND "Tag" = 'modulo_empresas';
UPDATE public."Modulos" SET "Padre" = 'menu_herramientas_gestion'     WHERE "IdSistema" = 2 AND "Tag" = 'modulo_listas';
UPDATE public."Modulos" SET "Padre" = 'menu_herramientas_gestion'     WHERE "IdSistema" = 2 AND "Tag" = 'modulo_tarjetas';
UPDATE public."Modulos" SET "Padre" = 'menu_configuracion'            WHERE "IdSistema" = 1 AND "Tag" = 'modulo_corporativos';
UPDATE public."Modulos" SET "Padre" = 'menu_catalogos_recurrentes'    WHERE "IdSistema" = 1 AND "Tag" = 'modulo_cuentas_bancarias';
UPDATE public."Modulos" SET "Padre" = 'menu_catalogos_adicionales'    WHERE "IdSistema" = 1 AND "Tag" = 'modulo_familia_insumos';
UPDATE public."Modulos" SET "Padre" = 'menu_catalogos_adicionales'    WHERE "IdSistema" = 1 AND "Tag" = 'modulo_documentos';
UPDATE public."Modulos" SET "Padre" = 'menu_facturacion'              WHERE "IdSistema" = 1 AND "Tag" = 'modulo_productos_odoo';
UPDATE public."Modulos" SET "Padre" = 'menu_facturacion_catalogos'    WHERE "IdSistema" = 1 AND "Tag" = 'modulo_terminos_pago';
UPDATE public."Modulos" SET "Padre" = 'menu_mano_obra_catalogos'      WHERE "IdSistema" = 1 AND "Tag" = 'modulo_tipos_nominas';
UPDATE public."Modulos" SET "Padre" = 'menu_catalogos_adicionales'    WHERE "IdSistema" = 1 AND "Tag" = 'modulo_tipo_presupuesto';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra_almacen'     WHERE "IdSistema" = 1 AND "Tag" = 'modulo_existencia_insumo';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra'             WHERE "IdSistema" = 1 AND "Tag" = 'modulo_programa_obra';
UPDATE public."Modulos" SET "Padre" = 'menu_crm_catalogos'            WHERE "IdSistema" = 1 AND "Tag" = 'modulo_medio_contacto';
UPDATE public."Modulos" SET "Padre" = 'menu_licitacion'               WHERE "IdSistema" = 1 AND "Tag" = 'modulo_solicitud_cotizacion';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra_presupuestacion' WHERE "IdSistema" = 1 AND "Tag" = 'modulo_aditivas';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra_presupuestacion' WHERE "IdSistema" = 1 AND "Tag" = 'modulo_deductivas';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra'             WHERE "IdSistema" = 2 AND "Tag" = 'modulo_estimacion';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra_presupuestacion' WHERE "IdSistema" = 2 AND "Tag" = 'modulo_deductivas';
UPDATE public."Modulos" SET "Padre" = 'menu_gestion_obra_almacen'     WHERE "IdSistema" = 2 AND "Tag" = 'modulo_existencia_insumo';
UPDATE public."Modulos" SET "Padre" = 'menu_herramientas_gestion'     WHERE "IdSistema" = 2 AND "Tag" = 'modulo_tablero';
UPDATE public."Modulos" SET "Padre" = 'menu_crm_catalogos'            WHERE "IdSistema" = 1 AND "Tag" = 'modulo_genero';

```
### Otros
Se modificó la función: "fn_explosionesinsumos_read_paged" [Falta Producción]

fn_Requisiciones_Read_Paged [Producción]

fn_ordenescompras_read_paged [Producción]

fn_recepcionesinsumos_read_paged [Producción]

fn_salidasinsumos_read_paged [Producción]

``` SQL
--PRODUCCION
ALTER TABLE public."OrdenesComprasDetalles"
ADD COLUMN "UrlDocumento" VARCHAR(255) NULL;

ALTER TABLE public."RecepcionesInsumosDetalles"
ADD COLUMN "UrlDocumento" VARCHAR(255) NULL;

ALTER TABLE public."SalidasInsumosDetalles"
ADD COLUMN "UrlDocumento" VARCHAR(255) NULL;

ALTER TABLE public."DevolucionesInsumosDetalles"
ADD COLUMN "UrlDocumento" VARCHAR(255) NULL;

ALTER TABLE public."DevolucionesInsumosDetalles"
ADD COLUMN "Comentario" VARCHAR(255) NULL;
```

recepcioninsumosagrupadosdetallesview [Produccion]

fn_RecepcionInsumosAgrupadosDetalles_Read [Produccion]


### Devolución Insumos

``` SQL
--PRODUCCION

CREATE TABLE public."DevolucionesInsumosDocumentos" (

"Id" int4 GENERATED ALWAYS AS IDENTITY(

INCREMENT BY 1

MINVALUE 1

MAXVALUE 2147483647

START 1

CACHE 1

NO CYCLE

) NOT NULL,

"IdDevolucionInsumo" int4 NOT NULL,

"Nombre" varchar(255) NOT NULL,

"Comentario" text NULL,

"UrlDocumento" text NOT NULL,

"IdUsuarioRegistro" int4 NOT NULL,

"FechaRegistro" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,

"IdUsuarioModifico" int4 NOT NULL,

"FechaModifico" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,

"Activo" bool DEFAULT true NOT NULL,

CONSTRAINT "_DevolucionesInsumosDocumentos__pk" PRIMARY KEY ("Id")

);

  

-- Índices

CREATE INDEX ix_devolucionesinsumosdocumentos_iddevolucioninsumo

ON public."DevolucionesInsumosDocumentos" USING btree ("IdDevolucionInsumo");

  

CREATE INDEX ix_devolucionesinsumosdocumentos_idusuariomodifico

ON public."DevolucionesInsumosDocumentos" USING btree ("IdUsuarioModifico");

  

CREATE INDEX ix_devolucionesinsumosdocumentos_idusuarioregistro

ON public."DevolucionesInsumosDocumentos" USING btree ("IdUsuarioRegistro");

  

-- Foreign Keys

ALTER TABLE public."DevolucionesInsumosDocumentos"

ADD CONSTRAINT "fk_DevolucionesInsumosDocumentos_IdDevolucionInsumo"

FOREIGN KEY ("IdDevolucionInsumo") REFERENCES public."DevolucionesInsumos"("Id");

  

ALTER TABLE public."DevolucionesInsumosDocumentos"

ADD CONSTRAINT "fk_DevolucionesInsumosDocumentos_idusuariomodifico"

FOREIGN KEY ("IdUsuarioModifico") REFERENCES public."Usuarios"("Id");

  

ALTER TABLE public."DevolucionesInsumosDocumentos"

ADD CONSTRAINT "fk_DevolucionesInsumosDocumentos_idusuarioregistro"

FOREIGN KEY ("IdUsuarioRegistro") REFERENCES public."Usuarios"("Id");
```



``` SQL
--PRODUCCION
CREATE TABLE public."DevolucionesInsumosComentarios" (

"Id" int4 GENERATED ALWAYS AS IDENTITY(

INCREMENT BY 1

MINVALUE 1

MAXVALUE 2147483647

START 1

CACHE 1

NO CYCLE

) NOT NULL,

"IdDevolucionInsumo" int4 NOT NULL,

"Comentario" text NOT NULL,

"IdUsuarioRegistro" int4 NOT NULL,

"FechaRegistro" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,

"IdUsuarioModifico" int4 NOT NULL,

"FechaModifico" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,

"Activo" bool DEFAULT true NOT NULL,

CONSTRAINT "_DevolucionesInsumosComentarios__pk" PRIMARY KEY ("Id")

);

  

-- Índices

CREATE INDEX ix_devolucionesinsumoscomentarios_iddevolucioninsumo

ON public."DevolucionesInsumosComentarios" USING btree ("IdDevolucionInsumo");

  

CREATE INDEX ix_devolucionesinsumoscomentarios_idusuariomodifico

ON public."DevolucionesInsumosComentarios" USING btree ("IdUsuarioModifico");

  

CREATE INDEX ix_devolucionesinsumoscomentarios_idusuarioregistro

ON public."DevolucionesInsumosComentarios" USING btree ("IdUsuarioRegistro");

  

-- Foreign Keys

ALTER TABLE public."DevolucionesInsumosComentarios"

ADD CONSTRAINT "fk_DevolucionesInsumosComentarios_IdDevolucionInsumo"

FOREIGN KEY ("IdDevolucionInsumo") REFERENCES public."DevolucionesInsumos"("Id");

  

ALTER TABLE public."DevolucionesInsumosComentarios"

ADD CONSTRAINT "fk_DevolucionesInsumosComentarios_IdUsuarioModifico"

FOREIGN KEY ("IdUsuarioModifico") REFERENCES public."Usuarios"("Id");

  

ALTER TABLE public."DevolucionesInsumosComentarios"

ADD CONSTRAINT "fk_DevolucionesInsumosComentarios_IdUsuarioRegistro"

FOREIGN KEY ("IdUsuarioRegistro") REFERENCES public."Usuarios"("Id");
```

### Explosión de Insumos

``` SQL
--PRODUCCION

ALTER TABLE "PresupuestosConceptos" ADD COLUMN "Actualizado" BOOLEAN NOT NULL DEFAULT false;

ALTER TABLE "PresupuestosMatriz" ADD COLUMN "Actualizado" BOOLEAN NOT NULL DEFAULT false;

ALTER TABLE "PresupuestosMatrizConceptos" ADD COLUMN "Actualizado" BOOLEAN NOT NULL DEFAULT false;

ALTER TABLE "PresupuestosPartidas" ADD COLUMN "Actualizado" BOOLEAN NOT NULL DEFAULT false;
```

fn_presupuesto_programacion_read_paged [Producción]

fn_presupuesto_programacion_read [Producción]

fn_presupuesto_concepto_spi [Producción]

### Módulo Permisos Documentos

``` SQL
-- SISTEMA WEB: PRODUCCION

INSERT INTO public."Modulos" ("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre") values (1, 'Administración Documentos', 'menu_herramientas_admin_doc', 3, 3, 'menu_herramientas')

INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")
VALUES
(1, 'Administración Documentos', 'modulo_admin_documentos', 3, 3, 'menu_herramientas_admin_doc'),
(1, 'Tipo Carpetas', 'modulo_admin_tipo_carpetas', 3, 3, 'menu_herramientas_admin_doc'),
(1, 'Carpetas', 'modulo_admin_carpetas', 3, 3, 'menu_herramientas_admin_doc');

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (129,'Acceso','modulo_admin_documentos_acceso',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (130,'Registrar','modulo_admin_tipo_carpetas_registrar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (131,'Registrar','modulo_admin_carpetas_registrar',3,3);
```

``` SQL
-- SISTEMA MOVIL: PRODUCCION

INSERT INTO public."Modulos" ("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")
values (2, 'Administración Documentos', 'menu_herramientas_admin_doc', 3, 3, 'menu_herramientas')

INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")
VALUES
(2, 'Administración Documentos', 'modulo_admin_documentos', 3, 3, 'menu_herramientas_admin_doc'),
(2, 'Tipo Carpetas', 'modulo_admin_tipo_carpetas', 3, 3, 'menu_herramientas_admin_doc'),
(2, 'Carpetas', 'modulo_admin_carpetas', 3, 3, 'menu_herramientas_admin_doc');

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (134,'Acceso','modulo_admin_documentos_acceso',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (135,'Registrar','modulo_admin_tipo_carpetas_registrar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (136,'Registrar','modulo_admin_carpetas_registrar',3,3);
```
### Bitácora Centro Costos

``` SQL
CREATE TABLE public."BitacoraCentrosCostos" (
"Id" int4 GENERATED ALWAYS AS IDENTITY
(INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
"IdCentroCosto" int4 NOT NULL,
"IdPartida" int4 NULL,
"IdConcepto" int4 NULL,
"Observacion" varchar(250) NULL,
"Fecha" timestamp not NULL,
"IdUsuarioRegistro" int4 NOT NULL,
"FechaRegistro" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
"IdUsuarioModifico" int4 NOT NULL,
"FechaModifico" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
"Activo" bool DEFAULT true NOT NULL,
CONSTRAINT "BitacoraCentrosCostos_pkey" PRIMARY KEY ("Id")
);

ALTER TABLE "BitacoraCentrosCostos"
ADD COLUMN "Area" varchar(250) NOT NULL DEFAULT '',
ADD COLUMN "Tema" varchar(250) NULL;

  

-- Indexes

CREATE INDEX "IX_BitacoraCentrosCostos_Id" ON public."BitacoraCentrosCostos" USING btree ("Id");
CREATE INDEX "IX_BitacoraCentrosCostos_IdCentroCosto" ON public."BitacoraCentrosCostos" USING btree ("IdCentroCosto");
CREATE INDEX "IX_BitacoraCentrosCostos_IdPartida" ON public."BitacoraCentrosCostos" USING btree ("IdPartida");
CREATE INDEX "IX_BitacoraCentrosCostos_IdConcepto" ON public."BitacoraCentrosCostos" USING btree ("IdConcepto");
CREATE INDEX "IX_BitacoraCentrosCostos_IdUsuarioRegistro" ON public."BitacoraCentrosCostos" USING btree ("IdUsuarioRegistro");
CREATE INDEX "IX_BitacoraCentrosCostos_IdUsuarioModifico" ON public."BitacoraCentrosCostos" USING btree ("IdUsuarioModifico");
CREATE INDEX "IX_BitacoraCentrosCostos_Fecha" ON public."BitacoraCentrosCostos" USING btree ("Fecha");

  

-- Foreign keys (ajusta los nombres de tablas/columnas si difieren en tu esquema)

ALTER TABLE public."BitacoraCentrosCostos"
ADD CONSTRAINT "fk_BitacoraCentrosCostos_IdCentroCosto"
FOREIGN KEY ("IdCentroCosto") REFERENCES public."CentrosCostos"("Id");

ALTER TABLE public."BitacoraCentrosCostos"
ADD CONSTRAINT "fk_BitacoraCentrosCostos_IdPartida"
FOREIGN KEY ("IdPartida") REFERENCES public."PresupuestosPartidas"("Id");

ALTER TABLE public."BitacoraCentrosCostos"
ADD CONSTRAINT "fk_BitacoraCentrosCostos_IdConcepto"
FOREIGN KEY ("IdConcepto") REFERENCES public."PresupuestosConceptos"("Id");

ALTER TABLE public."BitacoraCentrosCostos"
ADD CONSTRAINT "fk_BitacoraCentrosCostos_IdUsuarioRegistro"
FOREIGN KEY ("IdUsuarioRegistro") REFERENCES public."Usuarios"("Id");

ALTER TABLE public."BitacoraCentrosCostos"
ADD CONSTRAINT "fk_BitacoraCentrosCostos_IdUsuarioModifico"
FOREIGN KEY ("IdUsuarioModifico") REFERENCES public."Usuarios"("Id");
```

``` SQL

CREATE TABLE public."BitacoraCentrosCostosComentarios" (
  "Id"                int4 GENERATED ALWAYS AS IDENTITY
                        (INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
  "IdBitacora"        int4 NOT NULL,
  "Comentario"        text NOT NULL,

  "IdUsuarioRegistro" int4 NOT NULL,
  "FechaRegistro"     timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
  "IdUsuarioModifico" int4 NOT NULL,
  "FechaModifico"     timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,

  "Activo"            bool DEFAULT true NOT NULL,

  CONSTRAINT "BitacoraCentrosCostosComentarios_pkey" PRIMARY KEY ("Id")
);

-- Indexes
CREATE INDEX "IX_BitacoraCentrosCostosComentarios_Id"                 ON public."BitacoraCentrosCostosComentarios" USING btree ("Id");
CREATE INDEX "IX_BitacoraCentrosCostosComentarios_IdBitacora"         ON public."BitacoraCentrosCostosComentarios" USING btree ("IdBitacora");
CREATE INDEX "IX_BitacoraCentrosCostosComentarios_IdUsuarioRegistro"  ON public."BitacoraCentrosCostosComentarios" USING btree ("IdUsuarioRegistro");
CREATE INDEX "IX_BitacoraCentrosCostosComentarios_IdUsuarioModifico"  ON public."BitacoraCentrosCostosComentarios" USING btree ("IdUsuarioModifico");
CREATE INDEX "IX_BitacoraCentrosCostosComentarios_FechaRegistro"      ON public."BitacoraCentrosCostosComentarios" USING btree ("FechaRegistro");

-- Foreign keys
ALTER TABLE public."BitacoraCentrosCostosComentarios"
  ADD CONSTRAINT "fk_BitCCCom_IdBitacora"
    FOREIGN KEY ("IdBitacora") REFERENCES public."BitacoraCentrosCostos"("Id");

ALTER TABLE public."BitacoraCentrosCostosComentarios"
  ADD CONSTRAINT "fk_BitCCCom_IdUsuarioRegistro"
    FOREIGN KEY ("IdUsuarioRegistro") REFERENCES public."Usuarios"("Id");

ALTER TABLE public."BitacoraCentrosCostosComentarios"
  ADD CONSTRAINT "fk_BitCCCom_IdUsuarioModifico"
    FOREIGN KEY ("IdUsuarioModifico") REFERENCES public."Usuarios"("Id");

```

``` SQL
CREATE TABLE public."BitacoraCentrosCostosDocumentos" (
"Id" int4 GENERATED ALWAYS AS IDENTITY (INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
"IdBitacora" int4 NOT NULL,
"Nombre" varchar(255) NULL,
"Comentario" text NULL,
"UrlDocumento" text NULL,
"IdUsuarioRegistro" int4 NOT NULL,
"FechaRegistro" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
"IdUsuarioModifico" int4 NOT NULL,
"FechaModifico" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
"Activo" bool DEFAULT true NOT NULL,

CONSTRAINT "BitacoraCentrosCostosDocumentos_pkey" PRIMARY KEY ("Id")

);

  

-- Indexes

CREATE INDEX "IX_BitacoraCentrosCostosDocumentos_Id" ON public."BitacoraCentrosCostosDocumentos" USING btree ("Id");

CREATE INDEX "IX_BitacoraCentrosCostosDocumentos_IdBitacora" ON public."BitacoraCentrosCostosDocumentos" USING btree ("IdBitacora");

CREATE INDEX "IX_BitacoraCentrosCostosDocumentos_IdUsuarioModifico" ON public."BitacoraCentrosCostosDocumentos" USING btree ("IdUsuarioModifico");

CREATE INDEX "IX_BitacoraCentrosCostosDocumentos_IdUsuarioRegistro" ON public."BitacoraCentrosCostosDocumentos" USING btree ("IdUsuarioRegistro");

  

-- Foreign keys

ALTER TABLE public."BitacoraCentrosCostosDocumentos"

ADD CONSTRAINT "fk_BitCCD_IdBitacora"

FOREIGN KEY ("IdBitacora") REFERENCES public."BitacoraCentrosCostos"("Id");

  

ALTER TABLE public."BitacoraCentrosCostosDocumentos"
ADD CONSTRAINT "fk_BitCCD_IdUsuarioModifico"
FOREIGN KEY ("IdUsuarioModifico") REFERENCES public."Usuarios"("Id");

ALTER TABLE public."BitacoraCentrosCostosDocumentos"
ADD CONSTRAINT "fk_BitCCD_IdUsuarioRegistro"
FOREIGN KEY ("IdUsuarioModifico") REFERENCES public."Usuarios"("Id");
```

``` SQL
CREATE TABLE public."TiposEstatusBitacoraCentrosCostos" (

"Id" int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
"Nombre" varchar(100) NOT NULL,
"Tipo" varchar(100) NOT NULL,
CONSTRAINT "TiposEstatusBitacoraCentrosCostoss_pkey" PRIMARY KEY ("Id"));
CREATE INDEX ix_TiposEstatusBitacoraCentrosCostos_id ON public."TiposEstatusBitacoraCentrosCostos" USING btree ("Id");

INSERT INTO public."TiposEstatusBitacoraCentrosCostos" ("Nombre", "Tipo")
VALUES
    ('Creado', '200'),
    ('Autorizado', '1000'),
    ('Cancelado', '-3000'),
    ('Rechazado', '-2000'),
    ('Autorizacion completa', '1100');

```

``` SQL
CREATE TABLE public."BitacoraCentrosCostosEstatus" (
"Id" int4 GENERATED ALWAYS AS IDENTITY (
INCREMENT BY 1
MINVALUE 1
MAXVALUE 2147483647
START 1
CACHE 1
NO CYCLE
) NOT NULL,
"IdBitacora" int4 NOT NULL,
"IdEstatus" int4 NOT NULL,
"IdUsuarioRegistro" int4 NOT NULL,
"FechaRegistro" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
CONSTRAINT "BitacoraCentrosCostosEstatus_pkey" PRIMARY KEY ("Id")
);

  

-- Índices

CREATE INDEX ix_bitacoracentroscostosestatus_id
ON public."BitacoraCentrosCostosEstatus" USING btree ("Id");

CREATE INDEX ix_bitacoracentroscostosestatus_idestatus
ON public."BitacoraCentrosCostosEstatus" USING btree ("IdEstatus");

CREATE INDEX ix_bitacoracentroscostosestatus_idbitacora
ON public."BitacoraCentrosCostosEstatus" USING btree ("IdBitacora");  

CREATE INDEX ix_bitacoracentroscostosestatus_idusuarioregistro
ON public."BitacoraCentrosCostosEstatus" USING btree ("IdUsuarioRegistro");


-- Claves foráneas

ALTER TABLE public."BitacoraCentrosCostosEstatus"
ADD CONSTRAINT "fk_BitacoraCentrosCostosEstatus_IdEstatus"
FOREIGN KEY ("IdEstatus")
REFERENCES public."TiposEstatusBitacoraCentrosCostos" ("Id");

  
ALTER TABLE public."BitacoraCentrosCostosEstatus"
ADD CONSTRAINT "fk_BitacoraCentrosCostosEstatus_IdBitacora"
FOREIGN KEY ("IdBitacora")
REFERENCES public."BitacoraCentrosCostos" ("Id");


ALTER TABLE public."BitacoraCentrosCostosEstatus"
ADD CONSTRAINT "fk_BitacoraCentrosCostosEstatus_IdUsuarioRegistro"
FOREIGN KEY ("IdUsuarioRegistro")
REFERENCES public."Usuarios" ("Id");
```

``` SQL
INSERT INTO "TiposFlujosAutorizaciones" ("Nombre", "Descripcion", "Tag")
VALUES ('Bitacora Centro Costos', 'Bitacora Centro Costos', '##Flujo_bcc');
```

fn_calculosbitacorascentroscostosestatus [Producción] 
fn_BitacoraCentroCosto_Read_Paged [Producción]
fn_addocdashboard_read [Producción]
fn_CalculoCantidadDocumentosCarpeta [Producción]

### Módulo Bitácora Permisos

```SQL
--- SISTEMA WEB: PRODUCCION

INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")
VALUES
(1, 'Bitácora Centro Costos', 'modulo_bitacora_cc', 3, 3, 'menu_herramientas');

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (137,'Acceso','modulo_bitacora_cc_acceso',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (137,'Registrar','modulo_bitacora_cc_registrar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (137,'Editar','modulo_bitacora_cc_editar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (137,'Eliminar','modulo_bitacora_cc_eliminar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (137,'Eliminar masivo','modulo_bitacora_cc_eliminar_masivo',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (137,'Exportar','modulo_bitacora_cc_exportar',3,3);
```

```SQL
---SISTEMA MOVIL: PRODUCCION

INSERT INTO public."Modulos" ("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre") VALUES (2, 'Bitácora Centro Costos', 'modulo_bitacora_cc', 3, 3, 'menu_herramientas');

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (138,'Acceso','modulo_bitacora_cc_acceso',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (138,'Registrar','modulo_bitacora_cc_registrar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (138,'Editar','modulo_bitacora_cc_editar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (138,'Eliminar','modulo_bitacora_cc_eliminar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (138,'Eliminar masivo','modulo_bitacora_cc_eliminar_masivo',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (138,'Exportar','modulo_bitacora_cc_exportar',3,3);
```

### Modificación PresupuestoConcepto

``` SQL
-- PRODUCCIÓN

ALTER TABLE "PresupuestosConceptos"
ALTER COLUMN "Descripcion" TYPE VARCHAR(1000)

ALTER TABLE "PresupuestosConceptos"
ALTER COLUMN "Nombre" TYPE VARCHAR(1000);

-- public.aditivasdetallesview source

DROP VIEW aditivasdetallesview;

CREATE OR REPLACE VIEW public.aditivasdetallesview
AS SELECT detalle."Id",
    detalle."IdExplosionInsumo",
    detalle."Cantidad",
    detalle."IdUsuarioRegistro",
    detalle."FechaRegistro",
    detalle."IdUsuarioModifico",
    detalle."FechaModifico",
    detalle."IdAditivaAgrupador",
    detalle."Precio",
    aditiva."Id" AS "AditivaId",
    aditiva."IdExplosion" AS "AditivaIdExplosion",
    aditiva."Nombre" AS "AditivaNombre",
    aditiva."Codigo" AS "AditivaCodigo",
    aditiva."Descripcion" AS "AditivaDescripcion",
    aditiva."IdUsuarioRegistro" AS "AditivaIdUsuarioRegistro",
    aditiva."FechaRegistro" AS "AditivaFechaRegistro",
    aditiva."IdUsuarioModifico" AS "AditivaIdUsuarioModifico",
    aditiva."FechaModifico" AS "AditivaFechaModifico",
    aditiva."Activo" AS "AditivaActivo",
    aditiva."IdTipo" AS "AditivaIdTipo",
    aditiva."IdRequisicion" AS "AditivaIdRequisicion",
    explosion."Id" AS "ExplosionId",
    explosion."IdPresupuesto" AS "ExplosionIdPresupuesto",
    explosion."Codigo" AS "ExplosionCodigo",
    explosion."Descripcion" AS "ExplosionDescripcion",
    explosion."IdUsuarioRegistro" AS "ExplosionIdUsuarioRegistro",
    explosion."FechaRegistro" AS "ExplosionFechaRegistro",
    explosion."IdUsuarioModifico" AS "ExplosionIdUsuarioModifico",
    explosion."FechaModifico" AS "ExplosionFechaModifico",
    explosion."Activo" AS "ExplosionActivo",
    explosion."Actualizada" AS "ExplosionActualizada",
    presupuesto."Id" AS "PresupuestoId",
    presupuesto."Nombre" AS "PresupuestoNombre",
    presupuesto."Codigo" AS "PresupuestoCodigo",
    presupuesto."Descripcion" AS "PresupuestoDescripcion",
    presupuesto."IdEmpresa" AS "PresupuestoIdEmpresa",
    presupuesto."IdClasificadorPresupuesto" AS "PresupuestoIdClasificadorPresupuesto",
    presupuesto."Email" AS "PresupuestoEmail",
    presupuesto."IdCentroCosto" AS "PresupuestoIdCentroCosto",
    presupuesto."IdResponsable" AS "PresupuestoIdResponsable",
    presupuesto."IdTipo" AS "PresupuestoIdTipo",
    presupuesto."Observaciones" AS "PresupuestoObservaciones",
    explosioninsumo."Id" AS "ExplosionInsumoId",
    explosioninsumo."IdExplosion" AS "ExplosionInsumoIdExplosion",
    explosioninsumo."IdPresupuesto" AS "ExplosionInsumoIdPresupuesto",
    explosioninsumo."IdPresupuestoConcepto" AS "ExplosionInsumoIdPresupuestoConcepto",
    explosioninsumo."IdInsumo" AS "ExplosionInsumoIdInsumo",
    explosioninsumo."Cantidad" AS "ExplosionInsumoCantidad",
    explosioninsumo."IdPrecio" AS "ExplosionInsumoIdPrecio",
    insumo."Id" AS "InsumoId",
    insumo."Nombre" AS "InsumoNombre",
    insumo."Codigo" AS "InsumoCodigo",
    tipoinsumo."Id" AS "TipoInsumoId",
    tipoinsumo."Nombre" AS "TipoInsumoNombre",
    tipoinsumo."Codigo" AS "TipoInsumoCodigo",
    tipoinsumo."Descripcion" AS "TipoInsumoDescripcion",
    unidadmedida."Id" AS "UnidadMedidaId",
    unidadmedida."Nombre" AS "UnidadMedidaNombre",
    unidadmedida."Clave" AS "UnidadMedidaClave",
    unidadmedida."Tipo" AS "UnidadMedidaTipo",
    familiainsumo."Id" AS "FamiliaInsumoId",
    familiainsumo."Nombre" AS "FamiliaInsumoNombre",
    familiainsumo."Codigo" AS "FamiliaInsumoCodigo",
    familiainsumo."Descripcion" AS "FamiliaInsumoDescripcion",
    presupuestopartida."Id" AS "PresupuestoPartidaId",
    presupuestopartida."Nombre" AS "PresupuestoPartidaNombre",
    presupuestopartida."Descripcion" AS "PresupuestoPartidaDescripcion",
    presupuestopartida."Observaciones" AS "PresupuestoPartidaObservaciones",
    presupuestoconcepto."Id" AS "PresupuestoConceptoId",
    presupuestoconcepto."Nombre" AS "PresupuestoConceptoNombre",
    presupuestoconcepto."Codigo" AS "PresupuestoConceptoCodigo",
    presupuestoconcepto."Descripcion" AS "PresupuestoConceptoDescripcion",
    presupuestoinsumoprecio."Id" AS "PresupuestoInsumoPrecioId",
    presupuestoinsumoprecio."IdInsumo" AS "PresupuestoInsumoPrecioIdInsumo",
    presupuestoinsumoprecio."IdMoneda" AS "PresupuestoInsumoPrecioIdMoneda",
    presupuestoinsumoprecio."IdPresupuesto" AS "PresupuestoInsumoPrecioIdPresupuesto",
    presupuestoinsumoprecio."Precio" AS "PresupuestoInsumoPrecioPrecio",
    usuarioregistro."Id" AS "UsuarioRegistroId",
    usuarioregistro."Nombre" AS "UsuarioRegistroNombre",
    usuarioregistro."ApellidoPaterno" AS "UsuarioRegistroApellidoPaterno",
    usuarioregistro."ApellidoMaterno" AS "UsuarioRegistroApellidoMaterno",
    usuariomodifico."Id" AS "UsuarioModificoId",
    usuariomodifico."Nombre" AS "UsuarioModificoNombre",
    usuariomodifico."ApellidoPaterno" AS "UsuarioModificoApellidoPaterno",
    usuariomodifico."ApellidoMaterno" AS "UsuarioModificoApellidoMaterno"
   FROM "AditivasDetalles" detalle
     JOIN "Aditivas" aditiva ON aditiva."Id" = detalle."IdAditivaAgrupador"
     JOIN "Explosiones" explosion ON explosion."Id" = aditiva."IdExplosion"
     JOIN "Presupuestos" presupuesto ON presupuesto."Id" = explosion."IdPresupuesto"
     LEFT JOIN "ExplosionesInsumos" explosioninsumo ON explosioninsumo."Id" = detalle."IdExplosionInsumo"
     LEFT JOIN "PresupuestosInsumosPrecios" presupuestoinsumoprecio ON presupuestoinsumoprecio."Id" = explosioninsumo."IdPrecio"
     LEFT JOIN "PresupuestosConceptos" presupuestoconcepto ON presupuestoconcepto."Id" = explosioninsumo."IdPresupuestoConcepto"
     LEFT JOIN "PresupuestosPartidas" presupuestopartida ON presupuestopartida."Id" = presupuestoconcepto."IdPartida"
     LEFT JOIN "Insumos" insumo ON insumo."Id" = explosioninsumo."IdInsumo"
     LEFT JOIN "TiposInsumos" tipoinsumo ON tipoinsumo."Id" = insumo."IdTipo"
     LEFT JOIN "UnidadesMedidas" unidadmedida ON unidadmedida."Id" = insumo."IdUnidadMedida"
     LEFT JOIN "FamiliasInsumos" familiainsumo ON familiainsumo."Id" = insumo."IdFamiliaInsumo"
     JOIN "Usuarios" usuarioregistro ON usuarioregistro."Id" = detalle."IdUsuarioRegistro"
     JOIN "Usuarios" usuariomodifico ON usuariomodifico."Id" = detalle."IdUsuarioModifico";

-- public.deductivasdetallesview source

DROP VIEW deductivasdetallesview;
CREATE OR REPLACE VIEW public.deductivasdetallesview
AS SELECT detalle."Id",
    detalle."IdExplosionInsumo",
    detalle."Cantidad",
    detalle."IdUsuarioRegistro",
    detalle."FechaRegistro",
    detalle."IdUsuarioModifico",
    detalle."FechaModifico",
    detalle."IdDeductivaAgrupador",
    detalle."Precio",
    centrocosto."Id" AS "CentroCostoId",
    centrocosto."Nombre" AS "CentroCostoNombre",
    centrocosto."Codigo" AS "CentroCostoCodigo",
    centrocosto."Descripcion" AS "CentroCostoDescripcion",
    deductiva."Id" AS "DeductivaId",
    deductiva."IdExplosion" AS "DeductivaIdExplosion",
    deductiva."Nombre" AS "DeductivaNombre",
    deductiva."Codigo" AS "DeductivaCodigo",
    deductiva."Descripcion" AS "DeductivaDescripcion",
    deductiva."IdUsuarioRegistro" AS "DeductivaIdUsuarioRegistro",
    deductiva."FechaRegistro" AS "DeductivaFechaRegistro",
    deductiva."IdUsuarioModifico" AS "DeductivaIdUsuarioModifico",
    deductiva."FechaModifico" AS "DeductivaFechaModifico",
    deductiva."Activo" AS "DeductivaActivo",
    deductiva."IdTipo" AS "DeductivaIdTipo",
    explosion."Id" AS "ExplosionId",
    explosion."IdPresupuesto" AS "ExplosionIdPresupuesto",
    explosion."Codigo" AS "ExplosionCodigo",
    explosion."Descripcion" AS "ExplosionDescripcion",
    explosion."IdUsuarioRegistro" AS "ExplosionIdUsuarioRegistro",
    explosion."FechaRegistro" AS "ExplosionFechaRegistro",
    explosion."IdUsuarioModifico" AS "ExplosionIdUsuarioModifico",
    explosion."FechaModifico" AS "ExplosionFechaModifico",
    explosion."Activo" AS "ExplosionActivo",
    explosion."Actualizada" AS "ExplosionActualizada",
    presupuesto."Id" AS "PresupuestoId",
    presupuesto."Nombre" AS "PresupuestoNombre",
    presupuesto."Codigo" AS "PresupuestoCodigo",
    presupuesto."Descripcion" AS "PresupuestoDescripcion",
    presupuesto."IdEmpresa" AS "PresupuestoIdEmpresa",
    presupuesto."IdClasificadorPresupuesto" AS "PresupuestoIdClasificadorPresupuesto",
    presupuesto."Email" AS "PresupuestoEmail",
    presupuesto."IdCentroCosto" AS "PresupuestoIdCentroCosto",
    presupuesto."IdResponsable" AS "PresupuestoIdResponsable",
    presupuesto."IdTipo" AS "PresupuestoIdTipo",
    presupuesto."Observaciones" AS "PresupuestoObservaciones",
    explosioninsumo."Id" AS "ExplosionInsumoId",
    explosioninsumo."IdExplosion" AS "ExplosionInsumoIdExplosion",
    explosioninsumo."IdPresupuesto" AS "ExplosionInsumoIdPresupuesto",
    explosioninsumo."IdPresupuestoConcepto" AS "ExplosionInsumoIdPresupuestoConcepto",
    explosioninsumo."IdInsumo" AS "ExplosionInsumoIdInsumo",
    explosioninsumo."Cantidad" AS "ExplosionInsumoCantidad",
    explosioninsumo."IdPrecio" AS "ExplosionInsumoIdPrecio",
    insumo."Id" AS "InsumoId",
    insumo."Nombre" AS "InsumoNombre",
    insumo."Codigo" AS "InsumoCodigo",
    tipoinsumo."Id" AS "TipoInsumoId",
    tipoinsumo."Nombre" AS "TipoInsumoNombre",
    tipoinsumo."Codigo" AS "TipoInsumoCodigo",
    tipoinsumo."Descripcion" AS "TipoInsumoDescripcion",
    unidadmedida."Id" AS "UnidadMedidaId",
    unidadmedida."Nombre" AS "UnidadMedidaNombre",
    unidadmedida."Clave" AS "UnidadMedidaClave",
    unidadmedida."Tipo" AS "UnidadMedidaTipo",
    familiainsumo."Id" AS "FamiliaInsumoId",
    familiainsumo."Nombre" AS "FamiliaInsumoNombre",
    familiainsumo."Codigo" AS "FamiliaInsumoCodigo",
    familiainsumo."Descripcion" AS "FamiliaInsumoDescripcion",
    presupuestopartida."Id" AS "PresupuestoPartidaId",
    presupuestopartida."Nombre" AS "PresupuestoPartidaNombre",
    presupuestopartida."Descripcion" AS "PresupuestoPartidaDescripcion",
    presupuestopartida."Observaciones" AS "PresupuestoPartidaObservaciones",
    presupuestoconcepto."Id" AS "PresupuestoConceptoId",
    presupuestoconcepto."Nombre" AS "PresupuestoConceptoNombre",
    presupuestoconcepto."Codigo" AS "PresupuestoConceptoCodigo",
    presupuestoconcepto."Descripcion" AS "PresupuestoConceptoDescripcion",
    presupuestoinsumoprecio."Id" AS "PresupuestoInsumoPrecioId",
    presupuestoinsumoprecio."IdInsumo" AS "PresupuestoInsumoPrecioIdInsumo",
    presupuestoinsumoprecio."IdMoneda" AS "PresupuestoInsumoPrecioIdMoneda",
    presupuestoinsumoprecio."IdPresupuesto" AS "PresupuestoInsumoPrecioIdPresupuesto",
    presupuestoinsumoprecio."Precio" AS "PresupuestoInsumoPrecioPrecio",
    usuarioregistro."Id" AS "UsuarioRegistroId",
    usuarioregistro."Nombre" AS "UsuarioRegistroNombre",
    usuarioregistro."ApellidoPaterno" AS "UsuarioRegistroApellidoPaterno",
    usuarioregistro."ApellidoMaterno" AS "UsuarioRegistroApellidoMaterno",
    usuariomodifico."Id" AS "UsuarioModificoId",
    usuariomodifico."Nombre" AS "UsuarioModificoNombre",
    usuariomodifico."ApellidoPaterno" AS "UsuarioModificoApellidoPaterno",
    usuariomodifico."ApellidoMaterno" AS "UsuarioModificoApellidoMaterno"
   FROM "DeductivasDetalles" detalle
     JOIN "Deductivas" deductiva ON deductiva."Id" = detalle."IdDeductivaAgrupador"
     JOIN "Explosiones" explosion ON explosion."Id" = deductiva."IdExplosion"
     JOIN "Presupuestos" presupuesto ON presupuesto."Id" = explosion."IdPresupuesto"
     JOIN "CentrosCostos" centrocosto ON centrocosto."Id" = presupuesto."IdCentroCosto"
     LEFT JOIN "ExplosionesInsumos" explosioninsumo ON explosioninsumo."Id" = detalle."IdExplosionInsumo"
     LEFT JOIN "PresupuestosInsumosPrecios" presupuestoinsumoprecio ON presupuestoinsumoprecio."Id" = explosioninsumo."IdPrecio"
     LEFT JOIN "PresupuestosConceptos" presupuestoconcepto ON presupuestoconcepto."Id" = explosioninsumo."IdPresupuestoConcepto"
     LEFT JOIN "PresupuestosPartidas" presupuestopartida ON presupuestopartida."Id" = presupuestoconcepto."IdPartida"
     LEFT JOIN "Insumos" insumo ON insumo."Id" = explosioninsumo."IdInsumo"
     LEFT JOIN "TiposInsumos" tipoinsumo ON tipoinsumo."Id" = insumo."IdTipo"
     LEFT JOIN "UnidadesMedidas" unidadmedida ON unidadmedida."Id" = insumo."IdUnidadMedida"
     LEFT JOIN "FamiliasInsumos" familiainsumo ON familiainsumo."Id" = insumo."IdFamiliaInsumo"
     JOIN "Usuarios" usuarioregistro ON usuarioregistro."Id" = detalle."IdUsuarioRegistro"
     JOIN "Usuarios" usuariomodifico ON usuariomodifico."Id" = detalle."IdUsuarioModifico";


-- public.estimacionesinsumosdetallesview source
DROP VIEW estimacionesinsumosdetallesview;
CREATE OR REPLACE VIEW public.estimacionesinsumosdetallesview
AS SELECT detalle."Id",
    detalle."IdEstimacionInsumo",
    detalle."IdFrente",
    detalle."Cantidad",
    detalle."Observaciones",
    detalle."IdUsuarioRegistro",
    detalle."FechaRegistro",
    detalle."IdProveedorRegistro",
    frente."Id" AS "FrenteId",
    frente."Codigo" AS "FrenteCodigo",
    frente."IdCentroCosto" AS "FrenteIdCentroCosto",
    frente."Nombre" AS "FrenteNombre",
    frente."Descripcion" AS "FrenteDescripcion",
    frente."IdUsuarioRegistro" AS "FrenteIdUsuarioRegistro",
    frente."FechaRegistro" AS "FrenteFechaRegistro",
    frente."IdUsuarioModifico" AS "FrenteIdUsuarioModifico",
    frente."FechaModifico" AS "FrenteFechaModifico",
    frente."Activo" AS "FrenteActivo",
    estimacioninsumo."Id" AS "EstimacionInsumoId",
    estimacioninsumo."IdEstimacion" AS "EstimacionInsumoIdEstimacion",
    estimacioninsumo."IdSubcontratoDetalle" AS "EstimacionInsumoIdSubcontratoDetalle",
    estimacioninsumo."Observaciones" AS "EstimacionInsumoObservaciones",
    estimacioninsumo."IdUsuarioRegistro" AS "EstimacionInsumoIdUsuarioRegistro",
    estimacioninsumo."FechaRegistro" AS "EstimacionInsumoFechaRegistro",
    estimacion."Id" AS "EstimacionId",
    estimacion."IdCentroCosto" AS "EstimacionIdCentroCosto",
    estimacion."IdCentroCostoAplica" AS "EstimacionIdCentroCostoAplica",
    estimacion."Folio" AS "EstimacionFolio",
    estimacion."IdProveedor" AS "EstimacionIdProveedor",
    estimacion."IdProveedorAplica" AS "EstimacionIdProveedorAplica",
    estimacion."IdSubcontrato" AS "EstimacionIdSubcontrato",
    estimacion."Observaciones" AS "EstimacionObservaciones",
    estimacion."IdUsuarioRegistro" AS "EstimacionIdUsuarioRegistro",
    estimacion."FechaRegistro" AS "EstimacionFechaRegistro",
    estimacion."IdUsuarioModifico" AS "EstimacionIdUsuarioModifico",
    estimacion."FechaModifico" AS "EstimacionFechaModifico",
    estimacion."Activo" AS "EstimacionActivo",
    estimacion."Clave" AS "EstimacionClave",
    estimacion."FechaInicial" AS "EstimacionFechaInicial",
    estimacion."FechaFinal" AS "EstimacionFechaFinal",
    subcontratodetalle."Id" AS "SubcontratoDetalleId",
    subcontratodetalle."IdExplosionInsumo" AS "SubcontratoDetalleIdExplosionInsumo",
    subcontratodetalle."IdExplosionSubcontrato" AS "SubcontratoDetalleIdExplosionSubcontrato",
    subcontratodetalle."Cantidad" AS "SubcontratoDetalleCantidad",
    subcontratodetalle."Observaciones" AS "SubcontratoDetalleObservaciones",
    subcontratodetalle."Precio" AS "SubcontratoDetallePrecio",
    subcontratodetalle."IdUsuarioRegistro" AS "SubcontratoDetalleIdUsuarioRegistro",
    subcontratodetalle."FechaRegistro" AS "SubcontratoDetalleFechaRegistro",
    subcontratodetalle."IdUsuarioModifico" AS "SubcontratoDetalleIdUsuarioModifico",
    subcontratodetalle."FechaModifico" AS "SubcontratoDetalleFechaModifico",
    subcontratodetalle."Activo" AS "SubcontratoDetalleActivo",
    empresa."Id" AS "EmpresaId",
    empresa."Nombre" AS "EmpresaNombre",
    empresa."NombreComercial" AS "EmpresaNombreComercial",
    empresa."RazonSocial" AS "EmpresaRazonSocial",
    empresa."RFC" AS "EmpresaRfc",
    presupuesto."Id" AS "PresupuestoId",
    presupuesto."Codigo" AS "PresupuestoCodigo",
    presupuesto."Nombre" AS "PresupuestoNombre",
    presupuesto."IdEmpresa" AS "PresupuestoIdEmpresa",
    centrocosto."Id" AS "CentroCostoId",
    centrocosto."Nombre" AS "CentroCostoNombre",
    centrocosto."Codigo" AS "CentroCostoCodigo",
    centrocosto."Descripcion" AS "CentroCostoDescripcion",
    explosioninsumo."Id" AS "ExplosionInsumoId",
    explosioninsumo."IdExplosion" AS "ExplosionInsumoIdExplosion",
    explosioninsumo."IdPresupuesto" AS "ExplosionInsumoIdPresupuesto",
    explosioninsumo."IdPresupuestoConcepto" AS "ExplosionInsumoIdPresupuestoConcepto",
    explosioninsumo."IdInsumo" AS "ExplosionInsumoIdInsumo",
    explosioninsumo."Cantidad" AS "ExplosionInsumoCantidad",
    explosioninsumo."IdPrecio" AS "ExplosionInsumoIdPrecio",
    explosioninsumo."IdUsuarioRegistro" AS "ExplosionInsumoIdUsuarioRegistro",
    explosioninsumo."FechaRegistro" AS "ExplosionInsumoFechaRegistro",
    explosioninsumo."IdUsuarioModifico" AS "ExplosionInsumoIdUsuarioModifico",
    explosioninsumo."FechaModifico" AS "ExplosionInsumoFechaModifico",
    explosioninsumo."Autorizado" AS "ExplosionInsumoAutorizado",
    explosioninsumo."Contratable" AS "ExplosionInsumoContratable",
    explosioninsumo."NoConsiderado" AS "ExplosionInsumoNoConsiderado",
    insumo."Id" AS "InsumoId",
    insumo."Nombre" AS "InsumoNombre",
    insumo."Codigo" AS "InsumoCodigo",
    insumo."Descripcion" AS "InsumoDescripcion",
    insumo."IdTipo" AS "InsumoIdTipo",
    insumo."IdCorporativo" AS "InsumoIdCorporativo",
    insumo."IdFamiliaInsumo" AS "InsumoIdFamiliaInsumo",
    insumo."IdUnidadMedida" AS "InsumoIdUnidadMedida",
    insumo."UrlImagen" AS "InsumoUrlImagen",
    unidad."Id" AS "UnidadMedidaId",
    unidad."Nombre" AS "UnidadMedidaNombre",
    unidad."Clave" AS "UnidadMedidaClave",
    unidad."Tipo" AS "UnidadMedidaTipo",
    tipoinsumo."Id" AS "TipoInsumoId",
    tipoinsumo."Nombre" AS "TipoInsumoNombre",
    tipoinsumo."Codigo" AS "TipoInsumoCodigo",
    tipoinsumo."Descripcion" AS "TipoInsumoDescripcion",
    tipoinsumo."ManoDeObra" AS "TipoInsumoManoDeObra",
    tipoinsumo."Financiero" AS "TipoInsumoFinanciero",
    tipoinsumo."Inventariable" AS "TipoInsumoInventariable",
    tipoinsumo."Administrativo" AS "TipoInsumoAdministrativo",
    tipoinsumo."IdCorporativo" AS "TipoInsumoIdCorporativo",
    presupuestoconcepto."Id" AS "PresupuestoConceptoId",
    presupuestoconcepto."IdPresupuesto" AS "PresupuestoConceptoIdPresupuesto",
    presupuestoconcepto."IdPartida" AS "PresupuestoConceptoIdPartida",
    presupuestoconcepto."IdMoneda" AS "PresupuestoConceptoIdMoneda",
    presupuestoconcepto."Codigo" AS "PresupuestoConceptoCodigo",
    presupuestoconcepto."Descripcion" AS "PresupuestoConceptoDescripcion",
    presupuestoconcepto."Cantidad" AS "PresupuestoConceptoCantidad",
    presupuestoconcepto."Precio" AS "PresupuestoConceptoPrecio",
    presupuestoconcepto."IdTipoConcepto" AS "PresupuestoConceptoIdTipoConcepto",
    presupuestoconcepto."Nombre" AS "PresupuestoConceptoNombre",
    presupuestopartida."Id" AS "PresupuestoPartidaId",
    presupuestopartida."Nombre" AS "PresupuestoPartidaNombre",
    presupuestopartida."Descripcion" AS "PresupuestoPartidaDescripcion",
    presupuestopartida."Observaciones" AS "PresupuestoPartidaObservaciones",
    presupuestopartida."IdPadre" AS "PresupuestoPartidaIdPadre",
    presupuestopartida."IdPresupuesto" AS "PresupuestoPartidaIdPresupuesto",
    usuarioregistro."Id" AS "UsuarioRegistroId",
    usuarioregistro."Nombre" AS "UsuarioRegistroNombre",
    usuarioregistro."ApellidoPaterno" AS "UsuarioRegistroApellidoPaterno",
    usuarioregistro."ApellidoMaterno" AS "UsuarioRegistroApellidoMaterno",
    presupuestoinsumoprecio."Id" AS "PresupuestoInsumoPrecioId",
    presupuestoinsumoprecio."IdInsumo" AS "PresupuestoInsumoPrecioIdInsumo",
    presupuestoinsumoprecio."IdMoneda" AS "PresupuestoInsumoPrecioIdMoneda",
    presupuestoinsumoprecio."IdPresupuesto" AS "PresupuestoInsumoPrecioIdPresupuesto",
    presupuestoinsumoprecio."Precio" AS "PresupuestoInsumoPrecioPrecio",
    proveedorregistro."RazonSocial" AS "ProveedorRegistroRazonSocial",
    proveedorregistro."NombreComercial" AS "ProveedorRegistroNombreComercial",
    proveedorregistro."Rfc" AS "ProveedorRegistroRfc"
   FROM "EstimacionesInsumosDetalles" detalle
     JOIN "EstimacionesInsumos" estimacioninsumo ON estimacioninsumo."Id" = detalle."IdEstimacionInsumo"
     JOIN "Estimaciones" estimacion ON estimacion."Id" = estimacioninsumo."IdEstimacion"
     JOIN "Frentes" frente ON frente."Id" = detalle."IdFrente"
     JOIN "ExplosionesSubcontratosDetalles" subcontratodetalle ON subcontratodetalle."Id" = estimacioninsumo."IdSubcontratoDetalle"
     JOIN "ExplosionesInsumos" explosioninsumo ON explosioninsumo."Id" = subcontratodetalle."IdExplosionInsumo"
     JOIN "Presupuestos" presupuesto ON presupuesto."Id" = explosioninsumo."IdPresupuesto"
     LEFT JOIN "PresupuestosInsumosPrecios" presupuestoinsumoprecio ON presupuestoinsumoprecio."Id" = explosioninsumo."IdPrecio"
     JOIN "CentrosCostos" centrocosto ON centrocosto."Id" = presupuesto."IdCentroCosto"
     JOIN "Empresas" empresa ON centrocosto."IdEmpresa" = empresa."Id"
     JOIN "Insumos" insumo ON insumo."Id" = explosioninsumo."IdInsumo"
     JOIN "UnidadesMedidas" unidad ON unidad."Id" = insumo."IdUnidadMedida"
     JOIN "TiposInsumos" tipoinsumo ON tipoinsumo."Id" = insumo."IdTipo"
     JOIN "PresupuestosConceptos" presupuestoconcepto ON presupuestoconcepto."Id" = explosioninsumo."IdPresupuestoConcepto"
     JOIN "PresupuestosPartidas" presupuestopartida ON presupuestopartida."Id" = presupuestoconcepto."IdPartida"
     LEFT JOIN "Usuarios" usuarioregistro ON usuarioregistro."Id" = detalle."IdUsuarioRegistro"
     LEFT JOIN "Proveedores" proveedorregistro ON proveedorregistro."Id" = detalle."IdProveedorRegistro"
  WHERE estimacion."Activo" = true;

-- public.estimacionesinsumosview source
DROP VIEW estimacionesinsumosview;
CREATE OR REPLACE VIEW public.estimacionesinsumosview
AS SELECT detalle."Id",
    detalle."IdEstimacion",
    detalle."IdSubcontratoDetalle",
    detalle."Observaciones",
    detalle."IdUsuarioRegistro",
    detalle."FechaRegistro",
    detalle."IdProveedorRegistro",
    estimacion."Id" AS "EstimacionId",
    estimacion."IdCentroCosto" AS "EstimacionIdCentroCosto",
    estimacion."IdCentroCostoAplica" AS "EstimacionIdCentroCostoAplica",
    estimacion."Folio" AS "EstimacionFolio",
    estimacion."IdProveedor" AS "EstimacionIdProveedor",
    estimacion."IdProveedorAplica" AS "EstimacionIdProveedorAplica",
    estimacion."IdSubcontrato" AS "EstimacionIdSubcontrato",
    estimacion."Observaciones" AS "EstimacionObservaciones",
    estimacion."IdUsuarioRegistro" AS "EstimacionIdUsuarioRegistro",
    estimacion."FechaRegistro" AS "EstimacionFechaRegistro",
    estimacion."IdUsuarioModifico" AS "EstimacionIdUsuarioModifico",
    estimacion."FechaModifico" AS "EstimacionFechaModifico",
    estimacion."Activo" AS "EstimacionActivo",
    estimacion."Clave" AS "EstimacionClave",
    estimacion."FechaInicial" AS "EstimacionFechaInicial",
    estimacion."FechaFinal" AS "EstimacionFechaFinal",
    estimacion."IdProveedorRegistro" AS "EstimacionIdProveedorRegistro",
    subcontratodetalle."Id" AS "SubcontratoDetalleId",
    subcontratodetalle."IdExplosionInsumo" AS "SubcontratoDetalleIdExplosionInsumo",
    subcontratodetalle."IdExplosionSubcontrato" AS "SubcontratoDetalleIdExplosionSubcontrato",
    subcontratodetalle."Cantidad" AS "SubcontratoDetalleCantidad",
    subcontratodetalle."Observaciones" AS "SubcontratoDetalleObservaciones",
    subcontratodetalle."Precio" AS "SubcontratoDetallePrecio",
    subcontratodetalle."IdUsuarioRegistro" AS "SubcontratoDetalleIdUsuarioRegistro",
    subcontratodetalle."FechaRegistro" AS "SubcontratoDetalleFechaRegistro",
    subcontratodetalle."IdUsuarioModifico" AS "SubcontratoDetalleIdUsuarioModifico",
    subcontratodetalle."FechaModifico" AS "SubcontratoDetalleFechaModifico",
    subcontratodetalle."Activo" AS "SubcontratoDetalleActivo",
    empresa."Id" AS "EmpresaId",
    empresa."Nombre" AS "EmpresaNombre",
    empresa."NombreComercial" AS "EmpresaNombreComercial",
    empresa."RazonSocial" AS "EmpresaRazonSocial",
    empresa."RFC" AS "EmpresaRfc",
    presupuesto."Id" AS "PresupuestoId",
    presupuesto."Codigo" AS "PresupuestoCodigo",
    presupuesto."Nombre" AS "PresupuestoNombre",
    presupuesto."IdEmpresa" AS "PresupuestoIdEmpresa",
    explosioninsumo."Id" AS "ExplosionInsumoId",
    explosioninsumo."IdExplosion" AS "ExplosionInsumoIdExplosion",
    explosioninsumo."IdPresupuesto" AS "ExplosionInsumoIdPresupuesto",
    explosioninsumo."IdPresupuestoConcepto" AS "ExplosionInsumoIdPresupuestoConcepto",
    explosioninsumo."IdInsumo" AS "ExplosionInsumoIdInsumo",
    explosioninsumo."Cantidad" AS "ExplosionInsumoCantidad",
    explosioninsumo."IdPrecio" AS "ExplosionInsumoIdPrecio",
    explosioninsumo."IdUsuarioRegistro" AS "ExplosionInsumoIdUsuarioRegistro",
    explosioninsumo."FechaRegistro" AS "ExplosionInsumoFechaRegistro",
    explosioninsumo."IdUsuarioModifico" AS "ExplosionInsumoIdUsuarioModifico",
    explosioninsumo."FechaModifico" AS "ExplosionInsumoFechaModifico",
    explosioninsumo."Autorizado" AS "ExplosionInsumoAutorizado",
    explosioninsumo."Contratable" AS "ExplosionInsumoContratable",
    explosioninsumo."NoConsiderado" AS "ExplosionInsumoNoConsiderado",
    insumo."Id" AS "InsumoId",
    insumo."Nombre" AS "InsumoNombre",
    insumo."Codigo" AS "InsumoCodigo",
    insumo."Descripcion" AS "InsumoDescripcion",
    insumo."IdTipo" AS "InsumoIdTipo",
    insumo."IdCorporativo" AS "InsumoIdCorporativo",
    insumo."IdFamiliaInsumo" AS "InsumoIdFamiliaInsumo",
    insumo."IdUnidadMedida" AS "InsumoIdUnidadMedida",
    insumo."UrlImagen" AS "InsumoUrlImagen",
    unidad."Id" AS "UnidadMedidaId",
    unidad."Nombre" AS "UnidadMedidaNombre",
    unidad."Clave" AS "UnidadMedidaClave",
    unidad."Tipo" AS "UnidadMedidaTipo",
    tipoinsumo."Id" AS "TipoInsumoId",
    tipoinsumo."Nombre" AS "TipoInsumoNombre",
    tipoinsumo."Codigo" AS "TipoInsumoCodigo",
    tipoinsumo."Descripcion" AS "TipoInsumoDescripcion",
    tipoinsumo."ManoDeObra" AS "TipoInsumoManoDeObra",
    tipoinsumo."Financiero" AS "TipoInsumoFinanciero",
    tipoinsumo."Inventariable" AS "TipoInsumoInventariable",
    tipoinsumo."Administrativo" AS "TipoInsumoAdministrativo",
    tipoinsumo."IdCorporativo" AS "TipoInsumoIdCorporativo",
    presupuestoconcepto."Id" AS "PresupuestoConceptoId",
    presupuestoconcepto."IdPresupuesto" AS "PresupuestoConceptoIdPresupuesto",
    presupuestoconcepto."IdPartida" AS "PresupuestoConceptoIdPartida",
    presupuestoconcepto."IdMoneda" AS "PresupuestoConceptoIdMoneda",
    presupuestoconcepto."Codigo" AS "PresupuestoConceptoCodigo",
    presupuestoconcepto."Descripcion" AS "PresupuestoConceptoDescripcion",
    presupuestoconcepto."Cantidad" AS "PresupuestoConceptoCantidad",
    presupuestoconcepto."Precio" AS "PresupuestoConceptoPrecio",
    presupuestoconcepto."IdTipoConcepto" AS "PresupuestoConceptoIdTipoConcepto",
    presupuestoconcepto."Nombre" AS "PresupuestoConceptoNombre",
    presupuestopartida."Id" AS "PresupuestoPartidaId",
    presupuestopartida."Nombre" AS "PresupuestoPartidaNombre",
    presupuestopartida."Descripcion" AS "PresupuestoPartidaDescripcion",
    presupuestopartida."Observaciones" AS "PresupuestoPartidaObservaciones",
    presupuestopartida."IdPadre" AS "PresupuestoPartidaIdPadre",
    presupuestopartida."IdPresupuesto" AS "PresupuestoPartidaIdPresupuesto",
    usuarioregistro."Id" AS "UsuarioRegistroId",
    usuarioregistro."Nombre" AS "UsuarioRegistroNombre",
    usuarioregistro."ApellidoPaterno" AS "UsuarioRegistroApellidoPaterno",
    usuarioregistro."ApellidoMaterno" AS "UsuarioRegistroApellidoMaterno",
    presupuestoinsumoprecio."Id" AS "PresupuestoInsumoPrecioId",
    presupuestoinsumoprecio."IdInsumo" AS "PresupuestoInsumoPrecioIdInsumo",
    presupuestoinsumoprecio."IdMoneda" AS "PresupuestoInsumoPrecioIdMoneda",
    presupuestoinsumoprecio."IdPresupuesto" AS "PresupuestoInsumoPrecioIdPresupuesto",
    presupuestoinsumoprecio."Precio" AS "PresupuestoInsumoPrecioPrecio",
    moneda."Id" AS "MonedaId",
    moneda."Clave" AS "MonedaClave",
    moneda."Nombre" AS "MonedaNombre",
    moneda."IdUsuarioRegistro" AS "MonedaIdUsuarioRegistro",
    moneda."FechaRegistro" AS "MonedaFechaRegistro",
    moneda."IdUsuarioModifico" AS "MonedaIdUsuarioModifico",
    moneda."FechaModifico" AS "MonedaFechaModifico",
    moneda."Activo" AS "MonedaActivo",
    proveedorregistro."RazonSocial" AS "ProveedorRegistroRazonSocial",
    proveedorregistro."NombreComercial" AS "ProveedorRegistroNombreComercial",
    proveedorregistro."Rfc" AS "ProveedorRegistroRfc"
   FROM "EstimacionesInsumos" detalle
     JOIN "Estimaciones" estimacion ON estimacion."Id" = detalle."IdEstimacion"
     JOIN "ExplosionesSubcontratosDetalles" subcontratodetalle ON subcontratodetalle."Id" = detalle."IdSubcontratoDetalle"
     JOIN "ExplosionesInsumos" explosioninsumo ON explosioninsumo."Id" = subcontratodetalle."IdExplosionInsumo"
     JOIN "Presupuestos" presupuesto ON presupuesto."Id" = explosioninsumo."IdPresupuesto"
     LEFT JOIN "PresupuestosInsumosPrecios" presupuestoinsumoprecio ON presupuestoinsumoprecio."Id" = explosioninsumo."IdPrecio"
     LEFT JOIN "Monedas" moneda ON moneda."Id" = presupuestoinsumoprecio."IdMoneda"
     JOIN "CentrosCostos" centrocosto ON centrocosto."Id" = presupuesto."IdCentroCosto"
     JOIN "Empresas" empresa ON centrocosto."IdEmpresa" = empresa."Id"
     JOIN "Insumos" insumo ON insumo."Id" = explosioninsumo."IdInsumo"
     JOIN "UnidadesMedidas" unidad ON unidad."Id" = insumo."IdUnidadMedida"
     JOIN "TiposInsumos" tipoinsumo ON tipoinsumo."Id" = insumo."IdTipo"
     JOIN "PresupuestosConceptos" presupuestoconcepto ON presupuestoconcepto."Id" = explosioninsumo."IdPresupuestoConcepto"
     JOIN "PresupuestosPartidas" presupuestopartida ON presupuestopartida."Id" = presupuestoconcepto."IdPartida"
     LEFT JOIN "Usuarios" usuarioregistro ON usuarioregistro."Id" = detalle."IdUsuarioRegistro"
     LEFT JOIN "Proveedores" proveedorregistro ON proveedorregistro."Id" = detalle."IdProveedorRegistro"
  WHERE estimacion."Activo" = true;


-- public.explosionesinsumosavancesfotograficosview source
DROP VIEW explosionesinsumosavancesfotograficosview;
CREATE OR REPLACE VIEW public.explosionesinsumosavancesfotograficosview
AS SELECT detalle."Id",
    detalle."IdAvance",
    detalle."UrlImagen",
    detalle."IdUsuarioRegistro",
    detalle."FechaRegistro",
    avance."Id" AS "AvanceId",
    avance."Cantidad" AS "AvanceCantidad",
    avance."IdExplosionInsumo" AS "AvanceIdExplosionInsumo",
    avance."Observaciones" AS "AvanceObservaciones",
    avance."IdUsuarioRegistro" AS "AvanceIdUsuarioRegistro",
    avance."FechaRegistro" AS "AvanceFechaRegistro",
    empresa."Id" AS "EmpresaId",
    empresa."Nombre" AS "EmpresaNombre",
    empresa."NombreComercial" AS "EmpresaNombreComercial",
    empresa."RazonSocial" AS "EmpresaRazonSocial",
    empresa."RFC" AS "EmpresaRfc",
    presupuesto."Id" AS "PresupuestoId",
    presupuesto."Codigo" AS "PresupuestoCodigo",
    presupuesto."Nombre" AS "PresupuestoNombre",
    presupuesto."IdEmpresa" AS "PresupuestoIdEmpresa",
    centrocosto."Id" AS "CentroCostoId",
    centrocosto."Codigo" AS "CentroCostoCodigo",
    centrocosto."Nombre" AS "CentroCostoNombre",
    centrocosto."Descripcion" AS "CentroCostoDescripcion",
    centrocosto."Observaciones" AS "CentroCostoObservaciones",
    centrocosto."IdTipoCentroCosto" AS "CentroCostoIdTipoCentroCosto",
    centrocosto."IdCliente" AS "CentroCostoIdCliente",
    centrocosto."IdEmpresa" AS "CentroCostoIdEmpresa",
    centrocosto."FechaInicial" AS "CentroCostoFechaInicial",
    centrocosto."FechaFinal" AS "CentroCostoFechaFinal",
    explosioninsumo."Id" AS "ExplosionInsumoId",
    explosioninsumo."IdExplosion" AS "ExplosionInsumoIdExplosion",
    explosioninsumo."IdPresupuesto" AS "ExplosionInsumoIdPresupuesto",
    explosioninsumo."IdPresupuestoConcepto" AS "ExplosionInsumoIdPresupuestoConcepto",
    explosioninsumo."IdInsumo" AS "ExplosionInsumoIdInsumo",
    explosioninsumo."Cantidad" AS "ExplosionInsumoCantidad",
    explosioninsumo."IdPrecio" AS "ExplosionInsumoIdPrecio",
    explosioninsumo."IdUsuarioRegistro" AS "ExplosionInsumoIdUsuarioRegistro",
    explosioninsumo."FechaRegistro" AS "ExplosionInsumoFechaRegistro",
    explosioninsumo."IdUsuarioModifico" AS "ExplosionInsumoIdUsuarioModifico",
    explosioninsumo."FechaModifico" AS "ExplosionInsumoFechaModifico",
    insumo."Id" AS "InsumoId",
    insumo."Nombre" AS "InsumoNombre",
    insumo."Codigo" AS "InsumoCodigo",
    insumo."Descripcion" AS "InsumoDescripcion",
    insumo."IdTipo" AS "InsumoIdTipo",
    insumo."IdCorporativo" AS "InsumoIdCorporativo",
    insumo."IdFamiliaInsumo" AS "InsumoIdFamiliaInsumo",
    insumo."IdUnidadMedida" AS "InsumoIdUnidadMedida",
    insumo."UrlImagen" AS "InsumoUrlImagen",
    unidad."Id" AS "UnidadMedidaId",
    unidad."Nombre" AS "UnidadMedidaNombre",
    unidad."Clave" AS "UnidadMedidaClave",
    unidad."Tipo" AS "UnidadMedidaTipo",
    tipoinsumo."Id" AS "TipoInsumoId",
    tipoinsumo."Nombre" AS "TipoInsumoNombre",
    tipoinsumo."Codigo" AS "TipoInsumoCodigo",
    tipoinsumo."Descripcion" AS "TipoInsumoDescripcion",
    tipoinsumo."ManoDeObra" AS "TipoInsumoManoDeObra",
    tipoinsumo."Financiero" AS "TipoInsumoFinanciero",
    tipoinsumo."Inventariable" AS "TipoInsumoInventariable",
    tipoinsumo."Administrativo" AS "TipoInsumoAdministrativo",
    tipoinsumo."IdCorporativo" AS "TipoInsumoIdCorporativo",
    presupuestoconcepto."Id" AS "PresupuestoConceptoId",
    presupuestoconcepto."IdPresupuesto" AS "PresupuestoConceptoIdPresupuesto",
    presupuestoconcepto."IdPartida" AS "PresupuestoConceptoIdPartida",
    presupuestoconcepto."IdMoneda" AS "PresupuestoConceptoIdMoneda",
    presupuestoconcepto."Codigo" AS "PresupuestoConceptoCodigo",
    presupuestoconcepto."Descripcion" AS "PresupuestoConceptoDescripcion",
    presupuestoconcepto."Cantidad" AS "PresupuestoConceptoCantidad",
    presupuestoconcepto."Precio" AS "PresupuestoConceptoPrecio",
    presupuestoconcepto."IdTipoConcepto" AS "PresupuestoConceptoIdTipoConcepto",
    presupuestoconcepto."Nombre" AS "PresupuestoConceptoNombre",
    presupuestopartida."Id" AS "PresupuestoPartidaId",
    presupuestopartida."Nombre" AS "PresupuestoPartidaNombre",
    presupuestopartida."Descripcion" AS "PresupuestoPartidaDescripcion",
    presupuestopartida."Observaciones" AS "PresupuestoPartidaObservaciones",
    presupuestopartida."IdPadre" AS "PresupuestoPartidaIdPadre",
    presupuestopartida."IdPresupuesto" AS "PresupuestoPartidaIdPresupuesto",
    usuarioregistro."Id" AS "UsuarioRegistroId",
    usuarioregistro."Nombre" AS "UsuarioRegistroNombre",
    usuarioregistro."ApellidoPaterno" AS "UsuarioRegistroApellidoPaterno",
    usuarioregistro."ApellidoMaterno" AS "UsuarioRegistroApellidoMaterno"
   FROM "ExplosionesInsumosAvancesFotograficos" detalle
     JOIN "ExplosionesInsumosAvances" avance ON avance."Id" = detalle."IdAvance"
     JOIN "ExplosionesInsumos" explosioninsumo ON explosioninsumo."Id" = avance."IdExplosionInsumo"
     JOIN "Presupuestos" presupuesto ON presupuesto."Id" = explosioninsumo."IdPresupuesto"
     JOIN "CentrosCostos" centrocosto ON centrocosto."Id" = presupuesto."IdCentroCosto"
     JOIN "Empresas" empresa ON centrocosto."IdEmpresa" = empresa."Id"
     JOIN "Insumos" insumo ON insumo."Id" = explosioninsumo."IdInsumo"
     JOIN "UnidadesMedidas" unidad ON unidad."Id" = insumo."IdUnidadMedida"
     JOIN "TiposInsumos" tipoinsumo ON tipoinsumo."Id" = insumo."IdTipo"
     JOIN "PresupuestosConceptos" presupuestoconcepto ON presupuestoconcepto."Id" = explosioninsumo."IdPresupuestoConcepto"
     JOIN "PresupuestosPartidas" presupuestopartida ON presupuestopartida."Id" = presupuestoconcepto."IdPartida"
     JOIN "Usuarios" usuarioregistro ON usuarioregistro."Id" = detalle."IdUsuarioRegistro";


-- public.explosionesinsumosavancesview source
DROP VIEW explosionesinsumosavancesview;
CREATE OR REPLACE VIEW public.explosionesinsumosavancesview
AS SELECT detalle."Id",
    detalle."Cantidad",
    detalle."IdExplosionInsumo",
    detalle."Observaciones",
    detalle."IdUsuarioRegistro",
    detalle."FechaRegistro",
    empresa."Id" AS "EmpresaId",
    empresa."Nombre" AS "EmpresaNombre",
    empresa."NombreComercial" AS "EmpresaNombreComercial",
    empresa."RazonSocial" AS "EmpresaRazonSocial",
    empresa."RFC" AS "EmpresaRfc",
    presupuesto."Id" AS "PresupuestoId",
    presupuesto."Codigo" AS "PresupuestoCodigo",
    presupuesto."Nombre" AS "PresupuestoNombre",
    presupuesto."IdEmpresa" AS "PresupuestoIdEmpresa",
    centrocosto."Id" AS "CentroCostoId",
    centrocosto."Codigo" AS "CentroCostoCodigo",
    centrocosto."Nombre" AS "CentroCostoNombre",
    centrocosto."Descripcion" AS "CentroCostoDescripcion",
    centrocosto."Observaciones" AS "CentroCostoObservaciones",
    centrocosto."IdTipoCentroCosto" AS "CentroCostoIdTipoCentroCosto",
    centrocosto."IdCliente" AS "CentroCostoIdCliente",
    centrocosto."IdEmpresa" AS "CentroCostoIdEmpresa",
    centrocosto."FechaInicial" AS "CentroCostoFechaInicial",
    centrocosto."FechaFinal" AS "CentroCostoFechaFinal",
    explosioninsumo."Id" AS "ExplosionInsumoId",
    explosioninsumo."IdExplosion" AS "ExplosionInsumoIdExplosion",
    explosioninsumo."IdPresupuesto" AS "ExplosionInsumoIdPresupuesto",
    explosioninsumo."IdPresupuestoConcepto" AS "ExplosionInsumoIdPresupuestoConcepto",
    explosioninsumo."IdInsumo" AS "ExplosionInsumoIdInsumo",
    explosioninsumo."Cantidad" AS "ExplosionInsumoCantidad",
    explosioninsumo."IdPrecio" AS "ExplosionInsumoIdPrecio",
    explosioninsumo."IdUsuarioRegistro" AS "ExplosionInsumoIdUsuarioRegistro",
    explosioninsumo."FechaRegistro" AS "ExplosionInsumoFechaRegistro",
    explosioninsumo."IdUsuarioModifico" AS "ExplosionInsumoIdUsuarioModifico",
    explosioninsumo."FechaModifico" AS "ExplosionInsumoFechaModifico",
    insumo."Id" AS "InsumoId",
    insumo."Nombre" AS "InsumoNombre",
    insumo."Codigo" AS "InsumoCodigo",
    insumo."Descripcion" AS "InsumoDescripcion",
    insumo."IdTipo" AS "InsumoIdTipo",
    insumo."IdCorporativo" AS "InsumoIdCorporativo",
    insumo."IdFamiliaInsumo" AS "InsumoIdFamiliaInsumo",
    insumo."IdUnidadMedida" AS "InsumoIdUnidadMedida",
    insumo."UrlImagen" AS "InsumoUrlImagen",
    unidad."Id" AS "UnidadMedidaId",
    unidad."Nombre" AS "UnidadMedidaNombre",
    unidad."Clave" AS "UnidadMedidaClave",
    unidad."Tipo" AS "UnidadMedidaTipo",
    tipoinsumo."Id" AS "TipoInsumoId",
    tipoinsumo."Nombre" AS "TipoInsumoNombre",
    tipoinsumo."Codigo" AS "TipoInsumoCodigo",
    tipoinsumo."Descripcion" AS "TipoInsumoDescripcion",
    tipoinsumo."ManoDeObra" AS "TipoInsumoManoDeObra",
    tipoinsumo."Financiero" AS "TipoInsumoFinanciero",
    tipoinsumo."Inventariable" AS "TipoInsumoInventariable",
    tipoinsumo."Administrativo" AS "TipoInsumoAdministrativo",
    tipoinsumo."IdCorporativo" AS "TipoInsumoIdCorporativo",
    presupuestoconcepto."Id" AS "PresupuestoConceptoId",
    presupuestoconcepto."IdPresupuesto" AS "PresupuestoConceptoIdPresupuesto",
    presupuestoconcepto."IdPartida" AS "PresupuestoConceptoIdPartida",
    presupuestoconcepto."IdMoneda" AS "PresupuestoConceptoIdMoneda",
    presupuestoconcepto."Codigo" AS "PresupuestoConceptoCodigo",
    presupuestoconcepto."Descripcion" AS "PresupuestoConceptoDescripcion",
    presupuestoconcepto."Cantidad" AS "PresupuestoConceptoCantidad",
    presupuestoconcepto."Precio" AS "PresupuestoConceptoPrecio",
    presupuestoconcepto."IdTipoConcepto" AS "PresupuestoConceptoIdTipoConcepto",
    presupuestoconcepto."Nombre" AS "PresupuestoConceptoNombre",
    presupuestopartida."Id" AS "PresupuestoPartidaId",
    presupuestopartida."Nombre" AS "PresupuestoPartidaNombre",
    presupuestopartida."Descripcion" AS "PresupuestoPartidaDescripcion",
    presupuestopartida."Observaciones" AS "PresupuestoPartidaObservaciones",
    presupuestopartida."IdPadre" AS "PresupuestoPartidaIdPadre",
    presupuestopartida."IdPresupuesto" AS "PresupuestoPartidaIdPresupuesto",
    usuarioregistro."Id" AS "UsuarioRegistroId",
    usuarioregistro."Nombre" AS "UsuarioRegistroNombre",
    usuarioregistro."ApellidoPaterno" AS "UsuarioRegistroApellidoPaterno",
    usuarioregistro."ApellidoMaterno" AS "UsuarioRegistroApellidoMaterno"
   FROM "ExplosionesInsumosAvances" detalle
     JOIN "ExplosionesInsumos" explosioninsumo ON explosioninsumo."Id" = detalle."IdExplosionInsumo"
     JOIN "Presupuestos" presupuesto ON presupuesto."Id" = explosioninsumo."IdPresupuesto"
     JOIN "CentrosCostos" centrocosto ON centrocosto."Id" = presupuesto."IdCentroCosto"
     JOIN "Empresas" empresa ON centrocosto."IdEmpresa" = empresa."Id"
     JOIN "Insumos" insumo ON insumo."Id" = explosioninsumo."IdInsumo"
     JOIN "UnidadesMedidas" unidad ON unidad."Id" = insumo."IdUnidadMedida"
     JOIN "TiposInsumos" tipoinsumo ON tipoinsumo."Id" = insumo."IdTipo"
     JOIN "PresupuestosConceptos" presupuestoconcepto ON presupuestoconcepto."Id" = explosioninsumo."IdPresupuestoConcepto"
     JOIN "PresupuestosPartidas" presupuestopartida ON presupuestopartida."Id" = presupuestoconcepto."IdPartida"
     JOIN "Usuarios" usuarioregistro ON usuarioregistro."Id" = detalle."IdUsuarioRegistro";

-- public.explosionesinsumosview source

DROP VIEW explosionesinsumosview;
CREATE OR REPLACE VIEW public.explosionesinsumosview
AS SELECT "ExplosionesInsumos"."Id",
    "ExplosionesInsumos"."IdExplosion",
    "ExplosionesInsumos"."IdPresupuesto",
    "ExplosionesInsumos"."IdPresupuestoConcepto",
    "ExplosionesInsumos"."IdInsumo",
    "ExplosionesInsumos"."Cantidad",
    "ExplosionesInsumos"."IdPrecio",
    "ExplosionesInsumos"."IdUsuarioRegistro",
    "ExplosionesInsumos"."FechaRegistro",
    "ExplosionesInsumos"."IdUsuarioModifico",
    "ExplosionesInsumos"."FechaModifico",
    "ExplosionesInsumos"."NoConsiderado",
    "ExplosionesInsumos"."Autorizado",
    "ExplosionesInsumos"."Contratable",
    "Explosiones"."Id" AS "ExplosionId",
    "Explosiones"."IdPresupuesto" AS "ExplosionIdPresupuesto",
    "Explosiones"."Codigo" AS "ExplosionCodigo",
    "Explosiones"."Descripcion" AS "ExplosionDescripcion",
    "Explosiones"."IdUsuarioRegistro" AS "ExplosionIdUsuarioRegistro",
    "Explosiones"."FechaRegistro" AS "ExplosionFechaRegistro",
    "Explosiones"."IdUsuarioModifico" AS "ExplosionIdUsuarioModifico",
    "Explosiones"."FechaModifico" AS "ExplosionFechaModifico",
    "Explosiones"."Activo" AS "ExplosionActivo",
    "Explosiones"."Actualizada" AS "ExplosionActualizada",
    "PresupuestosPartidas"."Id" AS "PresupuestoPartidaId",
    "PresupuestosPartidas"."IdPadre" AS "PresupuestoPartidaIdPadre",
    "PresupuestosPartidas"."IdPresupuesto" AS "PresupuestoPartidaIdPresupuesto",
    "PresupuestosPartidas"."Nombre" AS "PresupuestoPartidaNombre",
    "PresupuestosPartidas"."Observaciones" AS "PresupuestoPartidaObservaciones",
    "PresupuestosPartidas"."Descripcion" AS "PresupuestoPartidaDescripcion",
    "PresupuestosConceptos"."Id" AS "PresupuestoConceptoId",
    "PresupuestosConceptos"."IdMoneda" AS "PresupuestoConceptoIdMoneda",
    "PresupuestosConceptos"."IdPartida" AS "PresupuestoConceptoIdPartida",
    "PresupuestosConceptos"."IdPresupuesto" AS "PresupuestoConceptoIdPresupuesto",
    "PresupuestosConceptos"."IdTipoConcepto" AS "PresupuestoConceptoIdTipoConcepto",
    "PresupuestosConceptos"."Cantidad" AS "PresupuestoConceptoCantidad",
    "PresupuestosConceptos"."Nombre" AS "PresupuestoConceptoNombre",
    "PresupuestosConceptos"."Codigo" AS "PresupuestoConceptoCodigo",
    "PresupuestosConceptos"."Descripcion" AS "PresupuestoConceptoDescripcion",
    "PresupuestosConceptos"."Precio" AS "PresupuestoConceptoPrecio",
    "PresupuestosConceptos"."IdInsumo" AS "PresupuestoConceptoIdInsumo",
    "TiposConceptos"."Id" AS "TipoConceptoId",
    "TiposConceptos"."Nombre" AS "TipoConceptoNombre",
    "TiposConceptos"."IdCorporativo" AS "TipoConceptoIdCorporativo",
    "TiposConceptos"."IdFamiliaConcepto" AS "TipoConceptoIdFamiliaConcepto",
    "TiposConceptos"."IdUnidadMedida" AS "TipoConceptoIdUnidadMedida",
    "TiposConceptos"."Descripcion" AS "TipoConceptoDescripcion",
    "Insumos"."Id" AS "InsumoId",
    "Insumos"."Codigo" AS "InsumoCodigo",
    "Insumos"."Descripcion" AS "InsumoDescripcion",
    "Insumos"."Nombre" AS "InsumoNombre",
    "Insumos"."IdFamiliaInsumo" AS "InsumoIdFamiliaInsumo",
    "Insumos"."IdTipo" AS "InsumoIdTipo",
    "FamiliasInsumos"."Id" AS "FamiliaInsumoId",
    "FamiliasInsumos"."Codigo" AS "FamiliaInsumoCodigo",
    "FamiliasInsumos"."Nombre" AS "FamiliaInsumoNombre",
    "FamiliasInsumos"."Descripcion" AS "FamiliaInsumoDescripcion",
    "TiposInsumos"."Id" AS "TipoInsumoId",
    "TiposInsumos"."Codigo" AS "TipoInsumoCodigo",
    "TiposInsumos"."Nombre" AS "TipoInsumoNombre",
    "TiposInsumos"."Descripcion" AS "TipoInsumoDescripcion",
    "TiposInsumos"."ManoDeObra" AS "TipoInsumoManoDeObra",
    "TiposInsumos"."Administrativo" AS "TipoInsumoAdministrativo",
    "TiposInsumos"."Inventariable" AS "TipoInsumoInventariable",
    "TiposInsumos"."Financiero" AS "TipoInsumoFinanciero",
    "TiposInsumos"."Requerir" AS "TipoInsumoRequerir",
    "UnidadesMedidas"."Id" AS "UnidadMedidaId",
    "UnidadesMedidas"."Clave" AS "UnidadMedidaClave",
    "UnidadesMedidas"."Nombre" AS "UnidadMedidaNombre",
    "UnidadesMedidas"."Tipo" AS "UnidadMedidaTipo",
    "Presupuestos"."Id" AS "PresupuestoId",
    "Presupuestos"."IdEmpresa" AS "PresupuestoIdEmpresa",
    "Presupuestos"."IdCentroCosto" AS "PresupuestoIdCentroCosto",
    "Presupuestos"."Nombre" AS "PresupuestoNombre",
    "Presupuestos"."Codigo" AS "PresupuestoCodigo",
    "Presupuestos"."Descripcion" AS "PresupuestoDescripcion",
    "Presupuestos"."IdTipo" AS "PresupuestoIdTipo",
    "Presupuestos"."Email" AS "PresupuestoEmail",
    "Presupuestos"."IdClasificadorPresupuesto" AS "PresupuestoIdClasificadorPresupuesto",
    "Presupuestos"."IdResponsable" AS "PresupuestoIdResponsable",
    "Presupuestos"."Observaciones" AS "PresupuestoObservaciones",
    "CentrosCostos"."Id" AS "CentroCostoId",
    "CentrosCostos"."IdCliente" AS "CentroCostoIdCliente",
    "CentrosCostos"."IdEmpresa" AS "CentroCostoIdEmpresa",
    "CentrosCostos"."IdTipoCentroCosto" AS "CentroCostoIdTipoCentroCosto",
    "CentrosCostos"."Nombre" AS "CentroCostoNombre",
    "CentrosCostos"."Observaciones" AS "CentroCostoObservaciones",
    "CentrosCostos"."Codigo" AS "CentroCostoCodigo",
    "CentrosCostos"."Descripcion" AS "CentroCostoDescripcion",
    "CentrosCostos"."FechaInicial" AS "CentroCostoFechaInicial",
    "CentrosCostos"."FechaFinal" AS "CentroCostoFechaFinal",
    "CentrosCostos"."IdUsuarioRegistro" AS "CentroCostoIdUsuarioRegistro",
    "CentrosCostos"."FechaRegistro" AS "CentroCostoFechaRegistro",
    "CentrosCostos"."IdUsuarioModifico" AS "CentroCostoIdUsuarioModifico",
    "CentrosCostos"."FechaModifico" AS "CentroCostoFechaModifico",
    "CentrosCostos"."Activo" AS "CentroCostoActivo",
    "PresupuestosInsumosPrecios"."Id" AS "PresupuestoInsumoPrecioId",
    "PresupuestosInsumosPrecios"."IdInsumo" AS "PresupuestoInsumoPrecioIdInsumo",
    "PresupuestosInsumosPrecios"."IdMoneda" AS "PresupuestoInsumoPrecioIdMoneda",
    "PresupuestosInsumosPrecios"."IdPresupuesto" AS "PresupuestoInsumoPrecioIdPresupuesto",
    "PresupuestosInsumosPrecios"."Precio" AS "PresupuestoInsumoPrecioPrecio",
    usuarioregistro."Nombre" AS "UsuarioRegistroNombre",
    usuarioregistro."ApellidoPaterno" AS "UsuarioRegistroApellidoPaterno",
    usuarioregistro."ApellidoMaterno" AS "UsuarioRegistroApellidoMaterno",
    usuariomodifico."Nombre" AS "UsuarioModificoNombre",
    usuariomodifico."ApellidoPaterno" AS "UsuarioModificoApellidoPaterno",
    usuariomodifico."ApellidoMaterno" AS "UsuarioModificoApellidoMaterno"
   FROM "ExplosionesInsumos"
     JOIN "Explosiones" ON "Explosiones"."Id" = "ExplosionesInsumos"."IdExplosion"
     JOIN "Presupuestos" ON "Presupuestos"."Id" = "ExplosionesInsumos"."IdPresupuesto"
     JOIN "CentrosCostos" ON "CentrosCostos"."Id" = "Presupuestos"."IdCentroCosto"
     JOIN "PresupuestosConceptos" ON "PresupuestosConceptos"."Id" = "ExplosionesInsumos"."IdPresupuestoConcepto"
     JOIN "PresupuestosPartidas" ON "PresupuestosPartidas"."Id" = "PresupuestosConceptos"."IdPartida"
     JOIN "Insumos" ON "Insumos"."Id" = "ExplosionesInsumos"."IdInsumo"
     JOIN "TiposInsumos" ON "TiposInsumos"."Id" = "Insumos"."IdTipo"
     JOIN "TiposConceptos" ON "TiposConceptos"."Id" = "PresupuestosConceptos"."IdTipoConcepto"
     JOIN "FamiliasInsumos" ON "FamiliasInsumos"."Id" = "Insumos"."IdFamiliaInsumo"
     JOIN "UnidadesMedidas" ON "UnidadesMedidas"."Id" = "Insumos"."IdUnidadMedida"
     JOIN "PresupuestosInsumosPrecios" ON "PresupuestosInsumosPrecios"."Id" = "ExplosionesInsumos"."IdPrecio"
     JOIN "Usuarios" usuarioregistro ON usuarioregistro."Id" = "ExplosionesInsumos"."IdUsuarioRegistro"
     JOIN "Usuarios" usuariomodifico ON usuariomodifico."Id" = "ExplosionesInsumos"."IdUsuarioModifico"
  WHERE "Explosiones"."Activo" = true;


-- public.explosionessubcontratosdetallesview source
DROP VIEW explosionessubcontratosdetallesview;
CREATE OR REPLACE VIEW public.explosionessubcontratosdetallesview
AS SELECT detalle."Id",
    detalle."IdExplosionSubcontrato",
    detalle."IdExplosionInsumo",
    detalle."Cantidad",
    detalle."Precio",
    detalle."Observaciones",
    detalle."IdUsuarioRegistro",
    detalle."FechaRegistro",
    detalle."IdUsuarioModifico",
    detalle."FechaModifico",
    detalle."Activo",
    subcontrato."Id" AS "ExplosionSubcontratoId",
    subcontrato."Codigo" AS "ExplosionSubcontratoCodigo",
    subcontrato."IdCentroCosto" AS "ExplosionSubcontratoIdCentroCosto",
    subcontrato."IdProveedor" AS "ExplosionSubcontratoIdProveedor",
    subcontrato."Nombre" AS "ExplosionSubcontratoNombre",
    subcontrato."Observaciones" AS "ExplosionSubcontratoObservaciones",
    subcontrato."FechaInicial" AS "ExplosionSubcontratoFechaInicial",
    subcontrato."FechaFinal" AS "ExplosionSubcontratoFechaFinal",
    subcontrato."IdUsuarioRegistro" AS "ExplosionSubcontratoIdUsuarioRegistro",
    subcontrato."FechaRegistro" AS "ExplosionSubcontratoFechaRegistro",
    subcontrato."IdUsuarioModifico" AS "ExplosionSubcontratoIdUsuarioModifico",
    subcontrato."FechaModifico" AS "ExplosionSubcontratoFechaModifico",
    subcontrato."Activo" AS "ExplosionSubcontratoActivo",
    empresa."Id" AS "EmpresaId",
    empresa."Nombre" AS "EmpresaNombre",
    empresa."NombreComercial" AS "EmpresaNombreComercial",
    empresa."RazonSocial" AS "EmpresaRazonSocial",
    empresa."RFC" AS "EmpresaRfc",
    presupuesto."Id" AS "PresupuestoId",
    presupuesto."Codigo" AS "PresupuestoCodigo",
    presupuesto."Nombre" AS "PresupuestoNombre",
    presupuesto."IdEmpresa" AS "PresupuestoIdEmpresa",
    centrocosto."Id" AS "CentroCostoId",
    centrocosto."Codigo" AS "CentroCostoCodigo",
    centrocosto."Nombre" AS "CentroCostoNombre",
    centrocosto."Descripcion" AS "CentroCostoDescripcion",
    centrocosto."Observaciones" AS "CentroCostoObservaciones",
    centrocosto."IdTipoCentroCosto" AS "CentroCostoIdTipoCentroCosto",
    centrocosto."IdCliente" AS "CentroCostoIdCliente",
    centrocosto."IdEmpresa" AS "CentroCostoIdEmpresa",
    centrocosto."FechaInicial" AS "CentroCostoFechaInicial",
    centrocosto."FechaFinal" AS "CentroCostoFechaFinal",
    explosioninsumo."Id" AS "ExplosionInsumoId",
    explosioninsumo."IdExplosion" AS "ExplosionInsumoIdExplosion",
    explosioninsumo."IdPresupuesto" AS "ExplosionInsumoIdPresupuesto",
    explosioninsumo."IdPresupuestoConcepto" AS "ExplosionInsumoIdPresupuestoConcepto",
    explosioninsumo."IdInsumo" AS "ExplosionInsumoIdInsumo",
    explosioninsumo."Cantidad" AS "ExplosionInsumoCantidad",
    explosioninsumo."IdPrecio" AS "ExplosionInsumoIdPrecio",
    explosioninsumo."IdUsuarioRegistro" AS "ExplosionInsumoIdUsuarioRegistro",
    explosioninsumo."FechaRegistro" AS "ExplosionInsumoFechaRegistro",
    explosioninsumo."IdUsuarioModifico" AS "ExplosionInsumoIdUsuarioModifico",
    explosioninsumo."FechaModifico" AS "ExplosionInsumoFechaModifico",
    insumo."Id" AS "InsumoId",
    insumo."Nombre" AS "InsumoNombre",
    insumo."Codigo" AS "InsumoCodigo",
    insumo."Descripcion" AS "InsumoDescripcion",
    insumo."IdTipo" AS "InsumoIdTipo",
    insumo."IdCorporativo" AS "InsumoIdCorporativo",
    insumo."IdFamiliaInsumo" AS "InsumoIdFamiliaInsumo",
    insumo."IdUnidadMedida" AS "InsumoIdUnidadMedida",
    insumo."UrlImagen" AS "InsumoUrlImagen",
    unidad."Id" AS "UnidadMedidaId",
    unidad."Nombre" AS "UnidadMedidaNombre",
    unidad."Clave" AS "UnidadMedidaClave",
    unidad."Tipo" AS "UnidadMedidaTipo",
    tipoinsumo."Id" AS "TipoInsumoId",
    tipoinsumo."Nombre" AS "TipoInsumoNombre",
    tipoinsumo."Codigo" AS "TipoInsumoCodigo",
    tipoinsumo."Descripcion" AS "TipoInsumoDescripcion",
    tipoinsumo."ManoDeObra" AS "TipoInsumoManoDeObra",
    tipoinsumo."Financiero" AS "TipoInsumoFinanciero",
    tipoinsumo."Inventariable" AS "TipoInsumoInventariable",
    tipoinsumo."Administrativo" AS "TipoInsumoAdministrativo",
    tipoinsumo."IdCorporativo" AS "TipoInsumoIdCorporativo",
    presupuestoconcepto."Id" AS "PresupuestoConceptoId",
    presupuestoconcepto."IdPresupuesto" AS "PresupuestoConceptoIdPresupuesto",
    presupuestoconcepto."IdPartida" AS "PresupuestoConceptoIdPartida",
    presupuestoconcepto."IdMoneda" AS "PresupuestoConceptoIdMoneda",
    presupuestoconcepto."Codigo" AS "PresupuestoConceptoCodigo",
    presupuestoconcepto."Descripcion" AS "PresupuestoConceptoDescripcion",
    presupuestoconcepto."Cantidad" AS "PresupuestoConceptoCantidad",
    presupuestoconcepto."Precio" AS "PresupuestoConceptoPrecio",
    presupuestoconcepto."IdTipoConcepto" AS "PresupuestoConceptoIdTipoConcepto",
    presupuestoconcepto."Nombre" AS "PresupuestoConceptoNombre",
    presupuestoconcepto."IdInsumo" AS "PresupuestoConceptoIdInsumo",
    presupuestoconcepto."ActualizarPrecioAuto" AS "PresupuestoConceptoActualizarPrecioAuto",
    presupuestoconcepto."ImporteMatriz" AS "PresupuestoConceptoImporteMatriz",
    presupuestoconcepto."IdTipoSubcontrato" AS "PresupuestoConceptoIdTipoSubcontrato",
    presupuestoconcepto."Contratable" AS "PresupuestoConceptoContratable",
    presupuestopartida."Id" AS "PresupuestoPartidaId",
    presupuestopartida."Nombre" AS "PresupuestoPartidaNombre",
    presupuestopartida."Descripcion" AS "PresupuestoPartidaDescripcion",
    presupuestopartida."Observaciones" AS "PresupuestoPartidaObservaciones",
    presupuestopartida."IdPadre" AS "PresupuestoPartidaIdPadre",
    presupuestopartida."IdPresupuesto" AS "PresupuestoPartidaIdPresupuesto",
    usuarioregistro."Id" AS "UsuarioRegistroId",
    usuarioregistro."Nombre" AS "UsuarioRegistroNombre",
    usuarioregistro."ApellidoPaterno" AS "UsuarioRegistroApellidoPaterno",
    usuarioregistro."ApellidoMaterno" AS "UsuarioRegistroApellidoMaterno",
    usuariomodifico."Id" AS "UsuarioModificoId",
    usuariomodifico."Nombre" AS "UsuarioModificoNombre",
    usuariomodifico."ApellidoPaterno" AS "UsuarioModificoApellidoPaterno",
    usuariomodifico."ApellidoMaterno" AS "UsuarioModificoApellidoMaterno",
    presupuestoinsumoprecio."Id" AS "PresupuestoInsumoPrecioId",
    presupuestoinsumoprecio."IdInsumo" AS "PresupuestoInsumoPrecioIdInsumo",
    presupuestoinsumoprecio."IdMoneda" AS "PresupuestoInsumoPrecioIdMoneda",
    presupuestoinsumoprecio."IdPresupuesto" AS "PresupuestoInsumoPrecioIdPresupuesto",
    presupuestoinsumoprecio."Precio" AS "PresupuestoInsumoPrecioPrecio",
    tiposubcontrato."Id" AS "TipoSubcontratoId",
    tiposubcontrato."Nombre" AS "TipoSubcontratoNombre",
    tiposubcontrato."Descripcion" AS "TipoSubcontratoDescripcion"
   FROM "ExplosionesSubcontratosDetalles" detalle
     JOIN "ExplosionesSubcontratos" subcontrato ON subcontrato."Id" = detalle."IdExplosionSubcontrato"
     JOIN "ExplosionesInsumos" explosioninsumo ON explosioninsumo."Id" = detalle."IdExplosionInsumo"
     JOIN "Presupuestos" presupuesto ON presupuesto."Id" = explosioninsumo."IdPresupuesto"
     LEFT JOIN "PresupuestosInsumosPrecios" presupuestoinsumoprecio ON presupuestoinsumoprecio."Id" = explosioninsumo."IdPrecio"
     JOIN "CentrosCostos" centrocosto ON centrocosto."Id" = subcontrato."IdCentroCosto"
     JOIN "Empresas" empresa ON centrocosto."IdEmpresa" = empresa."Id"
     JOIN "Insumos" insumo ON insumo."Id" = explosioninsumo."IdInsumo"
     JOIN "UnidadesMedidas" unidad ON unidad."Id" = insumo."IdUnidadMedida"
     JOIN "TiposInsumos" tipoinsumo ON tipoinsumo."Id" = insumo."IdTipo"
     JOIN "PresupuestosConceptos" presupuestoconcepto ON presupuestoconcepto."Id" = explosioninsumo."IdPresupuestoConcepto"
     LEFT JOIN "TiposSubcontratos" tiposubcontrato ON tiposubcontrato."Id" = presupuestoconcepto."IdTipoSubcontrato"
     JOIN "PresupuestosPartidas" presupuestopartida ON presupuestopartida."Id" = presupuestoconcepto."IdPartida"
     JOIN "Usuarios" usuarioregistro ON usuarioregistro."Id" = detalle."IdUsuarioRegistro"
     JOIN "Usuarios" usuariomodifico ON usuariomodifico."Id" = detalle."IdUsuarioModifico"
  WHERE detalle."Activo" = true;


-- public.presupuestosmatrizconceptosview source
DROP VIEW presupuestosmatrizconceptosview;
CREATE OR REPLACE VIEW public.presupuestosmatrizconceptosview
AS SELECT "PresupuestosMatrizConceptos"."Id",
    "PresupuestosMatrizConceptos"."IdConcepto",
    "PresupuestosMatrizConceptos"."IdUsuarioRegistro",
    "PresupuestosMatrizConceptos"."FechaRegistro",
    "PresupuestosMatrizConceptos"."IdUsuarioModifico",
    "PresupuestosMatrizConceptos"."FechaModifico",
    "PresupuestosMatrizConceptos"."Cantidad",
    "PresupuestosMatrizConceptos"."IdTipoConcepto",
    "PresupuestosMatrizConceptos"."IdMoneda",
    "PresupuestosMatrizConceptos"."Codigo",
    "PresupuestosMatrizConceptos"."Descripcion",
    "PresupuestosMatrizConceptos"."Precio",
    "PresupuestosMatrizConceptos"."Nombre",
    "PresupuestosMatrizConceptos"."IdPadre",
    "PresupuestosMatrizConceptos"."IdPresupuesto",
    "PresupuestosMatrizConceptos"."IdInsumo",
    insumo."Id" AS insumo_id,
    insumo."Codigo" AS insumo_codigo,
    insumo."Nombre" AS insumo_nombre,
    insumo."Descripcion" AS insumo_descripcion,
    insumo."IdCorporativo" AS insumo_id_corporativo,
    insumo."IdFamiliaInsumo" AS insumo_id_familia_insumo,
    insumo."IdTipo" AS insumo_id_tipo,
    insumo."IdUnidadMedida" AS insumo_id_unidad_medida,
    insumo."UrlImagen" AS insumo_url_imagen,
    insumo."IdUsuarioRegistro" AS insumo_id_usuario_registro,
    insumo."FechaRegistro" AS insumo_fecha_registro,
    insumo."IdUsuarioModifico" AS insumo_id_usuario_modifico,
    insumo."FechaModifico" AS insumo_fecha_modifico,
    insumo."Activo" AS insumo_activo,
    presupuestoconcepto."Id" AS presupuesto_concepto_id,
    presupuestoconcepto."IdMoneda" AS presupuesto_concepto_id_moneda,
    presupuestoconcepto."IdPartida" AS presupuesto_concepto_id_partida,
    presupuestoconcepto."IdPresupuesto" AS presupuesto_concepto_id_presupuesto,
    presupuestoconcepto."IdTipoConcepto" AS presupuesto_concepto_id_tipo_concepto,
    presupuestoconcepto."Nombre" AS presupuesto_concepto_nombre,
    presupuestoconcepto."Codigo" AS presupuesto_concepto_codigo,
    presupuestoconcepto."Descripcion" AS presupuesto_concepto_descripcion,
    presupuestoconcepto."Cantidad" AS presupuesto_concepto_cantidad,
    presupuestoconcepto."Precio" AS presupuesto_concepto_precio,
    presupuestomatrizconceptopadre."Id" AS presupuesto_matriz_concepto_padre_id,
    presupuestomatrizconceptopadre."IdConcepto" AS presupuesto_matriz_concepto_padre_id_concepto,
    presupuestomatrizconceptopadre."IdUsuarioRegistro" AS presupuesto_matriz_concepto_padre_id_usuario_registro,
    presupuestomatrizconceptopadre."FechaRegistro" AS presupuesto_matriz_concepto_padre_fecha_registro,
    presupuestomatrizconceptopadre."IdUsuarioModifico" AS presupuesto_matriz_concepto_padre_id_usuario_modifico,
    presupuestomatrizconceptopadre."FechaModifico" AS presupuesto_matriz_concepto_padre_fecha_modifico,
    presupuestomatrizconceptopadre."Cantidad" AS presupuesto_matriz_concepto_padre_cantidad,
    presupuestomatrizconceptopadre."IdTipoConcepto" AS presupuesto_matriz_concepto_padre_id_tipo_concepto,
    presupuestomatrizconceptopadre."IdMoneda" AS presupuesto_matriz_concepto_padre_id_moneda,
    presupuestomatrizconceptopadre."Codigo" AS presupuesto_matriz_concepto_padre_codigo,
    presupuestomatrizconceptopadre."Descripcion" AS presupuesto_matriz_concepto_padre_descripcion,
    presupuestomatrizconceptopadre."Precio" AS presupuesto_matriz_concepto_padre_precio,
    presupuestomatrizconceptopadre."Nombre" AS presupuesto_matriz_concepto_padre_nombre,
    presupuestomatrizconceptopadre."IdPadre" AS presupuesto_matriz_concepto_padre_id_padre,
    tipoconcepto."Id" AS tipo_concepto_id,
    tipoconcepto."Nombre" AS tipo_concepto_nombre,
    tipoconcepto."Descripcion" AS tipo_concepto_descripcion,
    tipoconcepto."IdCorporativo" AS tipo_concepto_id_corporativo,
    tipoconcepto."IdFamiliaConcepto" AS tipo_concepto_id_familia_concepto,
    tipoconcepto."IdUnidadMedida" AS tipo_concepto_id_unidad_medida,
    moneda."Id" AS moneda_id,
    moneda."Clave" AS moneda_clave,
    moneda."Nombre" AS moneda_nombre,
    usuarioregistro."Id" AS usuario_registro_id,
    usuarioregistro."Nombre" AS usuario_registro_nombre,
    usuarioregistro."ApellidoPaterno" AS usuario_registro_apellido_paterno,
    usuarioregistro."ApellidoMaterno" AS usuario_registro_apellido_materno,
    usuariomodifico."Id" AS usuario_modifico_id,
    usuariomodifico."Nombre" AS usuario_modifico_nombre,
    usuariomodifico."ApellidoPaterno" AS usuario_modifico_apellido_paterno,
    usuariomodifico."ApellidoMaterno" AS usuario_modifico_apellido_materno
   FROM "PresupuestosMatrizConceptos"
     LEFT JOIN "PresupuestosConceptos" presupuestoconcepto ON presupuestoconcepto."Id" = "PresupuestosMatrizConceptos"."IdConcepto"
     LEFT JOIN "Insumos" insumo ON insumo."Id" = "PresupuestosMatrizConceptos"."IdInsumo"
     LEFT JOIN "PresupuestosMatrizConceptos" presupuestomatrizconceptopadre ON presupuestomatrizconceptopadre."Id" = "PresupuestosMatrizConceptos"."IdPadre"
     JOIN "TiposConceptos" tipoconcepto ON tipoconcepto."Id" = "PresupuestosMatrizConceptos"."IdTipoConcepto"
     JOIN "Monedas" moneda ON moneda."Id" = "PresupuestosMatrizConceptos"."IdMoneda"
     JOIN "Usuarios" usuarioregistro ON usuarioregistro."Id" = "PresupuestosMatrizConceptos"."IdUsuarioRegistro"
     JOIN "Usuarios" usuariomodifico ON usuariomodifico."Id" = "PresupuestosMatrizConceptos"."IdUsuarioModifico";
     
     ```

### Modificación Unidad Medida

``` SQL
-- PRODUCCIÓN


ALTER TABLE "UnidadesMedidas"
    ALTER COLUMN "Clave" TYPE VARCHAR(250);

-- public.centroscostosexistenciasinsumosview source
DROP VIEW centroscostosexistenciasinsumosview;
CREATE OR REPLACE VIEW public.centroscostosexistenciasinsumosview
AS SELECT existencia."Id",
    existencia."IdCentroCosto",
    existencia."IdInsumo",
    existencia."Cantidad",
    existencia."Precio",
    existencia."CantidadPorDevolverObra",
    existencia."CantidadPorTraspasar",
    cc."Id" AS "CentroCostoId",
    cc."Nombre" AS "CentroCostoNombre",
    cc."Codigo" AS "CentroCostoCodigo",
    cc."Descripcion" AS "CentroCostoDescripcion",
    cc."Observaciones" AS "CentroCostoObservaciones",
    cc."IdEmpresa" AS "CentroCostoIdEmpresa",
    cc."IdTipoCentroCosto" AS "CentroCostoIdTipoCentroCosto",
    cc."FechaInicial" AS "CentroCostoFechaInicial",
    cc."FechaFinal" AS "CentroCostoFechaFinal",
    cc."IdCliente" AS "CentroCostoIdCliente",
    cc."IdUsuarioRegistro" AS "CentroCostoIdUsuarioRegistro",
    cc."FechaRegistro" AS "CentroCostoFechaRegistro",
    cc."IdUsuarioModifico" AS "CentroCostoIdUsuarioModifico",
    cc."FechaModifico" AS "CentroCostoFechaModifico",
    cc."Activo" AS "CentroCostoActivo",
    insumo."Id" AS "InsumoId",
    insumo."Codigo" AS "InsumoCodigo",
    insumo."Nombre" AS "InsumoNombre",
    insumo."Descripcion" AS "InsumoDescripcion",
    insumo."IdCorporativo" AS "InsumoIdCorporativo",
    insumo."IdFamiliaInsumo" AS "InsumoIdFamiliaInsumo",
    insumo."IdTipo" AS "InsumoIdTipo",
    insumo."IdUnidadMedida" AS "InsumoIdUnidadMedida",
    insumo."UrlImagen" AS "InsumoUrlImagen",
    insumo."IdUsuarioRegistro" AS "InsumoIdUsuarioRegistro",
    insumo."FechaRegistro" AS "InsumoFechaRegistro",
    insumo."IdUsuarioModifico" AS "InsumoIdUsuarioModifico",
    insumo."FechaModifico" AS "InsumoFechaModifico",
    insumo."Activo" AS "InsumoActivo",
    familiainsumo."Id" AS "FamiliaInsumoId",
    familiainsumo."Codigo" AS "FamiliaInsumoCodigo",
    familiainsumo."Nombre" AS "FamiliaInsumoNombre",
    familiainsumo."Descripcion" AS "FamiliaInsumoDescripcion",
    tipoinsumo."Id" AS "TipoInsumoId",
    tipoinsumo."Codigo" AS "TipoInsumoCodigo",
    tipoinsumo."Nombre" AS "TipoInsumoNombre",
    tipoinsumo."Descripcion" AS "TipoInsumoDescripcion",
    unidad."Id" AS "UnidadMedidaId",
    unidad."Clave" AS "UnidadMedidaClave",
    unidad."Nombre" AS "UnidadMedidaNombre",
    unidad."Tipo" AS "UnidadMedidaTipo",
    emp."Id" AS "EmpresaId",
    emp."IdCorporativo" AS "EmpresaIdCorporativo",
    emp."Nombre" AS "EmpresaNombre",
    emp."NombreComercial" AS "EmpresaNombreComercial",
    emp."RazonSocial" AS "EmpresaRazonSocial",
    emp."RFC" AS "EmpresaRFC",
    emp."LogoURL" AS "EmpresaLogoURL",
    emp."IdUsuarioRegistro" AS "EmpresaIdUsuarioRegistro",
    emp."FechaRegistro" AS "EmpresaFechaRegistro",
    emp."IdUsuarioModifico" AS "EmpresaIdUsuarioModifico",
    emp."FechaModifico" AS "EmpresaFechaModifico",
    emp."Activo" AS "EmpresaActivo"
   FROM "CentrosCostosExistenciasInsumos" existencia
     JOIN "CentrosCostos" cc ON cc."Id" = existencia."IdCentroCosto"
     JOIN "Empresas" emp ON emp."Id" = cc."IdEmpresa"
     JOIN "Insumos" insumo ON insumo."Id" = existencia."IdInsumo"
     JOIN "UnidadesMedidas" unidad ON unidad."Id" = insumo."IdUnidadMedida"
     JOIN "TiposInsumos" tipoinsumo ON tipoinsumo."Id" = insumo."IdTipo"
     JOIN "FamiliasInsumos" familiainsumo ON familiainsumo."Id" = insumo."IdFamiliaInsumo";

-- public.devolucionesinsumosdetallesview source
DROP VIEW devolucionesinsumosdetallesview;
CREATE OR REPLACE VIEW public.devolucionesinsumosdetallesview
AS SELECT detalle."Id",
    detalle."IdDevolucionInsumo",
    detalle."IdInsumo",
    detalle."Cantidad",
    detalle."IdUsuarioRegistro",
    detalle."FechaRegistro",
    existencia."Id" AS "ExistenciaId",
    existencia."IdCentroCosto" AS "ExistenciaIdCentroCosto",
    existencia."IdInsumo" AS "ExistenciaIdInsumo",
    existencia."Precio" AS "ExistenciaPrecio",
    existencia."Cantidad" AS "ExistenciaCantidad",
    existencia."CantidadPorDevolverObra" AS "ExistenciaCantidadPorDevolverObra",
    existencia."CantidadPorTraspasar" AS "ExistenciaCantidadPorTraspasar",
    devolucion."Id" AS "DevolucionInsumoId",
    devolucion."Folio" AS "DevolucionInsumoFolio",
    devolucion."Clave" AS "DevolucionInsumoClave",
    devolucion."IdCentroCosto" AS "DevolucionInsumoIdCentroCosto",
    devolucion."IdCentroCostoRecibe" AS "DevolucionInsumoIdCentroCostoRecibe",
    devolucion."IdTipoDevolucion" AS "DevolucionInsumoIdTipoDevolucion",
    devolucion."Observaciones" AS "DevolucionInsumoObservaciones",
    devolucion."IdUsuarioRegistro" AS "DevolucionInsumoIdUsuarioRegistro",
    devolucion."FechaRegistro" AS "DevolucionInsumoFechaRegistro",
    empresa."Id" AS "EmpresaId",
    empresa."Nombre" AS "EmpresaNombre",
    empresa."NombreComercial" AS "EmpresaNombreComercial",
    empresa."RazonSocial" AS "EmpresaRazonSocial",
    empresa."RFC" AS "EmpresaRfc",
    centrocosto."Id" AS "CentroCostoId",
    centrocosto."Codigo" AS "CentroCostoCodigo",
    centrocosto."Nombre" AS "CentroCostoNombre",
    centrocosto."Descripcion" AS "CentroCostoDescripcion",
    centrocosto."Observaciones" AS "CentroCostoObservaciones",
    centrocosto."IdTipoCentroCosto" AS "CentroCostoIdTipoCentroCosto",
    centrocosto."IdCliente" AS "CentroCostoIdCliente",
    centrocosto."IdEmpresa" AS "CentroCostoIdEmpresa",
    centrocosto."FechaInicial" AS "CentroCostoFechaInicial",
    centrocosto."FechaFinal" AS "CentroCostoFechaFinal",
    centrocostorecibe."Id" AS "CentroCostoRecibeId",
    centrocostorecibe."Codigo" AS "CentroCostoRecibeCodigo",
    centrocostorecibe."Nombre" AS "CentroCostoRecibeNombre",
    centrocostorecibe."Descripcion" AS "CentroCostoRecibeDescripcion",
    centrocostorecibe."Observaciones" AS "CentroCostoRecibeObservaciones",
    centrocostorecibe."IdTipoCentroCosto" AS "CentroCostoRecibeIdTipoCentroCosto",
    centrocostorecibe."IdCliente" AS "CentroCostoRecibeIdCliente",
    centrocostorecibe."IdEmpresa" AS "CentroCostoRecibeIdEmpresa",
    centrocostorecibe."FechaInicial" AS "CentroCostoRecibeFechaInicial",
    centrocostorecibe."FechaFinal" AS "CentroCostoRecibeFechaFinal",
    insumo."Id" AS "InsumoId",
    insumo."Nombre" AS "InsumoNombre",
    insumo."Codigo" AS "InsumoCodigo",
    insumo."Descripcion" AS "InsumoDescripcion",
    insumo."IdTipo" AS "InsumoIdTipo",
    insumo."IdCorporativo" AS "InsumoIdCorporativo",
    insumo."IdFamiliaInsumo" AS "InsumoIdFamiliaInsumo",
    insumo."IdUnidadMedida" AS "InsumoIdUnidadMedida",
    insumo."UrlImagen" AS "InsumoUrlImagen",
    unidad."Id" AS "UnidadMedidaId",
    unidad."Nombre" AS "UnidadMedidaNombre",
    unidad."Clave" AS "UnidadMedidaClave",
    unidad."Tipo" AS "UnidadMedidaTipo",
    tipoinsumo."Id" AS "TipoInsumoId",
    tipoinsumo."Nombre" AS "TipoInsumoNombre",
    tipoinsumo."Codigo" AS "TipoInsumoCodigo",
    tipoinsumo."Descripcion" AS "TipoInsumoDescripcion",
    tipoinsumo."ManoDeObra" AS "TipoInsumoManoDeObra",
    tipoinsumo."Financiero" AS "TipoInsumoFinanciero",
    tipoinsumo."Inventariable" AS "TipoInsumoInventariable",
    tipoinsumo."Administrativo" AS "TipoInsumoAdministrativo",
    tipoinsumo."IdCorporativo" AS "TipoInsumoIdCorporativo",
    usuarioregistro."Id" AS "UsuarioRegistroId",
    usuarioregistro."Nombre" AS "UsuarioRegistroNombre",
    usuarioregistro."ApellidoPaterno" AS "UsuarioRegistroApellidoPaterno",
    usuarioregistro."ApellidoMaterno" AS "UsuarioRegistroApellidoMaterno"
   FROM "DevolucionesInsumosDetalles" detalle
     JOIN "DevolucionesInsumos" devolucion ON devolucion."Id" = detalle."IdDevolucionInsumo"
     LEFT JOIN "CentrosCostos" centrocosto ON centrocosto."Id" = devolucion."IdCentroCosto"
     JOIN "CentrosCostos" centrocostorecibe ON centrocostorecibe."Id" = devolucion."IdCentroCostoRecibe"
     JOIN "CentrosCostosExistenciasInsumos" existencia ON existencia."IdCentroCosto" = centrocosto."Id" AND existencia."IdInsumo" = detalle."IdInsumo"
     LEFT JOIN "Empresas" empresa ON centrocosto."IdEmpresa" = empresa."Id"
     JOIN "Insumos" insumo ON insumo."Id" = detalle."IdInsumo"
     JOIN "UnidadesMedidas" unidad ON unidad."Id" = insumo."IdUnidadMedida"
     JOIN "TiposInsumos" tipoinsumo ON tipoinsumo."Id" = insumo."IdTipo"
     JOIN "Usuarios" usuarioregistro ON usuarioregistro."Id" = detalle."IdUsuarioRegistro";

-- public.explosionesinsumosagrupadosview source
DROP VIEW explosionesinsumosagrupadosview;
CREATE OR REPLACE VIEW public.explosionesinsumosagrupadosview
AS SELECT explosioninsumo."Id",
    explosioninsumo."IdExplosion",
    explosioninsumo."IdPresupuesto",
    explosioninsumo."IdPresupuestoPartida",
    explosioninsumo."IdInsumo",
    explosioninsumo."Cantidad",
    explosioninsumo."IdPrecio",
    explosioninsumo."NoConsiderado",
    explosioninsumo."Autorizado",
    explosioninsumo."IdUsuarioRegistro",
    explosioninsumo."FechaRegistro",
    explosioninsumo."IdUsuarioModifico",
    explosioninsumo."FechaModifico",
    explosioninsumo."Contratable",
    "Explosiones"."Id" AS "ExplosionId",
    "Explosiones"."IdPresupuesto" AS "ExplosionIdPresupuesto",
    "Explosiones"."Codigo" AS "ExplosionCodigo",
    "Explosiones"."Descripcion" AS "ExplosionDescripcion",
    "Explosiones"."IdUsuarioRegistro" AS "ExplosionIdUsuarioRegistro",
    "Explosiones"."FechaRegistro" AS "ExplosionFechaRegistro",
    "Explosiones"."IdUsuarioModifico" AS "ExplosionIdUsuarioModifico",
    "Explosiones"."FechaModifico" AS "ExplosionFechaModifico",
    "Explosiones"."Activo" AS "ExplosionActivo",
    "Explosiones"."Actualizada" AS "ExplosionActualizada",
    "PresupuestosPartidas"."Id" AS "PresupuestoPartidaId",
    "PresupuestosPartidas"."IdPadre" AS "PresupuestoPartidaIdPadre",
    "PresupuestosPartidas"."IdPresupuesto" AS "PresupuestoPartidaIdPresupuesto",
    "PresupuestosPartidas"."Nombre" AS "PresupuestoPartidaNombre",
    "PresupuestosPartidas"."Observaciones" AS "PresupuestoPartidaObservaciones",
    "PresupuestosPartidas"."Descripcion" AS "PresupuestoPartidaDescripcion",
    "Insumos"."Id" AS "InsumoId",
    "Insumos"."Codigo" AS "InsumoCodigo",
    "Insumos"."Descripcion" AS "InsumoDescripcion",
    "Insumos"."Nombre" AS "InsumoNombre",
    "Insumos"."IdFamiliaInsumo" AS "InsumoIdFamiliaInsumo",
    "Insumos"."IdTipo" AS "InsumoIdTipo",
    "FamiliasInsumos"."Id" AS "FamiliaInsumoId",
    "FamiliasInsumos"."Codigo" AS "FamiliaInsumoCodigo",
    "FamiliasInsumos"."Nombre" AS "FamiliaInsumoNombre",
    "FamiliasInsumos"."Descripcion" AS "FamiliaInsumoDescripcion",
    "TiposInsumos"."Id" AS "TipoInsumoId",
    "TiposInsumos"."Codigo" AS "TipoInsumoCodigo",
    "TiposInsumos"."Nombre" AS "TipoInsumoNombre",
    "TiposInsumos"."Descripcion" AS "TipoInsumoDescripcion",
    "TiposInsumos"."ManoDeObra" AS "TipoInsumoManoDeObra",
    "TiposInsumos"."Administrativo" AS "TipoInsumoAdministrativo",
    "TiposInsumos"."Inventariable" AS "TipoInsumoInventariable",
    "TiposInsumos"."Financiero" AS "TipoInsumoFinanciero",
    "TiposInsumos"."Requerir" AS "TipoInsumoRequerir",
    "UnidadesMedidas"."Id" AS "UnidadMedidaId",
    "UnidadesMedidas"."Clave" AS "UnidadMedidaClave",
    "UnidadesMedidas"."Nombre" AS "UnidadMedidaNombre",
    "UnidadesMedidas"."Tipo" AS "UnidadMedidaTipo",
    "Presupuestos"."Id" AS "PresupuestoId",
    "Presupuestos"."IdEmpresa" AS "PresupuestoIdEmpresa",
    "Presupuestos"."IdCentroCosto" AS "PresupuestoIdCentroCosto",
    "Presupuestos"."Nombre" AS "PresupuestoNombre",
    "Presupuestos"."Codigo" AS "PresupuestoCodigo",
    "Presupuestos"."Descripcion" AS "PresupuestoDescripcion",
    "Presupuestos"."IdTipo" AS "PresupuestoIdTipo",
    "Presupuestos"."Email" AS "PresupuestoEmail",
    "Presupuestos"."IdClasificadorPresupuesto" AS "PresupuestoIdClasificadorPresupuesto",
    "Presupuestos"."IdResponsable" AS "PresupuestoIdResponsable",
    "Presupuestos"."Observaciones" AS "PresupuestoObservaciones",
    "CentrosCostos"."Id" AS "CentroCostoId",
    "CentrosCostos"."IdCliente" AS "CentroCostoIdCliente",
    "CentrosCostos"."IdEmpresa" AS "CentroCostoIdEmpresa",
    "CentrosCostos"."IdTipoCentroCosto" AS "CentroCostoIdTipoCentroCosto",
    "CentrosCostos"."Nombre" AS "CentroCostoNombre",
    "CentrosCostos"."Observaciones" AS "CentroCostoObservaciones",
    "CentrosCostos"."Codigo" AS "CentroCostoCodigo",
    "CentrosCostos"."Descripcion" AS "CentroCostoDescripcion",
    "CentrosCostos"."FechaInicial" AS "CentroCostoFechaInicial",
    "CentrosCostos"."FechaFinal" AS "CentroCostoFechaFinal",
    "CentrosCostos"."IdUsuarioRegistro" AS "CentroCostoIdUsuarioRegistro",
    "CentrosCostos"."FechaRegistro" AS "CentroCostoFechaRegistro",
    "CentrosCostos"."IdUsuarioModifico" AS "CentroCostoIdUsuarioModifico",
    "CentrosCostos"."FechaModifico" AS "CentroCostoFechaModifico",
    "CentrosCostos"."Activo" AS "CentroCostoActivo",
    "PresupuestosInsumosPrecios"."Id" AS "PresupuestoInsumoPrecioId",
    "PresupuestosInsumosPrecios"."IdInsumo" AS "PresupuestoInsumoPrecioIdInsumo",
    "PresupuestosInsumosPrecios"."IdMoneda" AS "PresupuestoInsumoPrecioIdMoneda",
    "PresupuestosInsumosPrecios"."IdPresupuesto" AS "PresupuestoInsumoPrecioIdPresupuesto",
    "PresupuestosInsumosPrecios"."Precio" AS "PresupuestoInsumoPrecioPrecio",
    usuarioregistro."Nombre" AS "UsuarioRegistroNombre",
    usuarioregistro."ApellidoPaterno" AS "UsuarioRegistroApellidoPaterno",
    usuarioregistro."ApellidoMaterno" AS "UsuarioRegistroApellidoMaterno",
    usuariomodifico."Nombre" AS "UsuarioModificoNombre",
    usuariomodifico."ApellidoPaterno" AS "UsuarioModificoApellidoPaterno",
    usuariomodifico."ApellidoMaterno" AS "UsuarioModificoApellidoMaterno"
   FROM "ExplosionesInsumosAgrupados" explosioninsumo
     JOIN "Explosiones" ON "Explosiones"."Id" = explosioninsumo."IdExplosion"
     JOIN "Presupuestos" ON "Presupuestos"."Id" = explosioninsumo."IdPresupuesto"
     JOIN "CentrosCostos" ON "CentrosCostos"."Id" = "Presupuestos"."IdCentroCosto"
     JOIN "PresupuestosPartidas" ON "PresupuestosPartidas"."Id" = explosioninsumo."IdPresupuestoPartida"
     JOIN "Insumos" ON "Insumos"."Id" = explosioninsumo."IdInsumo"
     JOIN "TiposInsumos" ON "TiposInsumos"."Id" = "Insumos"."IdTipo"
     JOIN "FamiliasInsumos" ON "FamiliasInsumos"."Id" = "Insumos"."IdFamiliaInsumo"
     JOIN "UnidadesMedidas" ON "UnidadesMedidas"."Id" = "Insumos"."IdUnidadMedida"
     JOIN "PresupuestosInsumosPrecios" ON "PresupuestosInsumosPrecios"."Id" = explosioninsumo."IdPrecio"
     JOIN "Usuarios" usuarioregistro ON usuarioregistro."Id" = explosioninsumo."IdUsuarioRegistro"
     JOIN "Usuarios" usuariomodifico ON usuariomodifico."Id" = explosioninsumo."IdUsuarioModifico"
  WHERE "Explosiones"."Activo" = true;


-- public.ordenescomprasinsumosagrupadosdetallesview source
DROP VIEW ordenescomprasinsumosagrupadosdetallesview;
CREATE OR REPLACE VIEW public.ordenescomprasinsumosagrupadosdetallesview
AS SELECT detalle."Id",
    detalle."IdOrdenCompra",
    detalle."IdPresupuestoMoneda",
    detalle."IdRequisicionDetalle",
    detalle."Precio",
    detalle."Cantidad",
    detalle."IdDivisa",
    detalle."Observaciones",
    divisa."Id" AS "DivisaId",
    divisa."IdCorporativo" AS "DivisaIdCorporativo",
    divisa."IdMoneda" AS "DivisaIdMoneda",
    divisa."TipoCambio" AS "DivisaTipoCambio",
    presupuesto."Id" AS "PresupuestoId",
    presupuesto."Codigo" AS "PresupuestoCodigo",
    presupuesto."Nombre" AS "PresupuestoNombre",
    presupuesto."IdEmpresa" AS "PresupuestoIdEmpresa",
    presupuestoinsumoprecio."Id" AS "PresupuestoInsumoPrecioId",
    presupuestoinsumoprecio."IdInsumo" AS "PresupuestoInsumoPrecioIdInsumo",
    presupuestoinsumoprecio."IdMoneda" AS "PresupuestoInsumoPrecioIdMoneda",
    presupuestoinsumoprecio."IdPresupuesto" AS "PresupuestoInsumoPrecioIdPresupuesto",
    presupuestoinsumoprecio."Precio" AS "PresupuestoInsumoPrecioPrecio",
    centrocosto."Id" AS "CentroCostoId",
    centrocosto."Codigo" AS "CentroCostoCodigo",
    centrocosto."Nombre" AS "CentroCostoNombre",
    centrocosto."Descripcion" AS "CentroCostoDescripcion",
    centrocosto."Observaciones" AS "CentroCostoObservaciones",
    centrocosto."IdTipoCentroCosto" AS "CentroCostoIdTipoCentroCosto",
    centrocosto."IdCliente" AS "CentroCostoIdCliente",
    centrocosto."IdEmpresa" AS "CentroCostoIdEmpresa",
    centrocosto."FechaInicial" AS "CentroCostoFechaInicial",
    centrocosto."FechaFinal" AS "CentroCostoFechaFinal",
    centrocostoaplicar."Id" AS "CentroCostoAplicarId",
    centrocostoaplicar."Codigo" AS "CentroCostoAplicarCodigo",
    centrocostoaplicar."Nombre" AS "CentroCostoAplicarNombre",
    centrocostoaplicar."Descripcion" AS "CentroCostoAplicarDescripcion",
    centrocostoaplicar."Observaciones" AS "CentroCostoAplicarObservaciones",
    centrocostoaplicar."IdTipoCentroCosto" AS "CentroCostoAplicarIdTipoCentroCosto",
    centrocostoaplicar."IdCliente" AS "CentroCostoAplicarIdCliente",
    centrocostoaplicar."IdEmpresa" AS "CentroCostoAplicarIdEmpresa",
    centrocostoaplicar."FechaInicial" AS "CentroCostoAplicarFechaInicial",
    centrocostoaplicar."FechaFinal" AS "CentroCostoAplicarFechaFinal",
    requisiciondetalle."Id" AS "RequisicionDetalleId",
    requisiciondetalle."IdRequisicion" AS "RequisicionDetalleIdRequisicion",
    requisiciondetalle."IdExplosionInsumoAgrupado" AS "RequisicionDetalleIdExplosionInsumo",
    requisiciondetalle."CantidadRequerir" AS "RequisicionDetalleCantidadRequerir",
    requisiciondetalle."Observaciones" AS "RequisicionDetalleObservaciones",
    requisiciondetalle."Frente" AS "RequisicionDetalleFrente",
    requisiciondetalle."UrlDocumento" AS "RequisicionDetalleUrlDocumento",
    requisiciondetalle."IdUsuarioRegistro" AS "RequisicionDetalleIdUsuarioRegistro",
    requisiciondetalle."FechaRegistro" AS "RequisicionDetalleFechaRegistro",
    requisiciondetalle."IdUsuarioModifico" AS "RequisicionDetalleIdUsuarioModifico",
    requisiciondetalle."FechaModifico" AS "RequisicionDetalleFechaModifico",
    requisiciondetalle."Activo" AS "RequisicionDetalleActivo",
    requisicion."Id" AS "RequisicionId",
    requisicion."Folio" AS "RequisicionFolio",
    requisicion."Nombre" AS "RequisicionNombre",
    requisicion."IdCentroCosto" AS "RequisicionIdCentroCosto",
    requisicion."IdCentroCostoAplicar" AS "RequisicionIdCentroCostoAplicar",
    requisicion."FechaRequerida" AS "RequisicionFechaRequerida",
    requisicion."DetallesEntrega" AS "RequisicionDetallesEntrega",
    requisicion."Observaciones" AS "RequisicionObservaciones",
    requisicion."IdUsuarioRegistro" AS "RequisicionIdUsuarioRegistro",
    requisicion."FechaRegistro" AS "RequisicionFechaRegistro",
    requisicion."IdUsuarioModifico" AS "RequisicionIdUsuarioModifico",
    requisicion."FechaModifico" AS "RequisicionFechaModifico",
    requisicion."Activo" AS "RequisicionActivo",
    explosioninsumo."Id" AS "ExplosionInsumoId",
    explosioninsumo."IdExplosion" AS "ExplosionInsumoIdExplosion",
    explosioninsumo."IdPresupuesto" AS "ExplosionInsumoIdPresupuesto",
    explosioninsumo."IdPresupuestoPartida" AS "ExplosionInsumoIdPresupuestoPartida",
    explosioninsumo."IdInsumo" AS "ExplosionInsumoIdInsumo",
    explosioninsumo."Cantidad" AS "ExplosionInsumoCantidad",
    explosioninsumo."IdPrecio" AS "ExplosionInsumoIdPrecio",
    explosioninsumo."IdUsuarioRegistro" AS "ExplosionInsumoIdUsuarioRegistro",
    explosioninsumo."FechaRegistro" AS "ExplosionInsumoFechaRegistro",
    explosioninsumo."IdUsuarioModifico" AS "ExplosionInsumoIdUsuarioModifico",
    explosioninsumo."FechaModifico" AS "ExplosionInsumoFechaModifico",
    explosioninsumo."Autorizado" AS "ExplosionInsumoAutorizado",
    explosioninsumo."Contratable" AS "ExplosionInsumoContratable",
    explosioninsumo."NoConsiderado" AS "ExplosionInsumoNoConsiderado",
    moneda."Id" AS "MonedaId",
    moneda."Nombre" AS "MonedaNombre",
    moneda."Clave" AS "MonedaClave",
    moneda."IdUsuarioRegistro" AS "MonedaIdUsuarioRegistro",
    moneda."FechaRegistro" AS "MonedaFechaRegistro",
    moneda."IdUsuarioModifico" AS "MonedaIdUsuarioModifico",
    moneda."FechaModifico" AS "MonedaFechaModifico",
    moneda."Activo" AS "MonedaActivo",
    presupuestomoneda."Id" AS "PresupuestoMonedaId",
    presupuestomoneda."IdMoneda" AS "PresupuestoMonedaIdMoneda",
    presupuestomoneda."IdPresupuesto" AS "PresupuestoMonedaIdPresupuesto",
    presupuestomoneda."TipoCambio" AS "PresupuestoMonedaTipoCambio",
    presupuestomoneda."Favorita" AS "PresupuestoMonedaFavorita",
    ordencompra."Id" AS "OrdenCompraId",
    ordencompra."Folio" AS "OrdenCompraFolio",
    ordencompra."Clave" AS "OrdenCompraClave",
    ordencompra."IdEmpresa" AS "OrdenCompraIdEmpresa",
    ordencompra."IdProveedor" AS "OrdenCompraIdProveedor",
    ordencompra."IdUsuarioRegistro" AS "OrdenCompraIdUsuarioRegistro",
    ordencompra."FechaRegistro" AS "OrdenCompraFechaRegistro",
    ordencompra."IdUsuarioModifico" AS "OrdenCompraIdUsuarioModifico",
    ordencompra."FechaModifico" AS "OrdenCompraFechaModifico",
    ordencompra."Activo" AS "OrdenCompraActivo",
    empresa."Id" AS "EmpresaId",
    empresa."IdCorporativo" AS "EmpresaIdCorporativo",
    empresa."Nombre" AS "EmpresaNombre",
    empresa."NombreComercial" AS "EmpresaNombreComercial",
    empresa."RazonSocial" AS "EmpresaRazonSocial",
    empresa."RFC" AS "EmpresaRFC",
    empresa."LogoURL" AS "EmpresaLogoURL",
    empresa."IdUsuarioRegistro" AS "EmpresaIdUsuarioRegistro",
    empresa."FechaRegistro" AS "EmpresaFechaRegistro",
    empresa."IdUsuarioModifico" AS "EmpresaIdUsuarioModifico",
    empresa."FechaModifico" AS "EmpresaFechaModifico",
    empresa."Activo" AS "EmpresaActivo",
    proveedor."Id" AS "ProveedorId",
    proveedor."IdEmpresa" AS "ProveedorIdEmpresa",
    proveedor."IdRegimenFiscal" AS "ProveedorIdRegimenFiscal",
    proveedor."NombreComercial" AS "ProveedorNombreComercial",
    proveedor."RazonSocial" AS "ProveedorRazonSocial",
    proveedor."Rfc" AS "ProveedorRfc",
    proveedor."Nombre" AS "ProveedorNombre",
    proveedor."SitioWeb" AS "ProveedorSitioWeb",
    proveedor."Telefono1" AS "ProveedorTelefono1",
    proveedor."Telefono2" AS "ProveedorTelefono2",
    proveedor."UrlSolicitudDocumento" AS "ProveedorUrlSolicitudDocumento",
    proveedor."ApellidoPaterno" AS "ProveedorApellidoPaterno",
    proveedor."ApellidoMaterno" AS "ProveedorApellidoMaterno",
    proveedor."Curp" AS "ProveedorCurp",
    proveedor."Email1" AS "ProveedorEmail1",
    proveedor."Email2" AS "ProveedorEmail2",
    proveedor."NombreContacto" AS "ProveedorNombreContacto",
    proveedor."IdUsuarioRegistro" AS "ProveedorIdUsuarioRegistro",
    proveedor."FechaRegistro" AS "ProveedorFechaRegistro",
    proveedor."IdUsuarioModifico" AS "ProveedorIdUsuarioModifico",
    proveedor."FechaModifico" AS "ProveedorFechaModifico",
    proveedor."Activo" AS "ProveedorActivo",
    insumo."Id" AS "InsumoId",
    insumo."Nombre" AS "InsumoNombre",
    insumo."Codigo" AS "InsumoCodigo",
    insumo."Descripcion" AS "InsumoDescripcion",
    insumo."IdTipo" AS "InsumoIdTipo",
    insumo."IdCorporativo" AS "InsumoIdCorporativo",
    insumo."IdFamiliaInsumo" AS "InsumoIdFamiliaInsumo",
    insumo."IdUnidadMedida" AS "InsumoIdUnidadMedida",
    insumo."UrlImagen" AS "InsumoUrlImagen",
    unidad."Id" AS "UnidadMedidaId",
    unidad."Nombre" AS "UnidadMedidaNombre",
    unidad."Clave" AS "UnidadMedidaClave",
    unidad."Tipo" AS "UnidadMedidaTipo",
    tipoinsumo."Id" AS "TipoInsumoId",
    tipoinsumo."Nombre" AS "TipoInsumoNombre",
    tipoinsumo."Codigo" AS "TipoInsumoCodigo",
    tipoinsumo."Descripcion" AS "TipoInsumoDescripcion",
    tipoinsumo."ManoDeObra" AS "TipoInsumoManoDeObra",
    tipoinsumo."Financiero" AS "TipoInsumoFinanciero",
    tipoinsumo."Inventariable" AS "TipoInsumoInventariable",
    tipoinsumo."Administrativo" AS "TipoInsumoAdministrativo",
    tipoinsumo."IdCorporativo" AS "TipoInsumoIdCorporativo",
    presupuestopartida."Id" AS "PresupuestoPartidaId",
    presupuestopartida."Nombre" AS "PresupuestoPartidaNombre",
    presupuestopartida."Descripcion" AS "PresupuestoPartidaDescripcion",
    presupuestopartida."Observaciones" AS "PresupuestoPartidaObservaciones",
    presupuestopartida."IdPadre" AS "PresupuestoPartidaIdPadre",
    presupuestopartida."IdPresupuesto" AS "PresupuestoPartidaIdPresupuesto",
    usuarioregistro."Id" AS "UsuarioRegistroId",
    usuarioregistro."Nombre" AS "UsuarioRegistroNombre",
    usuarioregistro."ApellidoPaterno" AS "UsuarioRegistroApellidoPaterno",
    usuarioregistro."ApellidoMaterno" AS "UsuarioRegistroApellidoMaterno",
    usuariomodifico."Id" AS "UsuarioModificoId",
    usuariomodifico."Nombre" AS "UsuarioModificoNombre",
    usuariomodifico."ApellidoPaterno" AS "UsuarioModificoApellidoPaterno",
    usuariomodifico."ApellidoMaterno" AS "UsuarioModificoApellidoMaterno"
   FROM "OrdenesComprasDetalles" detalle
     JOIN "OrdenesCompras" ordencompra ON ordencompra."Id" = detalle."IdOrdenCompra"
     LEFT JOIN "Divisas" divisa ON divisa."Id" = detalle."IdDivisa"
     JOIN "RequisicionesDetalles" requisiciondetalle ON requisiciondetalle."Id" = detalle."IdRequisicionDetalle"
     JOIN "Requisiciones" requisicion ON requisicion."Id" = requisiciondetalle."IdRequisicion"
     JOIN "ExplosionesInsumosAgrupados" explosioninsumo ON explosioninsumo."Id" = requisiciondetalle."IdExplosionInsumoAgrupado"
     JOIN "PresupuestosInsumosPrecios" presupuestoinsumoprecio ON presupuestoinsumoprecio."Id" = explosioninsumo."IdPrecio"
     JOIN "Presupuestos" presupuesto ON presupuesto."Id" = explosioninsumo."IdPresupuesto"
     JOIN "CentrosCostos" centrocosto ON centrocosto."Id" = presupuesto."IdCentroCosto"
     JOIN "CentrosCostos" centrocostoaplicar ON centrocostoaplicar."Id" = requisicion."IdCentroCostoAplicar"
     JOIN "Insumos" insumo ON insumo."Id" = explosioninsumo."IdInsumo"
     JOIN "UnidadesMedidas" unidad ON unidad."Id" = insumo."IdUnidadMedida"
     JOIN "TiposInsumos" tipoinsumo ON tipoinsumo."Id" = insumo."IdTipo"
     JOIN "PresupuestosPartidas" presupuestopartida ON presupuestopartida."Id" = explosioninsumo."IdPresupuestoPartida"
     JOIN "Empresas" empresa ON empresa."Id" = ordencompra."IdEmpresa"
     JOIN "PresupuestosMonedas" presupuestomoneda ON presupuestomoneda."Id" = detalle."IdPresupuestoMoneda"
     JOIN "Monedas" moneda ON moneda."Id" = presupuestomoneda."IdMoneda"
     JOIN "Proveedores" proveedor ON proveedor."Id" = ordencompra."IdProveedor"
     LEFT JOIN "Usuarios" usuarioregistro ON usuarioregistro."Id" = ordencompra."IdUsuarioRegistro"
     LEFT JOIN "Usuarios" usuariomodifico ON usuariomodifico."Id" = ordencompra."IdUsuarioModifico"
  WHERE ordencompra."Activo" = true;


DROP VIEW aditivasdetallesview;
CREATE OR REPLACE VIEW public.aditivasdetallesview
AS SELECT detalle."Id",
    detalle."IdExplosionInsumo",
    detalle."Cantidad",
    detalle."IdUsuarioRegistro",
    detalle."FechaRegistro",
    detalle."IdUsuarioModifico",
    detalle."FechaModifico",
    detalle."IdAditivaAgrupador",
    detalle."Precio",
    aditiva."Id" AS "AditivaId",
    aditiva."IdExplosion" AS "AditivaIdExplosion",
    aditiva."Nombre" AS "AditivaNombre",
    aditiva."Codigo" AS "AditivaCodigo",
    aditiva."Descripcion" AS "AditivaDescripcion",
    aditiva."IdUsuarioRegistro" AS "AditivaIdUsuarioRegistro",
    aditiva."FechaRegistro" AS "AditivaFechaRegistro",
    aditiva."IdUsuarioModifico" AS "AditivaIdUsuarioModifico",
    aditiva."FechaModifico" AS "AditivaFechaModifico",
    aditiva."Activo" AS "AditivaActivo",
    aditiva."IdTipo" AS "AditivaIdTipo",
    aditiva."IdRequisicion" AS "AditivaIdRequisicion",
    explosion."Id" AS "ExplosionId",
    explosion."IdPresupuesto" AS "ExplosionIdPresupuesto",
    explosion."Codigo" AS "ExplosionCodigo",
    explosion."Descripcion" AS "ExplosionDescripcion",
    explosion."IdUsuarioRegistro" AS "ExplosionIdUsuarioRegistro",
    explosion."FechaRegistro" AS "ExplosionFechaRegistro",
    explosion."IdUsuarioModifico" AS "ExplosionIdUsuarioModifico",
    explosion."FechaModifico" AS "ExplosionFechaModifico",
    explosion."Activo" AS "ExplosionActivo",
    explosion."Actualizada" AS "ExplosionActualizada",
    presupuesto."Id" AS "PresupuestoId",
    presupuesto."Nombre" AS "PresupuestoNombre",
    presupuesto."Codigo" AS "PresupuestoCodigo",
    presupuesto."Descripcion" AS "PresupuestoDescripcion",
    presupuesto."IdEmpresa" AS "PresupuestoIdEmpresa",
    presupuesto."IdClasificadorPresupuesto" AS "PresupuestoIdClasificadorPresupuesto",
    presupuesto."Email" AS "PresupuestoEmail",
    presupuesto."IdCentroCosto" AS "PresupuestoIdCentroCosto",
    presupuesto."IdResponsable" AS "PresupuestoIdResponsable",
    presupuesto."IdTipo" AS "PresupuestoIdTipo",
    presupuesto."Observaciones" AS "PresupuestoObservaciones",
    explosioninsumo."Id" AS "ExplosionInsumoId",
    explosioninsumo."IdExplosion" AS "ExplosionInsumoIdExplosion",
    explosioninsumo."IdPresupuesto" AS "ExplosionInsumoIdPresupuesto",
    explosioninsumo."IdPresupuestoConcepto" AS "ExplosionInsumoIdPresupuestoConcepto",
    explosioninsumo."IdInsumo" AS "ExplosionInsumoIdInsumo",
    explosioninsumo."Cantidad" AS "ExplosionInsumoCantidad",
    explosioninsumo."IdPrecio" AS "ExplosionInsumoIdPrecio",
    insumo."Id" AS "InsumoId",
    insumo."Nombre" AS "InsumoNombre",
    insumo."Codigo" AS "InsumoCodigo",
    tipoinsumo."Id" AS "TipoInsumoId",
    tipoinsumo."Nombre" AS "TipoInsumoNombre",
    tipoinsumo."Codigo" AS "TipoInsumoCodigo",
    tipoinsumo."Descripcion" AS "TipoInsumoDescripcion",
    unidadmedida."Id" AS "UnidadMedidaId",
    unidadmedida."Nombre" AS "UnidadMedidaNombre",
    unidadmedida."Clave" AS "UnidadMedidaClave",
    unidadmedida."Tipo" AS "UnidadMedidaTipo",
    familiainsumo."Id" AS "FamiliaInsumoId",
    familiainsumo."Nombre" AS "FamiliaInsumoNombre",
    familiainsumo."Codigo" AS "FamiliaInsumoCodigo",
    familiainsumo."Descripcion" AS "FamiliaInsumoDescripcion",
    presupuestopartida."Id" AS "PresupuestoPartidaId",
    presupuestopartida."Nombre" AS "PresupuestoPartidaNombre",
    presupuestopartida."Descripcion" AS "PresupuestoPartidaDescripcion",
    presupuestopartida."Observaciones" AS "PresupuestoPartidaObservaciones",
    presupuestoconcepto."Id" AS "PresupuestoConceptoId",
    presupuestoconcepto."Nombre" AS "PresupuestoConceptoNombre",
    presupuestoconcepto."Codigo" AS "PresupuestoConceptoCodigo",
    presupuestoconcepto."Descripcion" AS "PresupuestoConceptoDescripcion",
    presupuestoinsumoprecio."Id" AS "PresupuestoInsumoPrecioId",
    presupuestoinsumoprecio."IdInsumo" AS "PresupuestoInsumoPrecioIdInsumo",
    presupuestoinsumoprecio."IdMoneda" AS "PresupuestoInsumoPrecioIdMoneda",
    presupuestoinsumoprecio."IdPresupuesto" AS "PresupuestoInsumoPrecioIdPresupuesto",
    presupuestoinsumoprecio."Precio" AS "PresupuestoInsumoPrecioPrecio",
    usuarioregistro."Id" AS "UsuarioRegistroId",
    usuarioregistro."Nombre" AS "UsuarioRegistroNombre",
    usuarioregistro."ApellidoPaterno" AS "UsuarioRegistroApellidoPaterno",
    usuarioregistro."ApellidoMaterno" AS "UsuarioRegistroApellidoMaterno",
    usuariomodifico."Id" AS "UsuarioModificoId",
    usuariomodifico."Nombre" AS "UsuarioModificoNombre",
    usuariomodifico."ApellidoPaterno" AS "UsuarioModificoApellidoPaterno",
    usuariomodifico."ApellidoMaterno" AS "UsuarioModificoApellidoMaterno"
   FROM "AditivasDetalles" detalle
     JOIN "Aditivas" aditiva ON aditiva."Id" = detalle."IdAditivaAgrupador"
     JOIN "Explosiones" explosion ON explosion."Id" = aditiva."IdExplosion"
     JOIN "Presupuestos" presupuesto ON presupuesto."Id" = explosion."IdPresupuesto"
     LEFT JOIN "ExplosionesInsumos" explosioninsumo ON explosioninsumo."Id" = detalle."IdExplosionInsumo"
     LEFT JOIN "PresupuestosInsumosPrecios" presupuestoinsumoprecio ON presupuestoinsumoprecio."Id" = explosioninsumo."IdPrecio"
     LEFT JOIN "PresupuestosConceptos" presupuestoconcepto ON presupuestoconcepto."Id" = explosioninsumo."IdPresupuestoConcepto"
     LEFT JOIN "PresupuestosPartidas" presupuestopartida ON presupuestopartida."Id" = presupuestoconcepto."IdPartida"
     LEFT JOIN "Insumos" insumo ON insumo."Id" = explosioninsumo."IdInsumo"
     LEFT JOIN "TiposInsumos" tipoinsumo ON tipoinsumo."Id" = insumo."IdTipo"
     LEFT JOIN "UnidadesMedidas" unidadmedida ON unidadmedida."Id" = insumo."IdUnidadMedida"
     LEFT JOIN "FamiliasInsumos" familiainsumo ON familiainsumo."Id" = insumo."IdFamiliaInsumo"
     JOIN "Usuarios" usuarioregistro ON usuarioregistro."Id" = detalle."IdUsuarioRegistro"
     JOIN "Usuarios" usuariomodifico ON usuariomodifico."Id" = detalle."IdUsuarioModifico";


-- public.requisicionesdetallesinsumosagrupadosview source
DROP VIEW requisicionesdetallesinsumosagrupadosview;
CREATE OR REPLACE VIEW public.requisicionesdetallesinsumosagrupadosview
AS SELECT detalle."Id",
    detalle."IdRequisicion",
    detalle."CantidadRequerir",
    detalle."Observaciones",
    detalle."Frente",
    detalle."UrlDocumento",
    detalle."IdUsuarioRegistro",
    detalle."FechaRegistro",
    detalle."IdUsuarioModifico",
    detalle."FechaModifico",
    detalle."Activo",
    detalle."IdExplosionInsumoAgrupado" AS "IdExplosionInsumo",
    empresa."Id" AS "EmpresaId",
    empresa."Nombre" AS "EmpresaNombre",
    empresa."NombreComercial" AS "EmpresaNombreComercial",
    empresa."RazonSocial" AS "EmpresaRazonSocial",
    empresa."RFC" AS "EmpresaRfc",
    presupuesto."Id" AS "PresupuestoId",
    presupuesto."Codigo" AS "PresupuestoCodigo",
    presupuesto."Nombre" AS "PresupuestoNombre",
    presupuesto."IdEmpresa" AS "PresupuestoIdEmpresa",
    centrocosto."Id" AS "CentroCostoId",
    centrocosto."Codigo" AS "CentroCostoCodigo",
    centrocosto."Nombre" AS "CentroCostoNombre",
    centrocosto."Descripcion" AS "CentroCostoDescripcion",
    centrocosto."Observaciones" AS "CentroCostoObservaciones",
    centrocosto."IdTipoCentroCosto" AS "CentroCostoIdTipoCentroCosto",
    centrocosto."IdCliente" AS "CentroCostoIdCliente",
    centrocosto."IdEmpresa" AS "CentroCostoIdEmpresa",
    centrocosto."FechaInicial" AS "CentroCostoFechaInicial",
    centrocosto."FechaFinal" AS "CentroCostoFechaFinal",
    centrocostoaplicar."Id" AS "CentroCostoAplicarId",
    centrocostoaplicar."Codigo" AS "CentroCostoAplicarCodigo",
    centrocostoaplicar."Nombre" AS "CentroCostoAplicarNombre",
    centrocostoaplicar."Descripcion" AS "CentroCostoAplicarDescripcion",
    centrocostoaplicar."Observaciones" AS "CentroCostoAplicarObservaciones",
    centrocostoaplicar."IdTipoCentroCosto" AS "CentroCostoAplicarIdTipoCentroCosto",
    centrocostoaplicar."IdCliente" AS "CentroCostoAplicarIdCliente",
    centrocostoaplicar."IdEmpresa" AS "CentroCostoAplicarIdEmpresa",
    centrocostoaplicar."FechaInicial" AS "CentroCostoAplicarFechaInicial",
    centrocostoaplicar."FechaFinal" AS "CentroCostoAplicarFechaFinal",
    requisicion."Id" AS "RequisicionId",
    requisicion."Folio" AS "RequisicionFolio",
    requisicion."Nombre" AS "RequisicionNombre",
    requisicion."IdCentroCosto" AS "RequisicionIdCentroCosto",
    requisicion."IdCentroCostoAplicar" AS "RequisicionIdCentroCostoAplicar",
    requisicion."FechaRequerida" AS "RequisicionFechaRequerida",
    requisicion."DetallesEntrega" AS "RequisicionDetallesEntrega",
    requisicion."Observaciones" AS "RequisicionObservaciones",
    requisicion."IdUsuarioRegistro" AS "RequisicionIdUsuarioRegistro",
    requisicion."FechaRegistro" AS "RequisicionFechaRegistro",
    requisicion."IdUsuarioModifico" AS "RequisicionIdUsuarioModifico",
    requisicion."FechaModifico" AS "RequisicionFechaModifico",
    requisicion."Activo" AS "RequisicionActivo",
    explosioninsumo."Id" AS "ExplosionInsumoId",
    explosioninsumo."IdExplosion" AS "ExplosionInsumoIdExplosion",
    explosioninsumo."IdPresupuesto" AS "ExplosionInsumoIdPresupuesto",
    explosioninsumo."IdPresupuestoPartida" AS "ExplosionInsumoIdPresupuestoPartida",
    explosioninsumo."IdInsumo" AS "ExplosionInsumoIdInsumo",
    explosioninsumo."Cantidad" AS "ExplosionInsumoCantidad",
    explosioninsumo."IdPrecio" AS "ExplosionInsumoIdPrecio",
    explosioninsumo."IdUsuarioRegistro" AS "ExplosionInsumoIdUsuarioRegistro",
    explosioninsumo."FechaRegistro" AS "ExplosionInsumoFechaRegistro",
    explosioninsumo."IdUsuarioModifico" AS "ExplosionInsumoIdUsuarioModifico",
    explosioninsumo."FechaModifico" AS "ExplosionInsumoFechaModifico",
    explosioninsumo."Autorizado" AS "ExplosionInsumoAutorizado",
    explosioninsumo."Contratable" AS "ExplosionInsumoContratable",
    explosioninsumo."NoConsiderado" AS "ExplosionInsumoNoConsiderado",
    insumo."Id" AS "InsumoId",
    insumo."Nombre" AS "InsumoNombre",
    insumo."Codigo" AS "InsumoCodigo",
    insumo."Descripcion" AS "InsumoDescripcion",
    insumo."IdTipo" AS "InsumoIdTipo",
    insumo."IdCorporativo" AS "InsumoIdCorporativo",
    insumo."IdFamiliaInsumo" AS "InsumoIdFamiliaInsumo",
    insumo."IdUnidadMedida" AS "InsumoIdUnidadMedida",
    insumo."UrlImagen" AS "InsumoUrlImagen",
    unidad."Id" AS "UnidadMedidaId",
    unidad."Nombre" AS "UnidadMedidaNombre",
    unidad."Clave" AS "UnidadMedidaClave",
    unidad."Tipo" AS "UnidadMedidaTipo",
    tipoinsumo."Id" AS "TipoInsumoId",
    tipoinsumo."Nombre" AS "TipoInsumoNombre",
    tipoinsumo."Codigo" AS "TipoInsumoCodigo",
    tipoinsumo."Descripcion" AS "TipoInsumoDescripcion",
    tipoinsumo."ManoDeObra" AS "TipoInsumoManoDeObra",
    tipoinsumo."Financiero" AS "TipoInsumoFinanciero",
    tipoinsumo."Inventariable" AS "TipoInsumoInventariable",
    tipoinsumo."Administrativo" AS "TipoInsumoAdministrativo",
    tipoinsumo."IdCorporativo" AS "TipoInsumoIdCorporativo",
    presupuestopartida."Id" AS "PresupuestoPartidaId",
    presupuestopartida."Nombre" AS "PresupuestoPartidaNombre",
    presupuestopartida."Descripcion" AS "PresupuestoPartidaDescripcion",
    presupuestopartida."Observaciones" AS "PresupuestoPartidaObservaciones",
    presupuestopartida."IdPadre" AS "PresupuestoPartidaIdPadre",
    presupuestopartida."IdPresupuesto" AS "PresupuestoPartidaIdPresupuesto",
    usuarioregistro."Id" AS "UsuarioRegistroId",
    usuarioregistro."Nombre" AS "UsuarioRegistroNombre",
    usuarioregistro."ApellidoPaterno" AS "UsuarioRegistroApellidoPaterno",
    usuarioregistro."ApellidoMaterno" AS "UsuarioRegistroApellidoMaterno",
    usuariomodifico."Id" AS "UsuarioModificoId",
    usuariomodifico."Nombre" AS "UsuarioModificoNombre",
    usuariomodifico."ApellidoPaterno" AS "UsuarioModificoApellidoPaterno",
    usuariomodifico."ApellidoMaterno" AS "UsuarioModificoApellidoMaterno",
    presupuestoinsumoprecio."Id" AS "PresupuestoInsumoPrecioId",
    presupuestoinsumoprecio."IdInsumo" AS "PresupuestoInsumoPrecioIdInsumo",
    presupuestoinsumoprecio."IdMoneda" AS "PresupuestoInsumoPrecioIdMoneda",
    presupuestoinsumoprecio."IdPresupuesto" AS "PresupuestoInsumoPrecioIdPresupuesto",
    presupuestoinsumoprecio."Precio" AS "PresupuestoInsumoPrecioPrecio"
   FROM "RequisicionesDetalles" detalle
     JOIN "Requisiciones" requisicion ON requisicion."Id" = detalle."IdRequisicion"
     JOIN "ExplosionesInsumosAgrupados" explosioninsumo ON explosioninsumo."Id" = detalle."IdExplosionInsumoAgrupado"
     JOIN "Presupuestos" presupuesto ON presupuesto."Id" = explosioninsumo."IdPresupuesto"
     LEFT JOIN "PresupuestosInsumosPrecios" presupuestoinsumoprecio ON presupuestoinsumoprecio."Id" = explosioninsumo."IdPrecio"
     JOIN "CentrosCostos" centrocosto ON centrocosto."Id" = presupuesto."IdCentroCosto"
     JOIN "CentrosCostos" centrocostoaplicar ON centrocostoaplicar."Id" = requisicion."IdCentroCostoAplicar"
     JOIN "Empresas" empresa ON centrocosto."IdEmpresa" = empresa."Id"
     JOIN "Insumos" insumo ON insumo."Id" = explosioninsumo."IdInsumo"
     JOIN "UnidadesMedidas" unidad ON unidad."Id" = insumo."IdUnidadMedida"
     JOIN "TiposInsumos" tipoinsumo ON tipoinsumo."Id" = insumo."IdTipo"
     JOIN "PresupuestosPartidas" presupuestopartida ON presupuestopartida."Id" = explosioninsumo."IdPresupuestoPartida"
     JOIN "Usuarios" usuarioregistro ON usuarioregistro."Id" = requisicion."IdUsuarioRegistro"
     JOIN "Usuarios" usuariomodifico ON usuariomodifico."Id" = requisicion."IdUsuarioModifico"
  WHERE detalle."Activo" = true AND requisicion."Activo" = true;


-- public.salidasinsumosdetallesview source
DROP VIEW salidasinsumosdetallesview;
CREATE OR REPLACE VIEW public.salidasinsumosdetallesview
AS SELECT detalle."Id",
    detalle."Cantidad",
    detalle."Comentario",
    detalle."IdSalidaInsumo",
    detalle."IdInsumo",
    si."Id" AS "salidaInsumoId",
    si."Folio" AS "salidaInsumoFolio",
    si."Clave" AS "salidaInsumoClave",
    si."IdCentroCosto" AS "salidaInsumoIdCentroCosto",
    si."IdTipoSalida" AS "salidaInsumoIdTipoSalida",
    si."IdProveedor" AS "salidaInsumoIdProveedor",
    si."IdUsuarioRegistro" AS "salidaInsumoIdUsuarioRegistro",
    si."FechaRegistro" AS "salidaInsumoFechaRegistro",
    si."IdUsuarioModifico" AS "salidaInsumoIdUsuarioModifico",
    si."FechaModifico" AS "salidaInsumoFechaModifico",
    si."Activo" AS "salidaInsumoActivo",
    si."IdCentroCostoRecibe" AS "salidaInsumoIdCentroCostoRecibe",
    existencia."Id" AS "ExistenciaId",
    existencia."IdCentroCosto" AS "ExistenciaIdCentroCosto",
    existencia."IdInsumo" AS "ExistenciaIdInsumo",
    existencia."Precio" AS "ExistenciaPrecio",
    existencia."Cantidad" AS "ExistenciaCantidad",
    existencia."CantidadPorDevolverObra" AS "ExistenciaCantidadPorDevolverObra",
    existencia."CantidadPorTraspasar" AS "ExistenciaCantidadPorTraspasar",
    insumo."Id" AS "InsumoId",
    insumo."Nombre" AS "InsumoNombre",
    insumo."Codigo" AS "InsumoCodigo",
    insumo."Descripcion" AS "InsumoDescripcion",
    insumo."IdTipo" AS "InsumoIdTipo",
    insumo."IdCorporativo" AS "InsumoIdCorporativo",
    insumo."IdFamiliaInsumo" AS "InsumoIdFamiliaInsumo",
    insumo."IdUnidadMedida" AS "InsumoIdUnidadMedida",
    insumo."UrlImagen" AS "InsumoUrlImagen",
    unidad."Id" AS "UnidadMedidaId",
    unidad."Nombre" AS "UnidadMedidaNombre",
    unidad."Clave" AS "UnidadMedidaClave",
    unidad."Tipo" AS "UnidadMedidaTipo",
    tipoinsumo."Id" AS "TipoInsumoId",
    tipoinsumo."Nombre" AS "TipoInsumoNombre",
    tipoinsumo."Codigo" AS "TipoInsumoCodigo",
    tipoinsumo."Descripcion" AS "TipoInsumoDescripcion",
    tipoinsumo."ManoDeObra" AS "TipoInsumoManoDeObra",
    tipoinsumo."Financiero" AS "TipoInsumoFinanciero",
    tipoinsumo."Inventariable" AS "TipoInsumoInventariable",
    tipoinsumo."Administrativo" AS "TipoInsumoAdministrativo",
    tipoinsumo."IdCorporativo" AS "TipoInsumoIdCorporativo",
    cc."Id" AS "CentroCostoId",
    cc."IdEmpresa" AS "CentroCostoIdEmpresa",
    cc."Nombre" AS "CentroCostoNombre",
    cc."Codigo" AS "CentroCostoCodigo",
    cc."IdUsuarioRegistro" AS "CentroCostoIdUsuarioRegistro",
    cc."FechaRegistro" AS "CentroCostoFechaRegistro",
    cc."IdUsuarioModifico" AS "CentroCostoIdUsuarioModifico",
    cc."FechaModifico" AS "CentroCostoFechaModifico",
    cc."Activo" AS "CentroCostoActivo",
    cc."IdTipoCentroCosto" AS "CentroCostoIdTipoCentroCosto",
    cc."Descripcion" AS "CentroCostoDescripcion",
    cc."Observaciones" AS "CentroCostoObservaciones",
    cc."FechaInicial" AS "CentroCostoFechaInicial",
    cc."FechaFinal" AS "CentroCostoFechaFinal",
    cc."IdCliente" AS "CentroCostoIdCliente",
    tsi."Id" AS "TipoSalidaInsumoId",
    tsi."Nombre" AS "TipoSalidaInsumoNombre",
    tsi."Tag" AS "TipoSalidaInsumoTag",
    p."Id" AS "ProveedorId",
    p."IdEmpresa" AS "ProveedorIdEmpresa",
    p."IdRegimenFiscal" AS "ProveedorIdRegimenFiscal",
    p."NombreContacto" AS "ProveedorNombreContacto",
    p."NombreComercial" AS "ProveedorNombreComercial",
    p."RazonSocial" AS "ProveedorRazonSocial",
    p."Rfc" AS "ProveedorRfc",
    p."Nombre" AS "ProveedorNombre",
    p."ApellidoPaterno" AS "ProveedorApellidoPaterno",
    p."ApellidoMaterno" AS "ProveedorApellidoMaterno",
    p."Curp" AS "ProveedorCurp",
    p."Telefono1" AS "ProveedorTelefono1",
    p."Telefono2" AS "ProveedorTelefono2",
    p."Email1" AS "ProveedorEmail1",
    p."Email2" AS "ProveedorEmail2",
    ccr."Id" AS "CentroCostoRecibeId",
    ccr."IdEmpresa" AS "CentroCostoRecibeIdEmpresa",
    ccr."Nombre" AS "CentroCostoRecibeNombre",
    ccr."Codigo" AS "CentroCostoRecibeCodigo",
    ccr."IdUsuarioRegistro" AS "CentroCostoRecibeIdUsuarioRegistro",
    ccr."FechaRegistro" AS "CentroCostoRecibeFechaRegistro",
    ccr."IdUsuarioModifico" AS "CentroCostoRecibeIdUsuarioModifico",
    ccr."FechaModifico" AS "CentroCostoRecibeFechaModifico",
    ccr."Activo" AS "CentroCostoRecibeActivo",
    ccr."IdTipoCentroCosto" AS "CentroCostoRecibeIdTipoCentroCosto",
    ccr."Descripcion" AS "CentroCostoRecibeDescripcion",
    ccr."Observaciones" AS "CentroCostoRecibeObservaciones",
    ccr."FechaInicial" AS "CentroCostoRecibeFechaInicial",
    ccr."FechaFinal" AS "CentroCostoRecibeFechaFinal",
    ccr."IdCliente" AS "CentroCostoRecibeIdCliente",
    emp."Id" AS "EmpresaId",
    emp."IdCorporativo" AS "EmpresaIdCorporativo",
    emp."Nombre" AS "EmpresaNombre",
    emp."NombreComercial" AS "EmpresaNombreComercial",
    emp."RazonSocial" AS "EmpresaRazonSocial",
    emp."RFC" AS "EmpresaRFC",
    emp."LogoURL" AS "EmpresaLogoURL",
    emp."IdUsuarioRegistro" AS "EmpresaIdUsuarioRegistro",
    emp."FechaRegistro" AS "EmpresaFechaRegistro",
    emp."IdUsuarioModifico" AS "EmpresaIdUsuarioModifico",
    emp."FechaModifico" AS "EmpresaFechaModifico",
    emp."Activo" AS "EmpresaActivo",
    empccr."Id" AS "EmpresaCentroCostoRecibeId",
    empccr."IdCorporativo" AS "EmpresaCentroCostoRecibeIdCorporativo",
    empccr."Nombre" AS "EmpresaCentroCostoRecibeNombre",
    empccr."NombreComercial" AS "EmpresaCentroCostoRecibeNombreComercial",
    empccr."RazonSocial" AS "EmpresaCentroCostoRecibeRazonSocial",
    empccr."RFC" AS "EmpresaCentroCostoRecibeRFC",
    empccr."LogoURL" AS "EmpresaCentroCostoRecibeLogoURL",
    empccr."IdUsuarioRegistro" AS "EmpresaCentroCostoRecibeIdUsuarioRegistro",
    empccr."FechaRegistro" AS "EmpresaCentroCostoRecibeFechaRegistro",
    empccr."IdUsuarioModifico" AS "EmpresaCentroCostoRecibeIdUsuarioModifico",
    empccr."FechaModifico" AS "EmpresaCentroCostoRecibeFechaModifico",
    empccr."Activo" AS "EmpresaCentroCostoRecibeActivo",
    ur."Id" AS "UsuarioRegistroId",
    ur."IdCorporativo" AS "UsuarioRegistroIdCorporativo",
    ur."IdRol" AS "UsuarioRegistroIdRol",
    ur."Nombre" AS "UsuarioRegistroNombre",
    ur."ApellidoPaterno" AS "UsuarioRegistroApellidoPaterno",
    ur."ApellidoMaterno" AS "UsuarioRegistroApellidoMaterno",
    um."Id" AS "UsuarioModificoId",
    um."IdCorporativo" AS "UsuarioModificoIdCorporativo",
    um."IdRol" AS "UsuarioModificoIdRol",
    um."Nombre" AS "UsuarioModificoNombre",
    um."ApellidoPaterno" AS "UsuarioModificoApellidoPaterno",
    um."ApellidoMaterno" AS "UsuarioModificoApellidoMaterno"
   FROM "SalidasInsumosDetalles" detalle
     JOIN "SalidasInsumos" si ON si."Id" = detalle."IdSalidaInsumo"
     JOIN "CentrosCostosExistenciasInsumos" existencia ON existencia."IdCentroCosto" = si."IdCentroCosto" AND existencia."IdInsumo" = detalle."IdInsumo"
     JOIN "CentrosCostos" cc ON cc."Id" = si."IdCentroCosto"
     JOIN "Empresas" emp ON emp."Id" = cc."IdEmpresa"
     JOIN "TiposSalidasInsumos" tsi ON tsi."Id" = si."IdTipoSalida"
     JOIN "Insumos" insumo ON insumo."Id" = detalle."IdInsumo"
     JOIN "UnidadesMedidas" unidad ON unidad."Id" = insumo."IdUnidadMedida"
     JOIN "TiposInsumos" tipoinsumo ON tipoinsumo."Id" = insumo."IdTipo"
     JOIN "Usuarios" ur ON ur."Id" = si."IdUsuarioRegistro"
     JOIN "Usuarios" um ON um."Id" = si."IdUsuarioModifico"
     LEFT JOIN "Proveedores" p ON p."Id" = si."IdProveedor"
     LEFT JOIN "CentrosCostos" ccr ON ccr."Id" = si."IdCentroCostoRecibe"
     LEFT JOIN "Empresas" empccr ON empccr."Id" = ccr."IdEmpresa"
  WHERE si."Activo" = true;


-- public.tiposconceptosview source
DROP VIEW tiposconceptosview;
CREATE OR REPLACE VIEW public.tiposconceptosview
AS SELECT "TiposConceptos"."Id",
    "TiposConceptos"."IdCorporativo",
    "TiposConceptos"."IdFamiliaConcepto",
    "TiposConceptos"."IdUnidadMedida",
    "TiposConceptos"."Nombre",
    "TiposConceptos"."Descripcion",
    "Corporativos"."Id" AS corporativo_id,
    "Corporativos"."Nombre" AS corporativo_nombre,
    "FamiliasConceptos"."Id" AS familia_concepto_id,
    "FamiliasConceptos"."Nombre" AS familia_concepto_nombre,
    "FamiliasConceptos"."Descripcion" AS familia_concepto_descripcion,
    "UnidadesMedidas"."Id" AS unidad_medida_id,
    "UnidadesMedidas"."Tipo" AS unidad_medida_tipo,
    "UnidadesMedidas"."Clave" AS unidad_medida_clave,
    "UnidadesMedidas"."Nombre" AS unidad_medida_nombre
   FROM "TiposConceptos"
     JOIN "Corporativos" ON "Corporativos"."Id" = "TiposConceptos"."IdCorporativo"
     JOIN "FamiliasConceptos" ON "FamiliasConceptos"."Id" = "TiposConceptos"."IdFamiliaConcepto"
     JOIN "UnidadesMedidas" ON "UnidadesMedidas"."Id" = "TiposConceptos"."IdUnidadMedida";


DROP VIEW deductivasdetallesview;
CREATE OR REPLACE VIEW public.deductivasdetallesview
AS SELECT detalle."Id",
    detalle."IdExplosionInsumo",
    detalle."Cantidad",
    detalle."IdUsuarioRegistro",
    detalle."FechaRegistro",
    detalle."IdUsuarioModifico",
    detalle."FechaModifico",
    detalle."IdDeductivaAgrupador",
    detalle."Precio",
    centrocosto."Id" AS "CentroCostoId",
    centrocosto."Nombre" AS "CentroCostoNombre",
    centrocosto."Codigo" AS "CentroCostoCodigo",
    centrocosto."Descripcion" AS "CentroCostoDescripcion",
    deductiva."Id" AS "DeductivaId",
    deductiva."IdExplosion" AS "DeductivaIdExplosion",
    deductiva."Nombre" AS "DeductivaNombre",
    deductiva."Codigo" AS "DeductivaCodigo",
    deductiva."Descripcion" AS "DeductivaDescripcion",
    deductiva."IdUsuarioRegistro" AS "DeductivaIdUsuarioRegistro",
    deductiva."FechaRegistro" AS "DeductivaFechaRegistro",
    deductiva."IdUsuarioModifico" AS "DeductivaIdUsuarioModifico",
    deductiva."FechaModifico" AS "DeductivaFechaModifico",
    deductiva."Activo" AS "DeductivaActivo",
    deductiva."IdTipo" AS "DeductivaIdTipo",
    explosion."Id" AS "ExplosionId",
    explosion."IdPresupuesto" AS "ExplosionIdPresupuesto",
    explosion."Codigo" AS "ExplosionCodigo",
    explosion."Descripcion" AS "ExplosionDescripcion",
    explosion."IdUsuarioRegistro" AS "ExplosionIdUsuarioRegistro",
    explosion."FechaRegistro" AS "ExplosionFechaRegistro",
    explosion."IdUsuarioModifico" AS "ExplosionIdUsuarioModifico",
    explosion."FechaModifico" AS "ExplosionFechaModifico",
    explosion."Activo" AS "ExplosionActivo",
    explosion."Actualizada" AS "ExplosionActualizada",
    presupuesto."Id" AS "PresupuestoId",
    presupuesto."Nombre" AS "PresupuestoNombre",
    presupuesto."Codigo" AS "PresupuestoCodigo",
    presupuesto."Descripcion" AS "PresupuestoDescripcion",
    presupuesto."IdEmpresa" AS "PresupuestoIdEmpresa",
    presupuesto."IdClasificadorPresupuesto" AS "PresupuestoIdClasificadorPresupuesto",
    presupuesto."Email" AS "PresupuestoEmail",
    presupuesto."IdCentroCosto" AS "PresupuestoIdCentroCosto",
    presupuesto."IdResponsable" AS "PresupuestoIdResponsable",
    presupuesto."IdTipo" AS "PresupuestoIdTipo",
    presupuesto."Observaciones" AS "PresupuestoObservaciones",
    explosioninsumo."Id" AS "ExplosionInsumoId",
    explosioninsumo."IdExplosion" AS "ExplosionInsumoIdExplosion",
    explosioninsumo."IdPresupuesto" AS "ExplosionInsumoIdPresupuesto",
    explosioninsumo."IdPresupuestoConcepto" AS "ExplosionInsumoIdPresupuestoConcepto",
    explosioninsumo."IdInsumo" AS "ExplosionInsumoIdInsumo",
    explosioninsumo."Cantidad" AS "ExplosionInsumoCantidad",
    explosioninsumo."IdPrecio" AS "ExplosionInsumoIdPrecio",
    insumo."Id" AS "InsumoId",
    insumo."Nombre" AS "InsumoNombre",
    insumo."Codigo" AS "InsumoCodigo",
    tipoinsumo."Id" AS "TipoInsumoId",
    tipoinsumo."Nombre" AS "TipoInsumoNombre",
    tipoinsumo."Codigo" AS "TipoInsumoCodigo",
    tipoinsumo."Descripcion" AS "TipoInsumoDescripcion",
    unidadmedida."Id" AS "UnidadMedidaId",
    unidadmedida."Nombre" AS "UnidadMedidaNombre",
    unidadmedida."Clave" AS "UnidadMedidaClave",
    unidadmedida."Tipo" AS "UnidadMedidaTipo",
    familiainsumo."Id" AS "FamiliaInsumoId",
    familiainsumo."Nombre" AS "FamiliaInsumoNombre",
    familiainsumo."Codigo" AS "FamiliaInsumoCodigo",
    familiainsumo."Descripcion" AS "FamiliaInsumoDescripcion",
    presupuestopartida."Id" AS "PresupuestoPartidaId",
    presupuestopartida."Nombre" AS "PresupuestoPartidaNombre",
    presupuestopartida."Descripcion" AS "PresupuestoPartidaDescripcion",
    presupuestopartida."Observaciones" AS "PresupuestoPartidaObservaciones",
    presupuestoconcepto."Id" AS "PresupuestoConceptoId",
    presupuestoconcepto."Nombre" AS "PresupuestoConceptoNombre",
    presupuestoconcepto."Codigo" AS "PresupuestoConceptoCodigo",
    presupuestoconcepto."Descripcion" AS "PresupuestoConceptoDescripcion",
    presupuestoinsumoprecio."Id" AS "PresupuestoInsumoPrecioId",
    presupuestoinsumoprecio."IdInsumo" AS "PresupuestoInsumoPrecioIdInsumo",
    presupuestoinsumoprecio."IdMoneda" AS "PresupuestoInsumoPrecioIdMoneda",
    presupuestoinsumoprecio."IdPresupuesto" AS "PresupuestoInsumoPrecioIdPresupuesto",
    presupuestoinsumoprecio."Precio" AS "PresupuestoInsumoPrecioPrecio",
    usuarioregistro."Id" AS "UsuarioRegistroId",
    usuarioregistro."Nombre" AS "UsuarioRegistroNombre",
    usuarioregistro."ApellidoPaterno" AS "UsuarioRegistroApellidoPaterno",
    usuarioregistro."ApellidoMaterno" AS "UsuarioRegistroApellidoMaterno",
    usuariomodifico."Id" AS "UsuarioModificoId",
    usuariomodifico."Nombre" AS "UsuarioModificoNombre",
    usuariomodifico."ApellidoPaterno" AS "UsuarioModificoApellidoPaterno",
    usuariomodifico."ApellidoMaterno" AS "UsuarioModificoApellidoMaterno"
   FROM "DeductivasDetalles" detalle
     JOIN "Deductivas" deductiva ON deductiva."Id" = detalle."IdDeductivaAgrupador"
     JOIN "Explosiones" explosion ON explosion."Id" = deductiva."IdExplosion"
     JOIN "Presupuestos" presupuesto ON presupuesto."Id" = explosion."IdPresupuesto"
     JOIN "CentrosCostos" centrocosto ON centrocosto."Id" = presupuesto."IdCentroCosto"
     LEFT JOIN "ExplosionesInsumos" explosioninsumo ON explosioninsumo."Id" = detalle."IdExplosionInsumo"
     LEFT JOIN "PresupuestosInsumosPrecios" presupuestoinsumoprecio ON presupuestoinsumoprecio."Id" = explosioninsumo."IdPrecio"
     LEFT JOIN "PresupuestosConceptos" presupuestoconcepto ON presupuestoconcepto."Id" = explosioninsumo."IdPresupuestoConcepto"
     LEFT JOIN "PresupuestosPartidas" presupuestopartida ON presupuestopartida."Id" = presupuestoconcepto."IdPartida"
     LEFT JOIN "Insumos" insumo ON insumo."Id" = explosioninsumo."IdInsumo"
     LEFT JOIN "TiposInsumos" tipoinsumo ON tipoinsumo."Id" = insumo."IdTipo"
     LEFT JOIN "UnidadesMedidas" unidadmedida ON unidadmedida."Id" = insumo."IdUnidadMedida"
     LEFT JOIN "FamiliasInsumos" familiainsumo ON familiainsumo."Id" = insumo."IdFamiliaInsumo"
     JOIN "Usuarios" usuarioregistro ON usuarioregistro."Id" = detalle."IdUsuarioRegistro"
     JOIN "Usuarios" usuariomodifico ON usuariomodifico."Id" = detalle."IdUsuarioModifico";


-- public.estimacionesinsumosdetallesview source
DROP VIEW estimacionesinsumosdetallesview;
CREATE OR REPLACE VIEW public.estimacionesinsumosdetallesview
AS SELECT detalle."Id",
    detalle."IdEstimacionInsumo",
    detalle."IdFrente",
    detalle."Cantidad",
    detalle."Observaciones",
    detalle."IdUsuarioRegistro",
    detalle."FechaRegistro",
    detalle."IdProveedorRegistro",
    frente."Id" AS "FrenteId",
    frente."Codigo" AS "FrenteCodigo",
    frente."IdCentroCosto" AS "FrenteIdCentroCosto",
    frente."Nombre" AS "FrenteNombre",
    frente."Descripcion" AS "FrenteDescripcion",
    frente."IdUsuarioRegistro" AS "FrenteIdUsuarioRegistro",
    frente."FechaRegistro" AS "FrenteFechaRegistro",
    frente."IdUsuarioModifico" AS "FrenteIdUsuarioModifico",
    frente."FechaModifico" AS "FrenteFechaModifico",
    frente."Activo" AS "FrenteActivo",
    estimacioninsumo."Id" AS "EstimacionInsumoId",
    estimacioninsumo."IdEstimacion" AS "EstimacionInsumoIdEstimacion",
    estimacioninsumo."IdSubcontratoDetalle" AS "EstimacionInsumoIdSubcontratoDetalle",
    estimacioninsumo."Observaciones" AS "EstimacionInsumoObservaciones",
    estimacioninsumo."IdUsuarioRegistro" AS "EstimacionInsumoIdUsuarioRegistro",
    estimacioninsumo."FechaRegistro" AS "EstimacionInsumoFechaRegistro",
    estimacion."Id" AS "EstimacionId",
    estimacion."IdCentroCosto" AS "EstimacionIdCentroCosto",
    estimacion."IdCentroCostoAplica" AS "EstimacionIdCentroCostoAplica",
    estimacion."Folio" AS "EstimacionFolio",
    estimacion."IdProveedor" AS "EstimacionIdProveedor",
    estimacion."IdProveedorAplica" AS "EstimacionIdProveedorAplica",
    estimacion."IdSubcontrato" AS "EstimacionIdSubcontrato",
    estimacion."Observaciones" AS "EstimacionObservaciones",
    estimacion."IdUsuarioRegistro" AS "EstimacionIdUsuarioRegistro",
    estimacion."FechaRegistro" AS "EstimacionFechaRegistro",
    estimacion."IdUsuarioModifico" AS "EstimacionIdUsuarioModifico",
    estimacion."FechaModifico" AS "EstimacionFechaModifico",
    estimacion."Activo" AS "EstimacionActivo",
    estimacion."Clave" AS "EstimacionClave",
    estimacion."FechaInicial" AS "EstimacionFechaInicial",
    estimacion."FechaFinal" AS "EstimacionFechaFinal",
    subcontratodetalle."Id" AS "SubcontratoDetalleId",
    subcontratodetalle."IdExplosionInsumo" AS "SubcontratoDetalleIdExplosionInsumo",
    subcontratodetalle."IdExplosionSubcontrato" AS "SubcontratoDetalleIdExplosionSubcontrato",
    subcontratodetalle."Cantidad" AS "SubcontratoDetalleCantidad",
    subcontratodetalle."Observaciones" AS "SubcontratoDetalleObservaciones",
    subcontratodetalle."Precio" AS "SubcontratoDetallePrecio",
    subcontratodetalle."IdUsuarioRegistro" AS "SubcontratoDetalleIdUsuarioRegistro",
    subcontratodetalle."FechaRegistro" AS "SubcontratoDetalleFechaRegistro",
    subcontratodetalle."IdUsuarioModifico" AS "SubcontratoDetalleIdUsuarioModifico",
    subcontratodetalle."FechaModifico" AS "SubcontratoDetalleFechaModifico",
    subcontratodetalle."Activo" AS "SubcontratoDetalleActivo",
    empresa."Id" AS "EmpresaId",
    empresa."Nombre" AS "EmpresaNombre",
    empresa."NombreComercial" AS "EmpresaNombreComercial",
    empresa."RazonSocial" AS "EmpresaRazonSocial",
    empresa."RFC" AS "EmpresaRfc",
    presupuesto."Id" AS "PresupuestoId",
    presupuesto."Codigo" AS "PresupuestoCodigo",
    presupuesto."Nombre" AS "PresupuestoNombre",
    presupuesto."IdEmpresa" AS "PresupuestoIdEmpresa",
    centrocosto."Id" AS "CentroCostoId",
    centrocosto."Nombre" AS "CentroCostoNombre",
    centrocosto."Codigo" AS "CentroCostoCodigo",
    centrocosto."Descripcion" AS "CentroCostoDescripcion",
    explosioninsumo."Id" AS "ExplosionInsumoId",
    explosioninsumo."IdExplosion" AS "ExplosionInsumoIdExplosion",
    explosioninsumo."IdPresupuesto" AS "ExplosionInsumoIdPresupuesto",
    explosioninsumo."IdPresupuestoConcepto" AS "ExplosionInsumoIdPresupuestoConcepto",
    explosioninsumo."IdInsumo" AS "ExplosionInsumoIdInsumo",
    explosioninsumo."Cantidad" AS "ExplosionInsumoCantidad",
    explosioninsumo."IdPrecio" AS "ExplosionInsumoIdPrecio",
    explosioninsumo."IdUsuarioRegistro" AS "ExplosionInsumoIdUsuarioRegistro",
    explosioninsumo."FechaRegistro" AS "ExplosionInsumoFechaRegistro",
    explosioninsumo."IdUsuarioModifico" AS "ExplosionInsumoIdUsuarioModifico",
    explosioninsumo."FechaModifico" AS "ExplosionInsumoFechaModifico",
    explosioninsumo."Autorizado" AS "ExplosionInsumoAutorizado",
    explosioninsumo."Contratable" AS "ExplosionInsumoContratable",
    explosioninsumo."NoConsiderado" AS "ExplosionInsumoNoConsiderado",
    insumo."Id" AS "InsumoId",
    insumo."Nombre" AS "InsumoNombre",
    insumo."Codigo" AS "InsumoCodigo",
    insumo."Descripcion" AS "InsumoDescripcion",
    insumo."IdTipo" AS "InsumoIdTipo",
    insumo."IdCorporativo" AS "InsumoIdCorporativo",
    insumo."IdFamiliaInsumo" AS "InsumoIdFamiliaInsumo",
    insumo."IdUnidadMedida" AS "InsumoIdUnidadMedida",
    insumo."UrlImagen" AS "InsumoUrlImagen",
    unidad."Id" AS "UnidadMedidaId",
    unidad."Nombre" AS "UnidadMedidaNombre",
    unidad."Clave" AS "UnidadMedidaClave",
    unidad."Tipo" AS "UnidadMedidaTipo",
    tipoinsumo."Id" AS "TipoInsumoId",
    tipoinsumo."Nombre" AS "TipoInsumoNombre",
    tipoinsumo."Codigo" AS "TipoInsumoCodigo",
    tipoinsumo."Descripcion" AS "TipoInsumoDescripcion",
    tipoinsumo."ManoDeObra" AS "TipoInsumoManoDeObra",
    tipoinsumo."Financiero" AS "TipoInsumoFinanciero",
    tipoinsumo."Inventariable" AS "TipoInsumoInventariable",
    tipoinsumo."Administrativo" AS "TipoInsumoAdministrativo",
    tipoinsumo."IdCorporativo" AS "TipoInsumoIdCorporativo",
    presupuestoconcepto."Id" AS "PresupuestoConceptoId",
    presupuestoconcepto."IdPresupuesto" AS "PresupuestoConceptoIdPresupuesto",
    presupuestoconcepto."IdPartida" AS "PresupuestoConceptoIdPartida",
    presupuestoconcepto."IdMoneda" AS "PresupuestoConceptoIdMoneda",
    presupuestoconcepto."Codigo" AS "PresupuestoConceptoCodigo",
    presupuestoconcepto."Descripcion" AS "PresupuestoConceptoDescripcion",
    presupuestoconcepto."Cantidad" AS "PresupuestoConceptoCantidad",
    presupuestoconcepto."Precio" AS "PresupuestoConceptoPrecio",
    presupuestoconcepto."IdTipoConcepto" AS "PresupuestoConceptoIdTipoConcepto",
    presupuestoconcepto."Nombre" AS "PresupuestoConceptoNombre",
    presupuestopartida."Id" AS "PresupuestoPartidaId",
    presupuestopartida."Nombre" AS "PresupuestoPartidaNombre",
    presupuestopartida."Descripcion" AS "PresupuestoPartidaDescripcion",
    presupuestopartida."Observaciones" AS "PresupuestoPartidaObservaciones",
    presupuestopartida."IdPadre" AS "PresupuestoPartidaIdPadre",
    presupuestopartida."IdPresupuesto" AS "PresupuestoPartidaIdPresupuesto",
    usuarioregistro."Id" AS "UsuarioRegistroId",
    usuarioregistro."Nombre" AS "UsuarioRegistroNombre",
    usuarioregistro."ApellidoPaterno" AS "UsuarioRegistroApellidoPaterno",
    usuarioregistro."ApellidoMaterno" AS "UsuarioRegistroApellidoMaterno",
    presupuestoinsumoprecio."Id" AS "PresupuestoInsumoPrecioId",
    presupuestoinsumoprecio."IdInsumo" AS "PresupuestoInsumoPrecioIdInsumo",
    presupuestoinsumoprecio."IdMoneda" AS "PresupuestoInsumoPrecioIdMoneda",
    presupuestoinsumoprecio."IdPresupuesto" AS "PresupuestoInsumoPrecioIdPresupuesto",
    presupuestoinsumoprecio."Precio" AS "PresupuestoInsumoPrecioPrecio",
    proveedorregistro."RazonSocial" AS "ProveedorRegistroRazonSocial",
    proveedorregistro."NombreComercial" AS "ProveedorRegistroNombreComercial",
    proveedorregistro."Rfc" AS "ProveedorRegistroRfc"
   FROM "EstimacionesInsumosDetalles" detalle
     JOIN "EstimacionesInsumos" estimacioninsumo ON estimacioninsumo."Id" = detalle."IdEstimacionInsumo"
     JOIN "Estimaciones" estimacion ON estimacion."Id" = estimacioninsumo."IdEstimacion"
     JOIN "Frentes" frente ON frente."Id" = detalle."IdFrente"
     JOIN "ExplosionesSubcontratosDetalles" subcontratodetalle ON subcontratodetalle."Id" = estimacioninsumo."IdSubcontratoDetalle"
     JOIN "ExplosionesInsumos" explosioninsumo ON explosioninsumo."Id" = subcontratodetalle."IdExplosionInsumo"
     JOIN "Presupuestos" presupuesto ON presupuesto."Id" = explosioninsumo."IdPresupuesto"
     LEFT JOIN "PresupuestosInsumosPrecios" presupuestoinsumoprecio ON presupuestoinsumoprecio."Id" = explosioninsumo."IdPrecio"
     JOIN "CentrosCostos" centrocosto ON centrocosto."Id" = presupuesto."IdCentroCosto"
     JOIN "Empresas" empresa ON centrocosto."IdEmpresa" = empresa."Id"
     JOIN "Insumos" insumo ON insumo."Id" = explosioninsumo."IdInsumo"
     JOIN "UnidadesMedidas" unidad ON unidad."Id" = insumo."IdUnidadMedida"
     JOIN "TiposInsumos" tipoinsumo ON tipoinsumo."Id" = insumo."IdTipo"
     JOIN "PresupuestosConceptos" presupuestoconcepto ON presupuestoconcepto."Id" = explosioninsumo."IdPresupuestoConcepto"
     JOIN "PresupuestosPartidas" presupuestopartida ON presupuestopartida."Id" = presupuestoconcepto."IdPartida"
     LEFT JOIN "Usuarios" usuarioregistro ON usuarioregistro."Id" = detalle."IdUsuarioRegistro"
     LEFT JOIN "Proveedores" proveedorregistro ON proveedorregistro."Id" = detalle."IdProveedorRegistro"
  WHERE estimacion."Activo" = true;


-- public.recepcioninsumosagrupadosdetallesview source
DROP VIEW recepcioninsumosagrupadosdetallesview;
CREATE OR REPLACE VIEW public.recepcioninsumosagrupadosdetallesview
AS SELECT rid."Id",
    rid."Cantidad",
    rid."Comentario",
    rid."IdRecepcionInsumo",
    rid."IdCentroCostoRecibe",
    rid."IdTipo",
    rid."IdInsumo",
    rid."IdOrdenCompraDetalle",
    rid."UrlDocumento",
    cc."Id" AS "CentroCostoRecibeId",
    cc."IdEmpresa" AS "CentroCostoRecibeIdempresa",
    cc."Nombre" AS "CentroCostoRecibeNombre",
    cc."Codigo" AS "CentroCostoRecibeCodigo",
    cc."IdTipoCentroCosto" AS "CentroCostoRecibeIdtipocentrocosto",
    cc."Descripcion" AS "CentroCostoRecibeDescripcion",
    cc."Observaciones" AS "CentroCostoRecibeObservaciones",
    cc."IdCliente" AS "CentroCostoRecibeIdcliente",
    i."Id" AS "InsumoId",
    i."IdCorporativo" AS "InsumoIdcorporativo",
    i."IdTipo" AS "InsumoIdtipo",
    i."IdFamiliaInsumo" AS "InsumoIdfamiliainsumo",
    i."IdUnidadMedida" AS "InsumoIdunidadmedida",
    i."Codigo" AS "InsumoCodigo",
    i."Nombre" AS "InsumoNombre",
    i."Descripcion" AS "InsumoDescripcion",
    um."Id" AS "UnidadMedidaId",
    um."Tipo" AS "UnidadMedidaTipo",
    um."Clave" AS "UnidadMedidaClave",
    um."Nombre" AS "UnidadMedidaNombre",
    ri."Id" AS "RecepcionInsumoId",
    ri."Folio" AS "RecepcionInsumoFolio",
    ri."Clave" AS "RecepcionInsumoClave",
    ri."IdCentroCosto" AS "RecepcionInsumoIdcentrocosto",
    tri."Id" AS "TiposRecepcionesInsumosId",
    tri."Nombre" AS "TiposRecepcionesInsumosNombre",
    ocd."Id" AS "OrdenCompraDetalleId",
    ocd."IdOrdenCompra" AS "OrdenCompraDetalleIdordencompra",
    ocd."IdRequisicionDetalle" AS "OrdenCompraDetalleIdrequisiciondetalle",
    ocd."IdPresupuestoMoneda" AS "OrdenCompraDetalleIdpresupuestomoneda",
    ocd."Cantidad" AS "OrdenCompraDetalleCantidad",
    ocd."Precio" AS "OrdenCompraDetallePrecio",
    ocd."IdDivisa" AS "OrdenCompraDetalleIddivisa",
    ocd."Observaciones" AS "OrdenCompraDetalleObservaciones",
    rd."Id" AS "RequisicionDetalleId",
    rd."IdRequisicion" AS "RequisicionDetalleIdrequisicion",
    rd."IdExplosionInsumoAgrupado" AS "RequisicionDetalleIdexplosioninsumo",
    rd."CantidadRequerir" AS "RequisicionDetalleCantidadrequerir",
    rd."Observaciones" AS "RequisicionDetalleObservaciones",
    eim."Id" AS "ExplosionesInsumosMovimientosId",
    eim."IdExplosion" AS "ExplosionesInsumosMovimientosIdExplosion",
    eim."IdExplosionInsumoAgrupado" AS "ExplosionesInsumosMovimientosIdExplosionInsumo",
    eim."CantidadOriginal" AS "ExplosionesInsumosMovimientosCantidadOriginal",
    eim."IdPrecioOriginal" AS "ExplosionesInsumosMovimientosIdPrecioOriginal",
    eim."CantidadAditiva" AS "ExplosionesInsumosMovimientosCantidadAditiva",
    eim."PrecioAditiva" AS "ExplosionesInsumosMovimientosPrecioAditiva",
    eim."CantidadDeductiva" AS "ExplosionesInsumosMovimientosCantidadDeductiva",
    eim."PrecioDeductiva" AS "ExplosionesInsumosMovimientosPrecioDeductiva",
    eim."CantidadActual" AS "ExplosionesInsumosMovimientosCantidadActual",
    eim."PrecioActual" AS "ExplosionesInsumosMovimientosPrecioActual",
    eim."ImporteActual" AS "ExplosionesInsumosMovimientosImporteActual",
    eim."CantidadRequisicion" AS "ExplosionesInsumosMovimientosCantidadRequisicion",
    eim."CantidadContratada" AS "ExplosionesInsumosMovimientosCantidadContratada",
    eim."AvanceAcumulado" AS "ExplosionesInsumosMovimientosAvanceAcumulado",
    eim."EstimadoAcumulado" AS "ExplosionesInsumosMovimientosEstimadoAcumulado",
    eim."CantidadComprada" AS "ExplosionesInsumosMovimientosCantidadComprada",
    eim."CantidadRecepcion" AS "ExplosionesInsumosMovimientosCantidadRecepcion",
    oc."Id" AS "OrdenesComprasId",
    oc."IdEmpresa" AS "OrdenesComprasIdEmpresa",
    oc."IdProveedor" AS "OrdenesComprasIdProveedor",
    oc."Folio" AS "OrdenesComprasFolio",
    oc."Clave" AS "OrdenesComprasClave",
    oc."FechaRegistro" AS "OrdenesComprasFechaRegistro",
    p."NombreContacto" AS "ProveedoresNombreContacto",
    p."NombreComercial" AS "ProveedoresNombreComercial",
    p."RazonSocial" AS "ProveedoresRazonSocial",
    p."Rfc" AS "ProveedoresRfc",
    p."Nombre" AS "ProveedoresNombre",
    p."ApellidoPaterno" AS "ProveedoresApellidoPaterno",
    p."ApellidoMaterno" AS "ProveedoresApellidoMaterno",
    ccei."Id" AS "ExistenciaId",
    ccei."IdCentroCosto" AS "ExistenciaIdCentroCosto",
    ccei."IdInsumo" AS "ExistenciaIdInsumo",
    ccei."Cantidad" AS "ExistenciaCantidad",
    ccei."Precio" AS "ExistenciaPrecio",
    ccei."CantidadPorDevolverObra" AS "ExistenciaCantidadPorDevolverObra",
    ccei."CantidadPorTraspasar" AS "ExistenciaCantidadPorTraspasar"
   FROM "RecepcionesInsumosDetalles" rid
     JOIN "CentrosCostos" cc ON rid."IdCentroCostoRecibe" = cc."Id"
     JOIN "Insumos" i ON rid."IdInsumo" = i."Id"
     JOIN "UnidadesMedidas" um ON i."IdUnidadMedida" = um."Id"
     JOIN "RecepcionesInsumos" ri ON ri."Id" = rid."IdRecepcionInsumo"
     JOIN "TiposRecepcionesInsumos" tri ON tri."Id" = rid."IdTipo"
     LEFT JOIN "OrdenesComprasDetalles" ocd ON rid."IdOrdenCompraDetalle" = ocd."Id"
     LEFT JOIN "RequisicionesDetalles" rd ON ocd."IdRequisicionDetalle" = rd."Id"
     LEFT JOIN "ExplosionesInsumosAgrupados" ei ON rd."IdExplosionInsumoAgrupado" = ei."Id"
     LEFT JOIN "ExplosionesInsumosAgrupadosMovimientos" eim ON ei."Id" = eim."IdExplosionInsumoAgrupado"
     LEFT JOIN "OrdenesCompras" oc ON ocd."IdOrdenCompra" = oc."Id"
     LEFT JOIN "Proveedores" p ON p."Id" = oc."IdProveedor"
     LEFT JOIN "CentrosCostosExistenciasInsumos" ccei ON ccei."IdCentroCosto" = cc."Id" AND ccei."IdInsumo" = rid."IdInsumo"
  WHERE ri."Activo";


-- public.estimacionesinsumosview source
DROP VIEW estimacionesinsumosview;
CREATE OR REPLACE VIEW public.estimacionesinsumosview
AS SELECT detalle."Id",
    detalle."IdEstimacion",
    detalle."IdSubcontratoDetalle",
    detalle."Observaciones",
    detalle."IdUsuarioRegistro",
    detalle."FechaRegistro",
    detalle."IdProveedorRegistro",
    estimacion."Id" AS "EstimacionId",
    estimacion."IdCentroCosto" AS "EstimacionIdCentroCosto",
    estimacion."IdCentroCostoAplica" AS "EstimacionIdCentroCostoAplica",
    estimacion."Folio" AS "EstimacionFolio",
    estimacion."IdProveedor" AS "EstimacionIdProveedor",
    estimacion."IdProveedorAplica" AS "EstimacionIdProveedorAplica",
    estimacion."IdSubcontrato" AS "EstimacionIdSubcontrato",
    estimacion."Observaciones" AS "EstimacionObservaciones",
    estimacion."IdUsuarioRegistro" AS "EstimacionIdUsuarioRegistro",
    estimacion."FechaRegistro" AS "EstimacionFechaRegistro",
    estimacion."IdUsuarioModifico" AS "EstimacionIdUsuarioModifico",
    estimacion."FechaModifico" AS "EstimacionFechaModifico",
    estimacion."Activo" AS "EstimacionActivo",
    estimacion."Clave" AS "EstimacionClave",
    estimacion."FechaInicial" AS "EstimacionFechaInicial",
    estimacion."FechaFinal" AS "EstimacionFechaFinal",
    estimacion."IdProveedorRegistro" AS "EstimacionIdProveedorRegistro",
    subcontratodetalle."Id" AS "SubcontratoDetalleId",
    subcontratodetalle."IdExplosionInsumo" AS "SubcontratoDetalleIdExplosionInsumo",
    subcontratodetalle."IdExplosionSubcontrato" AS "SubcontratoDetalleIdExplosionSubcontrato",
    subcontratodetalle."Cantidad" AS "SubcontratoDetalleCantidad",
    subcontratodetalle."Observaciones" AS "SubcontratoDetalleObservaciones",
    subcontratodetalle."Precio" AS "SubcontratoDetallePrecio",
    subcontratodetalle."IdUsuarioRegistro" AS "SubcontratoDetalleIdUsuarioRegistro",
    subcontratodetalle."FechaRegistro" AS "SubcontratoDetalleFechaRegistro",
    subcontratodetalle."IdUsuarioModifico" AS "SubcontratoDetalleIdUsuarioModifico",
    subcontratodetalle."FechaModifico" AS "SubcontratoDetalleFechaModifico",
    subcontratodetalle."Activo" AS "SubcontratoDetalleActivo",
    empresa."Id" AS "EmpresaId",
    empresa."Nombre" AS "EmpresaNombre",
    empresa."NombreComercial" AS "EmpresaNombreComercial",
    empresa."RazonSocial" AS "EmpresaRazonSocial",
    empresa."RFC" AS "EmpresaRfc",
    presupuesto."Id" AS "PresupuestoId",
    presupuesto."Codigo" AS "PresupuestoCodigo",
    presupuesto."Nombre" AS "PresupuestoNombre",
    presupuesto."IdEmpresa" AS "PresupuestoIdEmpresa",
    explosioninsumo."Id" AS "ExplosionInsumoId",
    explosioninsumo."IdExplosion" AS "ExplosionInsumoIdExplosion",
    explosioninsumo."IdPresupuesto" AS "ExplosionInsumoIdPresupuesto",
    explosioninsumo."IdPresupuestoConcepto" AS "ExplosionInsumoIdPresupuestoConcepto",
    explosioninsumo."IdInsumo" AS "ExplosionInsumoIdInsumo",
    explosioninsumo."Cantidad" AS "ExplosionInsumoCantidad",
    explosioninsumo."IdPrecio" AS "ExplosionInsumoIdPrecio",
    explosioninsumo."IdUsuarioRegistro" AS "ExplosionInsumoIdUsuarioRegistro",
    explosioninsumo."FechaRegistro" AS "ExplosionInsumoFechaRegistro",
    explosioninsumo."IdUsuarioModifico" AS "ExplosionInsumoIdUsuarioModifico",
    explosioninsumo."FechaModifico" AS "ExplosionInsumoFechaModifico",
    explosioninsumo."Autorizado" AS "ExplosionInsumoAutorizado",
    explosioninsumo."Contratable" AS "ExplosionInsumoContratable",
    explosioninsumo."NoConsiderado" AS "ExplosionInsumoNoConsiderado",
    insumo."Id" AS "InsumoId",
    insumo."Nombre" AS "InsumoNombre",
    insumo."Codigo" AS "InsumoCodigo",
    insumo."Descripcion" AS "InsumoDescripcion",
    insumo."IdTipo" AS "InsumoIdTipo",
    insumo."IdCorporativo" AS "InsumoIdCorporativo",
    insumo."IdFamiliaInsumo" AS "InsumoIdFamiliaInsumo",
    insumo."IdUnidadMedida" AS "InsumoIdUnidadMedida",
    insumo."UrlImagen" AS "InsumoUrlImagen",
    unidad."Id" AS "UnidadMedidaId",
    unidad."Nombre" AS "UnidadMedidaNombre",
    unidad."Clave" AS "UnidadMedidaClave",
    unidad."Tipo" AS "UnidadMedidaTipo",
    tipoinsumo."Id" AS "TipoInsumoId",
    tipoinsumo."Nombre" AS "TipoInsumoNombre",
    tipoinsumo."Codigo" AS "TipoInsumoCodigo",
    tipoinsumo."Descripcion" AS "TipoInsumoDescripcion",
    tipoinsumo."ManoDeObra" AS "TipoInsumoManoDeObra",
    tipoinsumo."Financiero" AS "TipoInsumoFinanciero",
    tipoinsumo."Inventariable" AS "TipoInsumoInventariable",
    tipoinsumo."Administrativo" AS "TipoInsumoAdministrativo",
    tipoinsumo."IdCorporativo" AS "TipoInsumoIdCorporativo",
    presupuestoconcepto."Id" AS "PresupuestoConceptoId",
    presupuestoconcepto."IdPresupuesto" AS "PresupuestoConceptoIdPresupuesto",
    presupuestoconcepto."IdPartida" AS "PresupuestoConceptoIdPartida",
    presupuestoconcepto."IdMoneda" AS "PresupuestoConceptoIdMoneda",
    presupuestoconcepto."Codigo" AS "PresupuestoConceptoCodigo",
    presupuestoconcepto."Descripcion" AS "PresupuestoConceptoDescripcion",
    presupuestoconcepto."Cantidad" AS "PresupuestoConceptoCantidad",
    presupuestoconcepto."Precio" AS "PresupuestoConceptoPrecio",
    presupuestoconcepto."IdTipoConcepto" AS "PresupuestoConceptoIdTipoConcepto",
    presupuestoconcepto."Nombre" AS "PresupuestoConceptoNombre",
    presupuestopartida."Id" AS "PresupuestoPartidaId",
    presupuestopartida."Nombre" AS "PresupuestoPartidaNombre",
    presupuestopartida."Descripcion" AS "PresupuestoPartidaDescripcion",
    presupuestopartida."Observaciones" AS "PresupuestoPartidaObservaciones",
    presupuestopartida."IdPadre" AS "PresupuestoPartidaIdPadre",
    presupuestopartida."IdPresupuesto" AS "PresupuestoPartidaIdPresupuesto",
    usuarioregistro."Id" AS "UsuarioRegistroId",
    usuarioregistro."Nombre" AS "UsuarioRegistroNombre",
    usuarioregistro."ApellidoPaterno" AS "UsuarioRegistroApellidoPaterno",
    usuarioregistro."ApellidoMaterno" AS "UsuarioRegistroApellidoMaterno",
    presupuestoinsumoprecio."Id" AS "PresupuestoInsumoPrecioId",
    presupuestoinsumoprecio."IdInsumo" AS "PresupuestoInsumoPrecioIdInsumo",
    presupuestoinsumoprecio."IdMoneda" AS "PresupuestoInsumoPrecioIdMoneda",
    presupuestoinsumoprecio."IdPresupuesto" AS "PresupuestoInsumoPrecioIdPresupuesto",
    presupuestoinsumoprecio."Precio" AS "PresupuestoInsumoPrecioPrecio",
    moneda."Id" AS "MonedaId",
    moneda."Clave" AS "MonedaClave",
    moneda."Nombre" AS "MonedaNombre",
    moneda."IdUsuarioRegistro" AS "MonedaIdUsuarioRegistro",
    moneda."FechaRegistro" AS "MonedaFechaRegistro",
    moneda."IdUsuarioModifico" AS "MonedaIdUsuarioModifico",
    moneda."FechaModifico" AS "MonedaFechaModifico",
    moneda."Activo" AS "MonedaActivo",
    proveedorregistro."RazonSocial" AS "ProveedorRegistroRazonSocial",
    proveedorregistro."NombreComercial" AS "ProveedorRegistroNombreComercial",
    proveedorregistro."Rfc" AS "ProveedorRegistroRfc"
   FROM "EstimacionesInsumos" detalle
     JOIN "Estimaciones" estimacion ON estimacion."Id" = detalle."IdEstimacion"
     JOIN "ExplosionesSubcontratosDetalles" subcontratodetalle ON subcontratodetalle."Id" = detalle."IdSubcontratoDetalle"
     JOIN "ExplosionesInsumos" explosioninsumo ON explosioninsumo."Id" = subcontratodetalle."IdExplosionInsumo"
     JOIN "Presupuestos" presupuesto ON presupuesto."Id" = explosioninsumo."IdPresupuesto"
     LEFT JOIN "PresupuestosInsumosPrecios" presupuestoinsumoprecio ON presupuestoinsumoprecio."Id" = explosioninsumo."IdPrecio"
     LEFT JOIN "Monedas" moneda ON moneda."Id" = presupuestoinsumoprecio."IdMoneda"
     JOIN "CentrosCostos" centrocosto ON centrocosto."Id" = presupuesto."IdCentroCosto"
     JOIN "Empresas" empresa ON centrocosto."IdEmpresa" = empresa."Id"
     JOIN "Insumos" insumo ON insumo."Id" = explosioninsumo."IdInsumo"
     JOIN "UnidadesMedidas" unidad ON unidad."Id" = insumo."IdUnidadMedida"
     JOIN "TiposInsumos" tipoinsumo ON tipoinsumo."Id" = insumo."IdTipo"
     JOIN "PresupuestosConceptos" presupuestoconcepto ON presupuestoconcepto."Id" = explosioninsumo."IdPresupuestoConcepto"
     JOIN "PresupuestosPartidas" presupuestopartida ON presupuestopartida."Id" = presupuestoconcepto."IdPartida"
     LEFT JOIN "Usuarios" usuarioregistro ON usuarioregistro."Id" = detalle."IdUsuarioRegistro"
     LEFT JOIN "Proveedores" proveedorregistro ON proveedorregistro."Id" = detalle."IdProveedorRegistro"
  WHERE estimacion."Activo" = true;


-- public.explosionesinsumosavancesfotograficosview source
DROP VIEW explosionesinsumosavancesfotograficosview;
CREATE OR REPLACE VIEW public.explosionesinsumosavancesfotograficosview
AS SELECT detalle."Id",
    detalle."IdAvance",
    detalle."UrlImagen",
    detalle."IdUsuarioRegistro",
    detalle."FechaRegistro",
    avance."Id" AS "AvanceId",
    avance."Cantidad" AS "AvanceCantidad",
    avance."IdExplosionInsumo" AS "AvanceIdExplosionInsumo",
    avance."Observaciones" AS "AvanceObservaciones",
    avance."IdUsuarioRegistro" AS "AvanceIdUsuarioRegistro",
    avance."FechaRegistro" AS "AvanceFechaRegistro",
    empresa."Id" AS "EmpresaId",
    empresa."Nombre" AS "EmpresaNombre",
    empresa."NombreComercial" AS "EmpresaNombreComercial",
    empresa."RazonSocial" AS "EmpresaRazonSocial",
    empresa."RFC" AS "EmpresaRfc",
    presupuesto."Id" AS "PresupuestoId",
    presupuesto."Codigo" AS "PresupuestoCodigo",
    presupuesto."Nombre" AS "PresupuestoNombre",
    presupuesto."IdEmpresa" AS "PresupuestoIdEmpresa",
    centrocosto."Id" AS "CentroCostoId",
    centrocosto."Codigo" AS "CentroCostoCodigo",
    centrocosto."Nombre" AS "CentroCostoNombre",
    centrocosto."Descripcion" AS "CentroCostoDescripcion",
    centrocosto."Observaciones" AS "CentroCostoObservaciones",
    centrocosto."IdTipoCentroCosto" AS "CentroCostoIdTipoCentroCosto",
    centrocosto."IdCliente" AS "CentroCostoIdCliente",
    centrocosto."IdEmpresa" AS "CentroCostoIdEmpresa",
    centrocosto."FechaInicial" AS "CentroCostoFechaInicial",
    centrocosto."FechaFinal" AS "CentroCostoFechaFinal",
    explosioninsumo."Id" AS "ExplosionInsumoId",
    explosioninsumo."IdExplosion" AS "ExplosionInsumoIdExplosion",
    explosioninsumo."IdPresupuesto" AS "ExplosionInsumoIdPresupuesto",
    explosioninsumo."IdPresupuestoConcepto" AS "ExplosionInsumoIdPresupuestoConcepto",
    explosioninsumo."IdInsumo" AS "ExplosionInsumoIdInsumo",
    explosioninsumo."Cantidad" AS "ExplosionInsumoCantidad",
    explosioninsumo."IdPrecio" AS "ExplosionInsumoIdPrecio",
    explosioninsumo."IdUsuarioRegistro" AS "ExplosionInsumoIdUsuarioRegistro",
    explosioninsumo."FechaRegistro" AS "ExplosionInsumoFechaRegistro",
    explosioninsumo."IdUsuarioModifico" AS "ExplosionInsumoIdUsuarioModifico",
    explosioninsumo."FechaModifico" AS "ExplosionInsumoFechaModifico",
    insumo."Id" AS "InsumoId",
    insumo."Nombre" AS "InsumoNombre",
    insumo."Codigo" AS "InsumoCodigo",
    insumo."Descripcion" AS "InsumoDescripcion",
    insumo."IdTipo" AS "InsumoIdTipo",
    insumo."IdCorporativo" AS "InsumoIdCorporativo",
    insumo."IdFamiliaInsumo" AS "InsumoIdFamiliaInsumo",
    insumo."IdUnidadMedida" AS "InsumoIdUnidadMedida",
    insumo."UrlImagen" AS "InsumoUrlImagen",
    unidad."Id" AS "UnidadMedidaId",
    unidad."Nombre" AS "UnidadMedidaNombre",
    unidad."Clave" AS "UnidadMedidaClave",
    unidad."Tipo" AS "UnidadMedidaTipo",
    tipoinsumo."Id" AS "TipoInsumoId",
    tipoinsumo."Nombre" AS "TipoInsumoNombre",
    tipoinsumo."Codigo" AS "TipoInsumoCodigo",
    tipoinsumo."Descripcion" AS "TipoInsumoDescripcion",
    tipoinsumo."ManoDeObra" AS "TipoInsumoManoDeObra",
    tipoinsumo."Financiero" AS "TipoInsumoFinanciero",
    tipoinsumo."Inventariable" AS "TipoInsumoInventariable",
    tipoinsumo."Administrativo" AS "TipoInsumoAdministrativo",
    tipoinsumo."IdCorporativo" AS "TipoInsumoIdCorporativo",
    presupuestoconcepto."Id" AS "PresupuestoConceptoId",
    presupuestoconcepto."IdPresupuesto" AS "PresupuestoConceptoIdPresupuesto",
    presupuestoconcepto."IdPartida" AS "PresupuestoConceptoIdPartida",
    presupuestoconcepto."IdMoneda" AS "PresupuestoConceptoIdMoneda",
    presupuestoconcepto."Codigo" AS "PresupuestoConceptoCodigo",
    presupuestoconcepto."Descripcion" AS "PresupuestoConceptoDescripcion",
    presupuestoconcepto."Cantidad" AS "PresupuestoConceptoCantidad",
    presupuestoconcepto."Precio" AS "PresupuestoConceptoPrecio",
    presupuestoconcepto."IdTipoConcepto" AS "PresupuestoConceptoIdTipoConcepto",
    presupuestoconcepto."Nombre" AS "PresupuestoConceptoNombre",
    presupuestopartida."Id" AS "PresupuestoPartidaId",
    presupuestopartida."Nombre" AS "PresupuestoPartidaNombre",
    presupuestopartida."Descripcion" AS "PresupuestoPartidaDescripcion",
    presupuestopartida."Observaciones" AS "PresupuestoPartidaObservaciones",
    presupuestopartida."IdPadre" AS "PresupuestoPartidaIdPadre",
    presupuestopartida."IdPresupuesto" AS "PresupuestoPartidaIdPresupuesto",
    usuarioregistro."Id" AS "UsuarioRegistroId",
    usuarioregistro."Nombre" AS "UsuarioRegistroNombre",
    usuarioregistro."ApellidoPaterno" AS "UsuarioRegistroApellidoPaterno",
    usuarioregistro."ApellidoMaterno" AS "UsuarioRegistroApellidoMaterno"
   FROM "ExplosionesInsumosAvancesFotograficos" detalle
     JOIN "ExplosionesInsumosAvances" avance ON avance."Id" = detalle."IdAvance"
     JOIN "ExplosionesInsumos" explosioninsumo ON explosioninsumo."Id" = avance."IdExplosionInsumo"
     JOIN "Presupuestos" presupuesto ON presupuesto."Id" = explosioninsumo."IdPresupuesto"
     JOIN "CentrosCostos" centrocosto ON centrocosto."Id" = presupuesto."IdCentroCosto"
     JOIN "Empresas" empresa ON centrocosto."IdEmpresa" = empresa."Id"
     JOIN "Insumos" insumo ON insumo."Id" = explosioninsumo."IdInsumo"
     JOIN "UnidadesMedidas" unidad ON unidad."Id" = insumo."IdUnidadMedida"
     JOIN "TiposInsumos" tipoinsumo ON tipoinsumo."Id" = insumo."IdTipo"
     JOIN "PresupuestosConceptos" presupuestoconcepto ON presupuestoconcepto."Id" = explosioninsumo."IdPresupuestoConcepto"
     JOIN "PresupuestosPartidas" presupuestopartida ON presupuestopartida."Id" = presupuestoconcepto."IdPartida"
     JOIN "Usuarios" usuarioregistro ON usuarioregistro."Id" = detalle."IdUsuarioRegistro";


-- public.explosionesinsumosavancesview source
DROP VIEW explosionesinsumosavancesview;
CREATE OR REPLACE VIEW public.explosionesinsumosavancesview
AS SELECT detalle."Id",
    detalle."Cantidad",
    detalle."IdExplosionInsumo",
    detalle."Observaciones",
    detalle."IdUsuarioRegistro",
    detalle."FechaRegistro",
    empresa."Id" AS "EmpresaId",
    empresa."Nombre" AS "EmpresaNombre",
    empresa."NombreComercial" AS "EmpresaNombreComercial",
    empresa."RazonSocial" AS "EmpresaRazonSocial",
    empresa."RFC" AS "EmpresaRfc",
    presupuesto."Id" AS "PresupuestoId",
    presupuesto."Codigo" AS "PresupuestoCodigo",
    presupuesto."Nombre" AS "PresupuestoNombre",
    presupuesto."IdEmpresa" AS "PresupuestoIdEmpresa",
    centrocosto."Id" AS "CentroCostoId",
    centrocosto."Codigo" AS "CentroCostoCodigo",
    centrocosto."Nombre" AS "CentroCostoNombre",
    centrocosto."Descripcion" AS "CentroCostoDescripcion",
    centrocosto."Observaciones" AS "CentroCostoObservaciones",
    centrocosto."IdTipoCentroCosto" AS "CentroCostoIdTipoCentroCosto",
    centrocosto."IdCliente" AS "CentroCostoIdCliente",
    centrocosto."IdEmpresa" AS "CentroCostoIdEmpresa",
    centrocosto."FechaInicial" AS "CentroCostoFechaInicial",
    centrocosto."FechaFinal" AS "CentroCostoFechaFinal",
    explosioninsumo."Id" AS "ExplosionInsumoId",
    explosioninsumo."IdExplosion" AS "ExplosionInsumoIdExplosion",
    explosioninsumo."IdPresupuesto" AS "ExplosionInsumoIdPresupuesto",
    explosioninsumo."IdPresupuestoConcepto" AS "ExplosionInsumoIdPresupuestoConcepto",
    explosioninsumo."IdInsumo" AS "ExplosionInsumoIdInsumo",
    explosioninsumo."Cantidad" AS "ExplosionInsumoCantidad",
    explosioninsumo."IdPrecio" AS "ExplosionInsumoIdPrecio",
    explosioninsumo."IdUsuarioRegistro" AS "ExplosionInsumoIdUsuarioRegistro",
    explosioninsumo."FechaRegistro" AS "ExplosionInsumoFechaRegistro",
    explosioninsumo."IdUsuarioModifico" AS "ExplosionInsumoIdUsuarioModifico",
    explosioninsumo."FechaModifico" AS "ExplosionInsumoFechaModifico",
    insumo."Id" AS "InsumoId",
    insumo."Nombre" AS "InsumoNombre",
    insumo."Codigo" AS "InsumoCodigo",
    insumo."Descripcion" AS "InsumoDescripcion",
    insumo."IdTipo" AS "InsumoIdTipo",
    insumo."IdCorporativo" AS "InsumoIdCorporativo",
    insumo."IdFamiliaInsumo" AS "InsumoIdFamiliaInsumo",
    insumo."IdUnidadMedida" AS "InsumoIdUnidadMedida",
    insumo."UrlImagen" AS "InsumoUrlImagen",
    unidad."Id" AS "UnidadMedidaId",
    unidad."Nombre" AS "UnidadMedidaNombre",
    unidad."Clave" AS "UnidadMedidaClave",
    unidad."Tipo" AS "UnidadMedidaTipo",
    tipoinsumo."Id" AS "TipoInsumoId",
    tipoinsumo."Nombre" AS "TipoInsumoNombre",
    tipoinsumo."Codigo" AS "TipoInsumoCodigo",
    tipoinsumo."Descripcion" AS "TipoInsumoDescripcion",
    tipoinsumo."ManoDeObra" AS "TipoInsumoManoDeObra",
    tipoinsumo."Financiero" AS "TipoInsumoFinanciero",
    tipoinsumo."Inventariable" AS "TipoInsumoInventariable",
    tipoinsumo."Administrativo" AS "TipoInsumoAdministrativo",
    tipoinsumo."IdCorporativo" AS "TipoInsumoIdCorporativo",
    presupuestoconcepto."Id" AS "PresupuestoConceptoId",
    presupuestoconcepto."IdPresupuesto" AS "PresupuestoConceptoIdPresupuesto",
    presupuestoconcepto."IdPartida" AS "PresupuestoConceptoIdPartida",
    presupuestoconcepto."IdMoneda" AS "PresupuestoConceptoIdMoneda",
    presupuestoconcepto."Codigo" AS "PresupuestoConceptoCodigo",
    presupuestoconcepto."Descripcion" AS "PresupuestoConceptoDescripcion",
    presupuestoconcepto."Cantidad" AS "PresupuestoConceptoCantidad",
    presupuestoconcepto."Precio" AS "PresupuestoConceptoPrecio",
    presupuestoconcepto."IdTipoConcepto" AS "PresupuestoConceptoIdTipoConcepto",
    presupuestoconcepto."Nombre" AS "PresupuestoConceptoNombre",
    presupuestopartida."Id" AS "PresupuestoPartidaId",
    presupuestopartida."Nombre" AS "PresupuestoPartidaNombre",
    presupuestopartida."Descripcion" AS "PresupuestoPartidaDescripcion",
    presupuestopartida."Observaciones" AS "PresupuestoPartidaObservaciones",
    presupuestopartida."IdPadre" AS "PresupuestoPartidaIdPadre",
    presupuestopartida."IdPresupuesto" AS "PresupuestoPartidaIdPresupuesto",
    usuarioregistro."Id" AS "UsuarioRegistroId",
    usuarioregistro."Nombre" AS "UsuarioRegistroNombre",
    usuarioregistro."ApellidoPaterno" AS "UsuarioRegistroApellidoPaterno",
    usuarioregistro."ApellidoMaterno" AS "UsuarioRegistroApellidoMaterno"
   FROM "ExplosionesInsumosAvances" detalle
     JOIN "ExplosionesInsumos" explosioninsumo ON explosioninsumo."Id" = detalle."IdExplosionInsumo"
     JOIN "Presupuestos" presupuesto ON presupuesto."Id" = explosioninsumo."IdPresupuesto"
     JOIN "CentrosCostos" centrocosto ON centrocosto."Id" = presupuesto."IdCentroCosto"
     JOIN "Empresas" empresa ON centrocosto."IdEmpresa" = empresa."Id"
     JOIN "Insumos" insumo ON insumo."Id" = explosioninsumo."IdInsumo"
     JOIN "UnidadesMedidas" unidad ON unidad."Id" = insumo."IdUnidadMedida"
     JOIN "TiposInsumos" tipoinsumo ON tipoinsumo."Id" = insumo."IdTipo"
     JOIN "PresupuestosConceptos" presupuestoconcepto ON presupuestoconcepto."Id" = explosioninsumo."IdPresupuestoConcepto"
     JOIN "PresupuestosPartidas" presupuestopartida ON presupuestopartida."Id" = presupuestoconcepto."IdPartida"
     JOIN "Usuarios" usuarioregistro ON usuarioregistro."Id" = detalle."IdUsuarioRegistro";


-- public.explosionesinsumosview source
DROP VIEW explosionesinsumosview;
CREATE OR REPLACE VIEW public.explosionesinsumosview
AS SELECT "ExplosionesInsumos"."Id",
    "ExplosionesInsumos"."IdExplosion",
    "ExplosionesInsumos"."IdPresupuesto",
    "ExplosionesInsumos"."IdPresupuestoConcepto",
    "ExplosionesInsumos"."IdInsumo",
    "ExplosionesInsumos"."Cantidad",
    "ExplosionesInsumos"."IdPrecio",
    "ExplosionesInsumos"."IdUsuarioRegistro",
    "ExplosionesInsumos"."FechaRegistro",
    "ExplosionesInsumos"."IdUsuarioModifico",
    "ExplosionesInsumos"."FechaModifico",
    "ExplosionesInsumos"."NoConsiderado",
    "ExplosionesInsumos"."Autorizado",
    "ExplosionesInsumos"."Contratable",
    "Explosiones"."Id" AS "ExplosionId",
    "Explosiones"."IdPresupuesto" AS "ExplosionIdPresupuesto",
    "Explosiones"."Codigo" AS "ExplosionCodigo",
    "Explosiones"."Descripcion" AS "ExplosionDescripcion",
    "Explosiones"."IdUsuarioRegistro" AS "ExplosionIdUsuarioRegistro",
    "Explosiones"."FechaRegistro" AS "ExplosionFechaRegistro",
    "Explosiones"."IdUsuarioModifico" AS "ExplosionIdUsuarioModifico",
    "Explosiones"."FechaModifico" AS "ExplosionFechaModifico",
    "Explosiones"."Activo" AS "ExplosionActivo",
    "Explosiones"."Actualizada" AS "ExplosionActualizada",
    "PresupuestosPartidas"."Id" AS "PresupuestoPartidaId",
    "PresupuestosPartidas"."IdPadre" AS "PresupuestoPartidaIdPadre",
    "PresupuestosPartidas"."IdPresupuesto" AS "PresupuestoPartidaIdPresupuesto",
    "PresupuestosPartidas"."Nombre" AS "PresupuestoPartidaNombre",
    "PresupuestosPartidas"."Observaciones" AS "PresupuestoPartidaObservaciones",
    "PresupuestosPartidas"."Descripcion" AS "PresupuestoPartidaDescripcion",
    "PresupuestosConceptos"."Id" AS "PresupuestoConceptoId",
    "PresupuestosConceptos"."IdMoneda" AS "PresupuestoConceptoIdMoneda",
    "PresupuestosConceptos"."IdPartida" AS "PresupuestoConceptoIdPartida",
    "PresupuestosConceptos"."IdPresupuesto" AS "PresupuestoConceptoIdPresupuesto",
    "PresupuestosConceptos"."IdTipoConcepto" AS "PresupuestoConceptoIdTipoConcepto",
    "PresupuestosConceptos"."Cantidad" AS "PresupuestoConceptoCantidad",
    "PresupuestosConceptos"."Nombre" AS "PresupuestoConceptoNombre",
    "PresupuestosConceptos"."Codigo" AS "PresupuestoConceptoCodigo",
    "PresupuestosConceptos"."Descripcion" AS "PresupuestoConceptoDescripcion",
    "PresupuestosConceptos"."Precio" AS "PresupuestoConceptoPrecio",
    "PresupuestosConceptos"."IdInsumo" AS "PresupuestoConceptoIdInsumo",
    "TiposConceptos"."Id" AS "TipoConceptoId",
    "TiposConceptos"."Nombre" AS "TipoConceptoNombre",
    "TiposConceptos"."IdCorporativo" AS "TipoConceptoIdCorporativo",
    "TiposConceptos"."IdFamiliaConcepto" AS "TipoConceptoIdFamiliaConcepto",
    "TiposConceptos"."IdUnidadMedida" AS "TipoConceptoIdUnidadMedida",
    "TiposConceptos"."Descripcion" AS "TipoConceptoDescripcion",
    "Insumos"."Id" AS "InsumoId",
    "Insumos"."Codigo" AS "InsumoCodigo",
    "Insumos"."Descripcion" AS "InsumoDescripcion",
    "Insumos"."Nombre" AS "InsumoNombre",
    "Insumos"."IdFamiliaInsumo" AS "InsumoIdFamiliaInsumo",
    "Insumos"."IdTipo" AS "InsumoIdTipo",
    "FamiliasInsumos"."Id" AS "FamiliaInsumoId",
    "FamiliasInsumos"."Codigo" AS "FamiliaInsumoCodigo",
    "FamiliasInsumos"."Nombre" AS "FamiliaInsumoNombre",
    "FamiliasInsumos"."Descripcion" AS "FamiliaInsumoDescripcion",
    "TiposInsumos"."Id" AS "TipoInsumoId",
    "TiposInsumos"."Codigo" AS "TipoInsumoCodigo",
    "TiposInsumos"."Nombre" AS "TipoInsumoNombre",
    "TiposInsumos"."Descripcion" AS "TipoInsumoDescripcion",
    "TiposInsumos"."ManoDeObra" AS "TipoInsumoManoDeObra",
    "TiposInsumos"."Administrativo" AS "TipoInsumoAdministrativo",
    "TiposInsumos"."Inventariable" AS "TipoInsumoInventariable",
    "TiposInsumos"."Financiero" AS "TipoInsumoFinanciero",
    "TiposInsumos"."Requerir" AS "TipoInsumoRequerir",
    "UnidadesMedidas"."Id" AS "UnidadMedidaId",
    "UnidadesMedidas"."Clave" AS "UnidadMedidaClave",
    "UnidadesMedidas"."Nombre" AS "UnidadMedidaNombre",
    "UnidadesMedidas"."Tipo" AS "UnidadMedidaTipo",
    "Presupuestos"."Id" AS "PresupuestoId",
    "Presupuestos"."IdEmpresa" AS "PresupuestoIdEmpresa",
    "Presupuestos"."IdCentroCosto" AS "PresupuestoIdCentroCosto",
    "Presupuestos"."Nombre" AS "PresupuestoNombre",
    "Presupuestos"."Codigo" AS "PresupuestoCodigo",
    "Presupuestos"."Descripcion" AS "PresupuestoDescripcion",
    "Presupuestos"."IdTipo" AS "PresupuestoIdTipo",
    "Presupuestos"."Email" AS "PresupuestoEmail",
    "Presupuestos"."IdClasificadorPresupuesto" AS "PresupuestoIdClasificadorPresupuesto",
    "Presupuestos"."IdResponsable" AS "PresupuestoIdResponsable",
    "Presupuestos"."Observaciones" AS "PresupuestoObservaciones",
    "CentrosCostos"."Id" AS "CentroCostoId",
    "CentrosCostos"."IdCliente" AS "CentroCostoIdCliente",
    "CentrosCostos"."IdEmpresa" AS "CentroCostoIdEmpresa",
    "CentrosCostos"."IdTipoCentroCosto" AS "CentroCostoIdTipoCentroCosto",
    "CentrosCostos"."Nombre" AS "CentroCostoNombre",
    "CentrosCostos"."Observaciones" AS "CentroCostoObservaciones",
    "CentrosCostos"."Codigo" AS "CentroCostoCodigo",
    "CentrosCostos"."Descripcion" AS "CentroCostoDescripcion",
    "CentrosCostos"."FechaInicial" AS "CentroCostoFechaInicial",
    "CentrosCostos"."FechaFinal" AS "CentroCostoFechaFinal",
    "CentrosCostos"."IdUsuarioRegistro" AS "CentroCostoIdUsuarioRegistro",
    "CentrosCostos"."FechaRegistro" AS "CentroCostoFechaRegistro",
    "CentrosCostos"."IdUsuarioModifico" AS "CentroCostoIdUsuarioModifico",
    "CentrosCostos"."FechaModifico" AS "CentroCostoFechaModifico",
    "CentrosCostos"."Activo" AS "CentroCostoActivo",
    "PresupuestosInsumosPrecios"."Id" AS "PresupuestoInsumoPrecioId",
    "PresupuestosInsumosPrecios"."IdInsumo" AS "PresupuestoInsumoPrecioIdInsumo",
    "PresupuestosInsumosPrecios"."IdMoneda" AS "PresupuestoInsumoPrecioIdMoneda",
    "PresupuestosInsumosPrecios"."IdPresupuesto" AS "PresupuestoInsumoPrecioIdPresupuesto",
    "PresupuestosInsumosPrecios"."Precio" AS "PresupuestoInsumoPrecioPrecio",
    usuarioregistro."Nombre" AS "UsuarioRegistroNombre",
    usuarioregistro."ApellidoPaterno" AS "UsuarioRegistroApellidoPaterno",
    usuarioregistro."ApellidoMaterno" AS "UsuarioRegistroApellidoMaterno",
    usuariomodifico."Nombre" AS "UsuarioModificoNombre",
    usuariomodifico."ApellidoPaterno" AS "UsuarioModificoApellidoPaterno",
    usuariomodifico."ApellidoMaterno" AS "UsuarioModificoApellidoMaterno"
   FROM "ExplosionesInsumos"
     JOIN "Explosiones" ON "Explosiones"."Id" = "ExplosionesInsumos"."IdExplosion"
     JOIN "Presupuestos" ON "Presupuestos"."Id" = "ExplosionesInsumos"."IdPresupuesto"
     JOIN "CentrosCostos" ON "CentrosCostos"."Id" = "Presupuestos"."IdCentroCosto"
     JOIN "PresupuestosConceptos" ON "PresupuestosConceptos"."Id" = "ExplosionesInsumos"."IdPresupuestoConcepto"
     JOIN "PresupuestosPartidas" ON "PresupuestosPartidas"."Id" = "PresupuestosConceptos"."IdPartida"
     JOIN "Insumos" ON "Insumos"."Id" = "ExplosionesInsumos"."IdInsumo"
     JOIN "TiposInsumos" ON "TiposInsumos"."Id" = "Insumos"."IdTipo"
     JOIN "TiposConceptos" ON "TiposConceptos"."Id" = "PresupuestosConceptos"."IdTipoConcepto"
     JOIN "FamiliasInsumos" ON "FamiliasInsumos"."Id" = "Insumos"."IdFamiliaInsumo"
     JOIN "UnidadesMedidas" ON "UnidadesMedidas"."Id" = "Insumos"."IdUnidadMedida"
     JOIN "PresupuestosInsumosPrecios" ON "PresupuestosInsumosPrecios"."Id" = "ExplosionesInsumos"."IdPrecio"
     JOIN "Usuarios" usuarioregistro ON usuarioregistro."Id" = "ExplosionesInsumos"."IdUsuarioRegistro"
     JOIN "Usuarios" usuariomodifico ON usuariomodifico."Id" = "ExplosionesInsumos"."IdUsuarioModifico"
  WHERE "Explosiones"."Activo" = true;


-- public.explosionessubcontratosdetallesview source
DROP VIEW explosionessubcontratosdetallesview;
CREATE OR REPLACE VIEW public.explosionessubcontratosdetallesview
AS SELECT detalle."Id",
    detalle."IdExplosionSubcontrato",
    detalle."IdExplosionInsumo",
    detalle."Cantidad",
    detalle."Precio",
    detalle."Observaciones",
    detalle."IdUsuarioRegistro",
    detalle."FechaRegistro",
    detalle."IdUsuarioModifico",
    detalle."FechaModifico",
    detalle."Activo",
    subcontrato."Id" AS "ExplosionSubcontratoId",
    subcontrato."Codigo" AS "ExplosionSubcontratoCodigo",
    subcontrato."IdCentroCosto" AS "ExplosionSubcontratoIdCentroCosto",
    subcontrato."IdProveedor" AS "ExplosionSubcontratoIdProveedor",
    subcontrato."Nombre" AS "ExplosionSubcontratoNombre",
    subcontrato."Observaciones" AS "ExplosionSubcontratoObservaciones",
    subcontrato."FechaInicial" AS "ExplosionSubcontratoFechaInicial",
    subcontrato."FechaFinal" AS "ExplosionSubcontratoFechaFinal",
    subcontrato."IdUsuarioRegistro" AS "ExplosionSubcontratoIdUsuarioRegistro",
    subcontrato."FechaRegistro" AS "ExplosionSubcontratoFechaRegistro",
    subcontrato."IdUsuarioModifico" AS "ExplosionSubcontratoIdUsuarioModifico",
    subcontrato."FechaModifico" AS "ExplosionSubcontratoFechaModifico",
    subcontrato."Activo" AS "ExplosionSubcontratoActivo",
    empresa."Id" AS "EmpresaId",
    empresa."Nombre" AS "EmpresaNombre",
    empresa."NombreComercial" AS "EmpresaNombreComercial",
    empresa."RazonSocial" AS "EmpresaRazonSocial",
    empresa."RFC" AS "EmpresaRfc",
    presupuesto."Id" AS "PresupuestoId",
    presupuesto."Codigo" AS "PresupuestoCodigo",
    presupuesto."Nombre" AS "PresupuestoNombre",
    presupuesto."IdEmpresa" AS "PresupuestoIdEmpresa",
    centrocosto."Id" AS "CentroCostoId",
    centrocosto."Codigo" AS "CentroCostoCodigo",
    centrocosto."Nombre" AS "CentroCostoNombre",
    centrocosto."Descripcion" AS "CentroCostoDescripcion",
    centrocosto."Observaciones" AS "CentroCostoObservaciones",
    centrocosto."IdTipoCentroCosto" AS "CentroCostoIdTipoCentroCosto",
    centrocosto."IdCliente" AS "CentroCostoIdCliente",
    centrocosto."IdEmpresa" AS "CentroCostoIdEmpresa",
    centrocosto."FechaInicial" AS "CentroCostoFechaInicial",
    centrocosto."FechaFinal" AS "CentroCostoFechaFinal",
    explosioninsumo."Id" AS "ExplosionInsumoId",
    explosioninsumo."IdExplosion" AS "ExplosionInsumoIdExplosion",
    explosioninsumo."IdPresupuesto" AS "ExplosionInsumoIdPresupuesto",
    explosioninsumo."IdPresupuestoConcepto" AS "ExplosionInsumoIdPresupuestoConcepto",
    explosioninsumo."IdInsumo" AS "ExplosionInsumoIdInsumo",
    explosioninsumo."Cantidad" AS "ExplosionInsumoCantidad",
    explosioninsumo."IdPrecio" AS "ExplosionInsumoIdPrecio",
    explosioninsumo."IdUsuarioRegistro" AS "ExplosionInsumoIdUsuarioRegistro",
    explosioninsumo."FechaRegistro" AS "ExplosionInsumoFechaRegistro",
    explosioninsumo."IdUsuarioModifico" AS "ExplosionInsumoIdUsuarioModifico",
    explosioninsumo."FechaModifico" AS "ExplosionInsumoFechaModifico",
    insumo."Id" AS "InsumoId",
    insumo."Nombre" AS "InsumoNombre",
    insumo."Codigo" AS "InsumoCodigo",
    insumo."Descripcion" AS "InsumoDescripcion",
    insumo."IdTipo" AS "InsumoIdTipo",
    insumo."IdCorporativo" AS "InsumoIdCorporativo",
    insumo."IdFamiliaInsumo" AS "InsumoIdFamiliaInsumo",
    insumo."IdUnidadMedida" AS "InsumoIdUnidadMedida",
    insumo."UrlImagen" AS "InsumoUrlImagen",
    unidad."Id" AS "UnidadMedidaId",
    unidad."Nombre" AS "UnidadMedidaNombre",
    unidad."Clave" AS "UnidadMedidaClave",
    unidad."Tipo" AS "UnidadMedidaTipo",
    tipoinsumo."Id" AS "TipoInsumoId",
    tipoinsumo."Nombre" AS "TipoInsumoNombre",
    tipoinsumo."Codigo" AS "TipoInsumoCodigo",
    tipoinsumo."Descripcion" AS "TipoInsumoDescripcion",
    tipoinsumo."ManoDeObra" AS "TipoInsumoManoDeObra",
    tipoinsumo."Financiero" AS "TipoInsumoFinanciero",
    tipoinsumo."Inventariable" AS "TipoInsumoInventariable",
    tipoinsumo."Administrativo" AS "TipoInsumoAdministrativo",
    tipoinsumo."IdCorporativo" AS "TipoInsumoIdCorporativo",
    presupuestoconcepto."Id" AS "PresupuestoConceptoId",
    presupuestoconcepto."IdPresupuesto" AS "PresupuestoConceptoIdPresupuesto",
    presupuestoconcepto."IdPartida" AS "PresupuestoConceptoIdPartida",
    presupuestoconcepto."IdMoneda" AS "PresupuestoConceptoIdMoneda",
    presupuestoconcepto."Codigo" AS "PresupuestoConceptoCodigo",
    presupuestoconcepto."Descripcion" AS "PresupuestoConceptoDescripcion",
    presupuestoconcepto."Cantidad" AS "PresupuestoConceptoCantidad",
    presupuestoconcepto."Precio" AS "PresupuestoConceptoPrecio",
    presupuestoconcepto."IdTipoConcepto" AS "PresupuestoConceptoIdTipoConcepto",
    presupuestoconcepto."Nombre" AS "PresupuestoConceptoNombre",
    presupuestoconcepto."IdInsumo" AS "PresupuestoConceptoIdInsumo",
    presupuestoconcepto."ActualizarPrecioAuto" AS "PresupuestoConceptoActualizarPrecioAuto",
    presupuestoconcepto."ImporteMatriz" AS "PresupuestoConceptoImporteMatriz",
    presupuestoconcepto."IdTipoSubcontrato" AS "PresupuestoConceptoIdTipoSubcontrato",
    presupuestoconcepto."Contratable" AS "PresupuestoConceptoContratable",
    presupuestopartida."Id" AS "PresupuestoPartidaId",
    presupuestopartida."Nombre" AS "PresupuestoPartidaNombre",
    presupuestopartida."Descripcion" AS "PresupuestoPartidaDescripcion",
    presupuestopartida."Observaciones" AS "PresupuestoPartidaObservaciones",
    presupuestopartida."IdPadre" AS "PresupuestoPartidaIdPadre",
    presupuestopartida."IdPresupuesto" AS "PresupuestoPartidaIdPresupuesto",
    usuarioregistro."Id" AS "UsuarioRegistroId",
    usuarioregistro."Nombre" AS "UsuarioRegistroNombre",
    usuarioregistro."ApellidoPaterno" AS "UsuarioRegistroApellidoPaterno",
    usuarioregistro."ApellidoMaterno" AS "UsuarioRegistroApellidoMaterno",
    usuariomodifico."Id" AS "UsuarioModificoId",
    usuariomodifico."Nombre" AS "UsuarioModificoNombre",
    usuariomodifico."ApellidoPaterno" AS "UsuarioModificoApellidoPaterno",
    usuariomodifico."ApellidoMaterno" AS "UsuarioModificoApellidoMaterno",
    presupuestoinsumoprecio."Id" AS "PresupuestoInsumoPrecioId",
    presupuestoinsumoprecio."IdInsumo" AS "PresupuestoInsumoPrecioIdInsumo",
    presupuestoinsumoprecio."IdMoneda" AS "PresupuestoInsumoPrecioIdMoneda",
    presupuestoinsumoprecio."IdPresupuesto" AS "PresupuestoInsumoPrecioIdPresupuesto",
    presupuestoinsumoprecio."Precio" AS "PresupuestoInsumoPrecioPrecio",
    tiposubcontrato."Id" AS "TipoSubcontratoId",
    tiposubcontrato."Nombre" AS "TipoSubcontratoNombre",
    tiposubcontrato."Descripcion" AS "TipoSubcontratoDescripcion"
   FROM "ExplosionesSubcontratosDetalles" detalle
     JOIN "ExplosionesSubcontratos" subcontrato ON subcontrato."Id" = detalle."IdExplosionSubcontrato"
     JOIN "ExplosionesInsumos" explosioninsumo ON explosioninsumo."Id" = detalle."IdExplosionInsumo"
     JOIN "Presupuestos" presupuesto ON presupuesto."Id" = explosioninsumo."IdPresupuesto"
     LEFT JOIN "PresupuestosInsumosPrecios" presupuestoinsumoprecio ON presupuestoinsumoprecio."Id" = explosioninsumo."IdPrecio"
     JOIN "CentrosCostos" centrocosto ON centrocosto."Id" = subcontrato."IdCentroCosto"
     JOIN "Empresas" empresa ON centrocosto."IdEmpresa" = empresa."Id"
     JOIN "Insumos" insumo ON insumo."Id" = explosioninsumo."IdInsumo"
     JOIN "UnidadesMedidas" unidad ON unidad."Id" = insumo."IdUnidadMedida"
     JOIN "TiposInsumos" tipoinsumo ON tipoinsumo."Id" = insumo."IdTipo"
     JOIN "PresupuestosConceptos" presupuestoconcepto ON presupuestoconcepto."Id" = explosioninsumo."IdPresupuestoConcepto"
     LEFT JOIN "TiposSubcontratos" tiposubcontrato ON tiposubcontrato."Id" = presupuestoconcepto."IdTipoSubcontrato"
     JOIN "PresupuestosPartidas" presupuestopartida ON presupuestopartida."Id" = presupuestoconcepto."IdPartida"
     JOIN "Usuarios" usuarioregistro ON usuarioregistro."Id" = detalle."IdUsuarioRegistro"
     JOIN "Usuarios" usuariomodifico ON usuariomodifico."Id" = detalle."IdUsuarioModifico"
  WHERE detalle."Activo" = true;
```

### Análisis de Compra

fn_OrdenesComprasDetalles_Insumos_Agrupados_Read_Paged

``` SQL
--- WEB
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (44,'Analisis de compra','modulo_orden_compra_analisis',3,3);

---MOVIL
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (54,'Analisis de compra','modulo_orden_compra_analisis',3,3);
```

### Análisis de Recepción Insumos

fn_RecepcionesInsumosDetalles_Analisis_Paged

``` SQL
--- WEB
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (48,'Analisis recepción insumos','modulo_recepcion_insumo_analisis',3,3);

---MOVIL
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (61,'Analisis recepción insumos','modulo_recepcion_insumo_analisis',3,3);
```

### Análisis de Salida de Insumos

Agregamos campo de 'Frente' en la tabla SalidaInsumosDetalle

``` SQL
ALTER TABLE public."SalidasInsumosDetalles" ADD "IdFrente" int4 NULL;

CREATE INDEX ix_salidasinsumosdetalles_idfrente ON public."SalidasInsumosDetalles" USING btree ("IdFrente");

ALTER TABLE public."SalidasInsumosDetalles" ADD CONSTRAINT "fk_SalidasInsumosDetalles_IdFrente" FOREIGN KEY ("IdFrente") REFERENCES public."Frentes"("Id");
```

fn_salidasinsumosdetalles_read_paged
fn_get_presupuesto_insumo_precio

``` SQL
--- WEB
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (46,'Analisis salida insumos','modulo_salida_insumo_analisis',3,3);

---MOVIL
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (62,'Analisis salida insumos','modulo_salida_insumo_analisis',3,3);
```

### Análisis de Devolución de Insumos

fn_DevolucionesInsumosDetalles_Read_Paged

``` SQL
--- WEB
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (45,'Análisis devolución insumos','modulo_devolucion_insumo_analisis',3,3);

---MOVIL
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (64,'Análisis devolución insumos','modulo_devolucion_insumo_analisis',3,3);
```

### Análisis Subcontratos

``` SQL
ALTER TABLE public."ExplosionesSubcontratosDetalles"
ADD COLUMN "UrlDocumento" varchar(255) NULL;

ALTER TABLE public."ExplosionesSubcontratos" 
ADD COLUMN "Folio" integer NULL;
```

explosionsubcontratoview
fn_ExplosionesSubcontratos_Read_Paged
ExplosionesSubcontratosDetallesView
fn_ExplosionesSubcontratosDetalles_Read_Paged

``` SQL
--- WEB
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (50,'Análisis Subcontrato de Obra','modulo_subcontrato_obra_analisis',3,3);

---MOVIL
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (55,'Análisis Subcontrato de Obra','modulo_subcontrato_obra_analisis',3,3);
```

### Análisis Estimaciones

``` SQL
ALTER TABLE public."EstimacionesInsumos"
ADD COLUMN "UrlDocumento" varchar(255) NULL;
```

fn_EstimacionesInsumosDetalles_Read_Paged
EstimacionesInsumosDetallesView
estimacionesinsumosview
fn_EstimacionesInsumos_Read_Paged

``` SQL
--- WEB
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (49,'Análisis Estimación','modulo_estimacion_analisis',3,3);

---MOVIL
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (56,'Análisis Estimación','modulo_estimacion_analisis',3,3);
```

### Análisis Presupuestos


``` SQL
--- WEB
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (18,'Análisis Presupuestos','modulo_presupuestos_analisis',3,3);

---MOVIL
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (56,'Análisis Estimación','modulo_estimacion_analisis',3,3);
```

### Análisis Aditivas y Deductivas


``` SQL
--- WEB
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (39,'Análisis Aditivas','modulo_aditivas_analisis',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (41,'Análisis Deductivas','modulo_deductivas_analisis',3,3);

---MOVIL
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (59,'Análisis Aditivas','modulo_aditivas_analisis',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (60,'Análisis Deductivas','modulo_deductivas_analisis',3,3);
```

### Análisis Requisiciones
fn_requisicionesdetallesinsumosagrupados_read_paged