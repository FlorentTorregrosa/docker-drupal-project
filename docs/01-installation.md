# Installation

* Execute: `make project-init`
  * This will enable a git pre-commit hook that will run check against the code.
    You will need to have the following tools installed:
      * execute `npm install` in scripts/quality folder
      * nodejs (8.11.x recommended)
      * gulp-cli
  * You can also remove the symlink in .git/hooks to remove this feature.
* Adapt the following files to your configuration:
  * .env
  * conf/drupal/default/settings.local.php
    * uncomment lines in the "Development" section.
* Execute `scripts/install.sh` (do not if using docker, see below)

## Additional steps to install with Docker compose

* **Do not execute scripts/install.sh from your computer.**.
* Adapt the following files to your configuration:
  * .env
    * Set you Github OAuth token.
    * For example to enable Xdebug.
  * docker-compose.yml
* Execute:

```bash
make docker-up
make docker-site-install
```
