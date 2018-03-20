<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>

<script src = "static/js/playerTab.js"></script>

<style>
            .container{
                align-self: center;
            }
            .playerslist {
            border: 1px solid red;
            }
            .playertabout {
            border: 1px solid red;
            float: right;
            width: 40%;
        }   
        .changesIn{
            border: 1px solid red;


        }
        .changesOut{
            border: 1px solid red;

        }
        .changesMix{
            border: 1px solid red;

        }
            .playertabin {
            border: 1px solid red;
            float: left;
            width: 40%;
            }
            .cabeceraInOut{
            }
            li{
            cursor:pointer;
            padding: 6px;
            color: red;
            }
            li:hover{
            color:blue;
            }
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

        <!--<div class="container" class="confirm_button">
            <button onClick="addPlayer()" >Add</button>
            <button onClick="rmPlayer()" >Remove</button>
            <button onClick="confirmTabs()" >Confirm</button>
        </div>-->

        <!--git reset --hard <commit> 
-->

        <script>
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
                    });
                }
            };

            function replacePlayer(name, origin, destiny){
                console.clear();
                let x = $(name).text();
                console.log(x);
                if(origin==='in'){
                    console.log('click en in');
                    var index = playerInOut.indexOf(x);
                    if(index===-1){
                        console.log('no esta en inout');
                        console.log('in --> out');
                        console.log('in --> inout');
                        var pos = playerIn.indexOf(x);
                        playerIn.splice(pos,1);
                        playerInOut.push(x);
                        playerOut.push(x);
                    }else{
                        console.log('esta en inout');
                        console.log('in --> out');
                        console.log('inout --> out');
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
                        console.log('esta en out');
                        console.log('out --> in');
                        console.log('inout --> in');
                        var pos = playerOut.indexOf(x);
                        playerOut.splice(pos,1);
                        var pos = playerInOut.indexOf(x);
                        playerInOut.splice(pos,1);
                        playerIn.push(x);
                    }else{
                        console.log('esta en in');
                        console.log('in --> out');
                        console.log('inout --> out');
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
                addPlayerIn();
                addPlayerOut();
                addPlayerInOut();
            };
            launch();
                
        </script>
