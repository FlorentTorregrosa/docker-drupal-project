#!/bin/bash

. $(dirname $(dirname ${BASH_SOURCE[0]}))/script-parameters.sh

if [ "${USE_REDIS}" = "yes" ]; then
  echo -e "${COLOR_LIGHT_GREEN}Clear Redis cache because otherwise it is no emptied on site install and it provokes errors.${COLOR_NC}"
  redis-cli -h "${DRUPAL_SITE_DEFAULT_REDIS_HOST}" -p "${DRUPAL_SITE_DEFAULT_REDIS_PORT}" -n "${DRUPAL_SITE_DEFAULT_REDIS_BASE}" FLUSHDB
fi

if [ "${DRUPAL_SITE_DEFAULT_HAS_EXPORTED_CONFIG}" = "true" ]; then
  echo -e "${COLOR_LIGHT_GREEN}Install Drupal using existing config.${COLOR_NC}"
  $DRUSH site:install "${DRUPAL_SITE_DEFAULT_INSTALLATION_PROFILE}" \
    --account-mail="${DRUPAL_SITE_DEFAULT_ACCOUNT_MAIL}" \
    --account-name="${DRUPAL_SITE_DEFAULT_ACCOUNT_NAME}" \
    --account-pass="${DRUPAL_SITE_DEFAULT_ACCOUNT_PASS}" \
    --site-mail="${DRUPAL_SITE_DEFAULT_SITE_MAIL}" \
    --site-name="${DRUPAL_SITE_DEFAULT_SITE_NAME}" \
    --locale="${DRUPAL_SITE_DEFAULT_DEFAULT_LANGUAGE}" \
    --sites-subdir="${DRUPAL_SITE_DEFAULT_FOLDER_NAME}" \
    --existing-config \
    -y
else
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
fi
