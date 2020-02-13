#!/bin/bash

# Load variables from example.env file to have the color variables (.env is not
# initialized yet).
set -o allexport
source $(dirname ${BASH_SOURCE[0]})/../example.env
set +o allexport

PROJECT_PATH=$(dirname $(dirname ${BASH_SOURCE[0]}))

echo -e "${COLOR_LIGHT_GREEN}Copy example files.${COLOR_NC}"

rsync -avz --ignore-existing $PROJECT_PATH/example.env $PROJECT_PATH/.env
echo -e "${COLOR_LIGHT_RED}Please check values in $PROJECT_PATH/.env${COLOR_NC}"

rsync -avz --ignore-existing $PROJECT_PATH/conf/env/example.composer.env $PROJECT_PATH/conf/env/composer.env
echo -e "${COLOR_LIGHT_RED}Please check values in $PROJECT_PATH/conf/env/composer.env${COLOR_NC}"

rsync -avz --ignore-existing $PROJECT_PATH/conf/drupal/default/example.settings.local.php $PROJECT_PATH/conf/drupal/default/settings.local.php
echo -e "${COLOR_LIGHT_RED}Please check values in $PROJECT_PATH/conf/drupal/default/settings.local.php${COLOR_NC}"

echo -e "${COLOR_LIGHT_GREEN}Create public files directory.${COLOR_NC}"
mkdir -p $PROJECT_PATH/app/sites/default/files

echo -e "${COLOR_LIGHT_GREEN}Permissions are for dev environments. It should be less permissive.${COLOR_NC}"
chmod 777 $PROJECT_PATH/app/sites/default/files

#echo -e "${COLOR_LIGHT_GREEN}Create symlink to git hook.${COLOR_NC}"
#ln -s ../../scripts/quality/git-pre-commit-hook.sh $PROJECT_PATH/.git/hooks/pre-commit
