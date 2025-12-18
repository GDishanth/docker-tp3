docker rm -f http script data 2>/dev/null

docker network rm monreseau 2>/dev/null

docker network create monreseau

docker build -t mon-php-custom .

docker run -d \
  --name data \
  --network monreseau \
  -e MARIADB_RANDOM_ROOT_PASSWORD=yes \
  -v "$(pwd)/sql":/docker-entrypoint-initdb.d \
  mariadb

sleep 10

docker run -d \
  --name script \
  --network monreseau \
  -v "$(pwd)/html":/app \
  mon-php-custom

docker run -d \
  --name http \
  --network monreseau \
  -p 8080:80 \
  -v "$(pwd)/html":/app \
  -v "$(pwd)/conf/default.conf":/etc/nginx/conf.d/default.conf \
  nginx

docker ps


