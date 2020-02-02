# Additional Docker information

## Traefik integration

If there's a local traefik reverse-proxy on your development environment,
you can access the site through:
* http://web-ddp8.docker.localhost/
* http://en-web-ddp8.docker.localhost/
* http://fr-web-ddp8.docker.localhost/

Alternative hostnames can be provided by setting environment variables, for
instance using a .env file. See the example.env file for the available
variables.

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

A Traefik configuration and docker-compose.yml are on `https://github.com/FlorentTorregrosa/docker-traefik`
to ease the usage.

## Q/A
### How to find out the container names?

You can use the command `docker ps` which list all the running docker
containers.

![docker PS](http://i.imgur.com/SDgHsqs.png)

### How to use Drush within Docker?

Using Makefile:

```shell script
make docker-drush cr
```

Or when in the container, you have to "be" in the app folder (eg: `/project/app`) or the project
folder (eg: `/project`)

Optional: you can use Drush within the web container by using the alias
`@default.docker-dev`:

```bash
drush @default.docker-dev status
```

### How to import a custom dump?

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
