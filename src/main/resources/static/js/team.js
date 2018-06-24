"use strict"

let matchId;
let sended = false;

$(function () {
	$('#contact').hide();
	$('#joinTeam').hide();
	$('#matchRecord').hide();
	$('#playerTab').hide();
	$('#playersRequests').hide();
	$('#notificationsDiv').hide();
	$('#deputyPower').hide();
	$('#invalidatePetition').hide();
	$('#deputyContact').hide();
	update();
});

function update(){
	
	if(isUserDeputy){// es delegado
    	$('#matchRecord').show();
    	$('#playerTab').show();
    	$('#playersRequests').show();
    	$('#notificationsDiv').show();
    	$('#deputyPower').show();
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


function getMatch(teamId, id){
	matchId = id;
	
	$.ajax({
	    method: "get",  
	    url: "/getMatch",
	    data: {teamId: teamId, matchId: id},
	    success: (data)=>{
	    	data = JSON.parse(data);
	    	let date = data.date.split('-');
	    	$('#matchRecordModalTitle').text("Partido del dia " + date[2] + "-" + date[1] + "-" + date[0]);
	    	$('#homeTeamName').text(data.homeTeamName);
	    	$('#awayTeamName').text(data.awayTeamName);
	    	$('.recorded').remove();
	    	if(data.recordChecked === "true"){
	    		$("#sendMatchRecord").attr("disabled","disabled");
	    		$("#homeTeamPoints").val(data.homeTeamPoints);
	    		$("#awayTeamPoints").val(data.awayTeamPoints);
	    		$('#homeTeamPoints').prop('readonly', true);
	    		$('#awayTeamPoints').prop('readonly', true);
	    	}
	    	else{
	    		$("#sendMatchRecord").removeAttr("disabled");
	    		$("#homeTeamPoints").val("");
	    		$("#awayTeamPoints").val("");
	    		$('#homeTeamPoints').prop('readonly', false);
	    		$('#awayTeamPoints').prop('readonly', false);

		    	getMatchRecord(teamId,matchId);
	    	}
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
	    	if(data != "Ya has enviado el acta para el partido")
	    		getMatchRecord(teamId,matchId);
	    	
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

function changeTeamInfo(id){
	let nms = $('#nextMatchSchedule').prop("value");
	let nmf = $('#nextMatchFacilities').prop("value");
	let ts = $('#trainingSchedule').prop("value");
	
	$.ajax({
	    method: "post",  
	    url: "/changeTeamInfo",
	    data:
	    {
	    	teamId: id,
	    	nextMatchSchedule: nms,
	    	nextMatchFacilities : nmf,
	    	trainingSchedule: ts
	    },
	    success: (data)=>{
	    	$('#closeChangeInfo').click();
	    	location.reload();
	    },
	    error: (XMLHttpRequest, textStatus, errorThrown)=> {
	    	console.log(XMLHttpRequest);
	    	console.log(textStatus);
	    	console.log(errorThrown);
	        alert("Ha ocurrido un error inesperado"); 
	    }       
	});
}

function invalidatePetition(){
	$.ajax({
	    method: "post",  
	    url: "/invalidatePetition",
	    data:
	    {
	    	matchId: matchId
	    },
	    success: (data)=>{
	    	$('#invalidatePetition').hide();
	    	$('#invalidatePetition').attr("disabled","disabled");
	    	/*$("#sendMatchRecord").removeAttr("disabled");
    		$("#homeTeamPoints").val("");
    		$("#awayTeamPoints").val("");
    		$('#homeTeamPoints').prop('readonly', false);
    		$('#awayTeamPoints').prop('readonly', false);
    		$('.recorded').remove();
    		$('#info').empty();*/
	    },
	    error: (XMLHttpRequest, textStatus, errorThrown)=> {
	    	console.log(XMLHttpRequest);
	    	console.log(textStatus);
	    	console.log(errorThrown);
	        alert("Ha ocurrido un error inesperado"); 
	    }       
	});
}

function deputyContact(){
	
}


function getMatchRecord(teamId, matchId){
	let div2 = $('<div>').addClass('col-md-6 col-md-offset-3 marginTop recorded');
	let div = $('<div>').addClass('row');
	
	$.ajax({
	    method: "get",  
	    url: "/getMatchRecord",
	    data:
	    {	teamId : teamId,
	    	matchId:matchId
	    },
	    success: (data)=>{
	    	let lengthh = data.length;
	    	if(lengthh> 0){
		    	let aux = JSON.parse(data[0]);
		    	div2.append($('<label>').attr("id","deputy1"));
		    	div.append(div2);
		    	$('#info').append(div);
		    	
		    	$('#deputy1').text("Resultado según " + aux.teamName + ": " +  aux.homeTeamPoints + " - " + aux.awayTeamPoints);

		    	if(lengthh > 1 && !aux.checked){
		    		aux = JSON.parse(data[1]);
		    		div2.append($('<label>').attr("id","deputy2"));
    		    	div.append(div2);
    		    	$('#info').append(div);
	    			$('#deputy2').text("Resultado según " + aux.teamName + ": " +  aux.awayTeamPoints + " - " + aux.homeTeamPoints);
	    			$('#sendMatchRecord').prop('disabled', true);
	
	    			$('#invalidatePetition').show();
	    			$('#deputyContact').show();
		    	}
	    	}
	    	else{
	    		$('#info').append(div);
		    	$('#deputy1').text("Ningun equipo ha firmado el acta");
	    	}
	    },
	    error: (XMLHttpRequest, textStatus, errorThrown)=> { 

	    }       
	});
}




