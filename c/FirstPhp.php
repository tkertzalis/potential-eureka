<!DOCTYPE html>
<html>
<head>
	<title>
		
	</title>
	<h1>First php programm</h1>
</head>
<body>
	<?php
		$a_bool = TRUE;
		$a_str = "foo";
		$a_str22 = 'foo';
		$an_int = 12;

		echo nl2br(gettype($a_bool)."\n");

		if(is_int($an_int)){
			$an_int +=4;
			echo "\$an_int=$an_int"." and fuck off";
		}else{

		}

		
	?>

</body>
</html>