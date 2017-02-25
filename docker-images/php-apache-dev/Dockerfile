FROM florenttorregrosa/docker-drupal:php7

RUN docker-php-pecl-install \
        xdebug

# Install Coder.
RUN composer global require drupal/coder:8.2.* \
    && composer clear-cache

RUN rm -rf /var/www/html && ln -s /project/www /var/www/html
