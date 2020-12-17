var me={};
var game_status={};

$(function () {
	draw_empty_board();
	fill_board();
	
	$('#score4_login').click( login_to_game);
	$('#score4_reset').click( reset_board);
	$('#do_move').click( do_move);
	$('#move_div').hide();
	game_status_update();
});


function draw_empty_board() {
	var t ='<table id="score4_table">';
	for(var i=1; i<7; i++){
		t += '<tr>';
		for (var j=1; j<8; j++){
			t += '<td class="score4_square" id="square_'+j+'_'+i+'">' + j + ',' + i + '</td>';
		}
		t += '</tr>';
	}

	t+='</table>';
	
	$('#score4_board').html(t);
}

function fill_board(){
	$.ajax({url: "score4.php/board/" , success:fill_board_by_data});
}

function reset_board() {
	$.ajax({url: "score4.php/board/", method: 'POST',  success: fill_board_by_data });
	$('#move_div').hide();
	$('#game_initializer').show(2000);
}

function fill_board_by_data(data){
	for(var i=0; i<data.length; i++){
		var o  = data[i];
		var id = '#square_' + o.x + '_' + o.y; //εκχωρω μερος του καθε αντικειμενου του ΑΡΙ 
													//(συντεταγμενες x,y) για να μπορω να αναφερθω 
														//σε καθε ενα κελι του board ξεχωριστα
		var c = o.p_color; //
		$(id).html(c); // κανω το inner HTML καθε στοιχειου null (οπως ειναι και στο ΑΡΙ)
	}
}
function login_to_game() {
	if($('#username').val()=='') {
		alert('Πρέπει να ορίσετε όνομα παίκτη');
		return;
	}
	var p_color = $('#pcolor').val();
	draw_empty_board();
	fill_board();
	
	$.ajax({url: "score4.php/players/"+p_color,
			method: 'PUT',
			datatype: "json",
			contentType: 'application/json',
			data: JSON.stringify( {username: $('#username').val(), player_color: p_color}),
			success: login_result,
			error: login_error});
}

function login_result(data) {
	me = data[0];
	$('#game_initializer').hide();
	update_info();
	game_status_update();
}

function login_error(data,y,z,c) {
	var x = data.responseJSON;
	alert(x.errormesg);
}

function game_status_update(){
	$.ajax({url: "score4.php/status/", success: update_status });
}








function update_status(data) {
	game_status=data[0];
	update_info();
	if(game_status.p_turn==me.player_color &&  me.player_color!=null) {
		x=0;
		// do play
		$('#move_div').show(1000);
		setTimeout(function() { game_status_update();}, 15000);
	} else {
		// must wait for something
		$('#move_div').hide(1000);
		setTimeout(function() { game_status_update();}, 4000);
	}
 	
}

function update_info(){
	$('#game_info').html("I am Player: "+me.player_color+", my name is "+me.username +'<br>Token='+me.token+'<br>Game state: '+game_status.status+', '+ game_status.p_turn+' must play now.');
	
}

function do_move() {
	var s = $('#the_move').val();
	
	var a = s.trim().split(/[ ]+/);
	if(a.length!=2) {
		alert('Must give 2 numbers');
		return;
	}
	$.ajax({url: "score4.php/board/piece/"+a[0]+'/'+a[1], 
			method: 'PUT',
			dataType: "json",
			contentType: 'application/json',
			data: JSON.stringify( {x: a[2], y: a[3]}),
			success: move_result,
			error: login_error});
	
}

function move_result(data){
	
}