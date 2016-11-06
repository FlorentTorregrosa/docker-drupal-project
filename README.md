# Docker Drupal project

A Drupal project template with Docker environment.

## Installation

* Execute: **scripts/init.sh**
* Adapt the following files to your configuration:
  * docker-compose.yml
  * scripts/script-parameters.local.sh
  * www/sites/default/settings.local.php
* Execute: **docker-compose up**
* In another tab, get a command-line in the container: **docker exec -it container_name_php_1 /bin/bash**
* In the **www** directory, execute: **composer install** to get the project's Drush.
* Execute scripts/install.sh
