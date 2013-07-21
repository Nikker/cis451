<?php

// Get a list of all forum categories and their threads
$cats = Beta::query("SELECT `cat_id` as `id`,`name` 
  FROM `forum_category` 
  ORDER BY `order`,`name` ASC;"
) or die ("Can't load forums");

$categories = array();

while ($cat = $cats->fetch_assoc()) {
  $cat['forums'] = array();
  $forums = Beta::query(
    sprintf("SELECT `name`,`slug`,`description` 
      FROM `forum` 
      WHERE `cat_id` = %d 
      ORDER BY `order`,`name` ASC;", $cat['id']
    )) or print "Can't load forum";
  while ($forum = $forums->fetch_assoc()) {
    $cat['forums'][] = $forum;
  }
  $forums->close();

  if (!empty($cat['forums'])) $categories[] = $cat;
}
$cats->close();

Beta::display("forum/index.tpl.php", "Forums", array("test" => "testing", "categories" => $categories));

?>
