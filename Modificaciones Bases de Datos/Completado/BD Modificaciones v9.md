---
tipo: changelog-bd
estado: completado
tags:
  - bd
  - postgresql
---

Índice: [[Índice]]

## Subcontratos [DevFeature]
``` SQL
CREATE OR REPLACE FUNCTION public.fn_explosionessubcontratos_read_paged(

p_start INTEGER,

p_limit INTEGER,

p_search TEXT,

p_idcentrocosto INTEGER DEFAULT NULL::INTEGER,

p_idusuario INTEGER DEFAULT NULL::INTEGER,

p_idproveedor INTEGER DEFAULT NULL::INTEGER

)

RETURNS TABLE (

totalcount BIGINT,

rownum BIGINT,

id INTEGER,

idcentrocosto INTEGER,

codigo VARCHAR,

idproveedor INTEGER,

nombre VARCHAR,

observaciones TEXT,

fechainicial TIMESTAMP WITHOUT TIME ZONE,

fechafinal TIMESTAMP WITHOUT TIME ZONE,

idusuarioregistro INTEGER,

fecharegistro TIMESTAMP WITHOUT TIME ZONE,

idusuariomodifico INTEGER,

fechamodifico TIMESTAMP WITHOUT TIME ZONE,

activo BOOLEAN,

clave VARCHAR,

idpresupuestomoneda INTEGER,

folio INTEGER,

iniciarautorizacion BOOLEAN,

centrocostoid INTEGER,

centrocostonombre VARCHAR,

centrocostocodigo VARCHAR,

tipocentrocostonombre VARCHAR,

proveedorid INTEGER,

proveedoridempresa INTEGER,

proveedoridregimenfiscal INTEGER,

proveedornombrecontacto VARCHAR,

proveedornombrecomercial VARCHAR,

proveedorrazonsocial VARCHAR,

proveedorrfc VARCHAR,

empresaid INTEGER,

empresanombre VARCHAR,

empresanombrecomercial VARCHAR,

empresarazonsocial VARCHAR,

empresarfc VARCHAR,

usuarioregistronombre VARCHAR,

usuarioregistroapellidopaterno VARCHAR,

usuarioregistroapellidomaterno VARCHAR,

usuariomodificonombre VARCHAR,

usuariomodificoapellidopaterno VARCHAR,

usuariomodificoapellidomaterno VARCHAR,

presupuestomonedaid INTEGER,

presupuestomonedaidmoneda INTEGER,

presupuestomonedaidpresupuesto INTEGER,

presupuestomonedatipocambio NUMERIC,

presupuestomonedafavorita BOOLEAN,

monedaid INTEGER,

monedaclave VARCHAR,

monedanombre VARCHAR,

monedaidusuarioregistro INTEGER,

monedafecharegistro TIMESTAMP WITHOUT TIME ZONE,

monedaidusuariomodifico INTEGER,

monedafechamodifico TIMESTAMP WITHOUT TIME ZONE,

monedaactivo BOOLEAN,

TipoSubcontratoId integer ,

TipoSubcontratoNombre character varying ,

TipoSubcontratoDescripcion character varying ,

ultimoestatus TEXT,

idrolautorizar INTEGER,

siguienteestatus TEXT,

totalmonedasubcontrato NUMERIC,

totalmonedapresupuesto NUMERIC,

SubcontratoMonedaId INTEGER,

SubcontratoTipoCambio NUMERIC,

SubcontratoMonedaClave VARCHAR,

SubcontratoMonedaNombre VARCHAR

)

LANGUAGE plpgsql

AS $function$

BEGIN

  

RETURN QUERY

SELECT

COUNT(*) OVER() AS TotalCount,

ROW_NUMBER() OVER (ORDER BY subcontrato."Id") AS RowNum,

  

subcontrato."Id",

subcontrato."IdCentroCosto",

subcontrato."Codigo",

subcontrato."IdProveedor",

subcontrato."Nombre",

subcontrato."Observaciones",

subcontrato."FechaInicial",

subcontrato."FechaFinal",

subcontrato."IdUsuarioRegistro",

subcontrato."FechaRegistro",

subcontrato."IdUsuarioModifico",

subcontrato."FechaModifico",

subcontrato."Activo",

subcontrato."Clave",

subcontrato."IdPresupuestoMoneda",

subcontrato."Folio",

subcontrato."IniciarAutorizacion",

  

subcontrato."CentroCostoId",

subcontrato."CentroCostoNombre",

subcontrato."CentroCostoCodigo",

subcontrato."TipoCentroCostoNombre",

  

subcontrato."ProveedorId",

subcontrato."ProveedorIdEmpresa",

subcontrato."ProveedorIdRegimenFiscal",

subcontrato."ProveedorNombreContacto",

subcontrato."ProveedorNombreComercial",

subcontrato."ProveedorRazonSocial",

subcontrato."ProveedorRfc",

  

subcontrato."EmpresaId",

subcontrato."EmpresaNombre",

subcontrato."EmpresaNombreComercial",

subcontrato."EmpresaRazonSocial",

subcontrato."EmpresaRFC",

  

subcontrato."UsuarioRegistroNombre",

subcontrato."UsuarioRegistroApellidoPaterno",

subcontrato."UsuarioRegistroApellidoMaterno",

  

subcontrato."UsuarioModificoNombre",

subcontrato."UsuarioModificoApellidoPaterno",

subcontrato."UsuarioModificoApellidoMaterno",

  

subcontrato."PresupuestoMonedaId",

subcontrato."PresupuestoMonedaIdMoneda",

subcontrato."PresupuestoMonedaIdPresupuesto",

subcontrato."PresupuestoMonedaTipoCambio",

subcontrato."PresupuestoMonedaFavorita",

  

subcontrato."MonedaId",

subcontrato."MonedaClave",

subcontrato."MonedaNombre",

subcontrato."MonedaIdUsuarioRegistro",

subcontrato."MonedaFechaRegistro",

subcontrato."MonedaIdUsuarioModifico",

subcontrato."MonedaFechaModifico",

subcontrato."MonedaActivo",

  

subcontrato."TipoSubcontratoId",

subcontrato."TipoSubcontratoNombre",

subcontrato."TipoSubcontratoDescripcion",

  

calculos_estatus."ultimo_estatus",

calculos_estatus."ultimo_rol_id",

calculos_estatus."siguiente_estatus",

  

COALESCE(

totales.totalmonedasubcontrato,

0

) AS totalmonedasubcontrato,

COALESCE(

totales.totalmonedasubcontrato,

0

) * COALESCE(

subcontrato."SubcontratoTipoCambio",

1

) AS totalmonedapresupuesto,

subcontrato."SubcontratoMonedaId",

subcontrato."SubcontratoTipoCambio",

subcontrato."SubcontratoMonedaClave",

subcontrato."SubcontratoMonedaNombre"

  

FROM explosionsubcontratoview AS subcontrato

  

LEFT JOIN LATERAL fn_calculosExplosionessubcontratosestatus(

subcontrato."Id",

subcontrato."EmpresaId"

) AS calculos_estatus ON TRUE

  

  

LEFT JOIN (

SELECT

d."IdExplosionSubcontrato",

COALESCE(

SUM(d."Cantidad" * d."Precio"),

0

) AS totalmonedasubcontrato

FROM "ExplosionesSubcontratosDetalles" d

WHERE d."Activo" = TRUE

GROUP BY d."IdExplosionSubcontrato"

) totales

ON totales."IdExplosionSubcontrato" = subcontrato."Id"

  

WHERE

(p_idCentroCosto IS NULL OR subcontrato."IdCentroCosto" = p_idCentroCosto)

AND (p_idProveedor IS NULL OR subcontrato."IdProveedor" = p_idProveedor)

AND (

p_idUsuario IS NULL

OR (

subcontrato."EmpresaId" IN (

SELECT "IdEmpresa"

FROM "UsuariosEmpresas"

WHERE "IdUsuario" = p_idUsuario

)

AND subcontrato."IdCentroCosto" IN (

SELECT "IdCentroCosto"

FROM "UsuariosCentrosCostos"

WHERE "IdUsuario" = p_idUsuario

)

)

)

AND (

p_search IS NULL

OR subcontrato."Nombre" ILIKE '%' || p_search || '%'

OR subcontrato."Codigo" ILIKE '%' || p_search || '%'

OR subcontrato."Clave" ILIKE '%' || p_search || '%'

OR subcontrato."Observaciones" ILIKE '%' || p_search || '%'

OR subcontrato."CentroCostoNombre" ILIKE '%' || p_search || '%'

OR subcontrato."CentroCostoCodigo" ILIKE '%' || p_search || '%'

OR subcontrato."ProveedorNombreContacto" ILIKE '%' || p_search || '%'

OR subcontrato."ProveedorNombreComercial" ILIKE '%' || p_search || '%'

OR subcontrato."ProveedorRazonSocial" ILIKE '%' || p_search || '%'

OR subcontrato."ProveedorRfc" ILIKE '%' || p_search || '%'

OR subcontrato."EmpresaNombre" ILIKE '%' || p_search || '%'

OR subcontrato."EmpresaNombreComercial" ILIKE '%' || p_search || '%'

OR subcontrato."EmpresaRazonSocial" ILIKE '%' || p_search || '%'

OR subcontrato."EmpresaRFC" ILIKE '%' || p_search || '%'

OR subcontrato."UsuarioRegistroNombre" ILIKE '%' || p_search || '%'

OR subcontrato."UsuarioRegistroApellidoPaterno" ILIKE '%' || p_search || '%'

OR subcontrato."UsuarioRegistroApellidoMaterno" ILIKE '%' || p_search || '%'

OR subcontrato."UsuarioModificoNombre" ILIKE '%' || p_search || '%'

OR subcontrato."UsuarioModificoApellidoPaterno" ILIKE '%' || p_search || '%'

OR subcontrato."UsuarioModificoApellidoMaterno" ILIKE '%' || p_search || '%'

)

  

ORDER BY subcontrato."Id" DESC

OFFSET p_start

LIMIT p_limit;

  

END;

$function$;
```

## Subcontratos Detalles [DevFeature]
``` SQL
-- fn_ExplosionesSubcontratosDetalles_Read_Paged
```
## Unidades Medida [Local-Dev-Demo-Producción]
``` SQL
BEGIN;

-- 1. Agregar la columna (nullable)
ALTER TABLE "UnidadesMedidas"
    ADD COLUMN "IdCorporativo" int4 NULL;

-- 2. Agregar la Foreign Key
ALTER TABLE "UnidadesMedidas"
    ADD CONSTRAINT "FK_UnidadesMedidas_Corporativos"
    FOREIGN KEY ("IdCorporativo")
    REFERENCES "Corporativos" ("Id");

-- 3. Crear el índice
CREATE INDEX "IX_UnidadesMedidas_IdCorporativo"
    ON "UnidadesMedidas" ("IdCorporativo");

COMMIT;
```

## Aditivas Estatus [Dev]
``` SQL
fn_calculosaditivasestatus
```
## Deductivas Estatus [Dev]
``` SQL
fn_calculosdeductivasestatus
```
## Permisos Unidades Medida [Dev-Demo-Producción]
``` SQL
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (194,'Registrar','modulo_unidades_medidas_registrar',3,3);
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (194,'Editar','modulo_unidades_medidas_editar',3,3);
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (194,'Eliminar','modulo_unidades_medidas_eliminar',3,3);
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (194,'Eliminar masivo','modulo_unidades_medidas_eliminar_masivo',3,3);
```
## Presupuestos Matriz [Dev-Demo-Producción]
``` SQL
ALTER TABLE "PresupuestosMatriz"
ADD COLUMN "CantidadRendimiento" numeric(18,4) NOT NULL DEFAULT 0,
ADD COLUMN "Operador" char(1) NOT NULL DEFAULT '*'
CONSTRAINT "CK_PresupuestosMatriz_Operador" CHECK ("Operador" IN ('*', '/'));

UPDATE "PresupuestosMatriz"
SET "CantidadRendimiento" = "Cantidad";
```
## Tipos Insumos [Dev-Demo-Producción]
``` SQL
ALTER TABLE "TiposInsumos"
    ADD COLUMN "Porcentaje" BOOLEAN NOT NULL DEFAULT FALSE;
    

CREATE TABLE public."TiposInsumosPorcentajes" (
	"IdTipoInsumoPorcentaje" int4 NOT NULL,
	"IdTipoInsumoAsociado" int4 NOT NULL,
	"Id" int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	CONSTRAINT "CK_TIP_NoAutoRef" CHECK (("IdTipoInsumoPorcentaje" <> "IdTipoInsumoAsociado")),
	CONSTRAINT "PK_TiposInsumosPorcentajes" PRIMARY KEY ("Id"),
	CONSTRAINT "UQ_TIP_Par" UNIQUE ("IdTipoInsumoPorcentaje", "IdTipoInsumoAsociado")
);

ALTER TABLE public."TiposInsumosPorcentajes" ADD CONSTRAINT "FK_TIP_Asociado" FOREIGN KEY ("IdTipoInsumoAsociado") REFERENCES public."TiposInsumos"("Id");

ALTER TABLE public."TiposInsumosPorcentajes" ADD CONSTRAINT "FK_TIP_Porcentaje" FOREIGN KEY ("IdTipoInsumoPorcentaje") REFERENCES public."TiposInsumos"("Id");
```

## Insumos [Dev-Demo-Producción]
``` SQL
-- fn_insumos_read_paged
```

``` SQL
ALTER TABLE "TiposProveedoresDocumentos"
ADD COLUMN "VerificarRepse" boolean NOT NULL DEFAULT false;

-- 1. Agregar la columna
ALTER TABLE public."ProveedoresRepse"
ADD COLUMN "IdDocumento" int4 NULL;

-- 2. Crear el índice sobre la columna
CREATE INDEX "ix_ProveedoresRepse_IdDocumento"
ON public."ProveedoresRepse" USING btree ("IdDocumento");

-- 3. Agregar la restricción de llave foránea
ALTER TABLE public."ProveedoresRepse"
ADD CONSTRAINT "FK_ProveedoresRepse_IdDocumento"
FOREIGN KEY ("IdDocumento") REFERENCES public."Documentos"("Id");

-- public."ProveedoresRepseActividades" definition

-- Drop table

-- DROP TABLE public."ProveedoresRepseActividades";

CREATE TABLE public."ProveedoresRepseActividades" (
	"Id" int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	"IdProveedorRepse" int4 NOT NULL,
	"Folio" varchar(100) NOT NULL,
	"Descripcion" text NOT NULL,
	"IdUsuarioRegistro" int4 NOT NULL,
	"FechaRegistro" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
	CONSTRAINT "ProveedoresRepseActividades_pkey" PRIMARY KEY ("Id")
);
CREATE INDEX "ix_ProveedoresRepseActividades_IdProveedorRepse" ON public."ProveedoresRepseActividades" USING btree ("IdProveedorRepse");


-- public."ProveedoresRepseActividades" foreign keys

ALTER TABLE public."ProveedoresRepseActividades" ADD CONSTRAINT "FK_ProveedoresRepseActividades_IdProveedorRepse" FOREIGN KEY ("IdProveedorRepse") REFERENCES public."ProveedoresRepse"("Id");
ALTER TABLE public."ProveedoresRepseActividades" ADD CONSTRAINT "FK_ProveedoresRepseActividades_IdUsuarioRegistro" FOREIGN KEY ("IdUsuarioRegistro") REFERENCES public."Usuarios"("Id");



fn_ProveedoresDocumentos_Read_Paged
fn_TipoProveedoresDocumentos_Read_Paged
fn_Proveedores_Read_Paged

ProveedoresDocumentosView
TipoProveedorDocumentoView
```