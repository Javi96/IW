<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>
<script>

	var isUserDeputy = ${team.deputy.id == user.id ? "true" : "false"};
	var belong = false;
	console.log("El id del user es" + ${user.id});
	<c:forEach items="${team.players}" var="player">
    	if(${player.id == user.id}){
    		belong = true;
    	};

	</c:forEach>

</script>
<script src="${s}/js/team.js"></script>

<link type="text/css" media="screen" rel="stylesheet" href="${s}/css/team.css" />
<div class = "container">
	<div class="jumbotron">
    	<div class="row">
	        <div class="col-md-4 col-xs-12 col-sm-6 col-lg-4">
	             <img id = "logoEquipo" src="${s}/img/rugbyFisicas.jpeg" alt="stack photo" class="img">
	        </div>
         	<div id = "teamInfo" class="col-md-8 col-xs-12 col-sm-6 col-lg-8">
	            <div id = "teamName">
	               <h2>${team.name} - ${team.category}</h2>
	            </div>
	            <ul class="container details teamInfoStyle">
	               <li><p><span class="glyphicon glyphicon-calendar one space" ></span> Entrenamientos: ${team.training_schedule} </p></li>
	               <li><p><span class="glyphicon glyphicon-calendar one space" ></span> Siguiente partido: ${team.next_match_schedule} </p></li>
	               <li><p><span class="glyphicon glyphicon-map-marker one space"></span> Instalaciones: ${team.next_match_facilities} </p></li>
	               <li><p><span class="glyphicon glyphicon-user one space"></span>Delegado: ${team.deputy.name}</p></li>
	            </ul>
	            <div >
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
					<form action = "/gallery_good" method="get"  class="btn-group teamButtonsStyle" id = "gallery">
						<button type="submit" class="btn btn-primary">Galeria</button>
					</form>
					<form action = "/ranking" method="get" class="btn-group teamButtonsStyle" id = "ranking">
						<button type="submit" class="btn btn-primary">Ver clasificacion</button>
						<input type="hidden" name = "sport" value="${team.sport}">
					</form>
					<form action = "/matchRecord" method="get"  class="btn-group teamButtonsStyle" id = "matchRecord">
						<button type="submit" class="btn btn-primary">Firmar actas</button>
						<input type="hidden" name = "id" value="${team.id}">
					</form>
					<form action = "/playerTab" method="get"  class="btn-group teamButtonsStyle" id = "playerTab">
						<button type="submit" class="btn btn-primary">Gestionar fichas</button>
						<input type="hidden" name = "id" value="${team.id}">
					</form>
				</div>
        	</div>
    	</div>
	</div>
</div>

<%@ include file="../jspf/footer.jspf"%>
