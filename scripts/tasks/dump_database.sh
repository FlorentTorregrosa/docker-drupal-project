#!/bin/bash

. $(dirname $(dirname ${BASH_SOURCE[0]}))/script-parameters.sh

echo -e "${COLOR_LIGHT_GREEN}Database backup.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" sql:dump --result-file="${PROJECT_PATH}/backups/${DRUPAL_SITE_DEFAULT_FOLDER_NAME}-${CURRENT_DATE}.sql" --gzip --structure-tables-key="common"
