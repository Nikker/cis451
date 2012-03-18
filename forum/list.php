<?php

// Get a list of all forum categories display that shit
$tpl->categories = array(
  array( 
    "title" => "Administration",
    "forums" => array (
      array(
        "title" => "Announcements",
        "slug" => "announcements",
        "desc" => "Administrator announcements."
      ),
    )
  ),
  array( 
    "title" => "Chat",
    "forums" => array (
      array(
        "title" => "General",
        "slug" => "general",
        "desc" => "Chat about things that don't fit in other categories."
      ),
      array(
        "title" => "Adults Only",
        "slug" => "adult",
        "desc" => "Chat about things that children can't see."
      )
    )
  ),
);
$tpl->title = "Forums";
$tpl->content = $tpl->fetch('forum/index.tpl.php');
$tpl->display();

?>
