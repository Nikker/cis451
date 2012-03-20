<?php

function current_user_can_edit_profile($profile_owner_username) {
  global $db;

  if (strcasecmp($profile_owner_username, Beta::username()) == 0) return true;
 
  $result = $db->query(
    sprintf("SELECT COUNT(*) AS `exists` 
    FROM `user_role_rel`
    NATURAL JOIN `user`
    NATURAL JOIN `user_role`
    WHERE `user_id` = %d
      AND `role` = 'admin'
    LIMIT 1", Beta::username())
  ) or die($db->error);
  
  return $result->fetch_object()->exists;
}

?>
