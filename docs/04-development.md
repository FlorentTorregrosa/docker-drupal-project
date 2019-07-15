# Development

## Development modules

To get development modules, in the file scripts/script-parameters.local.sh,
comment the line `ENVIRONMENT_MODE="prod"` to get development modules. Or just
run the command `composer install`.

## Xdebug

To have Xdebug enabled in the web container, in the file .env, set the variable
`XDEBUG_ENABLED=true`.

## Debug mode

This template use Drupal Debug to enable development features.

If you want to be in debug mode:
* Execute: `composer drupal-debug:enable`
* Uncomment lines from conf/drupal/default/settings.local.php in the
  "development section"

## PhpStorm optimisations

Exclude the following folders from indexation:
* app/sites/default/files
* app/sites/simpletest (will exist only when you will launch PHPUnit tests)
* backups
* data
* drupal-debug
* private_files
* www/sites/default/files
