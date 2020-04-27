#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/script-parameters.sh

echo -e "${COLOR_LIGHT_GREEN}Run behat tests.${COLOR_NC}"
${PROJECT_PATH}/vendor/bin/behat --config="${SCRIPTS_PATH}/tests/behat/behat.yml"
