#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/script-parameters.sh

echo -e "${COLOR_LIGHT_GREEN}Copy example files.${COLOR_NC}"
rsync -avz --ignore-existing $PROJECT_PATH/example.env                          $PROJECT_PATH/.env
rsync -avz --ignore-existing $PROJECT_PATH/conf/drupal/default/example.settings.local.php $PROJECT_PATH/conf/drupal/default/settings.local.php

echo -e "${COLOR_LIGHT_GREEN}Create public files directory.${COLOR_NC}"
mkdir -p $APP_PATH/sites/default/files

echo -e "${COLOR_LIGHT_GREEN}Permissions are for dev environments. It should be less permissive.${COLOR_NC}"
chmod 777 $APP_PATH/sites/default/files

#echo -e "${COLOR_LIGHT_GREEN}Create symlink to git hook.${COLOR_NC}"
#ln -s ../../scripts/quality/git-pre-commit-hook.sh $PROJECT_PATH/.git/hooks/pre-commit
