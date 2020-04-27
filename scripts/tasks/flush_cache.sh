#!/bin/bash

. $(dirname $(dirname ${BASH_SOURCE[0]}))/script-parameters.sh

echo -e "${COLOR_LIGHT_GREEN}Flush caches to be clean.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" cache:rebuild
