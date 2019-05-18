#!/bin/bash

# You should have the following tools installed globally:
# - npm

. $(dirname ${BASH_SOURCE[0]})/script-parameters.sh
. $(dirname ${BASH_SOURCE[0]})/script-parameters.local.sh

echo -e "${LIGHT_GREEN}Change temporarily directory to scripts/quality to have tools configuration taken into account.${NC}"
cd $SCRIPTS_PATH/quality

echo -e "${LIGHT_GREEN}Install npm packages.${NC}"
npm install

echo -e "${LIGHT_GREEN}Run code quality tools.${NC}"
./node_modules/.bin/gulp lint

echo -e "${LIGHT_GREEN}Back to the current directory.${NC}"
cd $CURRENT_PATH
