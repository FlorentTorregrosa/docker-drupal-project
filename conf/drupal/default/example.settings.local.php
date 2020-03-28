<?php

// @codingStandardsIgnoreFile
// See https://git.drupalcode.org/project/drupal/blob/HEAD/sites/default/default.settings.php

$databases = [];
$databases['default']['default'] = [
  'username' => getenv('DRUPAL_SITE_DEFAULT_DB_USER'),
  'password' => getenv('DRUPAL_SITE_DEFAULT_DB_PASSWORD'),
  'database' => getenv('DRUPAL_SITE_DEFAULT_DB_DATABASE'),
  'prefix' => getenv('DRUPAL_SITE_DEFAULT_DB_PREFIX'),
  'host' => getenv('DRUPAL_SITE_DEFAULT_DB_HOST'),
  'port' => getenv('DRUPAL_SITE_DEFAULT_DB_PORT'),
  'driver' => getenv('DRUPAL_SITE_DEFAULT_DB_DRIVER'),
];

// Change this value.
$settings['hash_salt'] = getenv('DRUPAL_SITE_DEFAULT_HASH_SALT');

$settings['config_sync_directory'] = $app_root . '/../conf/drupal/' . getenv('DRUPAL_SITE_DEFAULT_FOLDER_NAME') . '/sync';

$settings['update_free_access'] = FALSE;
$settings['allow_authorize_operations'] = FALSE;

$settings['file_public_path'] = 'sites/' . getenv('DRUPAL_SITE_DEFAULT_FOLDER_NAME') . '/files';
$settings['file_private_path'] = $app_root . '/../private_files/' . getenv('DRUPAL_SITE_DEFAULT_FOLDER_NAME');

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
];

$environment_trusted_host_patterns = [
  'WEBSERVER_HOST',
  'VARNISH_HOST',
  'VARNISH_DOMAIN',
  'DRUPAL_SITE_DEFAULT_DOMAIN_1',
  'DRUPAL_SITE_DEFAULT_DOMAIN_2',
  'DRUPAL_SITE_DEFAULT_DOMAIN_3',
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
$settings['omit_vary_cookie'] = getenv('DRUPAL_SITE_DEFAULT_OMIT_VARY_COOKIE');

$config['system.performance']['cache']['page']['max_age'] = (int) getenv('DRUPAL_SITE_DEFAULT_CACHE_PAGE_MAX_AGE');
$config['system.performance']['css']['preprocess'] = TRUE;
$config['system.performance']['js']['preprocess'] = TRUE;

$settings['cache_prefix'] = getenv('DRUPAL_SITE_DEFAULT_CACHE_PREFIX');
$settings['cache']['default'] = getenv('DRUPAL_SITE_DEFAULT_CACHE_DEFAULT');

// Always set the fast backend for bootstrap, discover and config, otherwise
// this gets lost when redis is enabled.
// @see https://api.drupal.org/api/drupal/core%21core.api.php/group/cache/8.5.x
$settings['cache']['bins']['bootstrap'] = 'cache.backend.chainedfast';
$settings['cache']['bins']['discovery'] = 'cache.backend.chainedfast';
$settings['cache']['bins']['config'] = 'cache.backend.chainedfast';

// Redis.
$settings['redis.connection']['interface'] = getenv('DRUPAL_SITE_DEFAULT_REDIS_INTERFACE');
$settings['redis.connection']['host'] = getenv('DRUPAL_SITE_DEFAULT_REDIS_HOST');
$settings['redis.connection']['port'] = getenv('DRUPAL_SITE_DEFAULT_REDIS_PORT');
$settings['redis.connection']['base'] = getenv('DRUPAL_SITE_DEFAULT_REDIS_BASE');
$settings['redis_compress_length'] = getenv('DRUPAL_SITE_DEFAULT_REDIS_COMPRESS_LENGTH');
$settings['redis_compress_level'] = getenv('DRUPAL_SITE_DEFAULT_REDIS_COMPRESS_LEVEL');

$settings['container_yamls'][] = 'modules/contrib/redis/redis.services.yml';
$settings['container_yamls'][] = 'modules/contrib/redis/example.services.yml';

// Varnish.
$config['varnish_purger.settings.varnish']['hostname'] = getenv('VARNISH_HOST');

// Errors.
$config['system.logging']['error_level'] = 'hide';

// Services.
$settings['container_yamls'][] = $app_root . '/../conf/drupal/' . getenv('DRUPAL_SITE_DEFAULT_FOLDER_NAME') . '/services.yml';

// Development.
// See https://git.drupalcode.org/project/drupal/blob/HEAD/sites/example.settings.local.php
//assert_options(ASSERT_ACTIVE, TRUE);
//\Drupal\Component\Assertion\Handle::register();

//$settings['container_yamls'][] = $app_root . '/../conf/drupal/' . getenv('DRUPAL_SITE_DEFAULT_FOLDER_NAME') . '/development.services.yml';

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
