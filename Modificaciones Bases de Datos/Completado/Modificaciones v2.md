---
tipo: changelog-bd
estado: completado
tags: [bd, postgresql]
---

Índice: [[Índice]]

### Bitácora Filtro Fechas

fn_bitacoracentrocosto_read_paged

### Análisis Requisiciones

``` SQL
---MOVIL
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (53,'Análisis Requisiciones','modulo_requisiciones_analisis',3,3);
```

### Cambios funciones

fn_explosiones_read_paged
fn_aditivas_read_paged
fn_Deductivas_Read_Paged
fn_explosionessubcontratos_read_paged
fn_estimaciones_read_paged
fn_OrdenesCompras_Read_Paged
fn_recepcionesinsumos_read_paged
fn_salidasinsumos_read_paged
fn_devolucionesinsumos_read_paged

### Permisos Historial Movimientos


``` SQL
INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")
VALUES
(1, 'Historial Movimientos', 'modulo_historial_movimientos', 3, 3, 'menu_herramientas')

---WEB
INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (140,'Acceso','modulo_historial_movimientos_acceso',3,3);
```

### Reportes

``` SQL
INSERT INTO "TiposReportes" ("Nombre", "Tag") VALUES
('Estimaciones', '##Estimaciones'),
('OrdenCompra', '##OrdenesCompra'),
('RecepcionInsumo', '##RecepcionesInsumo'),
('Subcontrato', '##Subcontratos');
```

TipoProveedorDocumentoView
fn_presupuesto_programacion_read

### Usuarios Módulos Notificaciones
``` SQL
-- public."UsuariosModulosNotificaciones" definition

-- Drop table

-- DROP TABLE public."UsuariosModulosNotificaciones";

CREATE TABLE public."UsuariosModulosNotificaciones" (
	"Id" int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	"IdUsuario" int4 NOT NULL,
	"IdSistema" int4 NOT NULL,
	"TagModulo" varchar(200) NOT NULL,
	"RecibeNotificacion" bool DEFAULT true NOT NULL,
	"IdUsuarioRegistro" int4 NOT NULL,
	"FechaRegistro" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
	"IdUsuarioModifico" int4 NOT NULL,
	"FechaModifico" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
	CONSTRAINT "UsuariosModulosNotificaciones_pkey" PRIMARY KEY ("Id"),
	CONSTRAINT unique_idusuario_idsistema_tagmodulo UNIQUE ("IdUsuario", "IdSistema", "TagModulo")
);
CREATE INDEX ix_usuariosmodulosnotificaciones_id ON public."UsuariosModulosNotificaciones" USING btree ("Id");
CREATE INDEX ix_usuariosmodulosnotificaciones_idsistema ON public."UsuariosModulosNotificaciones" USING btree ("IdSistema");
CREATE INDEX ix_usuariosmodulosnotificaciones_idusuario ON public."UsuariosModulosNotificaciones" USING btree ("IdUsuario");
CREATE INDEX ix_usuariosmodulosnotificaciones_idusuariomodifico ON public."UsuariosModulosNotificaciones" USING btree ("IdUsuarioModifico");
CREATE INDEX ix_usuariosmodulosnotificaciones_idusuarioregistro ON public."UsuariosModulosNotificaciones" USING btree ("IdUsuarioRegistro");


-- public."UsuariosModulosNotificaciones" foreign keys

ALTER TABLE public."UsuariosModulosNotificaciones" ADD CONSTRAINT "fk_UsuariosModulosNotificaciones_IdSistema" FOREIGN KEY ("IdSistema") REFERENCES public."Sistemas"("Id");
ALTER TABLE public."UsuariosModulosNotificaciones" ADD CONSTRAINT "fk_UsuariosModulosNotificaciones_IdSistema_TagModulo" FOREIGN KEY ("IdSistema","TagModulo") REFERENCES public."Modulos"("IdSistema","Tag") ON DELETE CASCADE;
ALTER TABLE public."UsuariosModulosNotificaciones" ADD CONSTRAINT "fk_UsuariosModulosNotificaciones_IdUsuario" FOREIGN KEY ("IdUsuario") REFERENCES public."Usuarios"("Id");
ALTER TABLE public."UsuariosModulosNotificaciones" ADD CONSTRAINT "fk_UsuariosModulosNotificaciones_IdUsuarioModifico" FOREIGN KEY ("IdUsuarioModifico") REFERENCES public."Usuarios"("Id");
ALTER TABLE public."UsuariosModulosNotificaciones" ADD CONSTRAINT "fk_UsuariosModulosNotificaciones_IdUsuarioRegistro" FOREIGN KEY ("IdUsuarioRegistro") REFERENCES public."Usuarios"("Id");
```