FROM florenttorregrosa/drupal-php:7.1-apache

RUN docker-php-pecl-install \
        xdebug

# Install Coder and configure Code sniffer.
RUN composer global require drupal/coder:8.2.* \
    && composer global require dealerdirect/phpcodesniffer-composer-installer \
    && composer clear-cache \
    && echo 'alias drupalcs="phpcs --standard=Drupal --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md'"' >> $HOME/.bashrc \
    && echo 'alias drupalcsp="phpcs --standard=DrupalPractice --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md'"' >> $HOME/.bashrc \
    && echo 'alias drupalcbf="phpcbf --standard=Drupal --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md'"' >> $HOME/.bashrc

# Add some bash aliases.
RUN echo 'alias ll="ls -l"' >> $HOME/.bashrc \
    && echo 'alias lll="ls -al"' >> $HOME/.bashrc

# Install Node.js, ESLint.
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - \
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
    && apt-get autoremove -q \

WORKDIR /project
