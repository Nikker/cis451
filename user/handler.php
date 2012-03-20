<?php

set_include_path(dirname(__FILE__) . PATH_SEPARATOR . get_include_path());
include 'functions.php';

$rules = array(
  '#^/$#' => 'list.php',
  '#^/(?<username>\w+)/?$#' => 'profile.php',
  '#^/(?<username>\w+)/edit/?$#i' => array('GET'=>'edit.php','POST'=>'edit_post.php'),
);

foreach ($rules as $regex=>$handler) {
  if (preg_match($regex, $uri, $matches)) {
    if (is_array($handler)) $handler = $handler[$_SERVER['REQUEST_METHOD']];
    Beta::run_handler($handler, $uri, $matches);
  }
}

Beta::run_handler('404.php');


?>
