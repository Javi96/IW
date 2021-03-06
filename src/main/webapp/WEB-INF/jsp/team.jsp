<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>
<script>
	var teamId = ${team.id};
	var isUserDeputy = ${team.deputy.id == user.id ? "true" : "false"};
	var belong = false;
	<c:forEach items="${team.activePlayers}" var="player">
    	if(${player.id == user.id}){
    		belong = true;
    	};
	</c:forEach>
	
   	if(!belong){
		<c:forEach items="${team.nonActivePlayers}" var="player">
		if(${player.id == user.id}){
			belong = true;
		};
		</c:forEach>
   	}
   	
</script>
<script src="${s}/js/team.js"></script>

<link type="text/css" media="screen" rel="stylesheet" href="${s}/css/team.css" />
<div class = "container">
	<div class="jumbotron">
    	<div class="row">
	        <div class="col-md-4 col-xs-12 col-sm-6 col-lg-4 form-group">
	        	<!-- 
	             	<img id = "logoEquipo" src="${s}/img/${team.id}/${foto}" alt="stack photo" class="img">
	             -->
	             <img id = "logoEquipo" src="${s}/img/rugbyFisicas.jpeg" alt="stack photo" class="img">
	        </div>
         	<div id = "teamInfo" class="col-md-8 col-xs-12 col-sm-6 col-lg-8">
	            <div id = "teamName">
	               <h2>${team.name} - ${team.category}</h2>
	            </div>
	            <ul class="container details teamInfoStyle">
	               <li><p><span class="glyphicon glyphicon-calendar one space" ></span> Entrenamientos: ${team.trainingSchedule} </p></li>
	               <li><p><span class="glyphicon glyphicon-calendar one space" ></span> Siguiente partido: ${team.nextMatchSchedule} </p></li>
	               <li><p><span class="glyphicon glyphicon-map-marker one space"></span> Instalaciones: ${team.nextMatchFacilities} </p></li>
	               <li><p><span class="glyphicon glyphicon-user one space"></span>Delegado: ${team.deputy.name}</p></li>
	               <li><p><span class="glyphicon glyphicon-user one space"></span>Descripcion: ${team.description}</p></li>
	            </ul>
	            <div>
	            	<c:if test = "${logged}">
		            	<form action = "/contact" method="get" class="btn-group teamButtonsStyle" id = "contact">
							<button type="submit" class="btn btn-primary">Contactar delegado</button>
							<input type="hidden" name = "id" value="${team.id}">
						</form>

						<form action = "/joinTeam" method="get"  class="btn-group teamButtonsStyle" id = "joinTeam">
							<button type="submit" class="btn btn-primary">Enviar solicitud</button>
							<input type="hidden" name = "id" value="${team.id}">
						</form>
					</c:if>
					<form action = "/gallery" method="get"  class="btn-group teamButtonsStyle" id = "gallery">
						<button type="submit" class="btn btn-primary">Galeria</button>
						<input type="hidden" name = "team" value="${team.id}">
					</form>
					<form action = "/ranking" method="get" class="btn-group teamButtonsStyle" id = "ranking">
						<button type="submit" class="btn btn-primary">Ver clasificacion</button>
						<input type="hidden" name = "sport" value="${team.sport}">
					</form>
					<div class="btn-group teamButtonsStyle" id = "matchRecord">
						<button type="button"  data-toggle="modal" data-target="#matchList"
						class="btn btn-primary">Firmar actas</button>
					</div>

					<form action = "/playerTab" method="get"  class="btn-group teamButtonsStyle" id = "playerTab">
						<button type="submit" class="btn btn-primary">Gestionar fichas</button>
						<input type="hidden" name = "id" value="${team.id}">
					</form>
					<div class="btn-group teamButtonsStyle" id = "playersRequests">
						<button type="submit" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalLong">Gestionar Ingresos</button>
						<input type="hidden" name = "id" value="${team.id}">
					</div>
					
					<div class="btn-group teamButtonsStyle" id = "deputyPower">
						<button id = "deputyPowerBtn" type="button" data-toggle="modal" data-target="#teamModalInfo" class="btn btn-primary">Modificar información</button>
					</div>
				</div>
        	</div>
    	</div>
	</div>

	<!-- Modal matchRecord-->
	<div class="modal fade" id="matchList"  role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-centered" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title">Gestionar actas de ${team.name}</h5>
	            </div>
	            <div class="modal-body">
	                <div class = "modal-title text-center">
	                	<h5>Partidos disputados</h5>
	                <hr></hr>
	                <div class="list-group">
	              
	                   <c:forEach items="${team.awayMatches}" var="match">
		                   <li class="list-group-item"  id = "${match.id}">
								<input class="inputSportAdmin all pull-center listStyle" type="submit" 
								value ="${match.homeTeam.name} vs ${match.awayTeam.name}" readonly/>
								<button id = "a${match.id}" onclick = "getMatch(${team.id}, ${match.id})" type="button" class="btn-danger" data-toggle="modal"
								 	data-target="#matchRecordModal">Firmar 
								</button>
						   </li>
						   <c:if test="${match.recordChecked}">
						   		<script>
						   			var mId = ${match.id};
						   			$("#"+mId).css("background-color","#0CAA41");
						   			$("#a"+mId).text('Resultado').button("refresh");
						   		</script>
						   </c:if>
	                   </c:forEach>
	                   
	                   <c:forEach items="${team.homeMatches}" var="match">
		               		<li class="list-group-item"  id = "${match.id}">
								<input class="inputSportAdmin all pull-center listStyle" type="submit" 
								value ="${match.homeTeam.name} vs ${match.awayTeam.name}" readonly/>
								<button id = "a${match.id}" onclick = "getMatch(${team.id}, ${match.id})" type="button" class="btn-danger" data-toggle="modal"
								 	data-target="#matchRecordModal">Firmar
								</button>
							</li>
							<c:if test="${match.recordChecked}">
						   		<script>
						   			var mId = ${match.id};	
						   			$("#"+mId).css("background-color","#0CAA41");
						   			$("#a"+mId).text('Resultado').button("refresh");
						   		</script>
						   </c:if>
	                   </c:forEach>
	                   
	                </div>
	            </div>
				<div class="modal-footer">
				    <div class="form-group">
				        <div>
				            <button onclick="reload()" type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				            <script type="text/javascript"> function reload() {location.reload();}</script>
				        </div>
				    </div>
				</div>
	        </div>
	    </div>
	</div>
	</div>
	<!-- Modal Match Record -->
	<div class="modal fade" id="matchRecordModal" role="dialog">
	    <div class="modal-dialog modal-dialog-centered" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title"></h5>
	            </div>
	            <div class="modal-body">
	                <div class="centerDivs">
	                    <div class="col-md-4" id="homeTeamName"></div>
	                    <div class="col-md-1">vs</div>
	                    <div class="col-md-4" id="awayTeamName"></div>
	                </div>
	                
	                <div id ="info" >
	                
	                	<div class="row">
				        	<div class="col-md-4 col-md-offset-2 text-center ">
					            <button type="button" onClick="invalidatePetition()" id="invalidatePetition" class="btn btn-success preview-add-button"><span class="glyphicon glyphicon-send"></span>
					            Solicitar Invalidar</button>
					        </div>  
					        <div class="col-md-4 text-center ">
					            <form action = "/contact" method="get" id = "deputyContact">
									<button type="submit" class="btn btn-primary" onclick="setIdContact()">Contactar delegado</button>
									<input type="hidden" name = "id" id="teamIdForDep">
								</form>
					         </div>   
					        
				    	</div>		
	                </div>
	                
	                <hr></hr>
	                <div class="centerDivs">
	                    <div id="homeTeamDiv">
	                       <input class="form-control" id = "homeTeamPoints" type="number" placeholder="Puntos equipo local">
	                    </div>
	                    <div id = "hyphen">-</div>
	                    <div id="awayTeamDiv">
	                        <input class="form-control" id = "awayTeamPoints" type="number" placeholder="Puntos equipo visitante">
	                    </div>
	                </div>
	            </div>
				<div class="modal-footer">
				    <div class="form-group">
				        <div class="col-sm-12 text-center ">
				            <button type="button" onClick="addMatchRecord()" id="sendMatchRecord" class="btn btn-success preview-add-button"><span class="glyphicon glyphicon-send"></span>
				            Enviar Acta</button>
				            <button type="button" class="btn btn-danger" id="closeRequestMatchModal">Close</button>
				        </div>
				    </div>
				</div>
	        </div>
	    </div>

	</div>
	

		<!-- Modal players requests-->
	<div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="exampleModalLongTitle">Solicitudes de ingreso a ${team.name}</h5>
	            </div>
	            <div class="modal-body" id = "modalRequest">
	            	<c:if test="${empty team.requests}">
	            		<h4>No hay solicitudes</h4>
	            	</c:if>
	                <c:forEach items="${team.requests}" var="request">
	                	<div id = "a${request.id}">
		                    <div class="row">
		                        <div class="col-md-4 col-md-offset-1 text-right">
		                            <h4>Nombre:</h4>
		                        </div>
		                        <div class="col-md-5 col-md-offset-right-1">
		                            <h4>${request.user.name}</h4>
		                        </div>
		                    </div>
		                    <div class="row">
		                        <div class="col-md-4 col-md-offset-1 text-right">
		                            <h4>Dni:</h4>
		                        </div>
		                        <div class="col-md-5 col-md-offset-right-1">
		                            <h4>${request.user.idCard}</h4>
		                        </div>
		                    </div>
		                    <div class="row">
		                        <div class="col-sm-12 text-center">
		                            <button type="button" onclick='acceptNewPlayer(${request.id})' class="btn btn-success">Aceptar</button>
		                            <button type="button" onclick='deleteRequestPlayer(${request.id})' class="btn btn-warning">Rechazar</button>
		                        </div>
		                    </div>
		                    <hr></hr>
	                    </div>
	                </c:forEach>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	            </div>
	        </div>
	    </div>
	</div>

	
	
	<!-- Modal change team info -->
	<div class="modal fade" id="teamModalInfo" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLongTitle">Modificar informacion del equipo</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        
	        <div class="row">
               <div class="col-md-4 col-md-offset-2 text-left">
                   <h4>Entrenamientos:</h4>
               </div>
               <div class="col-md-5 col-md-offset-right-2">
                   <input type=text id="trainingSchedule">
               </div>
           </div>
           
           <div class="row">
               <div class="col-md-4 col-md-offset-2 text-left">
                   <h4>Siguiente partido:</h4>
               </div>
               <div class="col-md-5 col-md-offset-right-2">
                   <input type=text id="nextMatchSchedule">
               </div>
           </div>
           <div class="row">
               <div class="col-md-4 col-md-offset-2 text-left">
                   <h4>Instalaciones:</h4>
               </div>
               <div class="col-md-5 col-md-offset-right-2">
                   <input type=text id="nextMatchFacilities">
               </div>
           </div>
           
           <div class="row">
               <div class="col-md-4 col-md-offset-2 text-left">
                   <h4>Descripcion:</h4>
               </div>
               <div class="col-md-5 col-md-offset-right-2">
					<textarea id="description" rows="4" cols="20" name="description"></textarea>
               </div>
           </div>
           
	      <div class="modal-footer">
	        <button type="button" class="btn btn-success" onclick='changeTeamInfo(${team.id})'>Guardar cambios</button>
	        <button type="button" class="btn btn-danger" id = "closeChangeInfo" data-dismiss="modal">Cerrar</button>
	      </div>
	    </div>
	  </div>
	</div>
</div>
</div>



<%@ include file="../jspf/footer.jspf"%>
