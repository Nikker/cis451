<?php

$forum = $db->query(
  sprintf("SELECT `forum_category`.`name` as `cat`, 
    `slug`, 
    `forum`.`name` as `name`,
    `description`
  FROM `forum`
  JOIN `forum_category` USING (`cat_id`)
  WHERE `slug` = '%s'", $params['forum'])
) or die ($db->error);

if ($forum->num_rows == 0) {
  $tpl->title = "Forum doesn't exist";
  $tpl->message = "This forum doesn't exist";
  $tpl->content = $tpl->fetch('error.tpl.php');
  $tpl->display();
  exit;
}

$tpl->forum = $forum->fetch_assoc();

$num_threads = $db->query(
  sprintf("SELECT COUNT(*) as `num` 
    FROM `forum_thread` 
    JOIN `forum` USING (`forum_id`)
    WHERE `forum`.`slug` = '%s'",$params['forum'])
)->fetch_object()->num;

$tpl->page = array_key_exists('page', $_GET)? $_GET['page'] : 1;
$tpl->pages = ceil($num_threads/Beta::threads_per_page);

$start = ($tpl->page - 1) * Beta::threads_per_page;

$threads = $db->query(
  sprintf("SELECT `thread_id` as `id`, `title`, `username` as `author` 
    FROM `forum_thread` 
    JOIN `forum` USING(`forum_id`)
    JOIN `user` USING(`user_id`)
    WHERE `forum`.`slug` = '%s'
    LIMIT %d,%d", $params['forum'], $start, Beta::threads_per_page)
) or die($db->error);

$tpl->forum['threads'] = array();
while ($thread = $threads->fetch_assoc()) {
  $tpl->forum['threads'][] = $thread;
}

$tpl->title = $tpl->forum['name'] . " | Forum";
$tpl->content = $tpl->fetch('forum/forum.tpl.php');
$tpl->display();

?>
