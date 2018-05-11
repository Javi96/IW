"use strict"

let matchId;

$(function () {
	$('#contact').hide();
	$('#joinTeam').hide();
	$('#matchRecord').hide();
	$('#playerTab').hide();
	$('#playersRequests').hide();
	$('#notifications').hide();
	update();
});

function update(){
	
	if(isUserDeputy){// es delegado
    	$('#matchRecord').show();
    	$('#playerTab').show();
    	$('#playersRequests').show();
    	$('#notifications').show();
    } 
	else{ // usuario normal logueado
		$('#contact').show();
		$('#notifications').show();
		if(belong){//si pertenece al equipo
			$('#joinTeam').hide();
		}
		else{//si no pertenece al equipo
			$('#joinTeam').show();
		}
	}
}

function getLastMatchRecord(){
	$.ajax({
	    method: "get",  
	    url: "/getLastMatch",
	    data: {teamId: teamId},
	    success: (data)=>{
	    	data = JSON.parse(data);
	    	let date = data.date.split('-');
	    	$('#matchRecordModalTitle').text("Partido del dia " + date[2] + "-" + date[1] + "-" + date[0]);
	    	$('#homeTeamName').text(data.homeTeamName);
	    	$('#awayTeamName').text(data.awayTeamName);
	    	matchId = data.matchId;
	    },
	    error: (XMLHttpRequest, textStatus, errorThrown)=> { 
	        alert("Status: " + textStatus);
	        alert("Error: " + errorThrown); 
	    }       
	});
}

function addMatchRecord(){
	let homeTeamPoints = $('#homeTeamPoints').prop('value');
	let awayTeamPoints = $('#awayTeamPoints').prop('value');
	
	$.ajax({
	    method: "post",  
	    url: "/matchRecord",
	    data:
	    {
	    	matchId: matchId,
	    	teamId: teamId,
	    	homeTeamPoints: homeTeamPoints,
	    	awayTeamPoints : awayTeamPoints
	    },
	    success: (data)=>{
	    	if(data != "Correct"){
	    		alert(data);
	    	}
	    	else{
	    		$('.modal-body').text("Acta enviada correctamente");
	    		$('#sendMatchRecord').prop('disabled', true);
	    	}
	    },
	    error: (XMLHttpRequest, textStatus, errorThrown)=> { 
	        alert("Tienes que rellenar la puntuacion de cada equipo"); 
	    }       
	});
}


