<?php

$tpl->forum = array(
  'cat' => 'Chat',
  'slug' => $params['forum'],
  'name' => $params['forum'],
  'desc' => "Description for whatever forum this is.",
  'threads' => array(
    array(
      'id' => 2,
      'title' => 'Hey I made a thread',
      'author' => 'Newbieface'
    ),
    array(
      'id' => 1,
      'title' => 'First thread!',
      'author' => 'Administrator'
    ),
  )
);

$tpl->page = @$_GET['page']? @$_GET['page'] : 1;
$tpl->pages = 1;

$tpl->title = $tpl->forum['name'] . " | Forum";
$tpl->content = $tpl->fetch('forum/forum.tpl.php');
$tpl->display();

?>
