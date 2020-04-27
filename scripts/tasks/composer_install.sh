#!/bin/bash

. $(dirname $(dirname ${BASH_SOURCE[0]}))/script-parameters.sh

echo -e "${COLOR_LIGHT_GREEN}Composer install.${COLOR_NC}"
if [ "${ENVIRONMENT_MODE}" = "dev" ]; then
    composer install --working-dir="${PROJECT_PATH}"
else
    composer install --working-dir="${PROJECT_PATH}" --no-dev
fi

echo -e "${COLOR_LIGHT_GREEN}Rebuild Drupal paranoia.${COLOR_NC}"
composer drupal:paranoia --working-dir="${PROJECT_PATH}"

echo -e "${COLOR_LIGHT_GREEN}Clear Drush cache in case of Drush update.${COLOR_NC}"
$DRUSH cache:clear drush
