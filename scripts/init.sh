#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/script-parameters.sh

echo -e "${LIGHT_GREEN}Copy example files.${NC}"
rsync -avz --ignore-existing $PROJECT_PATH/example.env                          $PROJECT_PATH/.env
rsync -avz --ignore-existing $PROJECT_PATH/example.docker-compose.yml           $PROJECT_PATH/docker-compose.yml
rsync -avz --ignore-existing $SCRIPTS_PATH/example.script-parameters.local.sh   $SCRIPTS_PATH/script-parameters.local.sh
rsync -avz --ignore-existing $WWW_PATH/sites/default/example.settings.local.php $WWW_PATH/sites/default/settings.local.php

echo -e "${LIGHT_GREEN}Create public files directory.${NC}"
mkdir -p $WWW_PATH/sites/default/files

echo -e "${LIGHT_GREEN}Permissions are for dev environments. It should be less permissive.${NC}"
chmod 777 $WWW_PATH/sites/default/files
