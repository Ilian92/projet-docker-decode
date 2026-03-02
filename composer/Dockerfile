FROM alpine:3.19

RUN apk add --no-cache php82 php82-phar php82-openssl php82-mbstring php82-curl curl git unzip \
    && ln -sf /usr/bin/php82 /usr/bin/php \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /app

ENTRYPOINT ["composer"]
