#!/bin/bash

function abspath() {
    python -c "import sys, os;sys.stdout.write(os.path.abspath(\"$@\"))"
}

PROJECT_PATH=$(abspath $(dirname $(dirname ${BASH_SOURCE[0]})))

CURRENT_PATH=$(pwd)

SCRIPTS_PATH=$PROJECT_PATH/scripts
WWW_PATH=$PROJECT_PATH/www

DRUSH=$PROJECT_PATH/vendor/bin/drush

CURRENT_DATE=$(date "+%Y-%m-%d-%Hh%Mm%Ss")

PROFILE=standard
DEFAULT_LANGUAGE=en
DEVELOPMENT_MODULES=(
  dblog
  devel
  field_ui
  views_ui
  # As in this template we not use custom install profile, enable some modules.
  admin_menu
  admin_menu_toolbar
  redis
#  search_api
#  search_api_solr
)
