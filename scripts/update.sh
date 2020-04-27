#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/script-parameters.sh

. ${SCRIPTS_PATH}/tasks/dump_database.sh

echo -e "${COLOR_LIGHT_GREEN}Enable maintenance mode.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" state:set system.maintenance_mode 1

. ${SCRIPTS_PATH}/tasks/composer_install.sh
. ${SCRIPTS_PATH}/tasks/update_database.sh

echo -e "${COLOR_LIGHT_GREEN}Clear cache to be sure cache are cleared even if there is no update. Otherwise for example 'drush config:export' does not detect that there are changes to export.${COLOR_NC}"
. ${SCRIPTS_PATH}/tasks/flush_cache.sh

#echo -e "${COLOR_LIGHT_GREEN}Export prod config split in case of overrides.${COLOR_NC}"
#$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" config-split:export prod -y

. ${SCRIPTS_PATH}/tasks/import_configuration.sh
. ${SCRIPTS_PATH}/tasks/update_translations.sh

# For update.sh import only content if the environment is dev to not risk
# breaking prod.
if [ "${ENVIRONMENT_MODE}" = "dev" ]; then
  . ${SCRIPTS_PATH}/tasks/import_default_content.sh
fi

echo -e "${COLOR_LIGHT_GREEN}Disable maintenance mode.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" state:set system.maintenance_mode 0

. ${SCRIPTS_PATH}/tasks/flush_cache.sh
. ${SCRIPTS_PATH}/tasks/run_cron.sh
