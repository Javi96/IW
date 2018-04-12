<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>
<link type="text/css" media="screen" rel="stylesheet" href="${s}/css/actas.css" />

<div class="container">

	<h1 class = "redColor" >Firma de actas</h1>

    <form action = "/delegatedTeam" method="get" class="form-area"  id = "centrado"> 
    
  			<div class="form-group">
   				<label> Equipo local:</label>
				<input class="form-control" id="nameLocal"type="text">
			</div>
			<div class="form-group">
				<label> Puntos local:</label>
				<input class="form-control" id="pointLocal"type="text">
			</div>
			<div class="form-group">
				<label> Equipo visitante:</label>
				<input class="form-control" id="nameVisti" type="text">
			</div>
			<div class="form-group">
				<label> Puntos local:</label>
				<input class="form-control" id="pointsVisi" type="text">
			</div>
					
            	<button  type="submit" class="btn btn-primary pull-right">Enviar</button>
    </form>
	
</div>

<%@ include file="../jspf/footer.jspf"%>
