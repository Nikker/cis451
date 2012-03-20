<?php


$count = $db->query("SELECT COUNT(*) as `count` FROM `user`;")->fetch_object()->count;

$tpl->page = array_key_exists('page', $_GET)? $_GET['page'] : 1;
$per_page = 50;
$start = ($tpl->page - 1) * $per_page;
$tpl->pages = ceil($count/$per_page);

$users = $db->query(
  sprintf("SELECT * FROM `user` LIMIT %d,%d",$start,$per_page)
) or die($db->error);

$tpl->users = array();
while ($user = $users->fetch_object()) {
  $tpl->users[] = $user;
}

$tpl->title = sprintf("User list page %d",$tpl->page);
$tpl->content = $tpl->fetch('user/list.tpl.php');
$tpl->display();

?>
