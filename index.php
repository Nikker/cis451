<?php

ini_set('error_reporting',E_ALL);
error_reporting(E_ALL);

require('inc/includes.php');

// Routing rules - regular expressions should be written carefully as what they match will be removed from the url before being passed to the handler
// For example: Use a lookahead to ensure that a directory ends in a slash
$rules = array(
  '#^/?$#' => 'home.php',
  '#^/forum(?=/)#i' => 'forum/handler.php',
  '/.*/' => '404.php'
);

$uri = str_replace(BETA_ROOT_URL, '', $_SERVER['REDIRECT_URL']);
foreach ($rules as $regex=>$handler) {
  if (preg_match($regex, $uri)) {
    // Remove the matched part of the URI before passing it on..
    $uri = preg_replace($regex,'', $uri);
    break;
  }
}

Beta::run_handler($handler, $uri);

?>
