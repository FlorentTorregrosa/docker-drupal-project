FROM florenttorregrosa/drupal-php:7.0-fpm-alpine

RUN docker-php-pecl-install \
        xdebug

# Install Coder.
RUN composer global require drupal/coder:8.2.* \
    && composer clear-cache

# Install Drupal console.
RUN curl https://drupalconsole.com/installer -L -o /usr/local/bin/drupal \
    && chmod +x /usr/local/bin/drupal \
    && drupal init
