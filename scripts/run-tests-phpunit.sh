#!/bin/bash

usage() {
    echo "run-test-phpunit.sh arguments"
}

. $(dirname ${BASH_SOURCE[0]})/script-parameters.sh

echo -e "${COLOR_LIGHT_GREEN}Workaround for drupal-composer/drupal-paranoia: make symlink to sites/simpletest.${COLOR_NC}"
rm -rf $WWW_PATH/sites/simpletest
ln -s $APP_PATH/sites/simpletest $WWW_PATH/sites/simpletest

echo -e "${COLOR_LIGHT_GREEN}Run tests.${COLOR_NC}"
sudo -u $WEBSERVER_USER -E $PROJECT_PATH/vendor/bin/phpunit -c $PROJECT_PATH/scripts/tests/phpunit.xml $@
