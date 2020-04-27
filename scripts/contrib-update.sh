#!/bin/bash

# Use this script to make core and contrib updates.
# Launch the script after making a git pull and editing your composer.json.

. $(dirname ${BASH_SOURCE[0]})/script-parameters.sh

# Ensure environment is up-to-date.
. ${SCRIPTS_PATH}/tasks/update_database.sh
. ${SCRIPTS_PATH}/tasks/export_config_split_prod.sh
. ${SCRIPTS_PATH}/tasks/import_configuration.sh

. ${SCRIPTS_PATH}/tasks/dump_database.sh

. ${SCRIPTS_PATH}/tasks/composer_update.sh

. ${SCRIPTS_PATH}/tasks/update_database.sh
. ${SCRIPTS_PATH}/tasks/update_translations.sh
. ${SCRIPTS_PATH}/tasks/flush_cache.sh
. ${SCRIPTS_PATH}/tasks/export_config_split_prod.sh
. ${SCRIPTS_PATH}/tasks/export_configuration.sh

. ${SCRIPTS_PATH}/tasks/flush_cache.sh
