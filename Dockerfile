FROM php:7.1.0-fpm-alpine

MAINTAINER Igor Glagola <igor@glagola.ru>

RUN apk update && \
    apk add --no-cache libpng libintl icu-libs libjpeg-turbo freetype && \
    apk add --no-cache --virtual .phpize-deps autoconf file g++ gcc libc-dev make pkgconf re2c && \
    apk add --no-cache --virtual .ext-deps libpng-dev icu-dev gettext-dev freetype-dev libjpeg-turbo-dev && \
    docker-php-ext-configure gd \
          --with-freetype-dir=/usr/include/ \
          --with-png-dir=/usr/include/ \
          --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install calendar gd intl pdo_mysql sockets gettext && \
    apk del .ext-deps && \
    pecl install xdebug && \
    apk del .phpize-deps

ADD ./expose-php.ini /usr/local/etc/php/conf.d/
ADD ./xdebug.ini /usr/local/etc/php/conf.d/

EXPOSE 9000
