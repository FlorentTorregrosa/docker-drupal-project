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

if (file_exists(__DIR__ . '/../development.settings.php')) {
  include __DIR__ . '/../development.settings.php';
}
