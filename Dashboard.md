---
tipo: dashboard
tags: [dashboard]
---

# Dashboard

## Pendientes (obsidian-tasks-plugin)

```tasks
not done
sort by priority
sort by due
```

## Modificaciones de BD activas

```dataview
TABLE estado
FROM "Modificaciones Bases de Datos"
WHERE tipo = "changelog-bd" AND estado = "activo"
```

## Scripts SQL destructivos (revisar antes de correr)

```dataview
LIST
FROM "SQL Scripts"
WHERE contains(tags, "destructivo")
```
