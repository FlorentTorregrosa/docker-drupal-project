#!/bin/bash

usage() {
    echo "run-test-phpunit.sh arguments"
}

. $(dirname ${BASH_SOURCE[0]})/script-parameters.sh
. $(dirname ${BASH_SOURCE[0]})/script-parameters.local.sh

if [ "${USE_DRUPAL_DEBUG}" = "yes" ]; then
  echo -e "${LIGHT_GREEN}Disable Drupal Debug in case it is still active.${NC}"
  composer drupal-debug:disable-original-drupal-kernel-substitution --working-dir="${PROJECT_PATH}"
  chown "${WEBSERVER_USER}":"${WEBSERVER_USER}" /tmp/drupal_debug_*
fi

echo -e "${LIGHT_GREEN}Workaround for drupal-composer/drupal-paranoia: make symlink to sites/simpletest.${NC}"
rm -rf $WWW_PATH/sites/simpletest
ln -s $APP_PATH/sites/simpletest $WWW_PATH/sites/simpletest

echo -e "${LIGHT_GREEN}Run tests.${NC}"
sudo -u $WEBSERVER_USER -E $PROJECT_PATH/vendor/bin/phpunit -c $PROJECT_PATH/scripts/tests/phpunit.xml $@

if [ "${USE_DRUPAL_DEBUG}" = "yes" ]; then
  echo -e "${LIGHT_GREEN}Enable Drupal Debug.${NC}"
  composer drupal-debug:enable-original-drupal-kernel-substitution --working-dir="${PROJECT_PATH}"
  chown "${WEBSERVER_USER}":"${WEBSERVER_USER}" /tmp/drupal_debug_*
fi
