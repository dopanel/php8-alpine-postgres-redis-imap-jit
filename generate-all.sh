docker pull php:8.2-fpm
docker pull php:8.1-fpm

docker build -f ./Dockerfile-8.1 -t dopanel/php8-alpine-with-postgres-redis-imap-jit:8.1 .
docker build -f ./Dockerfile-8.2 -t dopanel/php8-alpine-with-postgres-redis-imap-jit:8.2 .
docker build -f ./Dockerfile-8.2 -t dopanel/php8-alpine-with-postgres-redis-imap-jit .
