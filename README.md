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

## Documentation

See the **docs** folder for detailed documentation.

## Services

If using Docker with the default provided configuration, you will have:
* the website accessible through Apache: http://web.ddp8.docker.localhost
* the website accessible through Varnish: http://varnish.ddp8.docker.localhost
* a mail catcher: http://mail.ddp8.docker.localhost
* a Piwik app: http://piwik.ddp8.docker.localhost
