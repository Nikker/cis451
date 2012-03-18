<?php 

class Beta {

  // Include the specified handler else a 404 else display a basic 404
  public static function run_handler($h, $uri = '', $params = array()) {
    global $tpl;
    if (!include_once($h)) {
      if (!include_once('404.php')) {
        header("HTTP/1.0 404 Not Found");
        die("404 - Page not found");
      }
    }
  }

}

?>
