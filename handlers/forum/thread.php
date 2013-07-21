<?php

$thread = Beta::query(sprintf("SELECT `thread_id` as `id`,
  `title`,
  `forum_category`.`name` as `cat`,
  `forum`.`name` as `forum`
  FROM `forum_thread`
  JOIN `forum` USING (`forum_id`)
  JOIN `forum_category` USING (`cat_id`)
  WHERE `forum`.`slug` = '%s'
    AND `thread_id` = %d
  LIMIT 1;", $params['forum'], $params['thread'])
);

if ($thread->num_rows == 0) {
	Beta::display_error("Thread doesn't exist", "This thread doesn't exist.");
  exit;
}

$thread = $thread->fetch_assoc();

$num_posts = Beta::query(
  sprintf("SELECT COUNT(*) as `num` 
    FROM `forum_post`
    JOIN `forum_thread` USING(`thread_id`)
    JOIN `forum` USING (`forum_id`)
    WHERE `forum`.`slug` = '%s'
      AND `thread_id` = %d",$params['forum'], $params['thread'])
)->fetch_object()->num;

$page = array_key_exists('page', $_GET)? $_GET['page'] : 1;
$pages = ceil($num_posts/Beta::posts_per_page);
$start = ($page - 1) * Beta::posts_per_page;

$posts = Beta::query(
  sprintf("SELECT `post_id` as `id`,`content`,`username` as `author`, `time` 
    FROM `forum_post`
    JOIN `user` USING (`user_id`)
    JOIN `forum_thread` USING (`thread_id`)
    JOIN `forum` USING (`forum_id`)
    WHERE `forum`.`slug` = '%s'
      AND `thread_id` = %d
    ORDER BY `time` ASC
    LIMIT %d, %d
  ", $params['forum'], $params['thread'], $start, Beta::posts_per_page)
);

$thread['posts'] = array();
while ($post = $posts->fetch_assoc()) {
  $thread['posts'][] = $post;
}

Beta::display(
	'forum/thread.tpl.php',
	$thread['title'] . " | Thread",
	array(
		'thread' => $thread,
		'page' => $page,
		'pages' => $pages
	)
);

?>
