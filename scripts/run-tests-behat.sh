#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/script-parameters.sh
. $(dirname ${BASH_SOURCE[0]})/script-parameters.local.sh

echo -e "${LIGHT_GREEN}Disable Drupal Debug.${NC}"
composer drupal-debug:disable-original-drupal-kernel-substitution --working-dir="${PROJECT_PATH}"

echo -e "${LIGHT_GREEN}Run behat tests.${NC}"
$PROJECT_PATH/vendor/bin/behat --config="${SCRIPTS_PATH}/tests/behat/behat.yml"

echo -e "${LIGHT_GREEN}Enable Drupal Debug.${NC}"
composer drupal-debug:enable-original-drupal-kernel-substitution --working-dir="${PROJECT_PATH}"
