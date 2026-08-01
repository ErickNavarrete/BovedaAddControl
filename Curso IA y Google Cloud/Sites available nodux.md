sudo nano /etc/nginx/sites-available/nodux
sudo nginx -t && sudo systemctl reload nginx

## Antiguo
``` nginx
server {
    server_name nodux.com.mx www.nodux.com.mx;

    # Frontend Angular
    location / {
        proxy_pass http://localhost:4200;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/nodux.com.mx/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/nodux.com.mx/privkey.pem; # managed by Certbot

}

server {
    if ($host = nodux.com.mx) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name nodux.com.mx www.nodux.com.mx;
    return 404; # managed by Certbot


}

server {
    if ($host = devapi.nodux.com.mx) {
        return 301 https://$host$request_uri;
    } # managed by Certbot
    server_name devapi.nodux.com.mx;
    return 404; # managed by Certbot



    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/devapi.nodux.com.mx/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/devapi.nodux.com.mx/privkey.pem; # managed by Certbot

    # Backend .NET
    location /api/ {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

}
```

## Claude
``` nginx
# ---------- Frontend Angular ----------
server {
    listen 443 ssl;
    server_name nodux.com.mx www.nodux.com.mx;

    ssl_certificate     /etc/letsencrypt/live/nodux.com.mx/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/nodux.com.mx/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

    location / {
        proxy_pass http://127.0.0.1:4200;
        proxy_http_version 1.1;
        proxy_set_header Host              $host;
        proxy_set_header X-Real-IP         $remote_addr;
        proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

# ---------- Backend .NET ----------
server {
    listen 443 ssl;
    server_name devapi.nodux.com.mx;

    ssl_certificate     /etc/letsencrypt/live/devapi.nodux.com.mx/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/devapi.nodux.com.mx/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

    client_max_body_size 50M;

    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_http_version 1.1;
        proxy_set_header Host              $host;
        proxy_set_header X-Real-IP         $remote_addr;
        proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Upgrade           $http_upgrade;
        proxy_set_header Connection        keep-alive;
        proxy_read_timeout 120s;
    }
}

# ---------- Redirección HTTP -> HTTPS ----------
server {
    listen 80;
    server_name nodux.com.mx www.nodux.com.mx devapi.nodux.com.mx;
    return 301 https://$host$request_uri;
}
```

## Actual
``` nginx
# ---------- Frontend Angular ----------
server {
    listen 443 ssl;
    server_name nodux.com.mx www.nodux.com.mx;

    ssl_certificate     /etc/letsencrypt/live/nodux.com.mx/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/nodux.com.mx/privkey.pem;
    
    location / {
        proxy_pass http://localhost:4200;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}

# ---------- Backend .NET ----------
server {
    listen 443 ssl;
    server_name devapi.nodux.com.mx;

    ssl_certificate     /etc/letsencrypt/live/devapi.nodux.com.mx/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/devapi.nodux.com.mx/privkey.pem;

    location / {
        proxy_pass http://localhost:8080;
        proxy_http_version 1.1;
        proxy_set_header Host              $host;
        proxy_set_header X-Real-IP         $remote_addr;
        proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

# ---------- Redirección HTTP -> HTTPS ----------
server {
    listen 80;
    server_name nodux.com.mx www.nodux.com.mx devapi.nodux.com.mx;
    return 301 https://$host$request_uri;
}
```