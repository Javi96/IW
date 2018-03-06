<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>

<link type="text/css" media="screen" rel="stylesheet" href="${s}/css/team.css" />

 <script>
	
	function sent(){
		window.close();
	}
	
</script>
	
<div class="starter-template">

	<h1>Enviar solicitud</h1>
	
	<div class="centrado">
	
		<form  method="post" action="/basicTeam">
			<label> Nombre: </label>
		  	<input type="text" name="nombre" autocomplete="off"  placeholder="nombre">
		  	
		  	<label> DNI: </label>
		  	<input type="text" name="dni" autocomplete="off"  placeholder="DNI">
		</form>
		
	</div>	
	
	<div class="actas">
		<button onClick = "sent()" type="submit"> Enviar</button>
	</div>	
	
</div>

<%@ include file="../jspf/footer.jspf"%>
