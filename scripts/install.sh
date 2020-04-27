#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/script-parameters.sh

. $SCRIPTS_PATH/tasks/composer_install.sh

echo -e "${COLOR_LIGHT_GREEN}Database backup.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" sql:dump --result-file="${PROJECT_PATH}/backups/${DRUPAL_SITE_DEFAULT_FOLDER_NAME}-${CURRENT_DATE}.sql" --gzip --structure-tables-key="common"

if [ "${USE_REDIS}" = "yes" ]; then
  echo -e "${COLOR_LIGHT_GREEN}Clear Redis cache because otherwise it is no emptied on site install and it provokes errors.${COLOR_NC}"
  redis-cli -h "${DRUPAL_SITE_DEFAULT_REDIS_HOST}" -p "${DRUPAL_SITE_DEFAULT_REDIS_PORT}" -n "${DRUPAL_SITE_DEFAULT_REDIS_BASE}" FLUSHDB
fi

echo -e "${COLOR_LIGHT_GREEN}Install Drupal.${COLOR_NC}"
$DRUSH site:install "${DRUPAL_SITE_DEFAULT_INSTALLATION_PROFILE}" \
  --account-mail="${DRUPAL_SITE_DEFAULT_ACCOUNT_MAIL}" \
  --account-name="${DRUPAL_SITE_DEFAULT_ACCOUNT_NAME}" \
  --account-pass="${DRUPAL_SITE_DEFAULT_ACCOUNT_PASS}" \
  --site-mail="${DRUPAL_SITE_DEFAULT_SITE_MAIL}" \
  --site-name="${DRUPAL_SITE_DEFAULT_SITE_NAME}" \
  --locale="${DRUPAL_SITE_DEFAULT_DEFAULT_LANGUAGE}" \
  --sites-subdir="${DRUPAL_SITE_DEFAULT_FOLDER_NAME}" \
  -y

. $SCRIPTS_PATH/tasks/update_database.sh
#. $SCRIPTS_PATH/tasks/import_configuration.sh
. $SCRIPTS_PATH/tasks/development_modules.sh
#. $SCRIPTS_PATH/tasks/migrate_imports.sh
#. $SCRIPTS_PATH/tasks/update_translations.sh

echo -e "${COLOR_LIGHT_GREEN}Flush caches to be clean.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" cache:rebuild

echo -e "${COLOR_LIGHT_GREEN}Run CRON.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" core:cron
