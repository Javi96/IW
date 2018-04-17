<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>

<link href="${s}/css/matchRecord.css" rel="stylesheet">

<div class = "container">
	<div class="panel panel-default" >
		<h1 class="col-sm-12 text-center">Rugby</h1>
		<div class="panel-body form-horizontal" id = "matchRecord" >
			<div class="form-group">
				<label for="concept" class="col-sm-3 control-label">Equipo Local</label>
				<div class="col-sm-7">
					<input type="text" class="form-control" id="localTeam" name="concept">
				</div>
			</div>
			<div class="form-group">
				<label for="description" class="col-sm-3 control-label">Equipo Visitante</label>
				<div class="col-sm-7">
					<input type="text" class="form-control" id="awayTeam" name="description">
				</div>
			</div> 
		    <div class="form-group">
			    <label for="amount" class="col-sm-3 control-label">Puntos Local</label>
			    <div class="col-sm-7">
			    	<input type="number" class="form-control" id="localPoints" name="amount">
			    </div>
		    </div>
			<div class="form-group">
				<label for="amount" class="col-sm-3 control-label">Puntos Visitante</label>
			    <div class="col-sm-7">
			    	<input type="number" class="form-control" id="awayPoints" name="amount">
			    </div>
			</div> 
			 
			<div class="form-group">
			<div class="col-sm-12 text-center">
		    	<button type="button" class="btn btn-default preview-add-button">
		        	<span class="glyphicon glyphicon-send"></span> Enviar Acta
		    	</button>
			</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="../jspf/footer.jspf"%>
