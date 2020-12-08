$(function () {
	draw_empty_board();
	//fill_board();
});


function draw_empty_board() {
	var t ='<table id="score4_table">';
	for(var i=1; i<8; i++){
		t += '<tr>';
		for var(j=1; j<7; j++){
			t += '<td class="score4_square" id="square_'+j+'_'+i+'">' + j + ',' + i + '</td>';
		}
		t += '</tr>';
	}

	t+='</table>';
	
	$('#chess_board').html(t);
}

