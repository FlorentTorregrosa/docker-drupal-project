#!/bin/bash

# You should have the following tools installed globally:
# - npm

. $(dirname ${BASH_SOURCE[0]})/script-parameters.sh

echo -e "${COLOR_LIGHT_GREEN}Change temporarily directory to scripts/quality to have tools configuration taken into account.${COLOR_NC}"
cd $SCRIPTS_PATH/quality

echo -e "${COLOR_LIGHT_GREEN}Install npm packages.${COLOR_NC}"
npm install

echo -e "${COLOR_LIGHT_GREEN}Run code quality tools.${COLOR_NC}"
./node_modules/.bin/gulp lint

echo -e "${COLOR_LIGHT_GREEN}Back to the current directory.${COLOR_NC}"
cd $CURRENT_PATH
