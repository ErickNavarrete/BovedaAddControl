---
tipo: indice
tags: [bd, postgresql]
---

# Índice — Modificaciones de Base de Datos

Documento de navegación para la serie de cambios de BD. No reemplaza los archivos individuales (cada uno conserva su historial de cambios tal cual se aplicó); esto es solo un mapa para encontrarlos.

## Activos (aún no archivados)

- [[BD Modificaciones v8]]
- [[BD Modificaciones v9]]

## Completados / archivados

- [[Completado/BD Mod]]
- [[Completado/BD Mod 2]]
- [[Completado/Modificaciones v2]]
- [[Completado/BD Modificaciones v3]]
- [[Completado/BD Modificaciones v4]]
- [[Completado/BD Modificaciones v5]]
- [[Completado/BD Modificaciones v6]]
- [[Completado/BD Modificaciones v7]]
- [[Completado/Mod v3]]
- [[Completado/BD Modificaciones v10]]
- [[Completado/Aditivas Cantidad]]
- [[Completado/Cambios BD Alter Table]]
- [[Completado/Modificaciones entre Sistemas]]

## Nota sobre el orden

Los nombres `vN` no siguen un orden cronológico estrictamente confiable entre sí (hay dos series distintas: "BD Modificaciones vN" y "BD Mod"/"Mod vN"/"Modificaciones vN"). Cada sección dentro de cada archivo indica su propio estado de despliegue entre corchetes (ej. `[Dev-Demo-Producción]`, `[DevFeature]`, `[Dev]`, `[Listo]`) — esa etiqueta es la fuente de verdad sobre si un cambio ya se aplicó en producción, no el número de versión del archivo.

Con Dataview instalado, se puede reemplazar esta lista manual por una consulta automática usando el frontmatter `estado`:

````
```dataview
TABLE estado FROM "Modificaciones Bases de Datos"
SORT estado ASC
```
````
