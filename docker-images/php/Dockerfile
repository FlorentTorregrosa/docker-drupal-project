FROM php:7.0-fpm-alpine

COPY bin/docker-php-pecl-install /usr/local/bin/

RUN apk add --no-cache --update \
        git \
        bash \
        imagemagick \
        curl-dev \
        freetype-dev \
        grep \
        libjpeg-turbo-dev \
        libltdl \
        libmcrypt-dev \
        libpng-dev \
        libxml2-dev \
        mysql-client \
        python \
        ssmtp \
        sudo \
        unzip \
        wget \
        zlib-dev \
        rsync \
        # Libraries needed to compile php libraries.
        autoconf \
        gcc \
        libc-dev \
        libtool \
        make \
        sed \
    && docker-php-ext-install \
        bcmath \
        curl \
        exif \
        mbstring \
        mcrypt \
        mysqli \
        opcache \
        pcntl \
        pdo_mysql \
        soap \
        zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    # Install Uploadprogress.
    && git clone https://git.php.net/repository/pecl/php/uploadprogress.git \
    && cd uploadprogress \
    && phpize \
    && ./configure \
    && make && make install \
    && cd .. \
    && rm -rf uploadprogress \
    && echo "extension=uploadprogress.so" > /usr/local/etc/php/conf.d/conf-uploadprogress.ini \
    # Install PhpRedis.
    && git clone --branch=php7 https://github.com/phpredis/phpredis.git \
    && cd phpredis \
    && phpize \
    && ./configure \
    && make && make install \
    && cd .. \
    && rm -rf phpredis \
    && echo "extension=redis.so" > /usr/local/etc/php/conf.d/conf-redis.ini \
    # Remove libraries for compilation.
    && apk del --no-cache -r autoconf \
        gcc \
        libc-dev \
        libtool \
        make \
        sed \
    && rm -rf /var/cache/apk/* /usr/share/doc /usr/share/man /tmp/*

# Install Composer.
RUN cd /usr/local \
    && curl -sS https://getcomposer.org/installer | php \
    && chmod +x /usr/local/composer.phar \
    && ln -s /usr/local/composer.phar /usr/local/bin/composer \
    && echo 'PATH="$HOME/.composer/vendor/bin:$PATH"' >> $HOME/.bashrc

# Install Drush.
RUN composer global require drush/drush:@stable \
    && ~/.composer/vendor/bin/drush init -y \
    && composer clear-cache

WORKDIR /project
