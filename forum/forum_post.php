<?php

// Validate the posted data
if (empty($_POST['title']) or empty($_POST['content'])) {
  $tpl->form_error = "Both a title and body are required for new threads.";
  include('forum.php');
  exit;
}

// Put it in the database
$db->autocommit(false);
$thread = $db->prepare("INSERT INTO `forum_thread` 
  (`forum_id`,`user_id`,`title`)
  VALUES ((SELECT `forum_id` FROM `forum` WHERE `slug` = ? LIMIT 1),?,?);");

$post = $db->prepare("INSERT INTO `forum_post` 
  (`thread_id`,`user_id`,`content`) 
  VALUES (LAST_INSERT_ID(),?,?);");

if ($thread and $post) {
  $thread->bind_param('sis',$raw_params['forum'], Beta::user_id(), $_POST['title']);
  $post->bind_param('is',Beta::user_id(), $_POST['content']);
  if ($thread->execute()) {
    $id = $db->insert_id;
    if ($post->execute()) {
      $db->commit();
      header("Location: ./{$id}/");
    }
  }
}

$db->rollback();
$tpl->form_error = "There was a problem inserting your post into the database.";
include('forum.php');

?>
