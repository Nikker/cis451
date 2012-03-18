<?php

ini_set('error_reporting',E_ALL);
error_reporting(E_ALL);

require('inc/includes.php');

$request = array_key_exists('REDIRECT_URL', $_SERVER)? $_SERVER['REDIRECT_URL'] : '/';
$uri = str_replace(BETA_ROOT_URL, '', $request);

// Route directories to their handlers
// Given a URI request such as "/forum/...", a handler "forum/handler.php" 
// will be automatically attempted if 'forum' is not a key in the following array
$dirs = array(
  '' => 'home.php'
);

// Get the directory from the URI
preg_match('#^/(?<dir>[^/]*)(?<subpath>.*)$#', $uri, $match);

if (array_key_exists($match['dir'], $dirs)) {
  Beta::run_handler($dirs[$match['dir']], $match['subpath']);
} else {
  Beta::run_handler("{$match['dir']}/handler.php", $match['subpath']);
}

?>
