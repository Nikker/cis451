<?php

// Validate the posted data
if (empty($_POST['content'])) {
  $tpl->form_error = "You can't post a reply without content!";
  include('thread.php');
  exit;
}

// Put it in the database
$post = $db->prepare("INSERT INTO `forum_post` 
  (`thread_id`,`user_id`,`content`) 
  VALUES (?,?,?);");

if ($post) {
  $post->bind_param('iis',$raw_params['thread'], Beta::user_id(), $_POST['content']);
  if ($post->execute()) {
    header("Location: ./#post{$db->insert_id}");
  }
}

$tpl->form_error = "There was a problem inserting your post into the database.";
include('forum.php');

?>
