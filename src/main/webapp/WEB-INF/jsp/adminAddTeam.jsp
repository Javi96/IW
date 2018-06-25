<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>

<div class = "container">

	<div class = "row">
		<div class= "col-md-12">
		   <form class = "form-horizontal" name = "team" method="POST" action = "/addTeam">
		      <!-- Form Name -->
		      <h1 class = "col-sm-12 text-center">Crear equipo</h1>
		      <div class="form-group">
		         <label class="col-md-5 control-label" >Nombre</label>
		         <div class="col-md-3 col-md-offset-1">
		            <input id = "teamName" name = "name" type="text" class = "from-control-text">
		         </div>
		      </div>
		      <div class="form-group">
		         <label class="col-md-5 control-label" >Deporte</label>
		         <div class="col-md-3 col-md-offset-1">
		            <input id = "sport" name = "sport" type="text" class = "from-control">
		         </div>
		      </div>
		      <div class="form-group">
		         <label class="col-md-5 control-label" >Facultad</label>
		         <div class="col-md-3 col-md-offset-1">
		            <input id = "school" name = "school" type="text" class = "from-control">
		         </div>
		      </div>
		      <div class="form-group">
		         <label class="col-md-5 control-label" >Correo del delegado</label>
		         <div class="col-md-3 col-md-offset-1">
		            <input  name = "email" type="text" class = "from-control">
		         </div>
		      </div>
		      <div class="form-group">
			<label class="col-md-5 control-label" >Categoria:</label>
			<div class="col-md-3 col-md-offset-1">
				<input  name = "category" type="Radio" value="Masculino" class = "from-control">Masculino
				<input  name = "category" type="Radio" value="Femenino" class = "from-control">Femenino
			</div>
			
			</div>
			<div class="form-group">
			<label class="col-md-5 control-label" >Descripcion:</label>
			<div class="col-md-3 col-md-offset-1">
				<textarea id="description" rows="4" cols="40" name="description"></textarea>
			</div>
			</div>
		      <div class="col-sm-12 text-center">
		         <button type="submit" class="btn btn-success " id = "newTeamButton" style="margin: 8px;">Success</button>
		      </div>
		   </form>
	   </div>
   </div>
</div>