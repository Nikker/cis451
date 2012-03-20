<?php

set_include_path(dirname(__FILE__) . PATH_SEPARATOR . get_include_path());

$tpl->stylesheets[] = 'forum.css';

$rules = array(
  '#^/?$#' => 'list.php',
  '#^/(?<forum>\w+)/(?:(?<action>post)/?)?$#' => array('GET' => 'forum.php', 'POST' => 'forum_post.php'),
  '#^/(?<forum>\w+)/(?<thread>\d+)/?$#' => array('GET' => 'thread.php', 'POST' => 'thread_post.php')
);

foreach ($rules as $regex=>$handler) {
  if (preg_match($regex, $uri, $matches)) {
    if (is_array($handler)) $handler = $handler[$_SERVER['REQUEST_METHOD']];
    Beta::run_handler($handler, $uri, $matches);
  }
}

Beta::run_handler('404.php');

?>
