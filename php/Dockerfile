FROM php:5.6-fpm


# Ignore APT warnings about not having a TTY
ENV DEBIAN_FRONTEND noninteractive


# Some stuff
RUN apt-get update && apt-get install -y \
        vim-tiny \
        curl \
        nano \
        wget \
        unzip \
        git

# Memcached
RUN apt-get update && apt-get install -y libz-dev libmemcached-dev
RUN pecl install memcached
RUN echo extension=memcached.so >> /usr/local/etc/php/conf.d/memcached.ini


# Lib dependencies
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libicu-dev \
        libxml2-dev \
        imagemagick \
        libpq-dev
        
RUN docker-php-ext-install -j$(nproc) iconv intl xml soap mcrypt opcache pdo pdo_mysql pdo_pgsql sockets mysqli
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd




