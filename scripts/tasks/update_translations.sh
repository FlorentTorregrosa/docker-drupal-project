#!/bin/bash

. $(dirname $(dirname ${BASH_SOURCE[0]}))/script-parameters.sh
. $(dirname $(dirname ${BASH_SOURCE[0]}))/script-parameters.local.sh

echo -e "${LIGHT_GREEN}Enable l10n_update module.${NC}"
$DRUSH y en l10n_update

echo -e "${LIGHT_GREEN}Update translations status.${NC}"
$DRUSH l10n-update-refresh

echo -e "${LIGHT_GREEN}Update translations.${NC}"
$DRUSH l10n-update

echo -e "${LIGHT_GREEN}Disable l10n_update module.${NC}"
$DRUSH -y dis l10n_update

# TODO: Check this command.
#echo -e "${LIGHT_GREEN}Import custom translations.${NC}"
#$DRUSH language-import $DEFAULT_LANGUAGE $WWW_PATH/sites/all/profiles/custom/$PROFILE/translations/$PROFILE.po --replace
