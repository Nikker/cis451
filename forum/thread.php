<?php

$tpl->thread = array(
  'forum' => array (
    'slug' => $params['forum'],
    'name' => $params['forum'],
    'cat' => 'Chat'
   ),
  'id' => $params['thread'],
  'title' => 'Hey this is a thread!',
  'author' => 'NewbieFace',
  'posts' => array(
    array(
      'content' => "I posted a thread, I think that makes me awesome.  Although, this thread was never actually posted; it's just hard-coded.",
      'author' => 'NewbieFace',
      'time' => date("M jS, Y, g:i a",1342134131)
    ),
    array (
      'content' => "Hello, good sir.  I am replying on your thread!",
      'author' => "Gentleman",
      'time' => date("M jS, Y, g:i a",1342135131)
    )
  )
);

$tpl->title = $tpl->thread['title'] . " | Thread";
$tpl->content = $tpl->fetch('forum/thread.tpl.php');

$tpl->display();

?>
