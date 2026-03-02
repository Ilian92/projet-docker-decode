FROM projet-composer AS projet-composer

FROM alpine:3.19

RUN apk add --no-cache \
    php82 \
    php82-pdo \
    php82-pdo_pgsql \
    php82-pgsql \
    php82-zip \
    php82-gd \
    php82-intl \
    php82-opcache \
    php82-mbstring \
    php82-openssl \
    php82-phar \
    php82-tokenizer \
    php82-session \
    php82-ctype \
    php82-dom \
    php82-xml \
    php82-xmlwriter \
    php82-simplexml \
    php82-fileinfo \
    php82-curl \
    php82-iconv \
    postgresql-dev \
    && ln -sf /usr/bin/php82 /usr/bin/php

COPY --from=projet-composer /usr/local/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY composer.json composer.lock ./

COPY . .
ENV APP_ENV=prod

RUN composer install --no-dev --optimize-autoloader

RUN mkdir -p var/cache var/log \
    && chmod -R 777 var

EXPOSE 8000

CMD ["php", "-S", "0.0.0.0:8000", "-t", "public"]