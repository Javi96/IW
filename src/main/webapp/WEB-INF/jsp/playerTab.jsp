<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>

<script src = "static/js/playerTab.js"></script>

<style>
         .playerslist {
            margin-left:25%;
            min-height: 250px;
            max-width: 550px;
            margin-bottom: 2px;
            border: 2px solid red
            
        }
        .playertabout {
        	float:left;
        	min-height: 250px;
            width: 550px;
            border: 2px solid red;
        }	
        .playertabin {
        	float:left;
            margin-right: 2px;
        	min-height: 250px;
            border: 2px solid red;
            width: 550px;
        }
        li{
            cursor:pointer;
            padding: 6px;
        }
        li:hover{
            color:blue;
        }
        .confirm_button{
        	float:right;
        	margin-right: 300px;
        }
        h1 #cabeceraInOut{
            margin-left: 80px;
        }
     
     

</style>

<div class="container" id="tabs">
        
        <div class="playerslist" >
       		<h1 class="cabeceraInOut">Cambios en la plantilla</h1>
        	<ol id="INOUT"></ol>
        </div>

        
        <div class="playertabin">
            <h1 class="cabeceraIn">Fichas activas</h1>
            <ol id="IN"></ol>
        </div>
        
        <div class="playertabout">
            <h1 class="cabeceraOut">Fichas no activas</h1>
            <ol id="OUT"></ol>
        </div>    
</div>
<div class="container" class="confirm_button">
	<button onClick="addPlayer()" >Add</button>
    <button onClick="rmPlayer()" >Remove</button>
    <button onClick="confirmTabs()" >Confirm</button>
</div>
<script>
    
var playerIn = ["Pedro David Gonzalez", "Javier Cortes Tejada", "Javier Anton Alonso", "Biel Selles Salvás"];
var playerOut = [];
var playerInOut = [];

function render(id, array, target) {
  $("#" + id).empty();
  console.log(array);
  for(let jaja = 0; jaja < array.length; jaja++) {
	  console.log("aqui");
    let el = $("<li>" + array[jaja] + "</li>");
    $("#" + id).append(el);
    el.click(function(o) {
      move(this, array, target);
    })
  }
}

function move(el, src, tgt) {
	//elimina el elemento de la lista
  let x = $(el).text();
   const i = src.indexOf(x);
  if (i === -1) return;
  src.splice(i, 1);
  
  if(tgt === undefined){
  	let indexA = playerIn.indexOf(x);
    if(indexA === -1){
    	playerOut.splice(playerOut.indexOf(x), 1);
    	tgt = playerIn;
    }else{
      playerIn.splice(indexA, 1);
      tgt = playerOut; 
  	}
  }
  else if(playerInOut.indexOf(x)===-1){
  	playerInOut.push(x);
  }else{
  	playerInOut.splice(x.indexOf(x), 1);
  }
  tgt.push(x);
  regen();
}

function regen() {
  render("IN", playerIn, playerOut);
  render("OUT", playerOut, playerIn);
  render("INOUT", playerInOut);
}
regen();
    
</script>
