#!/bin/bash

. $(dirname $(dirname ${BASH_SOURCE[0]}))/script-parameters.sh

#echo -e "${COLOR_LIGHT_GREEN}Export prod config split in case of overrides.${COLOR_NC}"
#$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" config-split:export prod -y
