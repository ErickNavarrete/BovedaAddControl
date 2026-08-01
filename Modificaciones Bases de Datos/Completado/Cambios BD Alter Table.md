---
tipo: changelog-bd
estado: completado
tags: [bd, postgresql]
---

Índice: [[Índice]]

``` SQL
- `ALTER TABLE "OrdenesCompras" ADD COLUMN "Observaciones" TEXT;`
    
- `ALTER TABLE "PresupuestosPartidas" ADD COLUMN "Orden" INTEGER NOT NULL DEFAULT 0;`
    
- `ALTER TABLE "PresupuestosConceptos" ADD COLUMN "Orden" INTEGER NOT NULL DEFAULT 0;`
    
- `ALTER TABLE "Corporativos" ADD COLUMN "ImagenUrl" VARCHAR(250) NULL;`
    
- `ALTER TABLE public."Modulos" ADD COLUMN "Padre" VARCHAR NULL;`
    
- `ALTER TABLE public."OrdenesComprasDetalles" ADD COLUMN "UrlDocumento" VARCHAR(255) NULL;`
    
- `ALTER TABLE public."RecepcionesInsumosDetalles" ADD COLUMN "UrlDocumento" VARCHAR(255) NULL;`
    
- `ALTER TABLE public."SalidasInsumosDetalles" ADD COLUMN "UrlDocumento" VARCHAR(255) NULL;`
    
- `ALTER TABLE public."DevolucionesInsumosDetalles" ADD COLUMN "UrlDocumento" VARCHAR(255) NULL;`
    
- `ALTER TABLE public."DevolucionesInsumosDetalles" ADD COLUMN "Comentario" VARCHAR(255) NULL;`
    
- `ALTER TABLE "PresupuestosConceptos" ADD COLUMN "Actualizado" BOOLEAN NOT NULL DEFAULT false;`
    
- `ALTER TABLE "PresupuestosMatriz" ADD COLUMN "Actualizado" BOOLEAN NOT NULL DEFAULT false;`
    
- `ALTER TABLE "PresupuestosMatrizConceptos" ADD COLUMN "Actualizado" BOOLEAN NOT NULL DEFAULT false;`
    
- `ALTER TABLE "PresupuestosPartidas" ADD COLUMN "Actualizado" BOOLEAN NOT NULL DEFAULT false;`

- `ALTER TABLE public."SalidasInsumosDetalles" ADD "IdFrente" int4 NULL;`
    
- `ALTER TABLE "PresupuestosConceptos" ALTER COLUMN "Descripcion" TYPE VARCHAR(1000);`
    
- `ALTER TABLE "PresupuestosConceptos" ALTER COLUMN "Nombre" TYPE VARCHAR(1000);`
    
```