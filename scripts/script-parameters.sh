#!/bin/bash

function abspath() {
    python -c "import sys, os;sys.stdout.write(os.path.abspath(\"$@\"))"
}

FILE_PATH=$(abspath "${0}")
PROJECT_PATH=$(dirname $(dirname $FILE_PATH))

CURRENT_PATH=$(pwd)

SCRIPTS_PATH=$PROJECT_PATH/scripts
WWW_PATH=$PROJECT_PATH/www

DRUSH=$WWW_PATH/vendor/bin/drush

CURRENT_DATE=$(date "+%Y-%m-%d-%Hh%Mm%Ss")

PROFILE=standard
DEFAULT_LANGUAGE=en
DEVELOPMENT_MODULES=(
  config_inspector
  dblog
  devel
  devel_a11y
  features_ui
  field_ui
  kint
  renderviz
  search_kint
  views_ui
  webprofiler
  # As in this template we not use custom install profile, enable some modules.
  admin_toolbar_tools
  elasticsearch_connector
  redis
  search_api
  search_api_solr
)

# External libraries version.
DROPZONE_VERSION=4.3.0
