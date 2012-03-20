<?php

$thread = $db->query(sprintf("SELECT `thread_id` as `id`,
  `title`,
  `forum_category`.`name` as `cat`,
  `forum`.`name` as `forum`
  FROM `forum_thread`
  JOIN `forum` USING (`forum_id`)
  JOIN `forum_category` USING (`cat_id`)
  WHERE `forum`.`slug` = '%s'
    AND `thread_id` = %d
  LIMIT 1;", $params['forum'], $params['thread'])
) or die($db->error);

if ($thread->num_rows == 0) {
  $tpl->title = "Thread doesn't exist";
  $tpl->message = "This thread doesn't exist.";
  $tpl->content = $tpl->fetch('error.tpl.php');
  $tpl->display();
  exit;
}

$tpl->thread = $thread->fetch_assoc();

$num_posts = $db->query(
  sprintf("SELECT COUNT(*) as `num` 
    FROM `forum_post`
    JOIN `forum_thread` USING(`thread_id`)
    JOIN `forum` USING (`forum_id`)
    WHERE `forum`.`slug` = '%s'
      AND `thread_id` = %d",$params['forum'], $params['thread'])
)->fetch_object()->num;

$tpl->page = array_key_exists('page', $_GET)? $_GET['page'] : 1;
$tpl->pages = ceil($num_posts/Beta::posts_per_page);
$start = ($tpl->page - 1) * Beta::posts_per_page;

$posts = $db->query(
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
) or die($db->error);

$tpl->thread['posts'] = array();
while ($post = $posts->fetch_assoc()) {
  $tpl->thread['posts'][] = $post;
}

/*
$tpl->thread = array(
  'forum' => array (
    'slug' => $params['forum'],
    'name' => $params['forum'],
    'cat' => 'Chat'
   ),
  'id' => $params['thread'],
  'title' => 'Hey this is a thread!',
  'author' => 'NewbieFace',
  'posts' => array(
    array(
      'content' => "I posted a thread, I think that makes me awesome.  Although, this thread was never actually posted; it's just hard-coded.",
      'author' => 'NewbieFace',
      'time' => date("M jS, Y, g:i a",1342134131)
    ),
    array (
      'content' => "Hello, good sir.  I am replying on your thread!",
      'author' => "Gentleman",
      'time' => date("M jS, Y, g:i a",1342135131)
    )
  )
);
*/

$tpl->title = $tpl->thread['title'] . " | Thread";
$tpl->content = $tpl->fetch('forum/thread.tpl.php');

$tpl->display();

?>
