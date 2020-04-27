#!/bin/bash

# Load variables from .env file.
set -o allexport
source $(dirname ${BASH_SOURCE[0]})/../.env
set +o allexport

CURRENT_PATH=$(pwd)
CURRENT_DATE=$(date "+%Y-%m-%d-%Hh%Mm%Ss")

DEVELOPMENT_MODULES=(
  config_inspector
  dblog
  devel
  devel_a11y
  devel_generate
  devel_php
  field_ui
#  purge_ui
#  renderviz
  speedboxes
  views_ui
  # As in this template we not use custom install profile, enable some modules.
  admin_toolbar_tools
  health_check
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
