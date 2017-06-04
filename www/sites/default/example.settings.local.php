<?php

$databases['default']['default'] = array(
  'driver' => 'mysql',
  'database' => 'drupal',
  'username' => 'drupal',
  'password' => 'drupal',
  'host' => 'mysql',
  'charset' => 'utf8mb4',
  'collation' => 'utf8mb4_general_ci',
);
$drupal_hash_salt = 'template';
//$base_url = 'http://127.0.0.1';
//$cookie_domain = '.example.com';

$conf['file_private_path'] = '/project/private_files/default';

// Translations.
$conf['l10n_update_check_mode'] = 2;
$conf['l10n_update_download_store'] = 'sites/all/translations/contrib';

// Redis.
$conf['redis_client_host'] = 'redis';

if (file_exists(__DIR__ . '/../development.settings.php')) {
  include __DIR__ . '/../development.settings.php';
}
