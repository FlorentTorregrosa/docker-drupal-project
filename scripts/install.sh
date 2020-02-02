#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/script-parameters.sh

if [ "${USE_DRUPAL_DEBUG}" = "yes" ]; then
  echo -e "${COLOR_LIGHT_GREEN}Disable Drupal Debug in case it is still active.${COLOR_NC}"
  composer drupal-debug:disable-original-drupal-kernel-substitution --working-dir="${PROJECT_PATH}"
  chown "${WEBSERVER_USER}":"${WEBSERVER_USER}" /tmp/drupal_debug_*
fi

. $SCRIPTS_PATH/tasks/composer_install.sh

echo -e "${COLOR_LIGHT_GREEN}Clear Drush cache in case of update.${COLOR_NC}"
$DRUSH cache:clear drush

echo -e "${COLOR_LIGHT_GREEN}Database backup.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" sql:dump --result-file="${PROJECT_PATH}/backups/${DRUPAL_SITE_DEFAULT_FOLDER_NAME}-${CURRENT_DATE}.sql" --gzip --structure-tables-key="common"

if [ "${USE_REDIS}" = "yes" ]; then
  echo -e "${COLOR_LIGHT_GREEN}Clear Redis cache because otherwise it is no emptied on site install and it provokes errors.${COLOR_NC}"
  redis-cli -h "${DRUPAL_SITE_DEFAULT_REDIS_HOST}" -n "${DRUPAL_SITE_DEFAULT_REDIS_BASE}" FLUSHDB
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

echo -e "${COLOR_LIGHT_GREEN}Launch updates. Ensure that the database schema is up-to-date.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" updatedb -y

. $SCRIPTS_PATH/tasks/development_modules.sh
#. $SCRIPTS_PATH/tasks/migrate_imports.sh
#. $SCRIPTS_PATH/tasks/update_translations.sh

echo -e "${COLOR_LIGHT_GREEN}Rebuild Drupal paranoia.${COLOR_NC}"
composer drupal:paranoia --working-dir="${PROJECT_PATH}"

echo -e "${COLOR_LIGHT_GREEN}Run CRON.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" core:cron

echo -e "${COLOR_LIGHT_GREEN}Flush caches to be clean.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" cache:rebuild

if [ "${USE_DRUPAL_DEBUG}" = "yes" ]; then
  echo -e "${COLOR_LIGHT_GREEN}Enable Drupal Debug.${COLOR_NC}"
  composer drupal-debug:enable-original-drupal-kernel-substitution --working-dir="${PROJECT_PATH}"
  chown "${WEBSERVER_USER}":"${WEBSERVER_USER}" /tmp/drupal_debug_*
fi
