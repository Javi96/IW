<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>

<div class = "container">
	<form class = "form-horizontal" name = "league" method="POST" action = "/addLeague">
		<!-- Form Name -->
		<h1 class = "col-sm-12 text-center">Crear liga de deporte</h1>
		
		<div class="form-group">
			<label class="col-md-4 control-label" >Nombre deporte:</label>
			<div class="col-md-4">
				<input  name = "sport" type="text" class = "from-control-text">
			</div>
		</div>
		    
		<div class="form-group">
			<label class="col-md-4 control-label" >Nombre liga:</label>
			<div class="col-md-4">
				<input id = "sport" name = "sport" type="text" class = "from-control">
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-md-4 control-label" >Categoria:</label>
			<div class="col-md-4">
				<input id = "sport" name = "gender" type="Radio" class = "from-control">Masculino
				<input id = "sport" name = "gender" type="Radio" class = "from-control">Femenino
			</div>
		</div>
		
		<div class="col-sm-12 text-center">
			<button type="submit" class="btn btn-success " id = "newTeamButton" >Success</button>
		</div>
		
	</form>
</div>

<%@ include file="../jspf/footer.jspf"%>
