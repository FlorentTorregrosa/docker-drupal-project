#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/script-parameters.sh

. ${SCRIPTS_PATH}/tasks/composer_install.sh
. ${SCRIPTS_PATH}/tasks/dump_database.sh
. ${SCRIPTS_PATH}/tasks/install_drupal.sh
. ${SCRIPTS_PATH}/tasks/update_database.sh
#. ${SCRIPTS_PATH}/tasks/import_configuration.sh
. ${SCRIPTS_PATH}/tasks/enable_development_modules.sh
. ${SCRIPTS_PATH}/tasks/update_translations.sh
. ${SCRIPTS_PATH}/tasks/import_default_content.sh
. ${SCRIPTS_PATH}/tasks/flush_cache.sh
. ${SCRIPTS_PATH}/tasks/run_cron.sh
