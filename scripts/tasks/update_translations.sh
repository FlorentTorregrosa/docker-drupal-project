#!/bin/bash

. $(dirname $(dirname ${BASH_SOURCE[0]}))/script-parameters.sh

echo -e "${COLOR_LIGHT_GREEN}Update translations status.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" locale:check

echo -e "${COLOR_LIGHT_GREEN}Update translations.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" locale:update

#echo -e "${COLOR_LIGHT_GREEN}Import custom translations.${COLOR_NC}"
#$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" pm:enable drush_language -y
#$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" language:import:translations --langcode="${DRUPAL_SITE_DEFAULT_DEFAULT_LANGUAGE}" $APP_PATH/profiles/custom/${DRUPAL_SITE_DEFAULT_INSTALLATION_PROFILE}/translations/${DRUPAL_SITE_DEFAULT_INSTALLATION_PROFILE}.po
