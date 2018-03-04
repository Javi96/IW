<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>

<script src = "static/js/playerTab.js"></script>

<style>
        .playerslist {
            margin-left:30%;
            
        }
        .playertabout {
        	float:left;
        }	
        .playertabin {
        	float:left;
        	margin-right:30%;
        }
        li{
            cursor:pointer;
        }
        li:hover{
            color:blue;
        }
        .confirm_button{
        	float:right;
        	margin-right: 300px;
        }
     

</style>

<div class="container" id="tabs">
        
        <div id="IN/OUT" class="playerslist" >
            <h1>Cambios en la plantilla</h1>
        </div>

        
        <div class="playertabin">
            <h1>Fichas activas</h1>
            <ol id="IN"></ol>
        </div>
        
        <div class="playertabout">
            <h1>Fichas no activas</h1>
            <ol id="OUT"></ol>
        </div>    
</div>
<div class="container" class="confirm_button">
	<button onClick="addPlayer()" >Add</button>
    <button onClick="rmPlayer()" >Remove</button>
    <button onClick="confirmTabs()" >Confirm</button>
</div>
<script>
    
    let playersTab = [];

    let domInOut = document.getElementById("IN/OUT");
    let domIn = document.getElementById("IN");
    let domOut = document.getElementById("OUT");

    for(let i = 0; i < 14; i++){
        let persona = {name:"name"+i, forename1:"forename1_"+i, forename2:"forename2_"+i, id:i, state:"in", haschanged:false};
        playersTab.push(persona);
        let para = document.createElement("li");
        para.id = "li_" + i;
        let node = document.createTextNode(playersTab[i].name + " " + playersTab[i].forename1 + " " + playersTab[i].forename2 + "\n");
        para.appendChild(node);
        domIn.appendChild(para);

        para.onclick = function(){
            console.log(playersTab[persona.id]);
            let _rmLi = document.getElementById("li_"+persona.id);
            persona.haschanged = !persona.haschanged;
            if(persona.state == "in"){
                persona.state = "out";
                domIn.removeChild(_rmLi);
                domOut.appendChild(_rmLi);
            }
            else if(persona.state == "out"){
                persona.state= "in";
                domOut.removeChild(_rmLi);
                domIn.appendChild(_rmLi);
            }
        };
    }
</script>

