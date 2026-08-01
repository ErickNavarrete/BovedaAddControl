---
tipo: changelog-bd
estado: completado
tags: [bd, postgresql]
---

Índice: [[Índice]]

## Contacto Documentos [Dev-Demo-Producción]
``` SQL
ALTER TABLE "ContactosDocumentos" ADD COLUMN "Url" VARCHAR(450) NOT NULL DEFAULT '';
```

## Estatus [Dev-Demo-Producción]
``` SQL
fn_calculosaditivasestatus --
fn_CalculosDeductivasEstatus --
fn_calculossalidasinsumosestatus --
fn_CalculosRecepcionesInsumosEstatus --
fn_CalculosOrdenesComprasEstatus --
fn_CalculosRequisicionesEstatus --
fn_CalculosEstimacionesEstatus --
fn_CalculosExplosionesSubcontratosEstatus --
```

## Contactos [Dev-Demo-Producción]
``` SQL
ContactosAsesoresView --
ContactosDetallesPFisicasView --
ContactosDetallesPMoralesView --
ContactosEtapasView --
ContactosOrigenesView --
ContactosTareasView --
ContactosView -- 
ContactosViewPaged --

fn_Contactos_Read_Paged
```

## Corporativo Email Params [Dev-Demo-Producción]
``` SQL
-- public."CorporativosEmailParams" definition
-- DROP TABLE public."CorporativosEmailParams";

CREATE TABLE public."CorporativosEmailParams" (
"Id" int4 GENERATED ALWAYS AS IDENTITY (
INCREMENT BY 1
MINVALUE 1
MAXVALUE 2147483647
START 1
CACHE 1
NO CYCLE
) NOT NULL,
"IdCorporativo" int4 NOT NULL,
"Host" varchar(250) NOT NULL,
"Port" varchar(250) NOT NULL,
"SSL" boolean DEFAULT false NOT NULL,
"Correo" varchar(250) NOT NULL,
"Password" varchar(250) NOT NULL,
CONSTRAINT "CorporativosEmailParams_pkey" PRIMARY KEY ("Id")
);

-- Índices
CREATE INDEX ix_corporativosemailparams_id
ON public."CorporativosEmailParams" USING btree ("Id");

CREATE INDEX ix_corporativosemailparams_idcorporativo
ON public."CorporativosEmailParams" USING btree ("IdCorporativo");

-- Foreign Keys
ALTER TABLE public."CorporativosEmailParams"
ADD CONSTRAINT "fk_CorporativosEmailParams_IdCorporativo"
FOREIGN KEY ("IdCorporativo")
REFERENCES public."Corporativos"("Id");
```