<?php

$db_cnf = @parse_ini_file(BETA_MYCNF_DIR . '/.my.cnf');
$db = new mysqli(
  $db_cnf['client']['host'], 
  'beta',
  'holy password dude',
  'cis451_final',
  $db_cnf['client']['port']
) or die('Could not connect to database');

?>