<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>
<link type="text/css" media="screen" rel="stylesheet" href="${s}/css/team.css" />


<div class="container">
	<div class="row" id = "joinTeamStyle">
		<div class="col-md-12" >
		 <c:if test="${correct}">
		 	<div class="alert alert-success">
				<strong><span class="glyphicon glyphicon-send"></span> 
				Tu solicitud ha sido enviada correctamente</strong>
			</div>
		</c:if>
		<c:if test="${error}">
			<div class="alert alert-danger">
				<strong> <span class="glyphicon glyphicon-alert"></span>
				Error! Ya has enviado una solicitud a este equipo</strong>
			</div>
		</c:if>
		</div>
		
		<div >
			<form role="form" action="/sentRequestTeam" name = "requestTeam" method="post" >
				<div class="col-md-12">
					<div class="well well-sm"><strong><span class="glyphicon glyphicon-ok"></span> Required Field</strong></div>
					<div class="form-group">
						<label for="InputName">Nombre Completo</label>
						<div class="input-group">
							<input type="text" class="form-control" name="name" placeholder="Tu nombre completo" required>
							<span class="input-group-addon"><i class="glyphicon glyphicon-ok form-control-feedback"></i></span>
						</div>
					</div>
					<div class="form-group">
						<label for="InputEmail">DNI</label>
						<div class="input-group">
							<input type="text" class="form-control" name="id_card_nr" placeholder="Tu DNI incluida la letra" required  >
							<span class="input-group-addon"><i class="glyphicon glyphicon-ok form-control-feedback"></i></span>
						</div>
					</div>
					<input class="btn btn-info" type="submit" name="submit" id="submit" value="Enviar" >	
				</div>
				<input type="hidden" name="teamId" value ="${team.id}" placeholder="Tu DNI incluida la letra" required  >
			</form>
		</div>
	</div>
</div>

<%@ include file="../jspf/footer.jspf"%>
