<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	

<%@ include file="../jspf/header.jspf"%>
<link type="text/css" media="screen" rel="stylesheet" href="${s}/css/home.css" />
<link type="text/css" media="screen" rel="stylesheet" href="${s}/css/team.css" />

<div class = "container">
	<h1 class = "redColor" >Bienvenido a U-SPORTS</h1>
	<nav class="container navbar navbar-default" role="navigation"  >
		<div class="collapse navbar-collapse navbar-ex1-collapse">
    		<ul class="nav nav-justified">
    		 	<li class="dropdown resalte lead">
					<a title="UCM" href="" class="dropdown-toggle" data-toggle="dropdown">Tu</a>
					<ul class="dropdown-menu" role="menu">
						<li><a  href="">Reservar pista</a></li>
						<li><a  href="">Horario deportivo</a></li>
						<li><a  href="">Otros deportes</a></li>
					</ul>
				</li>
       			<li><a href="/basicTeam">Rugby Fisicas</a></li>
       			<li></li>
       			<li></li>
    		</ul>
    	</div>	
	</nav>
	
	
<script>
	
	function sent(){
		window.open("/contact");
	}
	
	function request(){
		window.open("/request");
	}
	
	function classification(){
		window.open("/classification");
	}
</script>

<div class="starter-template">

	<h1>BÁSICO</h1>
	
	
	<div class="photoData">
	
		<img id = "ucmFoto" src="${s}/img/ucmFoto.jpg">
		
		<ul class="lista">
			<li> Nombre: Rugby Fisicas </li>
			<li> Horario: </li>
			<li> Calificación: </li>
		</ul>
	</div>
	
	
	<div>
		<ul class="botones">
			<li>
				<button type="submit" onClick = "sent()"> Contactar Delegado</button>
			 </li>
			 
			 <li>
				<button type="submit" onClick = "request()"> Enviar solicitud</button>
			 </li>
			 
			 <li>
				<button type="submit"> Fotos equipo</button>
			 </li>
			 
			 <li>
				<button type="submit" onClick = "classification()"> Ver liga</button>
			 </li>
		</ul>
		
	</div>
		
</div>
</div>
<%@ include file="../jspf/footer.jspf"%>
