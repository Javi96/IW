<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	

<%@ include file="../jspf/header.jspf"%>
<link type="text/css" media="screen" rel="stylesheet" href="${s}/css/home.css" />

<div class = "container">
	<nav class="container navbar navbar-default" role="navigation" id="menu">
		<div class="collapse navbar-collapse navbar-ex1-collapse">
    		<ul class="nav nav-justified" id="contenidomenu">
    		 	<li class="dropdown resalte lead">
					<a class="dropdown-toggle" data-toggle="dropdown">Tú</a>
					<ul class="dropdown-menu" role="menu">
						<li><a  href="">Reservar pista</a></li>
						<li><a  href="/calendarPrueba">Horario deportivo</a></li>
						<li><a  href="">Otros deportes</a></li>
					</ul>
				</li>
       			<li class="dropdown-resalte lead"><a href="/team">Rugby Fisicas</a></li>
    		</ul>
    	</div>	
	</nav>
	
	<div class="jumbotron">
    	<div class="row">
	        <div class="col-md-4 col-xs-12 col-sm-6 col-lg-4">
	             <img id = "logoEquipo" src="${s}/img/rugbyFisicas.jpeg" alt="stack photo" class="img">
	        </div>
         	<div id = "teamInfo" class="col-md-8 col-xs-12 col-sm-6 col-lg-8">
	            <div id = "teamName">
	               <h2>${team.name}</h2>
	            </div>
	            <ul class="container details teamInfoStyle">
	               <li><p><span class="glyphicon glyphicon-calendar one space" ></span> Entrenamientos: ${team.trainingSchedule} </p></li>
	               <li><p><span class="glyphicon glyphicon-calendar one space" ></span> Siguiente partido: ${team.nextMatchSchedule} </p></li>
	               <li><p><span class="glyphicon glyphicon-map-marker one space"></span> Instalaciones: ${team.nextMatchFacilities} </p></li>
	               <li><p><span class="glyphicon glyphicon-user one space"></span>Delegado: ${team.deputy}</p></li>
	            </ul>
	            <div>
	            	<form action = "/contact" method="get" class="btn-group teamButtonsStyle">
						<button type="submit" class="btn btn-primary">Contactar delegado</button>
						<input type='hidden' name='team' value=${team.id}\>
						<input type='hidden' name='delegated' value=${team.debuty}\>
					</form>
					<form action = "/joinTeam" method="get"  class="btn-group teamButtonsStyle">
						<button type="submit" class="btn btn-primary">Enviar solicitud</button>
						<input type='hidden' name='team' value=${team.id}\>
					</form>
					<form action = "/gallery" method="get"  class="btn-group teamButtonsStyle">
						<button type="submit" class="btn btn-primary">Ver fotos</button>
					</form>
					<form action = "/classification" method="get" class="btn-group teamButtonsStyle">
						<button type="submit" class="btn btn-primary">Ver clasificacion</button>
					</form>
				</div>
        	</div>
    	</div>
	</div>
</div>
<%@ include file="../jspf/footer.jspf"%>
