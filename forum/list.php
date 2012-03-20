<?php

// Get a list of all forum categories and their threads
$tpl->categories = array();

$cats = $db->query("SELECT `cat_id` as `id`,`name` 
  FROM `forum_category` 
  ORDER BY `order`,`name` ASC;"
) or die($db->error);

while ($cat = $cats->fetch_assoc()) {
  $cat['forums'] = array();
  $forums = $db->query(
    sprintf("SELECT `name`,`slug`,`description` 
      FROM `forum` 
      WHERE `cat_id` = %d 
      ORDER BY `order`,`name` ASC;", $cat['id']
    )) or die($db->error);
  while ($forum = $forums->fetch_assoc()) {
    $cat['forums'][] = $forum;
  }
  $forums->close();

  if (!empty($cat['forums'])) $tpl->categories[] = $cat;
}
$cats->close();

$tpl->title = "Forums";
$tpl->content = $tpl->fetch('forum/index.tpl.php');
$tpl->display();

?>
