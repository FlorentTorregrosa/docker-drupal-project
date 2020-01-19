FROM florenttorregrosa/drupal-php:7.3-apache

RUN docker-php-pecl-install \
        xdebug \
    # Disable Xdebug by default.
    && mv /usr/local/etc/php/conf.d/docker-php-pecl-xdebug.ini /usr/local/etc/php/conf.d/docker-php-pecl-xdebug.disabled

# Allows to set Xdebug remote host dynamically.
COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
# Allows to disable or enable Xdebug depending on environment variables.
COPY bin/configure-xdebug /usr/local/bin/configure-xdebug
RUN chmod +x /usr/local/bin/configure-xdebug

# Install Coder and configure Code sniffer.
RUN composer global require \
        drupal/coder:8.3.* \
        dealerdirect/phpcodesniffer-composer-installer \
        mglaman/drupalorg-cli \
        mglaman/drupal-check \
    && echo 'alias drupalcs="phpcs --standard=Drupal --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md,yml'"' >> $HOME/.bashrc \
    && echo 'alias drupalcsp="phpcs --standard=DrupalPractice --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md,yml'"' >> $HOME/.bashrc \
    && echo 'alias drupalcbf="phpcbf --standard=Drupal --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md,yml'"' >> $HOME/.bashrc \
    && composer clear-cache

WORKDIR /project

# Exec configure Xdebug helper script before running the parent CMD script.
CMD ["configure-xdebug"]
