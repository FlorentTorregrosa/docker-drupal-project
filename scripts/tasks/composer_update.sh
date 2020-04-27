#!/bin/bash

. $(dirname $(dirname ${BASH_SOURCE[0]}))/script-parameters.sh

echo -e "${COLOR_LIGHT_GREEN}Composer update.${COLOR_NC}"
composer update --working-dir="${PROJECT_PATH}"

echo -e "${COLOR_LIGHT_GREEN}Rebuild Drupal paranoia.${COLOR_NC}"
composer drupal:paranoia --working-dir="${PROJECT_PATH}"

echo -e "${COLOR_LIGHT_GREEN}Clear Drush cache in case of Drush update.${COLOR_NC}"
$DRUSH cache:clear drush
