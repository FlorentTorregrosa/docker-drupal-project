#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/script-parameters.sh

echo -e "${COLOR_LIGHT_GREEN}Database backup.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" sql:dump --result-file="${PROJECT_PATH}/backups/${DRUPAL_SITE_DEFAULT_FOLDER_NAME}-${CURRENT_DATE}.sql" --gzip --structure-tables-key="common"

echo -e "${COLOR_LIGHT_GREEN}Put the site in maintenance mode.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" state:set system.maintenance_mode 1

. ${SCRIPTS_PATH}/tasks/composer_install.sh
. ${SCRIPTS_PATH}/tasks/update_database.sh

echo -e "${COLOR_LIGHT_GREEN}Clear cache to be sure cache are cleared even if there is no update. Otherwise for example 'drush config:export' does not detect that there are changes to export.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" cache:rebuild

#echo -e "${COLOR_LIGHT_GREEN}Export prod config split in case of overrides.${COLOR_NC}"
#$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" config-split:export prod -y

. ${SCRIPTS_PATH}/tasks/import_configuration.sh

# For update.sh import only content if the environment is dev to not risk
# breaking prod.
if [ "${ENVIRONMENT_MODE}" = "dev" ]; then
  . ${SCRIPTS_PATH}/tasks/import_default_content.sh
fi

. ${SCRIPTS_PATH}/tasks/update_translations.sh

echo -e "${COLOR_LIGHT_GREEN}Remove the maintenance mode.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" state:set system.maintenance_mode 0

echo -e "${COLOR_LIGHT_GREEN}Flush caches to be clean.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" cache:rebuild

echo -e "${COLOR_LIGHT_GREEN}Run CRON.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" core:cron
