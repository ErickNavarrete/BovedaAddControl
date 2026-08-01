---
tipo: indice
tags: [bd, postgresql]
---

# Índice — Modificaciones de Base de Datos

Documento de navegación para la serie de cambios de BD. No reemplaza los archivos individuales (cada uno conserva su historial de cambios tal cual se aplicó); esto es solo un mapa para encontrarlos.

## Listado (generado automáticamente con Dataview)

```dataview
TABLE estado
FROM "Modificaciones Bases de Datos"
WHERE tipo = "changelog-bd"
SORT estado ASC, file.name ASC
```

## Nota sobre el orden

Los nombres `vN` no siguen un orden cronológico estrictamente confiable entre sí (hay dos series distintas: "BD Modificaciones vN" y "BD Mod"/"Mod vN"/"Modificaciones vN"). Cada sección dentro de cada archivo indica su propio estado de despliegue entre corchetes (ej. `[Dev-Demo-Producción]`, `[DevFeature]`, `[Dev]`, `[Listo]`) — esa etiqueta es la fuente de verdad sobre si un cambio ya se aplicó en producción, no el número de versión del archivo.
