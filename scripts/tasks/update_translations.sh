#!/bin/bash

. $(dirname $(dirname ${BASH_SOURCE[0]}))/script-parameters.sh

echo -e "${COLOR_LIGHT_GREEN}Enable the modules required to import translations.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" pm:enable locale drush_language -y

echo -e "${COLOR_LIGHT_GREEN}Update translations status.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" locale:check

echo -e "${COLOR_LIGHT_GREEN}Update translations.${COLOR_NC}"
$DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" locale:update

echo -e "${COLOR_LIGHT_GREEN}Import custom translations.${COLOR_NC}"
# Expected translation file pattern is "XXX.[langcode].po".
for TRANSLATION_FILE_PATH in ${APP_PATH}/translations/custom/*.po
do
  # Ensure what is detected is a file.
  if [ -f "${TRANSLATION_FILE_PATH}" ]; then
    FILE_NAME=$(basename "${TRANSLATION_FILE_PATH}")
    LANGCODE=$(echo "${FILE_NAME}" | cut -d'.' -f2)
    $DRUSH "${DRUPAL_SITE_DEFAULT_DRUSH_ALIAS}" language:import:translations --langcode="${LANGCODE}" --autocreate-language=0 ${TRANSLATION_FILE_PATH}
  fi
done
