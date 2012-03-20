<?php 

class Beta {
  const threads_per_page = 20;
  const posts_per_page = 15;

  // Gets the user id of the currently logged in user
  // (right now we're hard coding that to the guest account)
  public static function user_id() {
    global $db;
    return $db->query("SELECT `user_id` FROM `user` WHERE `username` = 'Guest' LIMIT 1;")->fetch_object()->user_id;
  }

  public static function username() {
    return 'Guest';
  }

  public static function user_info() {
    global $db;
    return $db->query(sprintf("SELECT * FROM `user` WHERE `user_id` = %s;",self::user_id()))->fetch_object();
  }

  // Include the specified handler else a 404 else display a basic 404
  public static function run_handler($h, $uri = '', $raw_params = array()) {
    global $tpl, $db;
    $params = array_map(array($db,'real_escape_string'),$raw_params);
    if (!include_once($h)) {
      if (!include_once('404.php')) {
        header("HTTP/1.0 404 Not Found");
        echo "404 - Page not found";
      }
    }
    exit;
  }

  public static function error_page($title, $message, $status_code = 404) {
    global $tpl;
    switch ($status_code) {
      case 200: header('HTTP/1.1 200 OK'); break;
      case 404: header("HTTP/1.0 404 Not Found"); break;
      case 403: header('HTTP/1.1 403 Forbidden'); break;
      case 500: header('HTTP/1.1 500 Internal Server Error'); break;
    }
    $tpl->title = $title;
    $tpl->message = $message;
    $tpl->content = $tpl->fetch('error.tpl.php');
    $tpl->display();
    exit;
  }

}

?>
