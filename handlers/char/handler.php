<?php

set_include_path(dirname(__FILE__) . PATH_SEPARATOR . get_include_path());
include 'functions.php';

$rules = array(
  '#^/$#' => array('GET'=>'create.php','POST'=>'create_post.php'),
  '#^/(?<char>\w+)/?$#' => 'profile.php',
  '#^/(?<char>\w+)/edit/?$#i' => array('GET'=>'edit.php','POST'=>'edit_post.php'),
  '#^/(?<char>\w+)/page/?$#i' => 'page.php',
  '#^/(?<char>\w+)/page/edit/?$#i' => array('GET'=>'page-edit.php','POST'=>'page-edit_post.php'),
);

foreach ($rules as $regex=>$handler) {
  if (preg_match($regex, $uri, $matches)) {
    if (is_array($handler)) $handler = $handler[$_SERVER['REQUEST_METHOD']];
    Beta::run_handler('char',$handler, $uri, $matches);
  }
}

Beta::not_found();


?>
