<?php


$count = $db->query("SELECT COUNT(*) as `count` FROM `user`;")->fetch_object()->count;

$tpl->page = array_key_exists('page', $_GET)? $_GET['page'] : 1;
$per_page = 20;
$start = ($tpl->page - 1) * $per_page;
$tpl->pages = ceil($count/$per_page);

$users = $db->query(
  sprintf("SELECT * FROM `user` LIMIT %d,%d",$start,$per_page)
) or die($db->error);

$tpl->users = array();
while ($user = $users->fetch_object()) {
  $tpl->users[] = $user;
}

$tpl->title = "User list";
if ($tpl->page > 1) $tpl->title .= "- page {$tpl->page}";
$tpl->content = $tpl->fetch('user/list.tpl.php');
$tpl->display();

?>
