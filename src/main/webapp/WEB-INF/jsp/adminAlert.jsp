<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>

<div class = "container">

	<div class="col-md-12 text-center"> 
		<h1>Gestión de alertas</h1>
	</div>
	<table class="table">
		<thead>
		<tr>
			<th scope="col" class="text-center">#</th>
			<th scope="col" class="text-center">Equipo local</th>
			<th scope="col" class="text-center">Equipo visitante</th>
			<th scope="col" class="text-center">Puntuacion local</th>
			<th scope="col" class="text-center">Puntuacion visitante</th>
			<th scope="col" class="text-center">Fecha encuentro</th>
			<th scope="col" class="text-center">Comentarios delegado local</th>
			<th scope="col" class="text-center">Comentarios delegado visitante</th>
			<th scope="col" class="text-center">Invalidar</th>
		</tr>
		</thead>
		<tbody>
			<c:forEach items="${alerts}" var="alert">
				<tr class="text-center">
					<th scope="row">${alert.id}</th>
					<td>${alert.match.homeTeam.name}</td>
					<td>${alert.match.awayTeam.name}</td>
					<td>${alert.match.homeTeamPoints}</td>
					<td>${alert.match.awayTeamPoints}</td>
					<td>${alert.match.matchDate}</td>
					<td class="text-center col-md-2">${alert.msgHome}</td>
					<td class="text-center col-md-2">${alert.msgAway}</td>
					<td class="text-center col-md-2">
						<form action="/invalidateRecord" method = "post">
							<button type="submit" class="btn btn-danger">Invalidar</button>
							<input type = "hidden" name="matchId" value ="${alert.match.id}">
							<input type = "hidden" name="alertId" value ="${alert.id}">
						</form>
					</td>
					
				</tr>
			</c:forEach>    
		</tbody>
	</table>

</div>


