FROM florenttorregrosa/docker-drupal:php7

RUN docker-php-pecl-install \
        xdebug

# Install Coder.
RUN composer global require drupal/coder:8.2.* \
    && composer clear-cache

# Install Node.js.
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - \
    && apt-get install -y nodejs \
    && apt-get clean && apt-get autoremove -q

RUN rm -rf /var/www/html && ln -s /project/www /var/www/html
