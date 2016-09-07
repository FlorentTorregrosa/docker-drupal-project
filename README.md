# Docker Drupal project

A Drupal project template with Docker environment.

## Installation

* Copy/paste **scripts/example.script-parameters.local.sh** into **scripts/script-parameters.local.sh and adapt it to your configuration.**
* Copy/paste **www/sites/default/example.settings.local.php** into **www/sites/default/settings.local.php and adapt it to your configuration.**
* Copy/paste the example.docker-compose.yml into docker-compose.yml and adapt it to your configuration to use the docker images you want.
* Create **www/sites/default/files** folder.
* Execute: **docker-compose up**
* In another tab, get a command-line in the container: **docker exec -it container_name_php_1 /bin/bash**
* Execute scripts/install.sh
