---
tipo: changelog-bd
estado: completado
tags: [bd, postgresql]
---

Índice: [[Índice]]

## Centro Costo Params [Dev-Demo-Producción]
``` SQL
ALTER TABLE "CentrosCostosParamsAddControlNucleo"
ADD COLUMN "AvanceFisico" BOOLEAN NOT NULL DEFAULT TRUE,
ADD COLUMN "Estimacion" BOOLEAN NOT NULL DEFAULT FALSE;
```
## Permisos Dashboard [Dev-Demo-Producción]
``` SQL
INSERT INTO public."Modulos"

("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")

VALUES

(1, 'Dashboards', 'menu_dashboard', 3, 3, NULL);

  

INSERT INTO public."Modulos"

("IdSistema", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico", "Padre")

VALUES

(1, 'Dashboard gestion de proyectos', 'modulo_dashboard_gestion_proyecto', 3, 3, 'menu_dashboard');

  

INSERT INTO public."ModulosAcciones"

("IdModulo", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico")

VALUES

(152, 'Acceso', 'modulo_dashboard_gestion_proyecto_acceso', 3, 3),

(152, 'Avance programado total', 'modulo_dashboard_gestion_proyecto_avance_programado_total', 3, 3),

(152, 'Avance programado', 'modulo_dashboard_gestion_proyecto_avance_programado', 3, 3),

(152, 'Valor ganado', 'modulo_dashboard_gestion_proyecto_valor_ganado', 3, 3),

(152, 'SPI', 'modulo_dashboard_gestion_proyecto_spi', 3, 3),

(152, 'Grafica Avance programado vs Valor ganado', 'modulo_dashboard_gestion_proyecto_grafica_avance_programado_ganado', 3, 3),

(152, 'Tabla Avance programado vs Valor ganado', 'modulo_dashboard_gestion_proyecto_tabla_avance_programado_ganado', 3, 3),

(152, 'Grafica Avance programado vs Valor ganado(Mes)', 'modulo_dashboard_gestion_proyecto_grafica_avance_programado_ganado_mes', 3, 3),

(152, 'Grafica Avance programado acumulado vs Valor ganado acumulado', 'modulo_dashboard_gestion_proyecto_grafica_programado_acumulado_ganado_acumulado', 3, 3),

(152, 'Tabla Avance programado acumulado vs Valor ganado acumulado', 'modulo_dashboard_gestion_proyecto_tabla_programado_acumulado_ganado_acumulado', 3, 3),

(152, 'Costo ejercido', 'modulo_dashboard_gestion_proyecto_costo_ejercido', 3, 3),

(152, 'CPI', 'modulo_dashboard_gestion_proyecto_CPI', 3, 3),

(152, 'Grafica Costo ejercido vs Valor ganado(Mes)', 'modulo_dashboard_gestion_proyecto_grafica_costo_ejercido_ganado_mes', 3, 3),

(152, 'Grafica Costo ejercido acumulado vs Valor ganado acumulado', 'modulo_dashboard_gestion_proyecto_grafica_costo_ejercido_acumulado_ganado_acumulado', 3, 3),

(152, 'Tabla Costo ejercido acumulado vs Valor ganado acumulado', 'modulo_dashboard_gestion_proyecto_tabla_costo_ejercido_acumulado_ganado_acumulado', 3, 3);
```



## Permisos Corporativo [Dev-Demo-Producción]
``` SQL
INSERT INTO public."ModulosAcciones"(
"IdModulo", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico")
VALUES (1, 'Configuración Correo', 'modulo_corporativos_configuracion_correo', 3, 3);
```

## Importe Cambio [Dev-Demo-Producción]
``` SQL
fn_importe_a_cambio_convertida
```

## Permisos Proveedores [Dev-Demo-Producción]
``` SQL
INSERT INTO public."ModulosAcciones"(
"IdModulo", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico")
VALUES (17, 'Documentación', 'modulo_proveedores_documentacion', 3, 3);
```

## Módulo [Dev-Demo-Producción]
``` SQL
INSERT INTO public."ModulosAcciones"(
"IdModulo", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico")
VALUES (207, 'Gráfica Avance Programado vs Costo Ejercido', 'modulo_dashboard_gestion_proyecto_grafica_avance_programado_costo_ejercido', 3, 3);

INSERT INTO public."ModulosAcciones"(
"IdModulo", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico")
VALUES (207, 'Gráfica Avance Programado vs Costo Ejercido Acumulado', 'modulo_dashboard_gestion_proyecto_grafica_avance_programado_costo_ejercido_acumulado', 3, 3);

INSERT INTO public."ModulosAcciones"(
"IdModulo", "Nombre", "Tag", "IdUsuarioRegistro", "IdUsuarioModifico")
VALUES (207, 'Tabla Avance Programado vs Costo Ejercido', 'modulo_dashboard_gestion_proyecto_tabla_avance_programado_costo_ejercido', 3, 3);
```