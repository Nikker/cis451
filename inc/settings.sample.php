<?php

// Server-specific settings are here.  
// Implementation specific settings can be found in the Beta class in beta.php


define('BETA_HOST', 'example.com');

// Also set this in the .htaccess rewrite base
define('BETA_ROOT_URL', '/project/path');

define('BETA_ROOT_PATH', '/home/me/public_html');

// This should be somewhere that apache can not serve it.
define('BETA_DBCONF', '/home/me/db.ini');

define('BETA_TEMPLATE_DIR', BETA_ROOT_PATH . '/views');

?>
