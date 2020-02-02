#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/script-parameters.sh

if [ "${USE_DRUPAL_DEBUG}" = "yes" ]; then
  echo -e "${COLOR_LIGHT_GREEN}Disable Drupal Debug in case it is still active.${COLOR_NC}"
  composer drupal-debug:disable-original-drupal-kernel-substitution --working-dir="${PROJECT_PATH}"
  chown "${WEBSERVER_USER}":"${WEBSERVER_USER}" /tmp/drupal_debug_*
fi

echo -e "${COLOR_LIGHT_GREEN}Database backup.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" sql:dump --result-file="${PROJECT_PATH}/backups/${DRUPAL_SITE_DEFAULT_FOLDER_NAME}-${CURRENT_DATE}.sql" --gzip --structure-tables-key="common"

echo -e "${COLOR_LIGHT_GREEN}Put the site in maintenance mode.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" state:set system.maintenance_mode 1

. $SCRIPTS_PATH/tasks/composer_install.sh

echo -e "${COLOR_LIGHT_GREEN}Clear cache to be sure cache are cleared even if there is no update or Drush has been updated.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" cache:rebuild

echo -e "${COLOR_LIGHT_GREEN}Launch updates. Ensure that the database schema is up-to-date.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" updatedb -y

. $SCRIPTS_PATH/tasks/development_modules.sh

#echo -e "${COLOR_LIGHT_GREEN}TODO: Depending of project, import config with either CMI or features.${COLOR_NC}"

# For update.sh import only content if the environment is dev to not risk
# breaking prod.
#if [ "${ENVIRONMENT_MODE}" = "dev" ]; then
#  . $SCRIPTS_PATH/tasks/migrate_imports.sh
#fi

#. $SCRIPTS_PATH/tasks/update_translations.sh

echo -e "${COLOR_LIGHT_GREEN}Rebuild Drupal paranoia.${COLOR_NC}"
composer drupal:paranoia --working-dir="${PROJECT_PATH}"

echo -e "${COLOR_LIGHT_GREEN}Remove the maintenance mode.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" state:set system.maintenance_mode 0

echo -e "${COLOR_LIGHT_GREEN}Run CRON.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" core:cron

if [ "${USE_DRUPAL_DEBUG}" = "yes" ]; then
  echo -e "${COLOR_LIGHT_GREEN}Enable Drupal Debug.${COLOR_NC}"
  composer drupal-debug:enable-original-drupal-kernel-substitution --working-dir="${PROJECT_PATH}"
  chown "${WEBSERVER_USER}":"${WEBSERVER_USER}" /tmp/drupal_debug_*
fi
