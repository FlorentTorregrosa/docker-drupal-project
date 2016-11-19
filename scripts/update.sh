#!/bin/bash

function abspath() {
    python -c "import sys, os;sys.stdout.write(os.path.abspath(\"$@\"))"
}

FILE_PATH=$(abspath "${0}")
PROJECT_PATH=$(dirname $(dirname $FILE_PATH))

. $PROJECT_PATH/scripts/script-parameters.sh
. $PROJECT_PATH/scripts/script-parameters.local.sh

# Put the site in maintenance mode.
$DRUSH state-set system.maintenance_mode 1

# Install sources.
. $SCRIPTS_PATH/tasks/composer_install.sh

# Without drush alias, change temporarily directory to www.
cd $WWW_PATH

# Database backup.
$DRUSH sql-dump --result-file="${PROJECT_PATH}/backups/${CURRENT_DATE}.sql" --gzip

# Launch updates. Ensure that the database schema is up-to-date.
$DRUSH updb --entity-updates -y

# Enable development modules.
. $SCRIPTS_PATH/tasks/development_modules.sh

# Remove the maintenance mode.
$DRUSH state-set system.maintenance_mode 0

# Run CRON.
$DRUSH cron

# Back to the current directory.
cd $CURRENT_PATH
