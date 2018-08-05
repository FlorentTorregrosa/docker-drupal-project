# Installation

* Execute: `scripts/init.sh`
  * This will enable a git pre-commit hook that will run check against the code.
    You will need to have the following tools installed:
      * execute `npm install` in scripts/quality folder
      * nodejs (8.11.x recommended)
      * gulp-cli
  * You can also remove the symlink in .git/hooks to remove this feature.
* Adapt the following files to your configuration:
  * scripts/script-parameters.local.sh
  * conf/drupal/default/settings.local.php
* Execute `scripts/install.sh` (do not if using docker, see below)

## Additional steps to install with Docker compose

* **Do not execute scripts/install.sh from your computer.**.
* Adapt the following files to your configuration:
  * .env
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
cd /project (if necessary)
./scripts/install.sh
```
