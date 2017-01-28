<?php

$databases['default']['default'] = array(
  'driver' => 'mysql',
  'database' => 'drupal',
  'username' => 'drupal',
  'password' => 'drupal',
  'host' => 'mysql',
  'prefix' => '',
);

$settings['install_profile'] = 'standard';
$settings['hash_salt'] = 'template';
$settings['trusted_host_patterns'] = array(
  '^127\.0\.0\.1$',
);

// Piwik.
$config['piwik.settings']['url_http'] = 'http://127.0.0.1:8083/';

if (file_exists(__DIR__ . '/../development.settings.php')) {
  include __DIR__ . '/../development.settings.php';
}
