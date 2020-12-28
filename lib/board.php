<?php 
	function show_piece($x,$y) {
	global $mysqli;
	
	$sql = 'select * from board where x=? and y=?';
	$st = $mysqli->prepare($sql);
	$st->bind_param('ii',$x,$y);
	$st->execute();
	$res = $st->get_result();
	header('Content-type: application/json');
	print json_encode($res->fetch_all(MYSQLI_ASSOC), JSON_PRETTY_PRINT);
}


function move_piece($x,$y,$token) {
	
	if($token==null || $token=='') {
		header("HTTP/1.1 400 Bad Request");
		print json_encode(['errormesg'=>"token is not set."]);
		exit;
	}
	
	$color = current_color($token);
	if($color==null ) {
		header("HTTP/1.1 400 Bad Request");
		print json_encode(['errormesg'=>"You are not a player of this game."]);
		exit;
	}
	$status = read_status();
	if($status['status']!='started') {
		header("HTTP/1.1 400 Bad Request");
		print json_encode(['errormesg'=>"Game is not in action."]);
		exit;
	}
	if($status['p_turn']!=$color) {
		header("HTTP/1.1 400 Bad Request");
		print json_encode(['errormesg'=>"It is not your turn."]);
		exit;
	}
	$orig_board=read_board();
	$board=convert_board($orig_board);
	$n = is_valid_move($board,$color,$x,$y);
	if($n==false) {
		header("HTTP/1.1 400 Bad Request");
		print json_encode(['errormesg'=>"There is already a piece in this position."]);
		exit;
	}else{
		do_move($color,$x,$y);
		change_turn($color);
		
	}
	
	
}

function change_turn($c) //αλλάζει τη σειρά αφού γίνει κίνηση
{
	global $mysqli;
	if($c=='Y'){
		$sql = "UPDATE game_status SET p_turn='R' WHERE status ='started'";
	}else if($c=='R'){
		$sql = "UPDATE game_status SET p_turn='Y' WHERE status ='started'";		
	}
	$st = $mysqli->prepare($sql);
	$r = $st->execute();
}

























	
	function show_board() {
		
		global $mysqli;
		
		$sql = 'select * from board';
		$st = $mysqli->prepare($sql);
	
	
		$st->execute();
		$res = $st->get_result(); 
		
		header('Content-type: application/json');
		print json_encode($res->fetch_all(MYSQLI_ASSOC), JSON_PRETTY_PRINT);
	
	}
	
	function reset_board(){
		global $mysqli;		
		$sql = 'call clean_board()';
		$mysqli->query($sql);
		show_board();
	}
	
	function is_valid_move(&$board,$b,$x,$y){
		$flag = false;
		if(is_null($board[$x][$y]['p_color'])){
			$flag = true;
		}
		return $flag;
	}
	
	function read_board() {
		global $mysqli;
		$sql = 'select * from board';
		$st = $mysqli->prepare($sql);
		$st->execute();
		$res = $st->get_result();
		return($res->fetch_all(MYSQLI_ASSOC));
	}
	
	function convert_board(&$orig_board) {
		$board=[];
		foreach($orig_board as $i=>&$row) {
			$board[$row['x']][$row['y']] = &$row;
		} 
		return($board);
	}
	
	function do_move($b,$x,$y){
		global $mysqli;
		$sql = 'UPDATE board SET p_color=? WHERE x=? AND y=?';
		$st = $mysqli->prepare($sql);
		$st->bind_param('sii',$b,$x,$y);
		$st->execute();
	
		header('Content-type: application/json');
		print json_encode(read_board(), JSON_PRETTY_PRINT);
	}


?>