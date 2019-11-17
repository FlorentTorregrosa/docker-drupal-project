#!/bin/bash

usage() {
    echo "run-test-phpunit.sh arguments"
}

. $(dirname ${BASH_SOURCE[0]})/script-parameters.sh
. $(dirname ${BASH_SOURCE[0]})/script-parameters.local.sh

echo -e "${LIGHT_GREEN}Disable Drupal Debug.${NC}"
composer drupal-debug:disable-original-drupal-kernel-substitution --working-dir="${PROJECT_PATH}"

echo -e "${LIGHT_GREEN}Without drush alias, change temporarily directory to app.${NC}"
cd $APP_PATH

echo -e "${LIGHT_GREEN}Run tests.${NC}"
sudo -u $WEBSERVER_USER -E $PROJECT_PATH/vendor/bin/phpunit -c $PROJECT_PATH/scripts/tests/phpunit.xml $@

echo -e "${LIGHT_GREEN}Back to the current directory.${NC}"
cd $CURRENT_PATH

echo -e "${LIGHT_GREEN}Enable Drupal Debug.${NC}"
composer drupal-debug:enable-original-drupal-kernel-substitution --working-dir="${PROJECT_PATH}"
