<?php

$forum = Beta::query(
  sprintf("SELECT `forum_category`.`name` as `cat`, 
    `slug`, 
    `forum`.`name` as `name`,
    `description`
  FROM `forum`
  JOIN `forum_category` USING (`cat_id`)
  WHERE `slug` = '%s'", $params['forum'])
) or die("Can't query forum");

if ($forum->num_rows == 0) {
	Beta::error_page("Forum doesn't exist", "This forum doesn't exist");
  exit;
}

$forum = $forum->fetch_assoc();

$num_threads = Beta::query(
  sprintf("SELECT COUNT(*) as `num` 
    FROM `forum_thread` 
    JOIN `forum` USING (`forum_id`)
    WHERE `forum`.`slug` = '%s'",$params['forum'])
)->fetch_object()->num;

$page = array_key_exists('page', $_GET)? $_GET['page'] : 1;
$pages = ceil($num_threads/Beta::threads_per_page);

$start = ($page - 1) * Beta::threads_per_page;

$threads = Beta::query(
  sprintf("SELECT `thread_id` as `id`, `title`, `username` as `author` 
    FROM `forum_thread` 
    JOIN `forum` USING(`forum_id`)
    JOIN `user` USING(`user_id`)
    WHERE `forum`.`slug` = '%s'
    LIMIT %d,%d", $params['forum'], $start, Beta::threads_per_page)
);

$forum['threads'] = array();
while ($thread = $threads->fetch_assoc()) {
  $forum['threads'][] = $thread;
}


Beta::display(
	'forum/forum.tpl.php',
	$forum['name'] . " | Forum",
	array(
		'page' => $page,
		'pages' => $pages,
		'forum' => $forum
	)
);

?>
