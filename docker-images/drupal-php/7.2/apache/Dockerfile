FROM php:7.2-apache

ENV DEBCONF_FRONTEND non-interactive
ENV PHPREDIS_VERSION 4.3.0
ENV DRUSH_LAUNCHER_VERSION 0.6.0

ADD bin/docker-php-pecl-install /usr/local/bin/

# Prepare the phpredis library so it available to docker-php-ext-install.
RUN mkdir -p /usr/src/php/ext/redis \
    && curl -L https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && echo 'redis' >> /usr/src/php-available-exts

RUN apt-get update && apt-get install -y \
        apt-utils \
        git \
        gnupg \
        imagemagick \
        libcurl4-openssl-dev \
        libfreetype6-dev \
        libjpeg-turbo-progs \
        libjpeg62-turbo-dev \
        libpng-dev \
        libxml2-dev \
        mariadb-client \
        pngquant \
        python \
        redis-tools \
        sudo \
        unzip \
        wget \
        zlib1g-dev \
    && docker-php-ext-install \
        bcmath \
        curl \
        exif \
        mbstring \
        mysqli \
        opcache \
        pcntl \
        pdo_mysql \
        redis \
        soap \
        zip \
    && apt-get clean && apt-get autoremove -q \
    && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man /tmp/* \
    && a2enmod \
        deflate \
        expires \
        headers \
        mime \
        rewrite \
    && a2dissite 000-default.conf \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

# Install Uploadprogress.
RUN git clone https://git.php.net/repository/pecl/php/uploadprogress.git \
    && cd uploadprogress \
    && phpize \
    && ./configure \
    && make && make install \
    && cd .. \
    && rm -rf uploadprogress \
    && echo "extension=uploadprogress.so" > /usr/local/etc/php/conf.d/conf-uploadprogress.ini

# Install Composer.
RUN cd /usr/local \
    && curl -sS https://getcomposer.org/installer | php \
    && chmod +x /usr/local/composer.phar \
    && ln -s /usr/local/composer.phar /usr/local/bin/composer \
    && echo 'PATH="$HOME/.composer/vendor/bin:$PATH"' >> $HOME/.bashrc

# Install hirak/prestissimo for improve Composer performance.
RUN composer global require hirak/prestissimo \
    && composer clear-cache

# Install Drush Launcher.
RUN wget -O drush.phar https://github.com/drush-ops/drush-launcher/releases/download/$DRUSH_LAUNCHER_VERSION/drush.phar \
    && chmod +x drush.phar \
    && mv drush.phar /usr/local/bin/drush \
    && drush self-update
