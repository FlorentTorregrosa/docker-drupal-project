#!/bin/bash

. $(dirname $(dirname ${BASH_SOURCE[0]}))/script-parameters.sh

echo -e "${COLOR_LIGHT_GREEN}Composer install.${COLOR_NC}"
if [ "${ENVIRONMENT_MODE}" = "dev" ]; then
    composer install --working-dir="${PROJECT_PATH}"
else
    composer install --working-dir="${PROJECT_PATH}" --no-dev
fi
