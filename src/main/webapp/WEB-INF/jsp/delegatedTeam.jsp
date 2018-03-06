<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>

<link type="text/css" media="screen" rel="stylesheet" href="${s}/css/team.css" />

<script>
	
	function contactar(){
		window.open("/contact");
	}
	
	function actas(){
		window.open("/actas");
	}
	
</script>

<div class="starter-template">
	<h1>DELEGADO</h1>
	
	<div  class="photoData">
	
		<img id = "ucmFoto" src="${s}/img/ucmFoto.jpg">
		
			<ul class="lista">
				<li> Nombre: </li>
				<li> Horario: </li>
				<li> Calificación: </li>
				<li> Correo: <li>
			</ul>
		
	</div>
	
	
	<div>
		<ul class="botones">
			<li>
				<button type="submit" onClick = "contactar()"> Contactar Delegado</button>
			 </li>
			 
			 <li>
				<button type="submit" onClick = "actas()" > Firmar actas</button>
			 </li>
				 
			<li>
				<button type="submit"> Gestionar fichas</button>
			</li>
			
			<li>
				<button type="submit"> Fotos equipo</button>
			</li>
			
			<li>
				<button type="submit"> Ver liga</button>
			</li>
		</ul>
	</div>
	
</div>

<%@ include file="../jspf/footer.jspf"%>
