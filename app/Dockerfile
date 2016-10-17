FROM composer/composer:php5

RUN docker-php-ext-install -j$(nproc) pdo pdo_mysql

# Set application directory
WORKDIR /var/www/html

# Entrypoint script
COPY ./bootstrap.sh /bootstrap.sh
RUN chmod +x /bootstrap.sh

# MySQL & Redis configs
COPY ./config/main-local.php /main-local.php
COPY ./config/redis-connection-local.php /redis-connection-local.php


ENTRYPOINT ["/bootstrap.sh"]
CMD ["true"]
