<?php

$databases = array();

$conf['omit_vary_cookie'] = TRUE;

$update_free_access = FALSE;
$conf['allow_authorize_operations'] = FALSE;

$conf['file_public_path'] = 'sites/default/files';

ini_set('session.gc_probability', 1);
ini_set('session.gc_divisor', 100);
ini_set('session.gc_maxlifetime', 200000);
ini_set('session.cookie_lifetime', 2000000);

$conf['404_fast_paths_exclude'] = '/\/(?:styles)|(?:system\/files)\//';
$conf['404_fast_paths'] = '/\.(?:txt|png|gif|jpe?g|css|js|ico|swf|flv|cgi|bat|pl|dll|exe|asp)$/i';
$conf['404_fast_html'] = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML+RDFa 1.0//EN" "http://www.w3.org/MarkUp/DTD/xhtml-rdfa-1.dtd"><html xmlns="http://www.w3.org/1999/xhtml"><head><title>404 Not Found</title></head><body><h1>Not Found</h1><p>The requested URL "@path" was not found on this server.</p></body></html>';
# drupal_fast_404();

// Errors.
$conf['error_level'] = 0;

// Performance.
$conf['cache'] = 1;
$conf['block_cache'] = 1;
$conf['cache_lifetime'] = 0;
$conf['page_cache_maximum_age'] = 300;
$conf['page_compression'] = 1;
$conf['preprocess_css'] = 1;
$conf['preprocess_js'] = 1;

// Theme.
$conf['theme_debug'] = FALSE;
$conf['allow_css_double_underscores'] = TRUE;

// External cache.
if (file_exists(__DIR__ . '/.cache_activated')) {
  $conf['redis_client_interface'] = 'PhpRedis';
  $conf['lock_inc'] = 'sites/all/modules/redis/redis.lock.inc';
  $conf['path_inc'] = 'sites/all/modules/redis/redis.path.inc';
  $conf['cache_backends'][] = 'sites/all/modules/redis/redis.autoload.inc';
  $conf['cache_default_class'] = 'Redis_Cache';
}

if (file_exists(__DIR__ . '/settings.local.php')) {
  include __DIR__ . '/settings.local.php';
}
