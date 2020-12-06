<?php
	
$host='localhost';
$db = 'score4';
require_once "configlocal.php";



$user = $DB_USER;
$pass = $DB_PASS;

if(gethostname()=='users.iee.ihu.gr') {
	$mysqli = new mysqli($host, $user, $pass, $db,null);
} else {
	$mysqli = new mysqli($host, $user, $pass, $db);
}

if($mysqli->connect_errno) {
	echo "Failed to connect to MYSQL: (" . 
	$mysqli-> connect_errno . ") " . $mysqli->connect_error;
}	

?>