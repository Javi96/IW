"use strict"

let matchId;

$(function () {
	$('#contact').hide();
	$('#joinTeam').hide();
	$('#matchRecord').hide();
	$('#playerTab').hide();
	$('#playersRequests').hide();
	$('#notificationsDiv').hide();
	update();
});

function update(){
	
	if(isUserDeputy){// es delegado
    	$('#matchRecord').show();
    	$('#playerTab').show();
    	$('#playersRequests').show();
    	$('#notificationsDiv').show();
    } 
	else{ // usuario normal logueado
		$('#contact').show();
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

function deleteNotification(id){
	$.ajax({
	    method: "post",  
	    url: "/deleteNotification",
	    data:
	    {
	    	id:id
	    },
	    success: (data)=>{
	    	$('#'+id).remove();
	    	if($('#modalNotifications').children().length === 0)
	    		$('#modalNotifications').text("No hay mas notificaciones");
	    },
	    error: (XMLHttpRequest, textStatus, errorThrown)=> { 
	        alert("Ha ocurrido un error inesperado"); 
	    }       
	});
}

function responseNotification(id){
	window.open("https://www.google.com/intl/es/gmail/about/");
}

function acceptNewPlayer(id){
	$.ajax({
	    method: "post",  
	    url: "/acceptNewPlayer",
	    contentType:'application/json',
	    data:
	    {
	    	id:id
	    },
	    success: (data)=>{
	    	$('#'+id).remove();
	    	console.log($('#modalRequest'));
	    	if($('#modalRequest').children().length === 0)
	    		$('#modalRequest').text("No hay mas solicitudes");
	    },
	    error: (XMLHttpRequest, textStatus, errorThrown)=> { 
	        alert("Ha ocurrido un error inesperado"); 
	    }       
	});
}

function deleteRequestPlayer(id) {
	$.ajax({
	    method: "post",  
	    url: "/deleteRequest",
	    contentType:'application/json',
	    data:
	    {
	    	id:id
	    },
	    success: (data)=>{
	    	$('#'+id).remove();
	    	if($('#modalRequest').children().length === 0)
	    		$('#modalRequest').text("No hay mas solicitudes");
	    },
	    error: (XMLHttpRequest, textStatus, errorThrown)=> { 
	        alert("Ha ocurrido un error inesperado"); 
	    }       
	});
}

