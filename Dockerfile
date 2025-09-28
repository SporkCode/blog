ARG WORDPRESS_VERSION=6.8.2

FROM alpine:3.21 AS theme

RUN apk add --no-cache curl rsync

RUN curl https://downloads.wordpress.org/theme/peregrine.1.0.25.zip | unzip - 

RUN rsync /peregrine/ /static --recursive --exclude=.php


FROM ghcr.io/sporkcode/wordpress-php:${WORDPRESS_VERSION} AS php

COPY --from=theme /peregrine /var/www/html/wp-content/themes/peregrine


FROM ghcr.io/sporkcode/wordpress-nginx:${WORDPRESS_VERSION} AS nginx

COPY --from=theme /static /var/www/html/wp-content/themes/peregrine

