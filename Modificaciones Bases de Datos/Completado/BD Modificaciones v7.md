## AddControlNucleo Avance Obra [Dev-Demo-Produccion]
``` SQL
ALTER TABLE "AddControlNucleoAvanceObraOrigenes"
DROP CONSTRAINT IF EXISTS "FK_AddControlNucleoAvanceObraOrigenes_PresupuestosConceptos";

ALTER TABLE "AddControlNucleoAvanceObraOrigenes"
ADD CONSTRAINT "FK_AddControlNucleoAvanceObraOrigenes_PresupuestosConceptos"
FOREIGN KEY ("IdPresupuestoConcepto")
REFERENCES "PresupuestosConceptos
ON DELETE CASCADE;

ALTER TABLE public."AddControlNucleoAvanceObraOrigenes"  
DROP CONSTRAINT "FK_AddControlNucleoAvanceObraOrigenes_PresupuestosConceptos";

ALTER TABLE public."AddControlNucleoAvanceObraOrigenes"
DROP CONSTRAINT "fk_AddControlNucleoAvanceObraOrigenes_IdPresupuestoConcepto";


ALTER TABLE public."AddControlNucleoAvanceObraOrigenes"
ADD CONSTRAINT "fk_AddControlNucleoAvanceObraOrigenes_IdPresupuestoConcepto"
FOREIGN KEY ("IdPresupuestoConcepto")
REFERENCES public."PresupuestosConceptos"("Id")
ON DELETE CASCADE;
```

## AddControlNucleo Partida PCI [Dev-Demo-Producción]
``` SQL
CREATE TABLE public."AddControlNucleoPartidasPCI" (
    "Id" int4 GENERATED ALWAYS AS IDENTITY (
        INCREMENT BY 1
        MINVALUE 1
        MAXVALUE 2147483647
        START 1
        CACHE 1
        NO CYCLE
    ) NOT NULL,
    
    "IdPartidaPCI" int4 NOT NULL,
    "IdPresupuestoPartida" int4 NOT NULL,

    CONSTRAINT "AddControlNucleoPartidasPCI_pkey"
        PRIMARY KEY ("Id")
);

CREATE INDEX "ix_AddControlNucleoPartidasPCI_IdPartidaPCI"
    ON public."AddControlNucleoPartidasPCI"
    USING btree ("IdPartidaPCI");

CREATE INDEX "ix_AddControlNucleoPartidasPCI_IdPresupuestoPartida"
    ON public."AddControlNucleoPartidasPCI"
    USING btree ("IdPresupuestoPartida");


-- Foreign Keys
ALTER TABLE public."AddControlNucleoPartidasPCI"
ADD CONSTRAINT "FK_AddControlNucleoPartidasPCI_PresupuestosPartidas"
FOREIGN KEY ("IdPresupuestoPartida")
REFERENCES public."PresupuestosPartidas"("Id")
ON DELETE CASCADE;
```

## AddControlNucleo Notificaciones [Dev-Demo-Producción]
``` SQL
-- public."AddControlNucleoNotificaciones" definition

-- Drop table

-- DROP TABLE public."AddControlNucleoNotificaciones";

CREATE TABLE public."AddControlNucleoNotificaciones" (
	"Id" int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	"IdTablaMonitoreada" int4 NOT NULL,
	"IdUsuario" int4 NOT NULL,
	"Pk" int4 NOT NULL,
	"Leido" bool DEFAULT false NOT NULL,
	"Proceso" varchar(250) DEFAULT ''::character varying NOT NULL,
	"Proyecto" varchar(250) DEFAULT ''::character varying NOT NULL,
	"Folio" varchar(250) DEFAULT ''::character varying NOT NULL,
	"Tipo" varchar(250) DEFAULT ''::character varying NOT NULL,
	"FechaSolicitud" timestamp DEFAULT CURRENT_DATE NOT NULL,
	CONSTRAINT "AddControlNucleoNotificaciones_pkey" PRIMARY KEY ("Id")
);
CREATE INDEX "ix_AddControlNucleoNotificaciones_IdTablaMonitoreada" ON public."AddControlNucleoNotificaciones" USING btree ("IdTablaMonitoreada");
CREATE INDEX "ix_AddControlNucleoNotificaciones_IdUsuario" ON public."AddControlNucleoNotificaciones" USING btree ("IdUsuario");


-- public."AddControlNucleoNotificaciones" foreign keys

ALTER TABLE public."AddControlNucleoNotificaciones" ADD CONSTRAINT "fk_AddControlNucleoNotificaciones_IdTablaMonitoreada" FOREIGN KEY ("IdTablaMonitoreada") REFERENCES public."AddControlNucleoTablasMonitoreadas"("Id");
ALTER TABLE public."AddControlNucleoNotificaciones" ADD CONSTRAINT "fk_AddControlNucleoNotificaciones_IdUsuario" FOREIGN KEY ("IdUsuario") REFERENCES public."Usuarios"("Id");
```
## AddControlNucleo Notificaciones  View - Func [Dev-Demo-Producción]
``` SQL
AddControlNucleoNotificacionesView
fn_AddControlNucleoNotificaciones_Read_Paged
```
## ExplosionesInsumosAvances [Dev-Demo-Producción]
``` SQL
ALTER TABLE "ExplosionesInsumosAvances"
ADD COLUMN "FechaCreacion" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

ExplosionesInsumosAvancesFotograficosView
fn_ExplosionInsumoAvanceFotografico_Read_Paged
```