<?php

// If trying to edit another user's profile, check if the user has administrator privileges

if (!current_user_can_edit_profile($raw_params['username'])) {
  Beta::error_page("Permission denied","You don't have permission to edit other users profiles",403);
}

$user = Beta::query(
  sprintf("SELECT * 
    FROM `user` 
    NATURAL LEFT JOIN `user_profile`
    WHERE `username` LIKE '%s'", $params['username'])
);

if ($user->num_rows == 0) {
  Beta::error_page("User doesn't exist","This user doesn't exist.");
}

Beta::display(
	'user/edit.tpl.php',
	sprintf("Editing %s's profile", $tpl->user->username),
	array(
		'user' => $user->fetch_object()
	)
);

?>
