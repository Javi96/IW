"use strict"


var playerIn = new Array();
var playerInCopy = new Array();
var playerOut = new Array();
var playerInOut = new Array();
var idTeam;

/*
 * Manejador que se ejecuta cuando el DOM se haya cargado.
 */
$(document).ready(function() {
	
	
	loadActive();
	
	
	$("#btnReset").on("click", onResetClick);
	$("#btnSave").on("click", onSaveClick);
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
	console.log("dentro del script para cargar listas con el id del equipo:"+idTeam);
	
	$.get("/showPlayersByTeam", {idTeam: idTeam},
	function(data) {
		
		let userInfo = data.split("'");
		
		for(let i = 0; i < userInfo.length; i++){
			
			//obtenemos campos
			let datePlayer = userInfo[i].split(":");
			let validos = datePlayer[1].split(",");
			
			let idPlayer = validos[0].substring(1,validos[0].length);
			let namePlayer = validos[1].substring(0,validos[1].length-2);
			
			playerIn.push(new User(idPlayer,namePlayer,1));
			
			let li = $('<li class="list-group-item" >' + namePlayer+
					'<button type="button" class="close" aria-label="Close"> <span aria-hidden="true">&times;</span></button>'
			+"</li>").prop('id',idPlayer);
			
			//colocamos le id
			let playerID = $('<input>').attr('type','hidden').attr('name',"id").prop('value',idPlayer);
			
			//asignamos evento a cada elemento de la lista
			 li.click(function(o) {
		          addListIn(this, idPlayer, namePlayer);
		      });
			 
			li.append(playerID);
			
			$('#in').append(li);
		}
		
		playerInCopy = playerIn;
		completeTitle();
	});
	
}


function addListInOut(liEvento, idPlayer, namePlayer){
	
	//borramos elemento
	$("#"+idPlayer).remove();
	
	var user = getUser(playerInOut,idPlayer);
	borrarElem(playerInOut,idPlayer);
	
	
	borrarElem(playerInOut,idPlayer);
	$("#out #"+idPlayer).remove();
	
	
	//si el elemento vino de no activas
	/*
	if(user.ref == 2){
		borrarElem(playerIn,idPlayer);
		$("#in #"+idPlayer).remove();
		completeTitle();
	}else{
		
		//out
		borrarElem(playerOut,idPlayer);
		$("#out #"+idPlayer).remove();
		
		//in
		playerIn.push(user);
		cargarLista("in",idPlayer, namePlayer);
	}
	*/
	
	playerIn.push(user);
	cargarLista("in",idPlayer, namePlayer);
	
	
};

function addListIn(liEvento, idPlayer, namePlayer){
	
	//borramos elemento
	$("#"+idPlayer).remove();
	
	var user = getUser(playerIn,idPlayer);//obtenemos el usuario que vamso a borrar
	borrarElem(playerIn,idPlayer); //eliminamos de la lista

	//cambiamos referencia de origen en InOut
	var userCopy = user;
	userCopy.ref = 2;
	
	//Actualizamso listas
	playerInOut.push(user);
	playerOut.push(user);
	
	
	if(playerInOut.length == 1)
		$("#inout").empty();
	
	//añadimos a la lista de activas
	cargarLista("inout",idPlayer, namePlayer);
	cargarLista("out",idPlayer, namePlayer);
	
};

/**
 * funcion que le paso lista e imprimir lista
 */
function addListOut(liEvento, idPlayer, namePlayer){
	
	//borramos elemento
	$("#out #"+idPlayer).remove();
	
	var user = getUser(playerOut,idPlayer);//obtenemos el usuario que vamso a borrar
	
	 borrarElem(playerOut,idPlayer);
	 borrarElem(playerInOut,idPlayer);
	 $("#inout #"+idPlayer).remove();
	 
	 
	 /*
	if(user.ref == 2){
		playerInOut.push(user);
		if(playerInOut.length == 1)
			$("#inout").empty();
		cargarLista("inout",idPlayer, namePlayer);
	}else{
		borrarElem(playerInOut,idPlayer);
		 $("#inout #"+idPlayer).remove();
	}
	*/
	playerIn.push(user);
	cargarLista("in",idPlayer, namePlayer);
	
};

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

function existe(lista, idPlayer){
	
	var enc = false;
	
	lista.forEach(function(elem){
		
		if(elem.id == idPlayer)
			enc = true;
	});
	
	return ecn;
}

//objetos tipos user
function User(id, n, r) { 
	this.id = id;
	this.name = n;
	this.ref = r;
}

function onSaveClick(){
	
	var loc=location.href ="http://localhost:8000/team?id="+idTeam;
	
	$.ajax({
	    method: "get",  //"post",
	    url: loc,
	    data:{
	    		players: playerIn
	    },
	    success: (data)=>{
		    	if(data != "Correct"){
		    		alert("datos guardados correctamente");
		    	}
		    error: (XMLHttpRequest, textStatus, errorThrown)=> { 
		        alert("Error inesperado"); 
		    }
	    }
	});
	 
}

function onResetClick(){
	
	$("#inout").empty();
	$("#out").empty();
	$("#in").empty();
	
	//vaciamos arrys
	 playerIn = [];
	 playerInCopy = [];
	 playerOut = [];
	 playerInOut = [];
	 
	 
	$("#in_token").text('');
	$("#inout_token").text('');
	$("#out_token").text('');
	
	loadActive();
	
}

//lista ==> lista destino
function cargarLista(lista,idPlayer, namePlayer){
	
	let li = $('<li class="list-group-item" >' + namePlayer+
			'<button type="button" class="close" aria-label="Close"> <span aria-hidden="true">&times;</span></button>'
	+"</li>").prop('id',idPlayer);
	
	//colocamos le id
	let playerID = $('<input>').attr('type','hidden').attr('name',"id").prop('value',idPlayer);
	li.append(playerID);
	
	switch(lista){
		
	//si nos mandan a lista in ponemos action in
		case "in":
			li.click(function(o) {
		          addListIn(this, idPlayer, namePlayer);
		      });
		break;
		
		case "inout":
			$(li).css("color","red");
			li.click(function(o) {
		          addListInOut(this, idPlayer, namePlayer);
		      });
		break;
		
		case "out":
			li.click(function(o) {
				addListOut(this, idPlayer, namePlayer);
		      });
		break;
	}
	
	$('#'+lista).append(li);
	completeTitle();
}
