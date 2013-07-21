<?php

// If trying to edit another user's profile, check if the user has administrator privileges

if (!current_user_can_edit_character($raw_params['char'])) {
  Beta::error_page("Permission denied","You don't have permission to edit other users characters",403);
}

$char = Beta::query(
  sprintf("SELECT * 
    FROM `character` 
    NATURAL LEFT JOIN `char_desc`
    WHERE `name` LIKE '%s'", $params['char'])
) or die("Can't get character");

if ($char->num_rows == 0) {
  Beta::error_page("Character doesn't exist","This character doesn't exist.");
}

Beta::display(
	'char/edit.tpl.php', 
	sprintf("Editing %s's description", $tpl->character->name), 
	array(
		'character' => $char->fetch_object()
	)
);

?>
