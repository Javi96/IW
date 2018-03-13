<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>

<link type="text/css" media="screen" rel="stylesheet" href="${s}/css/home.css" />
<div class = "container">
	<div class="jumbotron">
    	<div class="row">
	        <div class="col-md-4 col-xs-12 col-sm-6 col-lg-4">
	             <img id = "logoEquipo" src="${s}/img/rugbyFisicas.jpeg" alt="stack photo" class="img">
	        </div>
         	<div id = "teamInfo" class="col-md-8 col-xs-12 col-sm-6 col-lg-8">
	            <div id = "teamName">
	               <h2>Rugby Fisicas</h2>
	            </div>
	            <ul class="container details teamInfoStyle">
	               <li><p><span class="glyphicon glyphicon-calendar one space" ></span>Entrenamientos: Lunes y Miercoles / 14:00 - 15:30 h </p></li>
	               <li><p><span class="glyphicon glyphicon-calendar one space" ></span>Siguiente partido: Viernes / 13:30 - 15:30</p></li>
	               <li><p><span class="glyphicon glyphicon-map-marker one space"></span>Instalaciones: Paraninfo Norte</p></li>
	               <li><p><span class="glyphicon glyphicon-user one space"></span>Delegado: Juan Antonio</p></li>
	            </ul>
	            <div class="btn-group teamButtonsStyle">
					<button type="button" class="btn btn-primary">Contactar delegado</button>
					<button type="button" class="btn btn-primary">Enviar solicitud</button>
					<button type="button" class="btn btn-primary">Ver fotos</button>
					<button type="button" class="btn btn-primary">Ver clasificacion</button>
				</div>
        	</div>
    	</div>
	</div>
</div>

<%@ include file="../jspf/footer.jspf"%>
