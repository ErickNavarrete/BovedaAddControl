---
tipo: changelog-bd
estado: completado
tags: [bd, postgresql]
---

Índice: [[Índice]]

## Contactos [Dev-Demo-Producción]
``` SQL
-- ETAPAS CONTACTOS
ALTER TABLE public."EtapasContactos" ALTER COLUMN "GenerarOportunidad" SET DEFAULT false;

-- ASESORES VENTA
ALTER TABLE "AsesoresVentas"
ADD COLUMN "OrdenRotacion" INTEGER NULL;

-- CONTACTOS ASESORES
ALTER TABLE "ContactosAsesores"
ADD COLUMN "FechaAsignacion" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- CONTACTOS
ALTER TABLE public."Contactos"
ADD COLUMN "IdGrupo" INTEGER,
ADD COLUMN "UrlImagen" VARCHAR(450),
ADD COLUMN "Calificado" BOOLEAN DEFAULT FALSE,
ADD COLUMN "Gestionar" BOOLEAN DEFAULT TRUE,
ADD COLUMN "Modificado" BOOLEAN DEFAULT FALSE;

ALTER TABLE public."Contactos" RENAME COLUMN "Modificado" TO "NuevoAsignado";

CREATE INDEX ix_contactos_idgrupo
ON public."Contactos"
USING btree ("IdGrupo");

ALTER TABLE public."Contactos"
ADD CONSTRAINT "fk_Contactos_IdGrupo"
FOREIGN KEY ("IdGrupo")
REFERENCES public."AsesoresGrupos"("Id");

```

## Contactos Origen [Dev-Demo-Producción]
``` SQL
CREATE TABLE public."ContactosOrigenes" (
    "Id" INT GENERATED ALWAYS AS IDENTITY,
    "IdContacto" INT NOT NULL,
    "IdMedioContacto" INT NOT NULL,
    "IdCampania" INT NOT NULL,
    "FechaOrigen" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT "ContactosOrigenes_pkey" PRIMARY KEY ("Id")
);

-- Índices
CREATE INDEX ix_contactosorigenes_idcontacto
    ON public."ContactosOrigenes" USING btree ("IdContacto");

CREATE INDEX ix_contactosorigenes_idmediocontacto
    ON public."ContactosOrigenes" USING btree ("IdMedioContacto");

CREATE INDEX ix_contactosorigenes_idcampania
    ON public."ContactosOrigenes" USING btree ("IdCampania");

-- Foreign Keys con ALTER TABLE
ALTER TABLE public."ContactosOrigenes"
ADD CONSTRAINT "fk_ContactosOrigenes_IdContacto"
FOREIGN KEY ("IdContacto")
REFERENCES public."Contactos"("Id");

ALTER TABLE public."ContactosOrigenes"
ADD CONSTRAINT "fk_ContactosOrigenes_IdMedioContacto"
FOREIGN KEY ("IdMedioContacto")
REFERENCES public."MediosContactos"("Id");

ALTER TABLE public."ContactosOrigenes"
ADD CONSTRAINT "fk_ContactosOrigenes_IdCampania"
FOREIGN KEY ("IdCampania")
REFERENCES public."Campanias"("Id");
```

## Contactos Tareas [Dev-Demo-Producción]
``` SQL
-- ESTATUS TAREAS
CREATE TABLE "EstatusTareasContactos" (
"Id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
"Nombre" VARCHAR(255) NOT NULL,
"Descripcion" VARCHAR(500) NOT NULL,
"Tipo" INT NOT NULL
);

CREATE INDEX "IDX_EstatusTareasContactos_Id"
ON "EstatusTareasContactos" ("Id");

-- TIPOS TAREAS
CREATE TABLE public."TiposTareasContactos" (
"Id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
"IdCorporativo" int4 NOT NULL,
"Nombre" varchar(255) NOT NULL,
"Descripcion" varchar(500) NULL,
"IdUsuarioRegistro" int4 NOT NULL,
"FechaRegistro" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
"IdUsuarioModifico" int4 NOT NULL,
"FechaModifico" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
"Activo" bool DEFAULT true NOT NULL
);


CREATE INDEX ix_tipostareascontactos_id
ON public."TiposTareasContactos" USING btree ("Id");

CREATE INDEX ix_tipostareascontactos_idcorporativo
ON public."TiposTareasContactos" USING btree ("IdCorporativo");

CREATE INDEX ix_tipostareascontactos_idusuarioregistro
ON public."TiposTareasContactos" USING btree ("IdUsuarioRegistro");

CREATE INDEX ix_tipostareascontactos_idusuariomodifico
ON public."TiposTareasContactos" USING btree ("IdUsuarioModifico");
 
ALTER TABLE public."TiposTareasContactos"
ADD CONSTRAINT "fk_TiposTareasContactos_IdCorporativo"
FOREIGN KEY ("IdCorporativo")
REFERENCES public."Corporativos"("Id");

ALTER TABLE public."TiposTareasContactos"
ADD CONSTRAINT "fk_TiposTareasContactos_IdUsuarioRegistro"
FOREIGN KEY ("IdUsuarioRegistro")
REFERENCES public."Usuarios"("Id");

ALTER TABLE public."TiposTareasContactos"
ADD CONSTRAINT "fk_TiposTareasContactos_IdUsuarioModifico"
FOREIGN KEY ("IdUsuarioModifico")
REFERENCES public."Usuarios"("Id");

-- CONTACTOS TAREAS
CREATE TABLE public."ContactosTareas" (
"Id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
"IdContacto" int4 NOT NULL,
"IdTipoTarea" int4 NOT NULL,
"IdAsesorVenta" int4 NOT NULL,
"Fecha" timestamp not null,
"Comentario" varchar(500) not null,
"IdUsuarioRegistro" int4 NOT NULL,
"FechaRegistro" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
"IdUsuarioModifico" int4 NOT NULL,
"FechaModifico" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
"Activo" bool DEFAULT true NOT NULL
);

CREATE INDEX ix_contactostareas_id
ON public."ContactosTareas" USING btree ("Id");

CREATE INDEX ix_contactostareas_idcontacto
ON public."ContactosTareas" USING btree ("IdContacto");

CREATE INDEX ix_contactostareas_idtipotarea
ON public."ContactosTareas" USING btree ("IdTipoTarea");

CREATE INDEX ix_contactostareas_idasesorventa
ON public."ContactosTareas" USING btree ("IdAsesorVenta");

CREATE INDEX ix_contactostareas_idusuarioregistro
ON public."ContactosTareas" USING btree ("IdUsuarioRegistro");

CREATE INDEX ix_contactostareas_idusuariomodifico
ON public."ContactosTareas" USING btree ("IdUsuarioModifico");

  
ALTER TABLE public."ContactosTareas"
ADD CONSTRAINT "fk_ContactosTareas_IdContacto"
FOREIGN KEY ("IdContacto")
REFERENCES public."Contactos"("Id");

ALTER TABLE public."ContactosTareas"
ADD CONSTRAINT "fk_ContactosTareas_IdTipoTarea"
FOREIGN KEY ("IdTipoTarea")
REFERENCES public."TiposTareasContactos"("Id");

ALTER TABLE public."ContactosTareas"
ADD CONSTRAINT "fk_ContactosTareas_IdAsesorVenta"
FOREIGN KEY ("IdAsesorVenta")
REFERENCES public."AsesoresVentas"("Id");

ALTER TABLE public."ContactosTareas"
ADD CONSTRAINT "fk_ContactosTareas_IdUsuarioRegistro"
FOREIGN KEY ("IdUsuarioRegistro")
REFERENCES public."Usuarios"("Id");

ALTER TABLE public."ContactosTareas"
ADD CONSTRAINT "fk_ContactosTareas_IdUsuarioModifico"
FOREIGN KEY ("IdUsuarioModifico")
REFERENCES public."Usuarios"("Id");

-- CONTACTOS TAREAS ESTATUS
CREATE TABLE public."ContactosTareasEstatus" (
    "Id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "IdTarea" int4 NOT NULL,
    "IdEstatus" int4 NOT NULL,
    "Comentario" varchar(500) NOT NULL,
    "IdUsuarioRegistro" int4 NOT NULL,
    "FechaRegistro" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "IdUsuarioModifico" int4 NOT NULL,
    "FechaModifico" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "Activo" bool DEFAULT true NOT NULL
);

CREATE INDEX ix_contactostareasestatus_id 
ON public."ContactosTareasEstatus" USING btree ("Id");

CREATE INDEX ix_contactostareasestatus_idtarea 
ON public."ContactosTareasEstatus" USING btree ("IdTarea");

CREATE INDEX ix_contactostareasestatus_idestatus 
ON public."ContactosTareasEstatus" USING btree ("IdEstatus");

CREATE INDEX ix_contactostareasestatus_idusuarioregistro 
ON public."ContactosTareasEstatus" USING btree ("IdUsuarioRegistro");

CREATE INDEX ix_contactostareasestatus_idusuariomodifico 
ON public."ContactosTareasEstatus" USING btree ("IdUsuarioModifico");

ALTER TABLE public."ContactosTareasEstatus"
ADD CONSTRAINT "fk_ContactosTareasEstatus_IdTarea"
FOREIGN KEY ("IdTarea")
REFERENCES public."ContactosTareas"("Id");

ALTER TABLE public."ContactosTareasEstatus"
ADD CONSTRAINT "fk_ContactosTareasEstatus_IdEstatus"
FOREIGN KEY ("IdEstatus")
REFERENCES public."EstatusTareasContactos"("Id");

ALTER TABLE public."ContactosTareasEstatus"
ADD CONSTRAINT "fk_ContactosTareasEstatus_IdUsuarioRegistro"
FOREIGN KEY ("IdUsuarioRegistro")
REFERENCES public."Usuarios"("Id");

ALTER TABLE public."ContactosTareasEstatus"
ADD CONSTRAINT "fk_ContactosTareasEstatus_IdUsuarioModifico"
FOREIGN KEY ("IdUsuarioModifico")
REFERENCES public."Usuarios"("Id");
```

## Presupuestos Params [Dev-Demo-Producción]
``` SQL
ALTER TABLE public."PresupuestosParams"
ADD COLUMN "ColorAvance" varchar(7) DEFAULT '#F26522';
```

## Módulo [Dev-Demo-Producción]
``` SQL
INSERT INTO public."Modulos"("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre") VALUES (1, 'Programación Obra Global', 'modulo_programacion_obra_global', 3, 3, 'menu_gestion_obra_presupuestacion');

INSERT INTO public."ModulosAcciones"(
"IdModulo", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico")
VALUES (203, 'Acceso', 'modulo_programacion_obra_global_acceso', 3, 3);
```
## Avance Obra Origen [Dev-Demo-Producción]
``` SQL
CREATE TABLE public."AddControlNucleoAvanceObraOrigenes" (
    "Id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "IdAvanceObraOrigen" INT NOT NULL,
    "IdPresupuestoConcepto" INT NOT NULL,
    "IdInsumo" INT NOT NULL
);

-- FK PresupuestosConceptos
ALTER TABLE public."AddControlNucleoAvanceObraOrigenes"
ADD CONSTRAINT "fk_AddControlNucleoAvanceObraOrigenes_IdPresupuestoConcepto"
FOREIGN KEY ("IdPresupuestoConcepto")
REFERENCES public."PresupuestosConceptos"("Id");

-- FK Insumos
ALTER TABLE public."AddControlNucleoAvanceObraOrigenes"
ADD CONSTRAINT "fk_AddControlNucleoAvanceObraOrigenes_IdInsumo"
FOREIGN KEY ("IdInsumo")
REFERENCES public."Insumos"("Id");

-- Índice IdAvanceObraOrigen
CREATE INDEX "ix_AddControlNucleoAvanceObraOrigenes_IdAvanceObraOrigen"
ON public."AddControlNucleoAvanceObraOrigenes" USING btree ("IdAvanceObraOrigen");

-- Índice IdPresupuestoConcepto
CREATE INDEX "ix_AddControlNucleoAvanceObraOrigenes_IdPresupuestoConcepto"
ON public."AddControlNucleoAvanceObraOrigenes" USING btree ("IdPresupuestoConcepto");

-- Índice IdInsumo
CREATE INDEX "ix_AddControlNucleoAvanceObraOrigenes_IdInsumo"
ON public."AddControlNucleoAvanceObraOrigenes" USING btree ("IdInsumo");
```

## Comercialización Carousel [Dev-Demo-Producción]
``` SQL
ALTER TABLE "ComercializacionCarousel" ADD COLUMN "PresentacionAddControl" BOOLEAN NOT NULL DEFAULT FALSE;
```

