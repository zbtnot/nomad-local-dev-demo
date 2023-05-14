FROM alpine:3.18

ARG php_version=php82
ARG php_fpm_bin=php-fpm82
RUN apk add --no-cache \
    multirun \
    nginx \
    ${php_version} \
    ${php_version}-fpm \
    ${php_version}-gd \
    ${php_version}-pdo \
    ${php_version}-sqlite3 \
    ${php_version}-pdo_sqlite \
    ${php_version}-mysqli \
    ${php_version}-pdo_mysql \
    ${php_version}-zlib \
    ${php_version}-curl \
    ${php_version}-mbstring
RUN adduser www-data -G www-data -D -H
COPY docker/nginx.conf /etc/nginx/http.d/default.conf

EXPOSE 8080
CMD ["multirun", "nginx -g 'daemon off;'", "php-fpm82 -F", "tail -F /var/log/nginx/error.log /var/log/php-fpm.log"]
