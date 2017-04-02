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
  config_inspector
  dblog
  devel
#  devel_a11y
  features_ui
  field_ui
#  kint
#  purge_ui
#  renderviz
#  search_kint
  views_ui
  webprofiler
  # As in this template we not use custom install profile, enable some modules.
  admin_toolbar_tools
#  purge
#  purge_drush
#  purge_queuer_coretags
#  purge_processor_cron
#  purge_ui
  redis
#  search_api
#  search_api_solr
#  varnish_purger
#  varnish_purge_tags
)
