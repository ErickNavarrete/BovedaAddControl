### Permisos Etapas Contacto [Listo]

``` SQL
--- WEB
INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")
VALUES
(1, 'Etapa Contacto', 'modulo_etapa_contacto', 3, 3, 'menu_crm_catalogos');

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (141,'Acceso','modulo_etapa_contacto_acceso',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (141,'Registrar','modulo_etapa_contacto_registrar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (141,'Editar','modulo_etapa_contacto_editar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (141,'Eliminar','modulo_etapa_contacto_eliminar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (141,'Eliminar masivo','modulo_etapa_contacto_eliminar_masivo',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (141,'Rotacion','modulo_etapa_contacto_rotacion',3,3);

---MOVIL
INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")
VALUES
(2, 'Etapa Contacto', 'modulo_etapa_contacto', 3, 3, 'menu_crm_catalogos');

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (142,'Acceso','modulo_etapa_contacto_acceso',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (142,'Registrar','modulo_etapa_contacto_registrar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (142,'Editar','modulo_etapa_contacto_editar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (142,'Eliminar','modulo_etapa_contacto_eliminar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (142,'Eliminar masivo','modulo_etapa_contacto_eliminar_masivo',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (142,'Rotacion','modulo_etapa_contacto_rotacion',3,3);
```

### Permisos Tipos Contacto [Listo]

``` SQL
--- WEB
INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")
VALUES
(1, 'Tipo Contacto', 'modulo_tipo_contacto', 3, 3, 'menu_crm_catalogos');

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (143,'Acceso','modulo_tipo_contacto_acceso',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (143,'Registrar','modulo_tipo_contacto_registrar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (143,'Editar','modulo_tipo_contacto_editar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (143,'Eliminar','modulo_tipo_contacto_eliminar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (143,'Eliminar masivo','modulo_tipo_contacto_eliminar_masivo',3,3);

---MOVIL
INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")
VALUES
(2, 'Tipo Contacto', 'modulo_tipo_contacto', 3, 3, 'menu_crm_catalogos');

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (144,'Acceso','modulo_tipo_contacto_acceso',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (144,'Registrar','modulo_tipo_contacto_registrar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (144,'Editar','modulo_tipo_contacto_editar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (144,'Eliminar','modulo_tipo_contacto_eliminar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (144,'Eliminar masivo','modulo_tipo_contacto_eliminar_masivo',3,3);

```

### Permisos Ocupación [Listo]

``` SQL
--- WEB
INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")
VALUES
(1, 'Ocupaciones', 'modulo_ocupacion', 3, 3, 'menu_crm_catalogos');

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (145,'Acceso','modulo_ocupacion_acceso',3,3);

---MOVIL
INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")
VALUES
(2, 'Ocupaciones', 'modulo_ocupacion', 3, 3, 'menu_crm_catalogos');

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (146,'Acceso','modulo_ocupacion_acceso',3,3);
```

### Permisos Tipo Empresas [Listo]

``` SQL
--- WEB
INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")
VALUES
(1, 'Tipo Empresa', 'modulo_tipo_empresa', 3, 3, 'menu_crm_catalogos');

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (147,'Acceso','modulo_tipo_empresa_acceso',3,3);

---MOVIL
INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")
VALUES
(2, 'Tipo Empresa', 'modulo_tipo_empresa', 3, 3, 'menu_crm_catalogos');

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (148,'Acceso','modulo_tipo_empresa_acceso',3,3);
```

### Permisos Tipo Empresas Constituida [Listo]

``` SQL
--- WEB
INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")
VALUES
(1, 'Tipo Empresa Constituida', 'modulo_tipo_empresa_constituida', 3, 3, 'menu_crm_catalogos');

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (149,'Acceso','modulo_tipo_empresa_constituida_acceso',3,3);

---MOVIL
INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")
VALUES
(2, 'Tipo Empresa Constituida', 'modulo_tipo_empresa_constituida', 3, 3, 'menu_crm_catalogos');

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (150,'Acceso','modulo_tipo_empresa_constituida_acceso',3,3);
```

### Ordenes Compra

``` SQL
ALTER TABLE "OrdenesCompras" ADD COLUMN "Observaciones" TEXT;
```

### Presupuestos Partidas

``` SQL
ALTER TABLE "PresupuestosPartidas" ADD COLUMN "Orden" INTEGER NOT NULL DEFAULT 0;

ALTER TABLE "PresupuestosConceptos" ADD COLUMN "Orden" INTEGER NOT NULL DEFAULT 0;

fn_presupuestospartidas_read
fn_presupuestosconceptos_read
fn_presupuestosconceptos_read_paged
```

### Corporativos [Listo]

``` SQL
ALTER TABLE "Corporativos" ADD COLUMN "ImagenUrl" VARCHAR(250) NULL;
```
### Permisos [Listo]

``` SQL
INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre") VALUES (1, 'Tipo Proveedor', 'modulo_tipo_proveedor', 3, 3, 'menu_catalogos_adicionales');

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (153,'Acceso','modulo_tipo_proveedor_acceso',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (153,'Registrar','modulo_tipo_proveedor_registrar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (153,'Editar','modulo_tipo_proveedor_editar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (153,'Eliminar','modulo_tipo_proveedor_eliminar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (153,'Eliminar masivo','modulo_tipo_proveedor_eliminar_masivo',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (153,'Exportar','modulo_tipo_proveedor_exportar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (153,'Importar','modulo_tipo_proveedor_importar',3,3);
```

``` SQL
INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre") VALUES (1, 'Tipo de Asesores', 'modulo_tipo_asesor', 3, 3, 'menu_crm_catalogos');

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (154,'Acceso','modulo_tipo_asesor_acceso',3,3);
```

``` SQL
INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre") VALUES (1, 'Grupo de Asesores', 'modulo_grupo_asesor', 3, 3, 'menu_crm_catalogos');

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (155,'Acceso','modulo_grupo_asesor_acceso',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (155,'Registrar','modulo_grupo_asesor_registrar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (155,'Editar','modulo_grupo_asesor_editar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (155,'Eliminar','modulo_grupo_asesor_eliminar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (155,'Eliminar masivo','modulo_grupo_asesor_eliminar_masivo',3,3);
```

``` SQL
INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre") VALUES (1, 'Asesor de Ventas', 'modulo_asesor_venta', 3, 3, 'menu_crm_catalogos');

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (156,'Acceso','modulo_asesor_venta_acceso',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (156,'Registrar','modulo_asesor_venta_registrar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (156,'Editar','modulo_asesor_venta_editar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (156,'Eliminar','modulo_asesor_venta_eliminar',3,3);

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (156,'Eliminar masivo','modulo_asesor_venta_eliminar_masivo',3,3);
```

### Permisos IA [Listo]

``` SQL
INSERT INTO public."Modulos"
("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre") VALUES (1, 'IA', 'modulo_ia', 3, 3, 'menu_herramientas');

INSERT INTO public."ModulosAcciones" ("IdModulo","Nombre","Tag","IdUsuarioRegistro","IdUsuarioModifico") VALUES (157,'Acceso','modulo_ia_acceso',3,3);
```