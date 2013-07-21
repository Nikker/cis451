<?php

if (!current_user_can_edit_profile($raw_params['username'])) include('edit.php');

// Nothing else needs to be validated, an empty profile is fine

$stmnt = Beta::db()->prepare("REPLACE INTO `user_profile` 
  SET `user_id` = (SELECT `user_id` FROM `user` WHERE `username` = ?),
    `content` = ?");

if ($stmnt) {
  $stmnt->bind_param('ss',$raw_params['username'], $_POST['content']);
  if ($stmnt->execute()) {
    header('location: ../');
  }
}

Beta::tpl()->form_error = 'There was a problem inserting into the database.';
include('edit.php');

?>
