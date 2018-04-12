<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>

<link type="text/css" media="screen" rel="stylesheet" href="${s}/css/calendarSport.css" />
<script src = "${s}/js/calendarSport.js"></script>

<div class = "container">

	<table> 
		<caption>Horario.</caption>
		
		<!-- columnas -->
		<thead>
		    <tr>
				<th class="time">Horario</th>
				<th>Lunes</th>
				<th>Martes</th>
				<th>Miercoles</th>
				<th>Jueves</th>
				<th>Viernes</th>
				<th>Sabado</th>
				<th>Domingo</th>
			</tr>
		</thead>
		
		<tbody>
			<!-- ${horas} -->
			<!-- filas -->
			<tr>
				<td class="time">09:00 - 10:00</td>
				<td>Entrenamiento</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			
			<tr>
				<td class="time">10:00 - 11:00</td>
				<td>Entrenamiento</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			
			<tr>
				<td class="time">11:00 - 12:00</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td>Partido</td>
				<td></td>
			</tr>
			
			<tr>
				<td class="time">12:00 - 13:00</td>
				<td></td>
				<td></td>
				<td>Entrenamiento</td>
				<td></td>
				<td></td>
				<td>Partido</td>
				<td></td>
			</tr>
			
			<tr>
				<td class="time">13:00 - 14:00</td>
				<td></td>
				<td></td>
				<td>Entrenamiento</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			
			<tr>
				<td class="time">14:00 - 15:00</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			
			<tr>
				<td class="time">15:00 - 16:00</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			
			<tr>
				<td class="time">16:00 - 17:00</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td>Entrenamiento</td>
				<td></td>
				<td></td>
			</tr>
			
			<tr>
				<td class="time">17:00 - 18:00</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td>Entrenamiento</td>
				<td></td>
				<td></td>
			</tr>
			
			<tr>
				<td class="time">18:00 - 19:00 </td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			
			<tr>
				<td class="time">19:00 - 20:00 </td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			
			<tr>
				<td class="time">20:00 - 21:00 </td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			
			<tr>
				<td class="time">21:00 - 22:00 </td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</tbody>
		
	</table>
</div>


<%@ include file="../jspf/footer.jspf"%>

