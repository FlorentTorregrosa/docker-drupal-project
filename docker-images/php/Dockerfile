FROM php:7.0-fpm

ENV DEBCONF_FRONTEND non-interactive

ADD bin/docker-php-pecl-install /usr/local/bin/

RUN apt-get update && apt-get install -y \
        git \
        imagemagick \
        libcurl4-openssl-dev \
        libfreetype6-dev \
        libjpeg-turbo-progs \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libxml2-dev \
        mysql-client \
        pngquant \
        python \
        ssmtp \
        sudo \
        unzip \
        wget \
        zlib1g-dev \
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
    && apt-get clean && apt-get autoremove -q \
    && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man /tmp/* \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

# Install Uploadprogress
RUN git clone https://git.php.net/repository/pecl/php/uploadprogress.git \
    && cd uploadprogress \
    && phpize \
    && ./configure \
    && make && make install \
    && cd .. \
    && rm -rf uploadprogress \
    && echo "extension=uploadprogress.so" > /usr/local/etc/php/conf.d/conf-uploadprogress.ini

# Install PhpRedis.
RUN git clone --branch=php7 https://github.com/phpredis/phpredis.git \
    && cd phpredis \
    && phpize \
    && ./configure \
    && make && make install \
    && cd .. \
    && rm -rf phpredis \
    && echo "extension=redis.so" > /usr/local/etc/php/conf.d/conf-redis.ini

# Install Composer.
RUN cd /usr/local \
    && curl -sS https://getcomposer.org/installer | php \
    && chmod +x /usr/local/composer.phar \
    && ln -s /usr/local/composer.phar /usr/local/bin/composer \
    && echo 'PATH="$HOME/.composer/vendor/bin:$PATH"' >> $HOME/.bashrc

# Install Drush.
RUN composer global require drush/drush:@stable







RUN docker-php-pecl-install \
        xdebug

# Install Coder.
RUN composer global require drupal/coder:8.2.*

# Install Drupal console.
RUN curl https://drupalconsole.com/installer -L -o /usr/local/bin/drupal \
    && chmod +x /usr/local/bin/drupal \
    && drupal init
