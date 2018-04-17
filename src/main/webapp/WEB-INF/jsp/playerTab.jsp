<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>

<script src = "static/js/playerTab.js"></script>

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

        <!--<div class="container" class="confirm_button">
            <button onClick="addPlayer()" >Add</button>
            <button onClick="rmPlayer()" >Remove</button>
            <button onClick="confirmTabs()" >Confirm</button>
        </div>-->

        <!--git reset --hard <commit> 
-->

        <script>
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
                    });
                }
            };

            function replacePlayer(name, origin){
                console.clear();
                let x = $(name).text();
                console.log(x);
                console.log(x.indexOf('×'));
                x=x.substring(0,x.indexOf('×')-1);
                console.log(x);
                if(origin==='in'){
                    console.log('click en in');
                    var index = playerInOut.indexOf(x);
                    if(index===-1){
                        var pos = playerIn.indexOf(x);
                        playerIn.splice(pos,1);
                        playerInOut.push(x);
                        playerOut.push(x);
                    }else{
                        var pos = playerIn.indexOf(x);
                        playerIn.splice(pos,1);
                        var pos = playerInOut.indexOf(x);
                        playerInOut.splice(pos,1);
                        playerOut.push(x);
                    }
                }else if(origin==='out'){
                    console.log('click en out');
                    var index = playerInOut.indexOf(x);
                    if(index===-1){
                        var pos = playerOut.indexOf(x);
                        playerOut.splice(pos,1);
                        playerInOut.push(x);
                        playerIn.push(x);
                    }else{
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
                        var pos = playerOut.indexOf(x);
                        playerOut.splice(pos,1);
                        var pos = playerInOut.indexOf(x);
                        playerInOut.splice(pos,1);
                        playerIn.push(x);

                    }else{
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
                //addPlayerIn();
                //addPlayerOut();
                //addPlayerInOut();
                addToVector('in', playerIn);
                addToVector('out', playerOut);
                addToVector('inout', playerInOut);
            };
            launch();
                
        </script>