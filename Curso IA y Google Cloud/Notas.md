---
tipo: referencia
tags: [gcloud, nodux, infraestructura]
---

Relacionado: [[Docker]], [[Sites available nodux]]

Crear 3 json appsettigns.json para cada entorno

	gcloud secrets versions access latest --secret="nodux-dev-appsettings”

gcloud secrets versions access latest \  
 --secret="nodux-dev-appsettings" \  
 --impersonate-service-account=324344599010-compute@developer.gserviceaccount.com

gcloud secrets list --impersonate-service-account=324344599010-compute@developer.gserviceaccount.com