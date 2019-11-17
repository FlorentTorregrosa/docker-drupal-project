<?php

// @codingStandardsIgnoreFile
// See https://git.drupalcode.org/project/drupal/blob/HEAD/sites/default/default.settings.php

$databases = [];
$databases['default']['default'] = [
  'driver' => 'mysql',
  'database' => 'drupal',
  'username' => 'drupal',
  'password' => 'drupal',
  'host' => 'mysql',
  'prefix' => '',
];

// Change this value.
$settings['hash_salt'] = 'template';

$config_directories = [
  CONFIG_SYNC_DIRECTORY => $app_root . '/' . $site_path . '/../../../conf/drupal/default/sync',
];

$settings['container_yamls'][] = $app_root . '/../conf/drupal/default/services.yml';

$settings['update_free_access'] = FALSE;
$settings['allow_authorize_operations'] = FALSE;

$settings['file_public_path'] = 'sites/default/files';
$settings['file_private_path'] = $app_root . '/../private_files/default';

$settings['file_scan_ignore_directories'] = [
  'node_modules',
  'bower_components',
];

// Prevent deletion of orphan files.
// TODO: Remove this line when the following issues will be fixed:
// - https://www.drupal.org/node/2801777
// - https://www.drupal.org/node/2708411
// - https://www.drupal.org/node/1239558
// - https://www.drupal.org/node/2666700
// - https://www.drupal.org/node/2810355
$config['system.file']['temporary_maximum_age'] = 0;

// Trusted host pattern.
$settings['trusted_host_patterns'] = [
  '^localhost$',
  '^127\.0\.0\.1$',
  '^varnish$',
  '^web$',
];

$environment_trusted_host_patterns = [
  'DRUPAL_TRAEFIK_FRONTEND_RULE_HOSTNAME',
  'VARNISH_TRAEFIK_FRONTEND_RULE_HOSTNAME',
];

foreach ($environment_trusted_host_patterns as $environment_trusted_host_pattern) {
  if (getenv($environment_trusted_host_pattern)) {
    $domains = explode(',', getenv($environment_trusted_host_pattern));
    foreach ($domains as $domain) {
      $settings['trusted_host_patterns'][] = '^' . $domain . '$';
    }
  }
}

// Translations.
$config['locale.settings']['translation']['path'] = 'translations/contrib';
$config['locale.settings']['translation']['use_source'] = 'local';

// Performance.
//$settings['omit_vary_cookie'] = TRUE;

$config['system.performance']['cache']['page']['max_age'] = 86400;
$config['system.performance']['css']['preprocess'] = TRUE;
$config['system.performance']['js']['preprocess'] = TRUE;

// Redis.
$settings['redis.connection']['interface'] = 'PhpRedis';
$settings['redis.connection']['host'] = 'redis';
$settings['redis.connection']['port'] = '6379';
$settings['redis.connection']['base'] = 0;

$settings['container_yamls'][] = 'modules/contrib/redis/redis.services.yml';
$settings['container_yamls'][] = 'modules/contrib/redis/example.services.yml';

$settings['cache']['default'] = 'cache.backend.redis';

// Varnish.
$config['varnish_purger.settings.varnish']['hostname'] = 'varnish';

// Errors.
$config['system.logging']['error_level'] = 'hide';

// Development.
// See https://git.drupalcode.org/project/drupal/blob/HEAD/sites/example.settings.local.php
//assert_options(ASSERT_ACTIVE, TRUE);
//\Drupal\Component\Assertion\Handle::register();

//$settings['container_yamls'][] = $app_root . '/../conf/drupal/default/development.services.yml';

//$config['devel.settings']['devel_dumper'] = 'var_dumper';
//$config['system.logging']['error_level'] = 'verbose';
//$config['system.performance']['css']['preprocess'] = FALSE;
//$config['system.performance']['js']['preprocess'] = FALSE;
//$config['views.settings']['ui']['show']['advanced_column'] = TRUE;

//$settings['cache']['bins']['dynamic_page_cache'] = 'cache.backend.null';
//$settings['cache']['bins']['page'] = 'cache.backend.null';
//$settings['cache']['bins']['render'] = 'cache.backend.null';

//$settings['extension_discovery_scan_tests'] = TRUE;
//$settings['rebuild_access'] = TRUE;
//$settings['skip_permissions_hardening'] = TRUE;
