#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/script-parameters.sh

echo -e "${LIGHT_GREEN}Copy example files.${NC}"
rsync -avz --ignore-existing $PROJECT_PATH/example.env                          $PROJECT_PATH/.env
rsync -avz --ignore-existing $SCRIPTS_PATH/example.script-parameters.local.sh   $SCRIPTS_PATH/script-parameters.local.sh
rsync -avz --ignore-existing $PROJECT_PATH/conf/drupal/default/example.settings.local.php $PROJECT_PATH/conf/drupal/default/settings.local.php

echo -e "${LIGHT_GREEN}Create public files directory.${NC}"
mkdir -p $APP_PATH/sites/default/files

echo -e "${LIGHT_GREEN}Permissions are for dev environments. It should be less permissive.${NC}"
chmod 777 $APP_PATH/sites/default/files

echo -e "${LIGHT_GREEN}Create symlink to git hook.${NC}"
ln -s ../../scripts/quality/git-pre-commit-hook.sh $PROJECT_PATH/.git/hooks/pre-commit

echo -e "${LIGHT_GREEN}Create drupal-debug folders.${NC}"
mkdir -p $PROJECT_PATH/drupal-debug/cache
mkdir -p $PROJECT_PATH/drupal-debug/logs
chmod 777 -R $PROJECT_PATH/drupal-debug
