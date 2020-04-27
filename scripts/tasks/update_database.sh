#!/bin/bash

. $(dirname $(dirname ${BASH_SOURCE[0]}))/script-parameters.sh

echo -e "${COLOR_LIGHT_GREEN}Launch updates. Ensure that the database schema is up-to-date.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" updatedb -y

echo -e "${COLOR_LIGHT_GREEN}Launch updates a second time. Just in case...${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" updatedb -y

echo -e "${COLOR_LIGHT_GREEN}Clear cache to be sure cache are cleared even if there is no update. Otherwise for example 'drush config:export' does not detect that there are changes to export.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" cache:rebuild
