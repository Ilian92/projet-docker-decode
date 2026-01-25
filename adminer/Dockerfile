FROM alpine:3.19

ENV ADMINER_VERSION=4.8.1

RUN apk add --no-cache \
    php82 \
    php82-session \
    php82-pgsql \
    php82-pdo_pgsql \
    php82-mysqli \
    php82-pdo_mysql \
    php82-pdo_sqlite \
    php82-pdo \
    php82-json \
    wget

RUN wget -O /var/www/adminer.php "https://github.com/vrana/adminer/releases/download/v${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php" \
    && chmod 644 /var/www/adminer.php

WORKDIR /var/www

EXPOSE 8080

CMD ["php82", "-S", "0.0.0.0:8080", "adminer.php"]