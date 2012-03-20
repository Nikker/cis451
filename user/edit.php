<?php

// If trying to edit another user's profile, check if the user has administrator privileges

if (!current_user_can_edit_profile($raw_params['username'])) {
  Beta::error_page("Permission denied","You don't have permission to edit other users profiles",403);
}

$user = $db->query(
  sprintf("SELECT * 
    FROM `user` 
    NATURAL LEFT JOIN `user_profile`
    WHERE `username` LIKE '%s'", $params['username'])
) or die($db->error);

if ($user->num_rows == 0) {
  Beta::error_page("User doesn't exist","This user doesn't exist.");
}

$tpl->user = $user->fetch_object();
$tpl->title = sprintf("Editing %s's profile", $tpl->user->username);
$tpl->content = $tpl->fetch('user/edit.tpl.php');
$tpl->display();

?>
