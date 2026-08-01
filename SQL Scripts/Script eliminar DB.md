---
tipo: script-sql
tags: [sql, mantenimiento, destructivo]
---

delete from "CentrosCostosExistenciasInsumos";

--SALIDAS--
delete from "SalidasInsumosComentarios";
delete from "SalidasInsumosDocumentos";
delete from "SalidasInsumosEstatus";
delete from "SalidasInsumosDetalles";
delete from "SalidasInsumos";

--RECEPCION INSUMOS--
delete from "RecepcionesInsumosDocumentos" 
delete from "RecepcionesInsumosDocumentos" 
delete from "RecepcionesInsumosEstatus" 
delete from "RecepcionesInsumosDetalles" 
delete from "RecepcionesInsumos"

--ADITIVAS--
delete from "AditivasDocumentos"; 
delete from "AditivasComentarios"; 
delete from "AditivasEstatus"; 
delete from "AditivasDetalles"; 
delete from "Aditivas";

--ORDEN DE COMPRA--
delete from "OrdenesComprasDocumentos"; 
delete from "OrdenesComprasComentarios"; 
delete from "OrdenesComprasEstatus"; 
delete from "OrdenesComprasParams"; 
delete from "OrdenesComprasDetalles"; 
delete from "OrdenesCompras";

--REQUISICIONES--
delete from "RequisicionesDocumentos"; 
delete from "RequisicionesComentarios"; 
delete from "RequisicionesEstatus";
delete from "RequisicionesDetallesAuxiliares"; 
delete from "RequisicionesDetalles"; 
delete from "Requisiciones";  

-- ESTIMACIONES --
delete from "EstimacionesComentarios"; 
delete from "EstimacionesDocumentos" ;
delete from "EstimacionesInsumosDetalles"; 
delete from "EstimacionesInsumos" ;
delete from "EstimacionesEstatus" ;
delete from "Estimaciones" ;

-- EXPLOSION INSUMOS --
delete from "ExplosionesSubcontratosParams" ;
delete from "ExplosionesSubcontratosComentarios"; 
delete from "ExplosionesSubcontratosEstatus" ;
delete from "ExplosionesSubcontratosDetalles"; 
delete from "ExplosionesSubcontratos"; 
delete from "ExplosionesInsumosAvancesFotograficos"; 
delete from "ExplosionesInsumosAvances" ;
delete from "ExplosionesInsumosMovimientos";  

-- DEDUCTIVAS --
delete from "DeductivasDocumentos"; 
delete from "DeductivasComentarios" ;
delete from "DeductivasEstatus" ;
delete from "DeductivasDetalles"; 
delete from "Deductivas";

-- EXPLOSION --
delete from "ExplosionesInsumosAgrupadosMovimientos";
delete from "ExplosionesInsumosAgrupados";
delete from "ExplosionesInsumos"; 
delete from "Explosiones" ;

-- PRESUPUESTOS --
delete from "PresupuestosMatrizConceptos";
delete from "PresupuestosMatriz";
delete from "PresupuestosConceptosProgramaciones";
delete from "PresupuestosConceptos";
delete from "PresupuestosDocumentos";
delete from "PresupuestosDomicilios" ;
delete from "PresupuestosEstatus" ;
delete from "PresupuestosInsumosPrecios" ;
delete from "PresupuestosMonedas" ;
delete from "PresupuestosPartidas";
delete from "Presupuestos";

delete from "PresupuestosConceptos" pp where pp."IdPresupuesto" = 180;
delete from "PresupuestosPartidas" pp where pp."IdPresupuesto" = 180;
delete from "PresupuestosInsumosPrecios" pip where pip."IdPresupuesto" = 180;
delete from "PresupuestosMonedas" pm where pm."IdPresupuesto" = 180;
delete from "PresupuestosEstatus" pe where pe."IdPresupuesto" = 180;
delete from "Presupuestos" pp where pp."Id" = 180;

-- PROVEEDORES --
delete from "CotizacionInsumosAgrupados";
delete from "ProveedoresDocumentos";
delete from "Proveedores";
delete from "TiposProveedoresDocumentos";
delete from "TiposProveedores";

-- INSUMOS --
delete from "InsumosAuxiliares";
delete from "DevolucionesInsumosDetalles";
delete from "Insumos";
delete from "FamiliasInsumos";
delete from "TiposInsumos";