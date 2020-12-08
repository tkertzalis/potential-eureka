$(function () {
	draw_empty_board();
	fill_board();
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