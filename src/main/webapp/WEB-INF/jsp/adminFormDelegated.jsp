<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>

<div class = "container">
	<form class = "form-horizontal" name = "team" method="POST" action = "/addDelegated">
		<!-- Form Name -->
		<h1 class = "col-sm-12 text-center">Crear delegado de equipo</h1>
		
		<div class="form-group">
			<label class="col-md-4 control-label" >Nombre delegado:</label>
			<div class="col-md-4">
				<input id = "teamName" name = "name" type="text" class = "from-control-text">
			</div>
		</div>
		    
		<div class="form-group">
			<label class="col-md-4 control-label" >Nombre equipo:</label>
			<div class="col-md-4">
				<input id = "sport" name = "sport" type="text" class = "from-control">
			</div>
		</div>
		
		<div class="col-sm-12 text-center">
			<button type="submit" class="btn btn-success " id = "newTeamButton" >Success</button>
		</div>
		
	</form>
</div>

<%@ include file="../jspf/footer.jspf"%>
