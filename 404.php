<?php
header("HTTP/1.0 404 Not Found");
$tpl->title = "Page not found";
$tpl->content = $tpl->fetch('errors/404.tpl.php');
$tpl->display();
?>
