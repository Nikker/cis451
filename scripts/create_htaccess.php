<?php

if (php_sapi_name() !== "cli") die("Command line only");

require "../inc/settings.php";


$in = file_get_contents("../inc/htaccess.tpl");

$out = preg_replace_callback(
	'/{{ ([A-Z_]+) }}/',
	function ($matches) {
		if (!defined($matches[1])) {
			die(sprintf("The constant %s is not defined", $matches[1]));
		} else {
			return constant($matches[1]);
		}
	},
	$in
);


file_put_contents("../.htaccess", $out);

?>
