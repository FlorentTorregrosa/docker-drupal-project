#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/script-parameters.sh
. $(dirname ${BASH_SOURCE[0]})/script-parameters.local.sh

if [ "${USE_DRUPAL_DEBUG}" = "yes" ]; then
  echo -e "${LIGHT_GREEN}Disable Drupal Debug in case it is still active.${NC}"
  composer drupal-debug:disable-original-drupal-kernel-substitution --working-dir="${PROJECT_PATH}"
  chown "${WEBSERVER_USER}":"${WEBSERVER_USER}" /tmp/drupal_debug_*
fi

echo -e "${LIGHT_GREEN}Run behat tests.${NC}"
$PROJECT_PATH/vendor/bin/behat --config="${SCRIPTS_PATH}/tests/behat/behat.yml"

if [ "${USE_DRUPAL_DEBUG}" = "yes" ]; then
  echo -e "${LIGHT_GREEN}Enable Drupal Debug.${NC}"
  composer drupal-debug:enable-original-drupal-kernel-substitution --working-dir="${PROJECT_PATH}"
  chown "${WEBSERVER_USER}":"${WEBSERVER_USER}" /tmp/drupal_debug_*
fi
