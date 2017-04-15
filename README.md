# Docker Drupal project

A Drupal project template with Docker environment.

## Installation

* Execute: **scripts/init.sh**
* Adapt the following files to your configuration:
  * docker-compose.yml
  * scripts/script-parameters.local.sh
  * www/sites/default/settings.local.php
* Execute: **docker-compose up**
* In another tab, get a command-line in the container: **docker exec -it container_name_web_1 /bin/bash**
* Execute scripts/install.sh

## Important note

With Drupal 7, download Drupal and contrib modules with Drush.

``drush dl drupal-7 --drupal-project-rename=www``

Otherwise composer will erase the content of the www directory each time a new Drupal core version is downloaded.
