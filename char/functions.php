<?php

function current_user_can_edit_character($char_name) {
  global $db;
  $has_permission = Beta::query(
    sprintf("SELECT COUNT(*) AS `count` 
    FROM `user`a
    LEFT JOIN `character` USING (`user_id`)
    NATURAL JOIN `user_role_rel`
    NATURAL JOIN `user_role`
    WHERE `user_id` = %d
      AND (
        `role` = 'admin' OR `character`.`name` = '%s'
      ) LIMIT 1", Beta::user_id(), $char_name)
  ) or die("Can't find user permissions");
  return $has_permission->fetch_object()->count;
}

?>
