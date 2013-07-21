<?php


$count = Beta::query("SELECT COUNT(*) as `count` FROM `user`;")->fetch_object()->count;

$page = array_key_exists('page', $_GET)? $_GET['page'] : 1;
$per_page = 20;
$start = ($page - 1) * $per_page;
$pages = ceil($count/$per_page);

$users = Beta::query(
  sprintf("SELECT * FROM `user` LIMIT %d,%d",$start,$per_page)
);

$user_list = array();
while ($user = $users->fetch_object()) {
  $user_list[] = $user;
}

Beta::display(
	'user/list.tpl.php',
	'User list' . ($page > 1? " - page {$page}" : ""),
	array(
		'page' => $page,
		'pages' => $pages,
		'users' => $user_list
	)
);

?>
