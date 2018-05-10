<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>

<div class = "container">
	<form class = "form-horizontal" name = "teamInfo" method="POST" action = "/changeTeamInfo">
		<!-- Form Name -->
		<h1 class = "col-sm-12 text-center">Modificar datos equipo</h1>
		<input id = "id" name = "id" type="hidden" value = "${team.id}">
		
		<div class="form-group">
			<label class="col-md-4 control-label" >Horario de entrenamiento</label>
			<div class="col-md-4">
				<input id = "trainingSchedule" value = "${team.trainingSchedule}" name = "trainingSchedule" type="text" class = "from-control-text">
			</div>
		</div>
		    
		<div class="form-group">
			<label class="col-md-4 control-label" >Proximo partido</label>
			<div class="col-md-4">
				<input id = "nextMatch" name = "nextMatchSchedule" value = "${team.nextMatchSchedule}" type="text" class = "from-control">
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-md-4 control-label" >Instalaciones</label>
			<div class="col-md-4">
				<input id = "nextMatch" name = "nextMatchFacilities" value = "${team.nextMatchFacilities}" type="text" class = "from-control">
			</div>
		</div>
		
		
		<div class="col-sm-12 text-center">
			<button type="submit" class="btn btn-success "  >Success</button>
		</div>
		
	</form>
</div>

<%@ include file="../jspf/footer.jspf"%>
