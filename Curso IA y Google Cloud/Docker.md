docker build -t nodux-front .
docker rm -f nodux-front
docker run -d --name nodux-front --restart always -p 4200:80 nodux-front

docker build -t nodux-back .
docker rm -f nodux-back
docker run -d --name nodux-back --restart always -p 8080:8080 nodux-back