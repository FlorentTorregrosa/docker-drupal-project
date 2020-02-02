#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/script-parameters.sh

if [ "${USE_DRUPAL_DEBUG}" = "yes" ]; then
  echo -e "${COLOR_LIGHT_GREEN}Disable Drupal Debug in case it is still active.${COLOR_NC}"
  composer drupal-debug:disable-original-drupal-kernel-substitution --working-dir="${PROJECT_PATH}"
  chown "${WEBSERVER_USER}":"${WEBSERVER_USER}" /tmp/drupal_debug_*
fi

echo -e "${COLOR_LIGHT_GREEN}Run behat tests.${COLOR_NC}"
$PROJECT_PATH/vendor/bin/behat --config="${SCRIPTS_PATH}/tests/behat/behat.yml"

if [ "${USE_DRUPAL_DEBUG}" = "yes" ]; then
  echo -e "${COLOR_LIGHT_GREEN}Enable Drupal Debug.${COLOR_NC}"
  composer drupal-debug:enable-original-drupal-kernel-substitution --working-dir="${PROJECT_PATH}"
  chown "${WEBSERVER_USER}":"${WEBSERVER_USER}" /tmp/drupal_debug_*
fi
