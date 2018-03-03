# Installation

* Execute: `scripts/init.sh`
* Adapt the following files to your configuration:
  * scripts/script-parameters.local.sh
  * conf/drupal/default/settings.local.php
* Execute `scripts/install.sh` (do not if using docker, see below)

## Additional steps to install with Docker compose

* **Do not execute scripts/install.sh from your computer.**.
* Adapt the following files to your configuration:
  * docker-compose.yml
* Execute:

```bash
docker-compose pull
docker-compose up
```

* In another tab, get a command-line in the container:

```bash
docker-compose exec web /bin/bash
```

* Then execute:

```bash
cd ..
./scripts/install.sh
```
