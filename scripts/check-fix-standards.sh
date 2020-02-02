#!/bin/bash

# You should have the following tools installed globally:
# - PHPCS
# - PHPCBF
# - Drupal CS registered
# - ESLint

usage() {
    echo "check-fix-standards.sh path_to_check"
}

while getopts "h" opt; do
    case "${opt}" in
        h)
            usage; exit 0;;
        \?)
            usage >&2; exit 1;;
    esac
done

if [ -z "$1" ] ; then
    echo 'The path to check is required';
    exit 1;
fi

. $(dirname ${BASH_SOURCE[0]})/script-parameters.sh

PATH_TO_CHECK=$(abspath $1)

echo -e "${COLOR_LIGHT_GREEN}Change temporarily directory to scripts/quality to have tools configuration taken into account.${COLOR_NC}"
cd $SCRIPTS_PATH/quality

echo -e "${COLOR_LIGHT_GREEN}PHP Code Sniffer${COLOR_NC}"
phpcs --standard=Drupal,DrupalPractice --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md' $PATH_TO_CHECK

echo -e "${COLOR_LIGHT_GREEN}PHP Code Beautifier${COLOR_NC}"
# TODO: Files are not modified.
phpcbf --standard=Drupal,DrupalPractice --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md' $PATH_TO_CHECK

echo -e "${COLOR_LIGHT_GREEN}ESLint${COLOR_NC}"
# TODO: The inclusion of eslint-config-airbnb does not work.
# Use .eslintrc.legacy.json as a temporary workaround.
eslint -c $SCRIPTS_PATH/quality/.eslintrc.legacy.json --no-eslintrc --fix $PATH_TO_CHECK

echo -e "${COLOR_LIGHT_GREEN}Back to the current directory.${COLOR_NC}"
cd $CURRENT_PATH
