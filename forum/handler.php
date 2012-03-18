<?php

$rules = array(
  '#^/?$#' => 'forum/list.php',
  '#^/(?<forum>\w+)/(?:(?<action>post)/?)?$#' => 'forum/forum.php',
  '#^/(?<forum>\w+)/(?<thread>\d+)/?$#' => 'forum/thread.php',
  '/.*/' => '404.php'
);

foreach ($rules as $regex=>$handler) {
  if (preg_match($regex, $uri, $matches)) {
    break;
  }
}

Beta::run_handler($handler, $uri, $matches);

?>
