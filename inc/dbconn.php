<?php
$db_cnf = @parse_ini_file(BETA_DBCONF);

$db = new mysqli(
  $db_cnf['host'], 
  $db_cnf['username'], 
  $db_cnf['password'], 
  $db_cnf['database'], 
  $db_cnf['port']
) or die('Could not connect to database');

?>
