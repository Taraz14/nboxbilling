FROM alpine:latest

LABEL maintainer="dimas <bonave.dimas@gmail.com>"

RUN set -x \
    # create nginx user/group
    && addgroup -g 101 -S nginx \
    && adduser -S -D -H -u 101 -h /var/cache/nginx -s /sbin/nologin -G nginx -g nginx nginx \
    && apk update \
    && apk add nginx \
    && mkdir -p /run/nginx \
    # forward request and error logs to docker log collector
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]


##############################################
FROM alpine:latest

LABEL maintainer="dimas <bonave.dimas@gmail.com>"

# create www user/group
RUN addgroup -g 1000 -S www \
    && adduser -S -D -H -u 1000 -h /var/cache/www -s /sbin/nologin -G www -g www www

RUN apk --update add \
    php7 \
    php7-bcmath \
    php7-dom \
    php7-ctype \
    php7-curl \
    php7-fpm \
    php7-gd \
    php7-iconv \
    php7-intl \
    php7-json \
    php7-mbstring \
    php7-mcrypt \
    php7-mysqlnd \
    php7-opcache \
    php7-openssl \
    php7-pdo \
    php7-pdo_mysql \
    php7-pdo_pgsql \
    php7-pdo_sqlite \
    php7-phar \
    php7-posix \
    php7-session \
    php7-soap \
    php7-xml \
    php7-zip \
    php7-gettext \
    && rm -rf /var/cache/apk/* \
    && chmod -R 777 /var/log/php7/

COPY docker-config/php/php.ini /etc/php7/conf.d/50-setting.ini
COPY docker-config/php/php-fpm.conf /etc/php7/php-fpm.conf

USER www

EXPOSE 9000

CMD ["php-fpm7", "-F"]