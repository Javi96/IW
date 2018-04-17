<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<<<<<<< HEAD
<%@ include file="../jspf/header.jspf"%>


<style>

            /* width */
::-webkit-scrollbar {
    width: 5px;
}

/* Track */
::-webkit-scrollbar-track {
    background: #f1f1f1; 
}

/* Handle */
::-webkit-scrollbar-thumb {
    background: #888; 
}

/* Handle on hover */
::-webkit-scrollbar-thumb:hover {
    background: #555; 
}

            .container{

            }
            .left_container{
                float: left;
                width: 100%;
            }
            .rigth_container{
                float: right;
                width: 100%;
            }
            .playerslist {
                height: 300px;
                overflow-y: auto;
                scroll-behavior: smooth;
                margin-bottom: 60px;
                margin-top: 20px;

            }
            .playertabout {
                width: 40%;
                height: 320px;
                overflow-y: auto;
                scroll-behavior: smooth;
                float: right;
                margin-bottom: 60px;

            }   
            .playertabin {
                width: 40%;
                height: 320px;
                overflow-y: auto;
                scroll-behavior: smooth;
                float: left;
                margin-bottom: 60px;

            }
            .changesIn{
                font-family: "Times New Roman", Times, serif;
                text-align: center;
                float: left;
                width: 40%;

            }
            .changesOut{
                font-family: "Times New Roman", Times, serif;
                float: right;
                width: 40%;
                text-align: center;
            }
            .changesMix{
                font-family: "Times New Roman", Times, serif;
                text-align: center; 
            }
            
            .cabeceraInOut{

            }

            /*li{
                font-family: "Times New Roman", Times, serif;
                cursor:pointer;
                padding: 6px;
                color: black;
                list-style-type: none;
                background-image: url("static/img/close_red.png");
            }

            li:hover{
                color:red;
                padding-left: 2rem;

                background-position: inherit;
                background-size: 1.6rem 1.6rem;

                background-repeat: no-repeat;
            }*/

            .confirm_button{
                float:right;
                margin-right: 300px;
            }

            ol #person{
                color: red;

            }
            .text{
                font-style: oblique;
                font-size: 12px;
                color: gray;
                text-align: center;
            }



            /*tabla*/
            #hor-minimalist-b
            {
                font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
                font-size: 12px;
                background: #fff;
                margin: 45px;
                width: 480px;
                border-collapse: collapse;
                text-align: left;
            }
            #hor-minimalist-b th
            {
                font-size: 14px;
                font-weight: normal;
                color: #039;
                padding: 10px 8px;
                border-bottom: 2px solid #6678b1;
            }
            #hor-minimalist-b td
            {
                border-bottom: 1px solid #ccc;
                color: #669;
                padding: 6px 8px;
            }
            #hor-minimalist-b tbody tr:hover td
            {
                color: #009;
            }

        </style>


        <!--<div class="list-group">
          <a href="#" class="list-group-item">First item</a>
          <a href="#" class="list-group-item">Second item</a>
          <a href="#" class="list-group-item">Third item</a>
        </div>

        <div id="table" class="table-responsive">
            <table id="hor-minimalist-b" class="table table-hover table-striped">
                <tr>
                    <th>Item name</th>
                    <th>Description</th>
                    <th>Price(Rs.)</th>
                </tr>
                <tr>
                    <td>Pentium IV</td>
                    <td>2.2 Ghz</td>
                    <td>2000 </td>
                </tr>
                <tr>
                    <td>Pentium Core Solo</td>
                    <td>1.2 Ghz</td>
                    <td>2000 </td>
                </tr>
                <tr>
                    <td>Pentium Core 2 Duo</td>
                    <td>1.2 Ghz</td>
                    <td>6000 </td>
                </tr>
                <tr>
                    <td>Intel Core i3</td>
                    <td>2.4 Ghz</td>
                    <td>8000 </td>
                </tr>
            </table>
        </div>-->

        <div class="container" id="tabs">

            <h1 id="inout_token" class="changesMix">Cambios en la plantilla</h1>

            <div class="playerslist" >
                    <ul id="inout" class="list-group list-group-flush"></ul> 
            </div> 
            
            <div class="left_container">
                <h1 id="in_token" class="changesIn">Fichas activas</h1>
                <h1 id="out_token" class="changesOut">Fichas no activas</h1>
            </div>
            <div class="left_container">
                <div class="playertabin">
                    <ul id="in" class="list-group list-group-flush"></ul> 
                </div>
                <div class="playertabout">
                    <ul id="out" class="list-group list-group-flush"></ul> 
                </div>
            </div>

            <div style="float: right;">
                <button class="btn btn-warning" onClick="checkReset()" type="reset">Eliminar modificaciones</button>
                <button class="btn btn-success" onClick="checkReset()" type="submit">Guardar cambios</button>
            </div>
        </div>
        <!--
            card bootstrap
            carousel bootstrap
        -->
=======
<%@ include file="../jspf/header.jspf"%>%>

<script src = "static/js/playerTab.js"></script>

<style>
            .container{
                align-self: center;
            }
            .playerslist {
            min-height: 250px;
            }
            .playertabout {
            float: right;
            width: 45%;
            min-height: 250px;
        }   
        .tittle{
			background: radial-gradient(white, #c3c1c1, #8f8686);
            text-align: center;
            font-size: 30px;
            color: #b60f0f;
            
            
        }
        
            .playertabin {
            float: left;
            width: 45%;
            min-height: 250px;
            }
            .cabeceraInOut{
            }
            li{
            cursor:pointer;
            padding: 6px;
            color: black;
            }
            li:hover{
            color:blue;
            }
            .confirm_button{
            float:right;
            margin-right: 300px;
            }
            ol #person{
            color: black;
            }
        .text{
            font-style: oblique;
            font-size: 12px;
            color: gray;
            display: table-row;
        }
        </style>
        <div class="container" id="tabs">
            <div class="playerslist" >
                <h1 class="changesMix">Cambios en la plantilla</h1>
                <ol class="person" id="INOUT"></ol>
            </div>
            <div class="playertabin">
                <h1 class="changesIn">Fichas activas</h1>
                <ol id="IN"></ol>
            </div>
            <div class="playertabout">
                <h1 class="changesOut">Fichas no activas</h1>
                <ol id="OUT"></ol>
            </div>
        </div>
>>>>>>> 961d4ac2948143026125d8b139ba2a7774bbb243

        <!--<div class="container" class="confirm_button">
            <button onClick="addPlayer()" >Add</button>
            <button onClick="rmPlayer()" >Remove</button>
            <button onClick="confirmTabs()" >Confirm</button>
        </div>-->

        <!--git reset --hard <commit> 
-->

        <script>
<<<<<<< HEAD
            const IN = 'in';
            const OUT = 'out';
            const INOUT = 'inout';

            var playerIn = ["Pedro David Gonzalez", "Javier Cortes Tejada", "Javier Anton Alonso", "Biel Selles Salvás", "Aitor Cayón Ruano", "Lidia Concepción Echevarría","Elena Kaloyanova Popova", "Fernándo Pérez Gutiérrez","Germán Franco Dorca"];
            var playerOut = ["Javier Berdecio Trigueros","Yu Liu","Juan Ramón del Caño Vega"];
            var playerInOut = [];
            
            function checkReset(){
                playerIn = ["Pedro David Gonzalez", "Javier Cortes Tejada", "Javier Anton Alonso", "Biel Selles Salvás", "Aitor Cayón Ruano", "Lidia Concepción Echevarría","Elena Kaloyanova Popova", "Fernándo Pérez Gutiérrez","Germán Franco Dorca"];
                playerOut = ["Javier Berdecio Trigueros","Yu Liu","Juan Ramón del Caño Vega"];
                playerInOut = [];
                addToVector('in', playerIn);
                addToVector('out', playerOut);
                addToVector('inout', playerInOut);
            };

            function addToVector(id, vector){
                $("#" + id + "_token").empty();
                switch(id){
                    case IN:
                    $("#" + id + "_token").append('Fichas activas ' + '(' + playerIn.length + '/40)');
                    break;
                    case OUT:
                    $("#" + id + "_token").append('Fichas no activas ' + '(' + playerOut.length + '/40)');
                    break;
                    case INOUT:
                    $("#" + id + "_token").append('Cambios en la plantilla: ' + playerInOut.length);
                    break;
                }
                


                $("#" + id).empty();
                vector.sort();
                if(vector.length==0){
                    let name = $('<li class="list-group-flush text-center text">(no hay elementos disponibles)</li>');
                    $("#" + id).append(name);

                }
                for(i=0; i<vector.length; i++){
                    let index = vector[i].indexOf('×');
                    let data = vector[i];
                    if(index!==-1){
                        data = vector[i].substring(0,index-1);
                        vector[i] = data;
                    }
                    let name = $('<li class="list-group-item" >' + data + 
                        '<button type="button" class="close" aria-label="Close"> <span aria-hidden="true">&times;</span></button>' +"</li>");

                    if(id==='inout'){
                       name = $('<li class="list-group-item" style="color: red;">' + data + 
                        '<button type="button" class="close" aria-label="Close"> <span aria-hidden="true">&times;</span></button>' +"</li>"); 
                    }
                    
                    //let name = checkInfo(playerInOut, i);
                    $("#" + id).append(name);
                    name.click(function(o) {
                      replacePlayer(this, id);
=======
            var playerIn = ["Pedro David Gonzalez", "Javier Cortes Tejada", "Javier Anton Alonso", "Biel Selles Salvás"];
            var playerOut = [];
            var playerInOut = [];
            
            function render(id, array, id2, target) {
              $("#" + id).empty();

              for(let index = 0; index < array.length; index++) {
                let name = $("<li>" + array[index] +"</li>");
                
                
                $("#" + id).append(name);
                name.click(function(o) {
                  move(this, id, array, target);
                })
              }
            }
            
            function move(name, id, src, target) {
                //elimina el elemento de la lista
              let x = $(name).text();
               const i = src.indexOf(x);
              if (i === -1) return;
              src.splice(i, 1);
              
              if(target === undefined){
                let indexA = playerIn.indexOf(x);
                if(indexA === -1){
                    playerOut.splice(playerOut.indexOf(x), 1);
                    target = playerIn;
                }else{//esta en in
                  playerIn.splice(indexA, 1);
                  target = playerOut; 
                }
              }
              else if(playerInOut.indexOf(x)===-1){
                playerInOut.push(x);
              }else{
                playerInOut.splice(x.indexOf(x), 1);
              }
              target.push(x);
              regen();
            }

            function regen() {
              render("IN", playerIn, 'OUT', playerOut);
              render("OUT", playerOut, 'IN', playerIn);
              render("INOUT", playerInOut);
            }

            function addPlayerIn(){
                $("#IN").empty();
                for(i=0; i<playerIn.length; i++){
                    let name = $("<li>" + playerIn[i] +"</li>");
                    $("#IN").append(name);
                    name.click(function(o) {
                      replacePlayer(this, 'in', 'out');
                    });
                }
            };

            function addPlayerOut(){
                $("#OUT").empty();
                for(i=0; i<playerOut.length; i++){
                    let name = $("<li>" + playerOut[i] +"</li>");
                    $("#OUT").append(name);
                    name.click(function(o) {
                      replacePlayer(this, 'out', 'in');
                    });
                }
            };

            function addPlayerInOut(){
                $("#INOUT").empty();
                for(i=0; i<playerInOut.length; i++){
                    let name = $("<li>" + playerInOut[i]+"</li>");
                    $("#INOUT").append(name);
                    name.click(function(o) {
                      replacePlayer(this, 'inout', 'both');
>>>>>>> 961d4ac2948143026125d8b139ba2a7774bbb243
                    });
                }
            };

<<<<<<< HEAD
            function replacePlayer(name, origin){
                console.clear();
                let x = $(name).text();
                console.log(x);
                console.log(x.indexOf('×'));
                x=x.substring(0,x.indexOf('×')-1);
                console.log(x);
=======
            function replacePlayer(name, origin, destiny){
                console.clear();
                let x = $(name).text();
                console.log(x);
>>>>>>> 961d4ac2948143026125d8b139ba2a7774bbb243
                if(origin==='in'){
                    console.log('click en in');
                    var index = playerInOut.indexOf(x);
                    if(index===-1){
<<<<<<< HEAD
=======
                        console.log('no esta en inout');
                        console.log('in --> out');
                        console.log('in --> inout');
>>>>>>> 961d4ac2948143026125d8b139ba2a7774bbb243
                        var pos = playerIn.indexOf(x);
                        playerIn.splice(pos,1);
                        playerInOut.push(x);
                        playerOut.push(x);
                    }else{
<<<<<<< HEAD
=======
                        console.log('esta en inout');
                        console.log('in --> out');
                        console.log('inout --> out');
>>>>>>> 961d4ac2948143026125d8b139ba2a7774bbb243
                        var pos = playerIn.indexOf(x);
                        playerIn.splice(pos,1);
                        var pos = playerInOut.indexOf(x);
                        playerInOut.splice(pos,1);
                        playerOut.push(x);
<<<<<<< HEAD
=======

>>>>>>> 961d4ac2948143026125d8b139ba2a7774bbb243
                    }
                }else if(origin==='out'){
                    console.log('click en out');
                    var index = playerInOut.indexOf(x);
                    if(index===-1){
<<<<<<< HEAD
                        var pos = playerOut.indexOf(x);
                        playerOut.splice(pos,1);
                        playerInOut.push(x);
                        playerIn.push(x);
                    }else{
=======
                        console.log('no esta en inout');
                        console.log('out --> in');
                        console.log('out --> inout');
                        var pos = playerOut.indexOf(x);
                        playerOut.splice(pos,1);
                        playerInOut.push(x);
                        playerOut.push(x);
                    }else{
                        console.log('esta en inout');
                        console.log('out --> in');
                        console.log('inout --> in');
>>>>>>> 961d4ac2948143026125d8b139ba2a7774bbb243
                        var pos = playerOut.indexOf(x);
                        playerOut.splice(pos,1);
                        var pos = playerInOut.indexOf(x);
                        playerInOut.splice(pos,1);
                        playerIn.push(x);
                    }
                }else if(origin==='inout'){
                    console.log('click en inout');
                    var index = playerIn.indexOf(x);
                    if(index===-1){
<<<<<<< HEAD
=======
                        console.log('esta en out');
                        console.log('out --> in');
                        console.log('inout --> in');
>>>>>>> 961d4ac2948143026125d8b139ba2a7774bbb243
                        var pos = playerOut.indexOf(x);
                        playerOut.splice(pos,1);
                        var pos = playerInOut.indexOf(x);
                        playerInOut.splice(pos,1);
                        playerIn.push(x);
<<<<<<< HEAD

                    }else{
=======
                    }else{
                        console.log('esta en in');
                        console.log('in --> out');
                        console.log('inout --> out');
>>>>>>> 961d4ac2948143026125d8b139ba2a7774bbb243
                        var pos = playerIn.indexOf(x);
                        playerIn.splice(pos,1);
                        var pos = playerInOut.indexOf(x);
                        playerInOut.splice(pos,1);
                        playerOut.push(x);
                    }
                }
                launch();
            };

            function launch(){
<<<<<<< HEAD
                //addPlayerIn();
                //addPlayerOut();
                //addPlayerInOut();
                addToVector('in', playerIn);
                addToVector('out', playerOut);
                addToVector('inout', playerInOut);
            };
            launch();
                
        </script>
=======
                addPlayerIn();
                addPlayerOut();
                addPlayerInOut();
            };
            launch();
                
        </script>
>>>>>>> 961d4ac2948143026125d8b139ba2a7774bbb243
