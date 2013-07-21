<?php

if (!current_user_can_edit_character($raw_params['char'])) include('edit.php');

// Nothing else needs to be validated, an empty profile is fine

$stmnt = Beta::db()->prepare("REPLACE INTO `char_desc` 
  SET `char_id` = (SELECT `char_id` FROM `character` WHERE `name` = ?),
    `content` = ?");

if ($stmnt) {
  $stmnt->bind_param('ss',$raw_params['char'], $_POST['content']);
  if ($stmnt->execute()) {
    header('location: ../');
  }
}

Beta::tpl()->form_error = 'There was a problem inserting into the database.';
include('edit.php');

?>
