FROM florenttorregrosa/docker-drupal:php7

RUN docker-php-pecl-install \
        xdebug

# Install Coder.
RUN composer global require drupal/coder:8.2.*

# Install Drupal console.
RUN curl https://drupalconsole.com/installer -L -o /usr/local/bin/drupal \
    && chmod +x /usr/local/bin/drupal \
    && drupal init

RUN rm -rf /var/www/html && ln -s /project/www /var/www/html
