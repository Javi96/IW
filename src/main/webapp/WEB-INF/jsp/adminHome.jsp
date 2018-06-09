<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>
<link type="text/css" media="screen" rel="stylesheet" href="${s}/css/adminHome.css" />

<script type="text/javascript">
	function deleteMsg(){
		$("#msg").remove();
	}
</script>

<div class="container">
	<nav class="container navbar navbar-default" role="navigation" id="menu" style="margin-top:30px">
	   <div class="collapse navbar-collapse navbar-ex1-collapse">
	      <ul class="nav nav-justified" id="contenidomenu">
	         <!-- Opciones -->
	         <li><a title="teamList" href="/adminHome">Inicio</a></li> 
	         <li><a title="addTeam" href="/addTeamView">Añadir equipo</a></li>
			 <li><a title="addLeague" href="/addLeagueView">Añadir liga</a></li>
	      </ul>
	   </div>
	</nav>
	
	<c:if test="${empty option}">
		<p id = "msg" class="text-center">Bienvenido al sistema de administración de deportes de la Universidad Complutense de Madrid.<br>
		En esta parte podrás administrar los equipos y las ligas de la universidad.</p>
		
		<div class="marginTop5">
			<%@ include file="../jsp/adminTeamList.jsp"%>
		</div>
	</c:if>
	
	<c:if test='${option == "adminAddTeam"}'>
		<%@ include file="../jsp/adminAddTeam.jsp"%>
	</c:if>
	
	<c:if test='${option == "adminAddLeague"}'>
		<%@ include file="../jsp/adminAddLeague.jsp"%>
	</c:if>
	
	<c:if test="${not empty correct}">
			<div class="col-md-6 col-md-offset-3 text-center alert alert-success">${correct} </div>
	</c:if>
		
	<c:if test="${not empty info}">
		<div class="col-md-6 col-md-offset-3 text-center alert alert-danger"> ${info} </div>
	</c:if>
	
</div>

<c:if test="${not empty correct}">
	<script>
		$("#${teamId}").css("background-color","#32CD32");
	</script>
</c:if>
<c:if test="${not empty incorrect}">
	<script>
	$("#${teamId}").css("background-color","#E31C20");
	</script>
</c:if>

<%@ include file="../jspf/footer.jspf"%>
