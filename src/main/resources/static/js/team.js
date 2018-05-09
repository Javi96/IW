"use strict"

$(function () {
	$('#contact').hide();
	$('#joinTeam').hide();
	$('#matchRecord').hide();
	$('#playerTab').hide();
	update();
});

function update(){
	
	if(isUserDeputy){// es delegado
    	$('#matchRecord').show();
    	$('#playerTab').show();
    } 
	else{ // usuario normal logueado
		$('#contact').show();
		if(!belong)
			$('#joinTeam').show();
		
	}
}

