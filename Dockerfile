FROM php:8.0-fpm-alpine

ENV PHP_INI_DIR=/usr/local/etc/php

RUN set -ex && apk update && apk add --no-cache zip unzip libpq imap-dev postgresql-dev krb5-dev ${PHPIZE_DEPS} && pecl install -o -f redis && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql && docker-php-ext-configure imap --with-kerberos --with-imap-ssl && docker-php-ext-configure opcache && ln -s /usr/lib/libnsl.so.2.0.0  /usr/lib/libnsl.so.1 && docker-php-ext-install pdo pdo_pgsql pgsql imap opcache && docker-php-ext-enable redis && apk del zip ${PHPIZE_DEPS} postgresql-dev krb5-dev && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/pear && rm -rf /tmp/* /var/lib/apt/lists/* && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" && sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 2G/g' "$PHP_INI_DIR/php.ini" && sed -i 's/post_max_size = 8M/post_max_size = 2G/g' "$PHP_INI_DIR/php.ini" && rm -rf /var/cache/apk/* && echo "opcache.enable=1" >> /usr/local/etc/php/php.ini && echo "opcache.enable_cli=1" >> /usr/local/etc/php/php.ini && echo "opcache.jit_buffer_size=500M" >> /usr/local/etc/php/php.ini && echo "opcache.jit=tracing" >> /usr/local/etc/php/php.ini && echo "opcache.jit=1255" >> /usr/local/etc/php/php.ini

WORKDIR /code
EXPOSE 9000
CMD php-fpm

# check: php -m | grep 'oci8'