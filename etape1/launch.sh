docker rm -f http script 2>/dev/null

docker network rm monreseau 2>/dev/null

docker network create monreseau

docker run -d \
  --name script \
  --network monreseau \
  -v "$(pwd)/html":/app \
  php:fpm

docker run -d \
  --name http \
  --network monreseau \
  -p 8080:80 \
  -v "$(pwd)/html":/app \
  -v "$(pwd)/conf/default.conf":/etc/nginx/conf.d/default.conf \
  nginx

docker ps


