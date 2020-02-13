# Installation

* Execute: `make project-init`
* Adapt the following files to your configuration:
  * .env
  * conf/env/composer.env
  * conf/drupal/default/settings.local.php
    * uncomment lines in the "Development" section.
* Execute `scripts/install.sh` (do not if using docker, see below)

## Additional steps to install with Docker compose

* **Do not execute scripts/install.sh from your computer.**.
* Execute:
```bash
make docker-up
make docker-site-install
```
