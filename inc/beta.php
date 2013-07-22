<?php 

// Singleton object for site settings and access to database and templating
class Beta {
  const threads_per_page = 20;
  const posts_per_page = 15;
	const layout_template = "layout.tpl.php";

	private static $instance = null;
	private $db;
	private $tpl;

	private function  __construct() {
		$db_cnf = @parse_ini_file(BETA_DBCONF);

		$db = new mysqli(
			$db_cnf['host'], 
			$db_cnf['username'], 
			$db_cnf['password'], 
			$db_cnf['database'], 
			$db_cnf['port']
		) or die('Could not connect to database');

		require_once(BETA_ROOT_PATH . '/lib/savant/Savant3.php');

		$tpl = new Savant3(array(
			'template_path' => array(BETA_TEMPLATE_DIR),
			'template' => self::layout_template)
		);

		$this->db = $db;
		$this->tpl = $tpl;
	}

	private function _db() {
		return $this->db;
	}

	private function _tpl() {
		return $this->tpl;
	}

	public static function init() {
		if (is_null(self::$instance)) {
			self::$instance = new Beta();
		}
	}

	public static function db() {
		return self::$instance->_db();
	}

	public static function tpl() {
		return self::$instance->_tpl();
	}

  // Gets the user id of the currently logged in user
  // (right now we're hard coding that to the guest account)
  public static function user_id() {
    return self::db()->query("SELECT `user_id` FROM `user` WHERE `username` = 'Guest' LIMIT 1;")->fetch_object()->user_id;
  }

  public static function username() {
    return 'Guest';
  }

  public static function user_info() {
    return self::db()->query(sprintf("SELECT * FROM `user` WHERE `user_id` = %s;",self::user_id()))->fetch_object();
  }

  // Include the specified handler else a 404 else display a basic 404
  public static function run_handler($path, $h, $uri = '', $raw_params = array()) {
    $params = array_map(array(self::db(),'real_escape_string'),$raw_params);
		$handler_path = BETA_CONTROLLER_DIR . DIRECTORY_SEPARATOR . $path . DIRECTORY_SEPARATOR . $h;
    if (!@include_once($handler_path)) {
			error_log("Unable to find handler: {$path}{$h}");
			self::not_found();
    }
    exit;
  }

	public static function not_found() {
		header("HTTP/1.0 404 Not Found");
		self::display("errors/404.tpl.php", "Page not found");
		exit;
	}

	public static function basic_404() {
		header("HTTP/1.0 404 Not Found");
		echo "404 - Page not found";
		exit;
	}

	public static function display($content_tpl, $title = "", $args = array()) {
		$tpl = self::tpl();
		$tpl->title = $title;
		foreach ($args as $key=>$value) {
			$tpl->$key = $value;
		}
		$tpl->content = $tpl->fetch($content_tpl);
		$tpl->display();
		$tpl->reset();
	}

	public static function add_stylesheet($stylesheet) {
		self::tpl()->stylesheets[] = $stylesheet;
	}

  public static function error_page($title, $message, $status_code = 404) {
    switch ($status_code) {
      case 200: header('HTTP/1.1 200 OK'); break;
      case 404: header("HTTP/1.0 404 Not Found"); break;
      case 403: header('HTTP/1.1 403 Forbidden'); break;
      case 500: header('HTTP/1.1 500 Internal Server Error'); break;
    }
		self::display('error.tpl.php', $title, array('message' => $message));
    exit;
  }

	public static function db_error() {
		error_log(self::db()->error);
		self::error_page("Database Error", "Sorry! A database error has occurred.", 500);
	}

	public static function query($query, $ignore_errors = false) {
		$result = self::db()->query($query);
		if (!$result && !$ignore_errors) {
			if (!headers_sent()) self::db_error();
			else die("Database error");
		}
		return $result;
	}

	public static function get_static_file($path) {
		return BETA_ROOT_URL . DIRECTORY_SEPARATOR . "static" . DIRECTORY_SEPARATOR . $path;
	}

	public static function static_file($path) {
		echo self::get_static_file($path);
	}

	public static function get_url() {
		return BETA_ROOT_URL . "/" . implode('/', array_map('urlencode',func_get_args()));
	}

	public static function url() {
		echo call_user_func_array(array(self, 'get_url'), func_get_args());
	}

}

Beta::init();

?>
