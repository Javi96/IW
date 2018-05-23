"use strict"


var playerIn = new Array();
var playerInCopy = new Array();

var playerOut = new Array();
var playerOutCopy = new Array();

var playerInOut = new Array();
var idTeam;

/*
 * Manejador que se ejecuta cuando el DOM se haya cargado.
 */
$(document).ready(function() {
	
	$("#btnReset").on("click", onResetClick);
	$("#btnSave").on("click", onSaveClick);
	
	loadActive();
	loadNoActive();
});

/**
* Funcion que captura las variables pasados por GET
* Devuelve un array de clave=>valor
*/
function getGET()
{
    // capturamos la url
    var loc = document.location.href;
    // si existe el interrogante
    if(loc.indexOf('?')>0)
    {
        // cogemos la parte de la url que hay despues del interrogante
        var getString = loc.split('?')[1];
        // obtenemos un array con cada clave=valor
        var GET = getString.split('&');
        var get = {};
        // recorremos todo el array de valores
        for(var i = 0, l = GET.length; i < l; i++){
            var tmp = GET[i].split('=');
            get[tmp[0]] = unescape(decodeURI(tmp[1]));
        }
        
        return get;
    }
}

function completeTitle(){
	
	$("#in_token").text('');
	$("#inout_token").text('');
	$("#out_token").text('');
	
	
	//in
    $("#in_token").append('Fichas activas ' + '(' + playerIn.length + '/40)');
    
    //out
    $("#out_token").append('Fichas no activas ' + '(' + playerOut.length + '/40)');
    
    //inout
    if(playerInOut.length == 0){
		let name = $('<li class="list-group-flush text-center text">(no hay elementos disponibles)</li>');
		$("#inout").append(name);
    }
    
    $("#inout_token").append('Cambios en la plantilla: ' + playerInOut.length);
}

function loadActive(){
	
	var valores = getGET();	
	idTeam = valores['id'];
	
	$.get("/savePlayerActive", {idTeam: idTeam},
	function(data) {
		
		let userInfo = data.split("'");
		
		for(let i = 0; i < userInfo.length; i++){
			
			//obtenemos campos
			let datePlayer = userInfo[i].split(":");
			let validos = datePlayer[1].split(",");
			let idPlayer = validos[0].substring(1,validos[0].length);
			let namePlayer = validos[1].substring(0,validos[1].length-2);
			
			playerIn.push(new User(idPlayer,namePlayer,1));
			
		}
		
		playerInCopy = playerIn.slice();
	});
}

function loadNoActive(){
	
	var valores = getGET();	
	idTeam = valores['id'];
	console.log("ID equipo:"+idTeam);
	
	$.get("/savePlayerNoActive", {idTeam: idTeam},
	function(data) {
		
		let userInfo = data.split("'");
		
		for(let i = 0; i < userInfo.length; i++){
			
			//obtenemos campos
			let datePlayer = userInfo[i].split(":");
			let validos = datePlayer[1].split(",");
			
			let idPlayer = validos[0].substring(1,validos[0].length);
			let namePlayer = validos[1].substring(0,validos[1].length-2);
			
			playerOut.push(new User(idPlayer,namePlayer,2));
		}
		playerOutCopy = playerOut.slice();
	});
}

function onPlayerActive(event){
	
	var idPlayer = event.id;
	$("#"+idPlayer).remove();
	
	var user = getUser(playerIn,idPlayer);
	borrarElem(playerIn,idPlayer);
	
	if(user.ref == 2){
		
		//inout
		borrarElem(playerInOut,idPlayer);
		$("#inout #"+idPlayer).remove();
		$("#"+idPlayer).remove();
		
	}else{
		
		//out
		playerInOut.push(user);
		
		if(playerInOut.length == 1)
			$("#inout").empty();
		
		cargarLista("inout",idPlayer, user.name);
	}
	
	//out
	playerOut.push(user);
	cargarLista("out",idPlayer, user.name);
	completeTitle();
}

function onPlayerInOut(event){
	
	var idPlayer = event.id;
	$("#"+idPlayer).remove();
	
	var user = getUser(playerInOut,idPlayer);
	borrarElem(playerInOut,idPlayer);
	
	if(user.ref == 2){
		
		borrarElem(playerIn,idPlayer);
		$("#in #"+idPlayer).remove();
		
		playerOut.push(user);
		cargarLista("out",idPlayer, user.name);
		
	}else{
		
		borrarElem(playerOut,idPlayer);
		$("#out #"+idPlayer).remove();
		
		playerIn.push(user);
		cargarLista("in",idPlayer, user.name);
	}
	completeTitle();
}

function onPlayerNoActive(event){ 
	
	var idPlayer = event.id;
	$("#out #"+idPlayer).remove();
	
	 var user = getUser(playerOut,idPlayer);
	 borrarElem(playerOut,idPlayer);
	 
	if(user.ref == 2){
		
		playerInOut.push(user);
		
		if(playerInOut.length == 1)
			$("#inout").empty();
		
		cargarLista("inout",idPlayer, user.name);
	
	}else{
		borrarElem(playerInOut,idPlayer);
		 $("#inout #"+idPlayer).remove();
	}

	//si o si se tiene que insertar en la lista de in
	 playerIn.push(user);
	 cargarLista("in",idPlayer, user.name);
		completeTitle();
}

//lista ==> lista destino
function cargarLista(lista,idPlayer, namePlayer){
	
	let li = $('<li class="list-group-item" id='+idPlayer+' >' + namePlayer+
			'<button type="button" class="close" aria-label="Close"> <span aria-hidden="true">&times;</span></button>'
	+"</li>").prop('id',idPlayer);
	
	//colocamos le id
	let playerID = $('<input>').attr('type','hidden').attr('name',"id").prop('value',idPlayer);
	li.append(playerID);
	
	switch(lista){
		
	//si nos mandan a lista in ponemos action in
		case "in":
			li.click(function(o) {
				onPlayerActive(this, idPlayer, namePlayer);
		      });
		break;
		
		case "inout":
			$(li).css("color","red");
			li.click(function(o) {
				onPlayerInOut(this, idPlayer, namePlayer);
		      });
		break;
		
		case "out":
			li.click(function(o) {
				onPlayerNoActive(this, idPlayer, namePlayer);
		      });
		break;
	}
	
	$('#'+lista).append(li);

}

function User(id, n, r) { 
	this.id = id;
	this.name = n;
	this.ref = r;
}

function getUser(lista,idPlayer){
	
	 var user;
	 
	lista.forEach(function(elem) {
		if(elem.id == idPlayer)
			user  = new User(elem.id,elem.name,elem.ref);		
	});
	
	return user;
}

function borrarElem(lista, idPlayer){
	
	var i = 0;
	
	lista.forEach(function(elem){
		
		if(elem.id == idPlayer)
			lista.splice(i,1);
		
		i++;
	});
}

function onSaveClick(){
	
    var opcion = confirm("¿Desea guardar los cambios?");
    if (opcion == true) {
        redireccionar();
	} 
	 
}

function vuelveATeam(){
	
	$.ajax({
	    method: "get",  
	    url: "/team",
	    data: {id: idTeam},
	    success: (data)=>{}       
	});
		
}

function redireccionar(){
	
var loc=location.href ="http://localhost:8000/team?id="+idTeam;
	
	var activos = new Array();
	var noActivos = new Array();

	//convertimos los datos para leerlos mejor
	playerIn.forEach(function(elem){
		var cadena = elem.id;
		activos.push(cadena);
	});
	
	//convertimos los datos para leerlos mejor
	playerOut.forEach(function(elem){
		var cadena = elem.id;
		noActivos.push(cadena);
	});

	
	$.ajax({
	    method: "post",  
	    url: "/savePlayerTab",
	    data:
	    {
	    	activePlayer:JSON.stringify(activos),
	    	noActivePlayer:JSON.stringify(noActivos),
	    	idTeam: idTeam
	    },
	    success: (data)=>{
	    		vuelveATeam();
	    }
	});
	
}

function onResetClick(){
	
	$("#inout").empty();
	$("#out").empty();
	$("#in").empty();
	
	 playerIn = playerInCopy.slice();
	 
	 for(let i = 0; i < playerIn.length; i++){
		 cargarLista("in",playerIn[i].id, playerIn[i].name);
	 }
	 
	 playerOut = playerOutCopy.slice();
	 
	 for(let i = 0; i < playerOut.length; i++){
		 cargarLista("out",playerOut[i].id, playerOut[i].name);
	 }
	 
	 playerInOut = [];

	completeTitle();
}