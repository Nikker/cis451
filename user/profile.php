<?php

Beta::tpl()->stylesheets[] = 'user-profile.css';

$user = Beta::query(
  sprintf("SELECT *,
      (SELECT COUNT(*) FROM `forum_post` WHERE `user_id` = `user`.`user_id`) as `forum_posts`
    FROM `user`
    LEFT JOIN `user_profile` USING (`user_id`)
    WHERE `username` LIKE '%s'", $params['username'])
);

if ($user->num_rows == 0) {
  Beta::error_page("User not found","There is no user by this username.");
}

$user = $user->fetch_object();
$user->characters = array();

$chars = Beta::query(
  sprintf("SELECT `character`.*,
      `char_species`.`slug` as `species`,
      `char_color`.`slug` as `color`
    FROM `character`
    JOIN `user` USING (`user_id`)
    JOIN `char_species` USING (`species_id`)
    JOIN `char_color` USING (`color_id`)
    WHERE `username` = '%s'", $params['username'])
);

while ($char = $chars->fetch_object()) {
  $user->characters[] = $char;
}

$user->roles = array();

$roles = Beta::query(
  sprintf("SELECT `role`
    FROM `user_role_rel`
    NATURAL JOIN `user`
    NATURAL JOIN `user_role`
    WHERE `username` = '%s'", $params['username'])
);

while ($role = $roles->fetch_object()) {
  $user->roles[] = $role->role;
}

Beta::display(
	'user/profile.tpl.php',
	sprintf("%s's Profile", $user->username),
	array(
		'user' => $user
	)
);

?>
