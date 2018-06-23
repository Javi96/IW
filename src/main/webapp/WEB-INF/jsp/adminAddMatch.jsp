<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<div class = "container">
	<form class = "form-horizontal" name = "match" method="POST" action = "/addMatch">
		<!-- Form Name -->
		<h1 class = "col-sm-12 text-center">Añadir partido </h1>
	
		<div class="row">
			<div class="col-md-12 text-center">
				<div class="dropdown btn-group">
					<button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">Selecciona un deporte
					<span class="caret"></span></button>
					<ul class="dropdown-menu">
						<c:forEach items="${sports}" var="sport">
							<li><a href="/getTeamsBySport?sport=${sport}">${sport}</a></li>	
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
		
		<c:if test="${not empty matchOf}">
			<div class = "text-center marginTop5">
				<h4> Has elegido ${matchOf} </h4>
			</div>
		</c:if>
		
		<div class="form-group marginTop5">
			<label class="col-md-4 col-md-offset-1 control-label" >Equipo local:</label>
			<div class="col-md-3">
				<select class="form-control" onchange = "putHomeTeamId(this)" id ="homeSelect">
					<option value = "-1" >Elige el equipo local</option>
					<c:forEach items="${teamsBySport}" var="team">
						<option value = "${team.id}" >${team.name} - ${team.category}</option>
					</c:forEach>
				</select>
			</div>
			<input type="hidden" id = "homeTeamId" name="homeTeamId"/> 
		</div>
		
		<div class="form-group">
			<label class="col-md-4 col-md-offset-1 control-label" >Equipo visitante:</label>
			<div class="col-md-3">
				<select class="form-control"  onchange = "putAwayTeamId(this)">
					<option value = "-1" >Elige el equipo visitante</option>
					<c:forEach items="${teamsBySport}" var="team">
						<option value = "${team.id}" >${team.name} - ${team.category}</option>
					</c:forEach>
				</select>
			</div>
			<input type="hidden" id = "awayTeamId" name="awayTeamId"/> 
		</div>
			    
		<div class="form-group">
			<label class="col-md-4 col-md-offset-1 control-label" >Puntos equipo local:</label>
			<div class="col-md-4">
				<input name = "homeTeamPoints" type="number" class = "from-control">
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-md-4 col-md-offset-1 control-label" >Puntos equipo visitante:</label>
			<div class="col-md-4">
				<input name = "awayTeamPoints" type="number" class = "from-control">
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-md-4 col-md-offset-1 control-label" >Actas definitivas:</label>
			<div class="col-md-4">
				<input name = "recordChecked" type="Radio" value = "1" class = "from-control">Firmar
			</div>
		</div>
		
		<div class="col-sm-12 text-center">
			<button type="submit" class="btn btn-success " >Añadir partido</button>
		</div>
		
	</form>
</div>

<script>
function putHomeTeamId(val){
	$('#homeTeamId').val(val.value);
}

function putAwayTeamId(val){
	$('#awayTeamId').val(val.value);
}
</script>
