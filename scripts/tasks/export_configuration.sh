#!/bin/bash

. $(dirname $(dirname ${BASH_SOURCE[0]}))/script-parameters.sh

if [ "${DRUPAL_SITE_DEFAULT_HAS_EXPORTED_CONFIG}" = "true" ]; then
  echo -e "${COLOR_LIGHT_GREEN}Export configuration.${COLOR_NC}"
  $DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" config:export -y
fi
