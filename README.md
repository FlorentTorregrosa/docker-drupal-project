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
* the website accessible through Apache:
  * http://web.ddp8.docker.localhost
  * http://en-web.ddp8.docker.localhost
  * http://fr-web.ddp8.docker.localhost
* the website accessible through Varnish: http://varnish.ddp8.docker.localhost
* a mail catcher: http://mail.ddp8.docker.localhost
* a Matomo app: http://matomo.ddp8.docker.localhost

Note: You have to adapt your DNS configuration to inform your computer to search
for local websites.

For example, you can edit your /etc/hosts file and add an entry like:
```
127.0.0.1  web.ddp8.docker.localhost en-web.ddp8.docker.localhost fr-web.ddp8.docker.localhost varnish.ddp8.docker.localhost mail.ddp8.docker.localhost matomo.ddp8.docker.localhost
```
