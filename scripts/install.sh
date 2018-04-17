#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/script-parameters.sh
. $(dirname ${BASH_SOURCE[0]})/script-parameters.local.sh

. $SCRIPTS_PATH/tasks/composer_install.sh

echo -e "${LIGHT_GREEN}Without drush alias, change temporarily directory to www.${NC}"
cd $WWW_PATH

echo -e "${LIGHT_GREEN}Clear Drush cache in case of update.${NC}"
$DRUSH cc drush

echo -e "${LIGHT_GREEN}Database backup.${NC}"
$DRUSH sql-dump --result-file="${PROJECT_PATH}/backups/${CURRENT_DATE}.sql" --gzip --structure-tables-key="common"

echo -e "${LIGHT_GREEN}Disable external cache.${NC}"
rm -f $WWW_PATH/sites/default/.cache_activated

echo -e "${LIGHT_GREEN}Install Drupal.${NC}"
$DRUSH site-install $PROFILE \
  --account-mail=$ACCOUNT_MAIL \
  --account-name=$ACCOUNT_NAME \
  --account-pass=$ACCOUNT_PASS \
  --site-mail=$SITE_MAIL \
  --site-name=$SITE_NAME \
  --locale=$DEFAULT_LANGUAGE \
  -y

echo -e "${LIGHT_GREEN}Launch updates.${NC}"
$DRUSH updb -y

. $SCRIPTS_PATH/tasks/development_modules.sh
#. $SCRIPTS_PATH/tasks/migrate_imports.sh
#. $SCRIPTS_PATH/tasks/update_translations.sh

echo -e "${LIGHT_GREEN}Run CRON.${NC}"
$DRUSH cron

echo -e "${LIGHT_GREEN}Enable external cache.${NC}"
touch $WWW_PATH/sites/default/.cache_activated
$DRUSH cc all

echo -e "${LIGHT_GREEN}Back to the current directory.${NC}"
cd $CURRENT_PATH
