<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	
<link type="text/css" media="screen" rel="stylesheet" href="${s}/css/home.css" />
<script type="text/javascript" src = "${s}/js/adminHome.js"></script>

<div class = "container">
	<form action="/teamListBySportAndCategory" method="get">
		<div class="col-md-4 col-md-offset-4">
			<div class="col-md-12">
				<div class="col-md-12 ">
					<select name = "sport">
						<c:forEach items="${sportList}" var="s">
							<option>${s}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="col-md-4 col-md-offset-2">
				<label><input class="checkMale" type="checkbox" name="category" value="Masculino">Masculino</label><br>
			</div>
			<div class="col-md-4">
				<label><input class="checkFemale" type="checkbox" name="category" value="Femenino">Femenino</label><br>
			</div>
			<div class="text-center">
				<button class="btn-danger" type="submit">Buscar</button>
			</div>
		</div>
	</form>

	<div class="col-md-6 col-md-offset-3 pre-scrollable" id="teamListForAdmin">
		<div class="list-group">
		<c:forEach items="${teamList}" var="team">
			<li class="list-group-item"  id = "${team.id}">
				<input class="inputSportAdmin all pull-center listStyle" type="submit" value ="${team.name}" readonly/><button onclick = "loadData(${team.id})" type="button" class="btn-danger" data-toggle="modal" data-target="#editTeamModal">Editar</button>
			</li>
		</c:forEach>
		</div>
	</div>
	<script>
		if("${teamList[0].category}" === "Masculino")
			$(".checkMale").prop('checked', true);
		else if ("${teamList[0].category}" === "Femenino")
			$(".checkFemale").prop('checked', true);
	</script>
	<!-- Modal update team-->
	<div class="modal fade" id="editTeamModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-centered" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	             	<h1 id = "updateTeamName" class="modal-title col-sm-12 text-center">Modificar equipo</h1>	
	            </div>
	            <div class="modal-body">
	                <form class="form-horizontal" role="form" name="team" action="/updateTeam" method="POST">
	                    <!-- Form Name -->
	                    <div class="form-group">
	                        <label class="col-md-5 control-label">Nombre</label>
	                        <div class="col-md-3 col-md-offset-1">
	                            <input id="teamName" name="name" type="text" class="from-control-text" required>            
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <label class="col-md-5 control-label">Deporte</label>
	                        <div class="col-md-3 col-md-offset-1">
	                            <input id="sport" name="sport" type="text" class="from-control" readonly required>
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <label class="col-md-5 control-label">Facultad</label>
	                        <div class="col-md-3 col-md-offset-1">
	                            <input id="school" name="school" type="text" class="from-control" readonly required>
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <label class="col-md-5 control-label">Correo del delegado</label>
	                        <div class="col-md-3 col-md-offset-1">
	                            <input id = "deputyEmail" name="email" type="text" class="from-control" readonly>
	                        </div>
	                    </div> 
	                    <div class="form-group">
	                        <label class="col-md-5 control-label">Proximo partido</label>
	                        <div class="col-md-3 col-md-offset-1">
	                            <input id = "nextMatchSchedule" name="nextMatchSchedule" type="text" class="from-control" required>
	                        </div>
	                    </div>
	                     <div class="form-group">
	                        <label class="col-md-5 control-label">Instalaciones</label>
	                        <div class="col-md-3 col-md-offset-1">
	                            <input id = "nextMatchFacilities" name="nextMatchFacilities" type="text" class="from-control" required>
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <label class="col-md-5 control-label">Horario de entrenamiento</label>
	                        <div class="col-md-3 col-md-offset-1">
	                            <input id = "trainingSchedule" name="trainingSchedule" type="text" class="from-control" required>
	                        </div>
	                    </div>
	                  <!-- <div class="form-group">
	                        <label class="col-md-5 control-label">Cambiar escudo</label>
	                        <div class="col-md-3 col-md-offset-1">
								<label for="files" class="btn">Selecciona el nuevo escudo</label>
								<input name="photo"  id="files" style="visibility:hidden; display:none" type="file" >
							</div>
	                    </div> -->
	                    <div class="form-group">
	                        <label class="col-md-5 control-label">Categoria:</label>
	                        <div class="col-md-4 col-md-offset-1">
	                            <input class="checkMale" id = "radioMale" name="category" type="Radio" value="Masculino" class="from-control" required>Masculino
	                            <input class="checkFemale" id = "radioFemale" name="category" type="Radio" value="Femenino" class="from-control" required>Femenino
	                        </div>
	                    </div>
	                     <div class="form-group">
	                        <label class="col-md-5 control-label">Descripcion:</label>
	                        <div class="col-md-4 col-md-offset-1">
	                            <textarea id="description" rows="4" cols="35" name="description"></textarea>
	                        </div>
	                    </div>
	                    <div class="form-group text-center">
	                   		<input type="hidden" name="id" id="teamId" required  >
	                        <button type="submit" class="btn btn-success">Guardar cambios</button>
	                    </div>
	                </form>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	            </div>
	        </div>
	    </div>
	</div>
	
	
</div>


