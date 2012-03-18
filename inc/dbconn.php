<?php
$db_cnf = @parse_ini_file(BETA_MYCNF_DIR . '/.my.cnf');

$db = new mysqli(
  $db_cnf['host'], 
  'beta',
  'holy password dude',
  'cis451_final',
  $db_cnf['port'],
  $db_cnf['socket']
) or die('Could not connect to database');

?>
