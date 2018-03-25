FROM php:7.1-cli-alpine

ENV PHPREDIS_VERSION 3.1.4
ENV DRUSH_LAUNCHER_VERSION 0.4.3

ADD bin/docker-php-pecl-install /usr/local/bin/

# Prepare the phpredis library so it available to docker-php-ext-install.
RUN mkdir -p /usr/src/php/ext/redis \
    && curl -L https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && echo 'redis' >> /usr/src/php-available-exts

RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    && apk add --no-cache --update \
        autoconf \
        bash \
        curl-dev \
        freetype-dev \
        gcc \
        git \
        grep \
        imagemagick \
        libc-dev \
        libjpeg-turbo-dev \
        libltdl \
        libmcrypt-dev \
        libpng-dev \
        libtool \
        libxml2-dev \
        make \
        mysql-client \
        python \
        rsync \
        sed \
        ssmtp \
        sudo \
        unzip \
        wget \
        zlib-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install \
        bcmath \
        curl \
        exif \
        gd \
        mbstring \
        mcrypt \
        mysqli \
        opcache \
        pcntl \
        pdo_mysql \
        redis \
        soap \
        zip \
    && docker-php-pecl-install \
        xdebug \
    && rm -rf /var/cache/apk/* /usr/share/doc /usr/share/man /tmp/*

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

# Install Drush Launcher.
RUN wget -O drush.phar https://github.com/drush-ops/drush-launcher/releases/download/$DRUSH_LAUNCHER_VERSION/drush.phar \
    && chmod +x drush.phar \
    && mv drush.phar /usr/local/bin/drush \
    && drush self-update

# Install Coder and configure Code sniffer.
RUN composer global require drupal/coder:8.2.* \
    && composer global require dealerdirect/phpcodesniffer-composer-installer \
    && composer clear-cache \
    && echo 'alias drupalcs="phpcs --standard=Drupal --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md'"' >> $HOME/.bashrc \
    && echo 'alias drupalcsp="phpcs --standard=DrupalPractice --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md'"' >> $HOME/.bashrc \
    && echo 'alias drupalcbf="phpcbf --standard=Drupal --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md'"' >> $HOME/.bashrc
