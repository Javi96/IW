<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>
<script src = "${s}/js/gallery.js"></script>
<link type="text/css" media="screen" rel="stylesheet" href="${s}/css/diary.css" />



	
		for(Team t : teamMatch) {
			System.out.println(t.getName());
			System.out.println(t.getNextMatchFacilities());
			System.out.println(t.getNextMatchSchedule());
			System.out.println(t.getTrainingSchedule());
		}
<div class="container">

<h2>Calendario</h2>    
    <hr />

    <div class="agenda">
        <div class="table-responsive">
            <table class="table table-condensed table-bordered">
                <thead>
                    <tr>
                        <th>Fecha</th>
                        <th>Evento</th>
                    </tr>
                </thead>
                <tbody>
                    
                    
                    <c:forEach items="${teams}" var="i">
                    <tr>
                    	<td class="agenda-time">
                            ${i.trainingSchedule}
                        </td>
                        <td class="agenda-events">
                            <div class="agenda-event">
							Entrenamiento. 
                            </div>
                        </td>
                   </tr>
                   <tr>
                        <td class="agenda-time">
                            ${i.nextMatchSchedule}
                        </td>
                        <td class="agenda-events">
                            <div class="agenda-event">
							Partido en ${i.nextMatchFacilities}.
                            </div>
                        </td>
                    </tr>
					</c:forEach>
				
                    
                </tbody>
            </table>
        </div>
    </div>
</div>


<%@ include file="../jspf/footer.jspf"%>
