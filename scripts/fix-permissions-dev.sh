#!/bin/bash

# This script is though to be run as root.
# Use this script only to fix permissions on a dev environment where you don't
# care about permissions and only want things to work.

. $(dirname ${BASH_SOURCE[0]})/script-parameters.sh

echo -e "${COLOR_LIGHT_GREEN}No more permissions problem!${COLOR_NC}"
chmod 777 -R $APP_PATH
chmod 777 -R /tmp/*
chmod 644 $APP_PATH/profiles/.gitkeep
