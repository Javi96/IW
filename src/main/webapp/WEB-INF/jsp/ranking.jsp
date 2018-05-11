<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>


<%@ include file="../jspf/header.jspf"%>

	<link type="text/css" media="screen" rel="stylesheet" href="${s}/css/ranking.css" />
	<script src = "${s}/js/rankingSearchTeam.js"></script>
    
 <div class = "container">
     <h1 id = "rankingTitle">La liga <small>${leagueName}</small></h1>
     <div id = "rankingHeader">
         <div id = "searchTeamDiv">
             <input id = "searchTeam" class="form-control" type="text" placeholder="Buscar equipo" onclick="search()" >
         </div>
         <div >
             <img id = "rankingImage" src="${s}/img/imgRugby.jpg" alt="logo pagina clasificacion">
         </div>
     </div>
          
     <div>
         <table class="table">
             <thead id = "rankingHead">
                 <tr>
                     <th scope="col">Puesto</th>
                     <th scope="col">Club</th>
                     <th scope="col">Victorias</th>
                     <th scope="col">Empates</th>
                     <th scope="col">Derrotas</th>
                 </tr>
             </thead>
             <tbody>
	             <c:forEach var="team" items = "${ranking}" varStatus="status">
	             	<tr>
	                     <th scope="row">${status.count}</th>
	                     <td>${team.name}</td>
	                     <td >${team.wins}</td>
	                     <td>${team.draws}</td>
	                     <td>${team.defeats}</td>
	                 </tr>
	             </c:forEach>
             </tbody>
         </table>
     </div>
 </div>

<%@ include file="../jspf/footer.jspf"%>