<?php

$tpl->stylesheets[] = 'user-profile.css';

$user = $db->query(
  sprintf("SELECT *,
      (SELECT COUNT(*) FROM `forum_post` WHERE `user_id` = `user`.`user_id`) as `forum_posts`
    FROM `user`
    LEFT JOIN `user_profile` USING (`user_id`)
    WHERE `username` LIKE '%s'", $params['username'])
) or die($db->error);

if ($user->num_rows == 0) {
  Beta::error_page("User not found","There is no user by this username.");
}

$tpl->user = $user->fetch_object();
$tpl->user->characters = array();

$chars = $db->query(
  sprintf("SELECT `character`.*,
      `char_species`.`slug` as `species`,
      `char_color`.`slug` as `color`
    FROM `character`
    JOIN `user` USING (`user_id`)
    JOIN `char_species` USING (`species_id`)
    JOIN `char_color` USING (`color_id`)
    WHERE `username` = '%s'", $params['username'])
) or die($db->error);

while ($char = $chars->fetch_object()) {
  $tpl->user->characters[] = $char;
}

$tpl->user->roles = array();

$roles = $db->query(
  sprintf("SELECT `role`
    FROM `user_role_rel`
    NATURAL JOIN `user`
    NATURAL JOIN `user_role`
    WHERE `username` = '%s'", $params['username'])
) or die($db->error);

while ($role = $roles->fetch_object()) {
  $tpl->user->roles[] = $role->role;
}

$tpl->title = sprintf("%s's Profile",$tpl->user->username);
$tpl->content = $tpl->fetch('user/profile.tpl.php');
$tpl->display();

?>
