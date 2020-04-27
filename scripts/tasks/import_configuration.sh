#!/bin/bash

. $(dirname $(dirname ${BASH_SOURCE[0]}))/script-parameters.sh

if [ "${DRUPAL_SITE_DEFAULT_HAS_EXPORTED_CONFIG}" = "true" ]; then
  echo -e "${COLOR_LIGHT_GREEN}Import configuration.${COLOR_NC}"
  $DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" config:import -y

  echo -e "${COLOR_LIGHT_GREEN}Import configuration a second time. In case the config of modules altering configuration import has changed.${COLOR_NC}"
  $DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" config:import -y
fi
