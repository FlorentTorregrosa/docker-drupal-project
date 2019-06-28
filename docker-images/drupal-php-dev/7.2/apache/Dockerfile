FROM florenttorregrosa/drupal-php:7.2-apache

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
RUN composer global require drupal/coder:8.3.* \
    && composer global require dealerdirect/phpcodesniffer-composer-installer \
    && echo 'alias drupalcs="phpcs --standard=Drupal --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md,yml'"' >> $HOME/.bashrc \
    && echo 'alias drupalcsp="phpcs --standard=DrupalPractice --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md,yml'"' >> $HOME/.bashrc \
    && echo 'alias drupalcbf="phpcbf --standard=Drupal --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md,yml'"' >> $HOME/.bashrc \
    # Install drupalorg-cli for contribution.
    && composer global require mglaman/drupalorg-cli \
    # Install drupal-check for contribution.
    && composer global require mglaman/drupal-check \
    && composer clear-cache

# Add some bash aliases.
RUN echo 'alias ll="ls -l"' >> $HOME/.bashrc \
    && echo 'alias lll="ls -al"' >> $HOME/.bashrc

# Install Node.js, ESLint.
RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - \
    && apt-get install -y nodejs \
    && apt-get clean \
    && apt-get autoremove -q \
    && npm install -g \
        eslint \
        gulp-cli \
    && npm cache clean --force

# Install Yarn.
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn \
    && apt-get clean \
    && apt-get autoremove -q

WORKDIR /project

# Exec configure Xdebug helper script before running the parent CMD script.
CMD ["configure-xdebug"]
