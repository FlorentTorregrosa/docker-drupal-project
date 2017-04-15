#!/bin/bash

. $(dirname $(dirname ${BASH_SOURCE[0]}))/script-parameters.sh
. $(dirname $(dirname ${BASH_SOURCE[0]}))/script-parameters.local.sh

$DRUSH y en l10n_update
$DRUSH l10n-update-refresh
$DRUSH l10n-update
$DRUSH -y dis l10n_update
# TODO: Check this command.
#$DRUSH language-import $DEFAULT_LANGUAGE $WWW_PATH/sites/all/profiles/custom/$PROFILE/translations/$PROFILE.po --replace
