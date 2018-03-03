# Docker Drupal project

A Drupal project template with Docker environment.

## Requirements

To use with Docker:
* Docker
* Docker compose

To use outside of Docker:
* Composer

Scripts inside the scripts folder don't have dependencies on Docker. So its
could be executed outside of a Docker environment.

Some adjustment in configuration files may be required.

## Installation

* Execute: `scripts/init.sh`
* Adapt the following files to your configuration:
  * scripts/script-parameters.local.sh
  * conf/drupal/default/settings.local.php
* Execute `scripts/install.sh` (do not if using docker, see below)

### Additional steps to install with Docker compose

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

* Execute:

```bash
cd ..
./scripts/install.sh
```

#### Traefik integration

If there's a local traefik reverse-proxy on your development environment, you
can access the site through http://web.ddp8.docker.localhost/

Otherwise it depends if you have made a port mapping in the docker-compose.yml
file, for example:

```yaml
services:
  web:
    ...
    ports:
      - 8081:80
```

The website **should** be located at this address: `http://127.0.0.1:8081/*`

### Q/A
#### How to find out the container names?

You can use the command `docker ps` which list all the running docker
containers.

![docker PS](http://i.imgur.com/SDgHsqs.png)

#### How to use Drush within Docker?

You can use Drush within the web container by using the alias `@docker.default`:

```bash
drush @docker.default status
```

Note: you have to "be" in the docroot folder (eg: `/project/www`) or the project
folder (eg: `/project`)

#### How to import a custom dump?

Put the dump in the `backups` folder and then in the **web** container you can
use the following command:

```bash
zcat /project/backups/DUMP_NAME.sql.gz | mysql -u drupal -pdrupal -h mysql drupal
```

Or using the following commands:

```bash
cd /project/backups
tar -xvzf /project/backups/DUMP_NAME.sql.gz
cd ..
drush sql-cli < /project/backups/DUMP_NAME.sql
```
