#!/bin/bash

# Script used to rsync sources to make patches.

. $(dirname ${BASH_SOURCE[0]})/script-parameters.sh

echo -e "${COLOR_LIGHT_GREEN}Copy contrib modules.${COLOR_NC}"
#rsync -avzP --delete ${PROJECT_PATH}/contrib/context_profile_role ${APP_PATH}/modules/contrib/
#rsync -avzP --delete ${PROJECT_PATH}/contrib/drupal-l10n ${PROJECT_PATH}/vendor/drupal-composer/
#rsync -avzP --delete ${PROJECT_PATH}/contrib/file_extractor ${APP_PATH}/modules/contrib/
#rsync -avzP --delete ${PROJECT_PATH}/contrib/image_styles_mapping ${APP_PATH}/modules/contrib/
#rsync -avzP --delete ${PROJECT_PATH}/contrib/menu_per_role ${APP_PATH}/modules/contrib/

echo -e "${COLOR_LIGHT_GREEN}Rebuild Drupal paranoia.${COLOR_NC}"
composer drupal:paranoia --working-dir="${PROJECT_PATH}"
