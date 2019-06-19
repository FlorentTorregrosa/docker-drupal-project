<?php

$databases['default']['default'] = [
  'driver' => 'mysql',
  'database' => 'drupal',
  'username' => 'drupal',
  'password' => 'drupal',
  'host' => 'mysql',
  'prefix' => '',
];

$settings['hash_salt'] = 'template';
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
    $settings['trusted_host_patterns'][] = getenv($environment_trusted_host_pattern);
  }
}

$settings['file_private_path'] = $app_root . '/../private_files/default';

// Translations.
$config['locale.settings']['translation']['path'] = 'translations/contrib';
$config['locale.settings']['translation']['use_source'] = 'local';

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

if (file_exists($app_root . '/' . $site_path . '/../development.settings.php')) {
  include $app_root . '/' . $site_path . '/../development.settings.php';
}
