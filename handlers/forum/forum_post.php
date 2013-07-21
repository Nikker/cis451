<?php

// Validate the posted data
if (empty($_POST['title']) or empty($_POST['content'])) {
	Beta::tpl()->form_error = "Both a title and body are required for new threads.";
  include('forum.php');
  exit;
}

// Put it in the database
Beta::db()->autocommit(false);
$thread = Beta::db()->prepare("INSERT INTO `forum_thread` 
  (`forum_id`,`user_id`,`title`)
  VALUES ((SELECT `forum_id` FROM `forum` WHERE `slug` = ? LIMIT 1),?,?);");

$post = Beta::db()->prepare("INSERT INTO `forum_post` 
  (`thread_id`,`user_id`,`content`) 
  VALUES (LAST_INSERT_ID(),?,?);");

if ($thread and $post) {
  $thread->bind_param('sis',$raw_params['forum'], Beta::user_id(), $_POST['title']);
  $post->bind_param('is',Beta::user_id(), $_POST['content']);
  if ($thread->execute()) {
    $id = Beta::db()->insert_id;
    if ($post->execute()) {
     	Beta::db()->commit();
      header("Location: ./{$id}/");
    }
  }
}

Beta::db()->rollback();
Beta::tpl()->form_error = "There was a problem inserting your post into the database.";
include('forum.php');

?>
