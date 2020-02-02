# Development

## Development modules

To get development modules, in the .env file,
have `ENVIRONMENT_MODE="dev"` to get development modules. Or just
run the command `composer install`.

## Xdebug

To have Xdebug enabled in the web container, in the file .env, set the variable
`XDEBUG_ENABLED=true`.

## Debug mode

If you want to be in debug mode, uncomment lines from conf/drupal/default/settings.local.php in the "Development" section

## PhpStorm optimisations

Exclude the following folders from indexation:
* app/sites/default/files
* app/sites/simpletest (will exist only when you will launch PHPUnit tests)
* backups
* data
* private_files
* www/sites/default/files

## NodeJS usage

To use NodeJS to compile CSS for example:

```bash
docker-compose exec node /bin/sh -c "cd /project/scripts/assets && npm install"
docker-compose exec node /bin/sh -c "cd /project/scripts/assets && ./node_modules/.bin/gulp"
```
