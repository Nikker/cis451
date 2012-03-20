<?php

$char = $db->query(
  sprintf("SELECT `character`.*, 
      `char_desc`.*,
      `username` as `owner`,
      `char_species`.`slug` as `species_slug`,
      `char_species`.`name` as `species_name`,
      `char_color`.`slug` as `color_slug`,
      `char_color`.`name` as `color_name`
    FROM `character`
    NATURAL LEFT JOIN `char_desc`
    JOIN `user` USING (`user_id`)
    JOIN `char_species` USING (`species_id`)
    JOIN `char_color` USING (`color_id`)
    WHERE `character`.`name` = '%s'", $params['char'])
) or die($db->error);

if ($char->num_rows == 0) {
  Beta::error_page("Character not found","There is no character by this name.");
}

$tpl->character = $char->fetch_object();

$tpl->title = sprintf("Character Profile: %s", $tpl->character->name);
$tpl->content = $tpl->fetch('char/profile.tpl.php');
$tpl->display();

?>
