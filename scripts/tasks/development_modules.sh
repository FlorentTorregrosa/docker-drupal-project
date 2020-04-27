#!/bin/bash

. $(dirname $(dirname ${BASH_SOURCE[0]}))/script-parameters.sh

if [ "${ENVIRONMENT_MODE}" = "dev" ]; then
  echo -e "${COLOR_LIGHT_GREEN}Enable development modules.${COLOR_NC}"
  MODULES=''
  for DEVELOPMENT_MODULE in "${DEVELOPMENT_MODULES[@]}"
  do
    MODULES="${MODULES} ${DEVELOPMENT_MODULE}"
  done
  $DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" pm:enable ${MODULES} -y
fi
