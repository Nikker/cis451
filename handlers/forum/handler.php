<?php

Beta::add_stylesheet('forum.css');

$rules = array(
  '#^/?$#' => 'list.php',
  '#^/(?<forum>\w+)/(?:(?<action>post)/?)?$#' => array('GET' => 'forum.php', 'POST' => 'forum_post.php'),
  '#^/(?<forum>\w+)/(?<thread>\d+)/?$#' => array('GET' => 'thread.php', 'POST' => 'thread_post.php')
);

foreach ($rules as $regex=>$handler) {
  if (preg_match($regex, $uri, $matches)) {
    if (is_array($handler)) $handler = $handler[$_SERVER['REQUEST_METHOD']];
    Beta::run_handler('forum', $handler, $uri, $matches);
  }
}

Beta::not_found();

?>
