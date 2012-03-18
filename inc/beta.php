<?php 

class Beta {

  // Include the specified handler, else display a basic 404
  public static function run_handler($h, $uri) {
    global $tpl;
    if (!@include_once($h)) {
        header("HTTP/1.0 404 Not Found");
        die("404 - Page not found");
    }
  }

}

?>
