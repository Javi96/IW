<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>
<link type="text/css" media="screen" rel="stylesheet" href="${s}/css/playerTab.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!--<script src = "${s}/js/playerTab.js"></script>-->


 <div class="container" id="tabs">

     <h1 id="inout_token" class="changesMix"></h1>

     <div class="playerslist" > 	<!-- lista norte  -->
             <ul id="inout" class="list-group list-group-flush"></ul> 
     </div> 
     
     <div class="left_container">
         <h1 id="in_token" class="changesIn"></h1>
         <h1 id="out_token" class="changesOut"></h1>
     </div>
     <div class="left_container">
         <div class="playertabin">	<!-- lista oeste -->
             <ul id="in" class="list-group list-group-flush">
             
             	<c:forEach items="${team.noActivePlayers}" var="player">
             		
             		<li class="list-group-item">
          
             			${player.name}
             			<button type="button" class="close" aria-label="Close"> 
             				<span aria-hidden="true">&times;</span>
             			</button>
             		</li>
				</c:forEach>
				
             </ul> 
         </div>
         <div class="playertabout">	<!-- lista este -->
             <ul id="out" class="list-group list-group-flush"></ul> 
         </div>
     </div>

     <div style="float: right">
         <button class="btn btn-warning" id="btnReset" type="reset">Eliminar modificaciones</button>
         <input id = "delete" name = "delete" type="checkbox" class="hidden" />
         
         <button class="btn btn-success" id="btnSave" type="submit">Guardar cambios</button>
         
        <!--  
        <form action="/savePlayerTab" method="post" >
	        	<button class="btn btn-success" id="btnSave" type="submit">Guardar cambios</button>
	        	<input id = "save" name = "save" type="checkbox" class="hidden" />
         </form>
         -->
     </div>

 </div>
        
<%@ include file="../jspf/footer.jspf"%>

