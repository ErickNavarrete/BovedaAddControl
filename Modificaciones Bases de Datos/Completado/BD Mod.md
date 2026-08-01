## Presupuestos Matriz [Dev-Demo-Producción]

``` SQL
ALTER TABLE public."PresupuestosMatriz" ADD COLUMN "IdUnidadMedida" int4;

CREATE INDEX ix_presupuestosmatriz_idunidadmedida ON public."PresupuestosMatriz" USING btree ("IdUnidadMedida");

ALTER TABLE public."PresupuestosMatriz" ADD CONSTRAINT "fk_PresupuestosMatriz_IdUnidadMedida" FOREIGN KEY ("IdUnidadMedida") REFERENCES public."UnidadesMedidas"("Id");

fn_presupuestosmatriz_read
fn_presupuestosmatriz_read_paged
```

## Presupuestos Matriz Conceptos [Dev-Demo-Producción]

``` SQL
ALTER TABLE public."PresupuestosMatrizConceptos" ADD COLUMN "IdUnidadMedida" int4;

CREATE INDEX ix_presupuestosmatrizconceptos_idunidadmedida ON public."PresupuestosMatrizConceptos" USING btree ("IdUnidadMedida");

ALTER TABLE public."PresupuestosMatrizConceptos" ADD CONSTRAINT "fk_PresupuestosMatrizConceptos_IdUnidadMedida" FOREIGN KEY ("IdUnidadMedida") REFERENCES public."UnidadesMedidas"("Id");

fn_presupuestosmatrizconceptos_read
PresupuestosMatrizConceptosView
fn_presupuestosmatrizconcepto_read_paged
```

## Explosiones Insumos [Dev-Demo-Producción]

``` SQL
fn_explosionesinsumos_read_paged
``` 

## Presupuestos Análisis [Dev-Demo-Producción]

``` SQL
fn_Presupuesto_Analisis_Agrupado_Read_Paged
fn_Presupuesto_Analisis_Read_Paged
explosionesinsumosagrupadosview
explosionesinsumosview
```

## Cambios Catálogos [Dev-Demo-Producción]

``` SQL
ALTER TABLE public."CentrosCostos" ALTER COLUMN "Descripcion" TYPE varchar(520) USING "Descripcion"::varchar(520);

ALTER TABLE public."Insumos" ALTER COLUMN "Descripcion" TYPE varchar(520) USING "Descripcion"::varchar(520);

ALTER TABLE public."TiposInsumos" ALTER COLUMN "Descripcion" TYPE varchar(520) USING "Descripcion"::varchar(520);
``` 

## Cambios Catálogos [Dev-Demo-Producción]

``` SQL
ALTER TABLE public."PresupuestosPartidas" ALTER COLUMN "Observaciones" TYPE varchar(520) USING "Observaciones"::varchar(520);
``` 

## Presupuesto Params [Dev-Demo-Producción]

``` SQL
CREATE TABLE public."PresupuestosParams" (
"Id" int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
"IdPresupuesto" int4 NOT NULL,
"FechaFin" timestamp NOT NULL,
"DiasHolgura" numeric(18, 6) NOT NULL,
"IdUsuarioRegistro" int4 NOT NULL,
"FechaRegistro" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
"IdUsuarioModifico" int4 NOT NULL,
"FechaModifico" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
"Activo" bool DEFAULT true NOT NULL,
CONSTRAINT "PresupuestosParams_pkey" PRIMARY KEY ("Id")
);

CREATE INDEX ix_presupuestosparams_id ON public."PresupuestosParams" USING btree ("Id");
CREATE INDEX IF NOT EXISTS ix_presupuestosparams_idpresupuesto
ON public."PresupuestosParams" USING btree ("IdPresupuesto");

CREATE INDEX IF NOT EXISTS ix_presupuestosparams_idusuariomodifico
ON public."PresupuestosParams" USING btree ("IdUsuarioModifico");

CREATE INDEX IF NOT EXISTS ix_presupuestosparams_idusuarioregistro
ON public."PresupuestosParams" USING btree ("IdUsuarioRegistro");


ALTER TABLE public."PresupuestosParams"
ADD CONSTRAINT "fk_PresupuestosParams_IdPresupuesto"
FOREIGN KEY ("IdPresupuesto")
REFERENCES public."Presupuestos"("Id");

ALTER TABLE public."PresupuestosParams"
ADD CONSTRAINT "fk_PresupuestosParams_IdUsuarioModifico"
FOREIGN KEY ("IdUsuarioModifico")
REFERENCES public."Usuarios"("Id");

ALTER TABLE public."PresupuestosParams"
ADD CONSTRAINT "fk_PresupuestosParams_IdUsuarioRegistro"
FOREIGN KEY ("IdUsuarioRegistro")
REFERENCES public."Usuarios"("Id");
``` 

## Presupuesto Programación [Dev-Demo-Producción]

``` SQL
fn_presupuesto_programacion_read
```

## Cambios Mario [Dev-Demo-Producción]

``` SQL
ALTER TABLE "Estados" ADD COLUMN "CodigoFacDominicana" int4 NOT NULL DEFAULT 0;

ALTER TABLE "Municipios" ADD COLUMN "CodigoEstadoFacDominicana" int4 NOT NULL DEFAULT 0;

ALTER TABLE "UnidadesMedidas" ADD COLUMN "CodigoFacDominicana" int4 NOT NULL DEFAULT 0;
```

## Presupuesto Jerarquías [Dev-Demo-Producción]

fn_presupuestos_partidas_jerarquia
fn_presupuestospartidas_jerarquia_read_paged

## Explosiones Subcontratos [Dev-Demo-Producción]

``` SQL
ALTER TABLE public."ExplosionesSubcontratos"
ADD COLUMN "IdTipoSubcontrato" int4 NULL;

-- 2️⃣ Crear índice (btree recomendado para FK y filtros)
CREATE INDEX ix_explosionessubcontratos_idtiposubcontrato
ON public."ExplosionesSubcontratos"
USING btree ("IdTipoSubcontrato");

-- 3️⃣ Agregar llave foránea
ALTER TABLE public."ExplosionesSubcontratos"
ADD CONSTRAINT "fk_ExplosionesSubcontratos_IdTipoSubcontrato"
FOREIGN KEY ("IdTipoSubcontrato")
REFERENCES public."TiposSubcontratos"("Id")

explosionsubcontratoview
fn_explosionessubcontratos_read_paged
```

## Presupuestos Conceptos [Dev-Demo-Producción]

fn_presupuestosconceptos_read_paged

## Explosión Insumos [Dev-Demo-Producción]

fn_explosiones_read_paged

## Corporativo [Dev-Demo-Producción]

``` SQL
ALTER TABLE "Corporativos"
ADD COLUMN "PresentacionAddControl" BOOLEAN NOT NULL DEFAULT FALSE;
``` 
## Presupuesto Params [Dev-Demo-Producción]

``` SQL
ALTER TABLE "PresupuestosParams"
ADD COLUMN "FechaInicio" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;
``` 

## Empresa Facturación Params [Dev-Demo-Producción]

``` SQL
ALTER TABLE "EmpresasParamsFacturacion"
ADD COLUMN "ApiKeyDemo" TEXT NULL,
ADD COLUMN "MedioEmisionDemo" TEXT NULL,
ADD COLUMN "BaseUrlDemo" TEXT NULL;


ALTER TABLE "EmpresasParamsFacturacion"
DROP COLUMN "Clave";
``` 

## Otros Gastos [Dev-Demo-Producción]
``` SQL
-- public."OtrosGastos" definition
-- Drop table
-- DROP TABLE public."OtrosGastos";

CREATE TABLE public."OtrosGastos" (
"Id" int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
"IdCentroCosto" int4 NOT NULL,
"IdProveedor" int4 NOT NULL,
"Fecha" date NOT NULL,
"ConceptoGasto" varchar(20) NOT NULL,
"Subtotal" numeric(18, 4) NOT NULL,
"Importe" numeric(18, 4) NOT NULL,
"Pagado" bool DEFAULT false NOT NULL,
"IdUsuarioRegistro" int4 NOT NULL,
"FechaRegistro" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
"IdUsuarioModifico" int4 NOT NULL,
"FechaModifico" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
"Activo" bool DEFAULT true NOT NULL,
CONSTRAINT "OtrosGastos_pkey" PRIMARY KEY ("Id")
);

CREATE INDEX ix_otrosgastos_id ON public."OtrosGastos" USING btree ("Id");
CREATE INDEX ix_otrosgastos_idcentrocosto ON public."OtrosGastos" USING btree ("IdCentroCosto");
CREATE INDEX ix_otrosgastos_idproveedor ON public."OtrosGastos" USING btree ("IdProveedor");
CREATE INDEX ix_otrosgastos_idusuarioregistro ON public."OtrosGastos" USING btree ("IdUsuarioRegistro");
CREATE INDEX ix_otrosgastos_idusuariomodifico ON public."OtrosGastos" USING btree ("IdUsuarioModifico");

-- public."OtrosGastos" foreign keys

ALTER TABLE public."OtrosGastos" ADD CONSTRAINT "fk_OtrosGastos_IdCentroCosto"
FOREIGN KEY ("IdCentroCosto") REFERENCES public."CentrosCostos"("Id");

ALTER TABLE public."OtrosGastos" ADD CONSTRAINT "fk_OtrosGastos_IdProveedor"
FOREIGN KEY ("IdProveedor") REFERENCES public."Proveedores"("Id");

ALTER TABLE public."OtrosGastos" ADD CONSTRAINT "fk_OtrosGastos_IdUsuarioRegistro"
FOREIGN KEY ("IdUsuarioRegistro") REFERENCES public."Usuarios"("Id");

ALTER TABLE public."OtrosGastos" ADD CONSTRAINT "fk_OtrosGastos_IdUsuarioModifico"
FOREIGN KEY ("IdUsuarioModifico") REFERENCES public."Usuarios"("Id");

-- FUNCIÓN PAGED
fn_OtrosGastos_Read_Paged
```

## Permisos Otros Gastos [Dev-Demo-Producción]
``` SQL
--- TABLA: Modulos
INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")
VALUES
(1, 'Otros Gastos', 'modulo_otro_gasto', 3, 3, 'menu_gestion_obra_presupuestacion');

---TABLA MODULOS ACCIONES
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (199,'Acceso','modulo_otro_gasto_acceso',3,3);
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (199,'Registrar','modulo_otro_gasto_registrar',3,3);
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (199,'Editar','modulo_otro_gasto_editar',3,3);
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (199,'Eliminar','modulo_otro_gasto_eliminar',3,3);
```

## Análisis Avance [Dev-Demo-Producción]
``` SQL
fn_explosioninsumoavance_analisis_concepto_read_paged
fn_explosioninsumoavance_analisis_partida_read_paged
```

## Permisos Análisis [Dev-Demo-Producción]
``` SQL
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (18,'Ejercido Conceptos','modulo_presupuestos_ejercido_concepto',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (18,'Ejercido Insumos','modulo_presupuestos_ejercido_insumo',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (18,'Análisis Avance','modulo_presupuestos_analisis_avance',3,3);
```

## Tipos Insumos [Dev-Demo-Producción]
``` SQL
ALTER TABLE "TiposInsumos"
ADD COLUMN "HerramientaMenor" bool DEFAULT false NOT null;

fn_tiposinsumos_read_paged
```

## Permisos [Dev-Demo-Producción]
``` SQL
-- UNIDAD DE MEDIDA
INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")
VALUES
(1, 'Unidades medida', 'modulo_unidades_medidas', 3, 3, 'menu_catalogos_adicionales');

  
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (194,'Acceso','modulo_unidades_medidas_acceso',3,3);

-- TIPOS DE FACTURA
INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")
VALUES
(1, 'Tipos de facturas', 'modulo_tipos_facturas', 3, 3, 'menu_facturacion_catalogos');

  
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (195,'Acceso','modulo_tipos_facturas_acceso',3,3);

-- TIPOS DE PAGO
INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")
VALUES
(1, 'Tipos de pago', 'modulo_tipos_pagos', 3, 3, 'menu_facturacion_catalogos');

  
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (196,'Acceso','modulo_tipos_pagos_acceso',3,3);

-- TIPOS CODIGO DE MODIFICACIÓN
INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")
VALUES
(1, 'Tipos de código de modificación', 'modulo_tipos_codigos_modificaciones', 3, 3, 'menu_facturacion_catalogos');

  
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (198,'Acceso','modulo_tipos_codigos_modificaciones_acceso',3,3);


--- ELIMINAR: modulo_presupuestos_analisis
--- ELIMINAR: modulo_avance_fisico
```

## Presupuestos Conceptos [Dev-Demo-Producción]
``` SQL
ALTER TABLE "PresupuestosConceptos"
ADD COLUMN "HerramientaMenor" BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE "PresupuestosConceptos"  
ADD COLUMN "ImporteMatrizCondicion" numeric(18,6) NOT NULL DEFAULT 0;

fn_presupuestosconceptos_read_paged
fn_presupuestosmatriz_read
```