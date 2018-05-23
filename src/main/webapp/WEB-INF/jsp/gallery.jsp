<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>
<!--<script src = "${s}/js/gallery.js"></script>-->
<link type="text/css" media="screen" rel="stylesheet" href="${s}/css/gallery.css" />

<body>

        
        <div id ="container" class="container">         
        <h2 style="text-align:center">Galleria de imagenes</h2>
        
<div>
	<button id="team" type="button" class="btn btn-primary" data-toggle="modal" data-target="#create" name="${team}">
	  Añadir galería
	</button>

	<div class="modal fade" id="create" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h2 class="modal-title" id="exampleModalLabel">Escribe el nombre de la nueva galería</h2>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
		  	<form action = "/createGallery/${team}" method="post"  class="btn-group teamButtonsStyle" id = "create_gallery">
			  	<div class="form-group" style="float: left; width: 100%;">
					<input type="text" class="form-control" id="usr" required="required" name="data">
					
			    </div>
			    <div class="form-group" style="float: right; width: 100%;">
				
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Salir</button>
		        	<button type="submit" class="btn btn-primary">Guardar cambios</button>
			    </div>
			</form>
	      <div class="modal-footer">
	      </div>
	    </div>
	  </div>
	</div>
	</div>
	
	
	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#remove">
	  Eliminar gelaría
	</button>

	<div class="modal fade" id="remove" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h2 class="modal-title" id="exampleModalLabel">Selecciona la galería a eliminar</h2>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
		  	<form action = "/removeGallery/${team}" method="post"  class="btn-group teamButtonsStyle" id = "remove_gallery">
		  	
		  	<div class="form-group" style="float: center; width: 100%;">
				<select class="form-control" id="sel1" required="required" name="selectionbox">
				<c:forEach items="${gallery}" var="i">
					<option>${i.name}</option>
				</c:forEach>
				</select>
			</div>
			    <div class="form-group" style="float: right; width: 100%;">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Salir</button>
		        	<button type="submit" class="btn btn-primary" >Guardar cambios</button>
			    </div>
			</form>
	      <div class="modal-footer">
	      </div>
	    </div>
	  </div>
	</div>
	</div>
</div>


<!-- <c:forEach items="${galleries}" var="i">
		<tr>
			<th style="text-align: left">"${i[name]}"</th>
			<th style="text-align: left">"${i[files]}"</th>
			<th style="text-align: right">
			<form action = "/gallery_good" method="get"  class="btn-group teamButtonsStyle" id = "gallery">
				<button type="submit" class="btn btn-primary">Ver galería</button>
				<input type="hidden" name = "team" value="${team}">
				<input type="hidden" name = "gallery" value="${i}">
			</form>
			</th>
		 </tr>  
		</c:forEach>
		 -->
                                                      
<div id="test" class="table-responsive">
	<table id="gallery_table" class="table table-striped table-hover">
	<thead>
		 <tr>
			<th style="text-align: left">Nombre de la galería</th>
			<th style="text-align: left">Imágenes</th>
			<th style="text-align: right"></th>
		 </tr>
	</thead>
	<tbody id='gallery_body'>
		<c:forEach items="${gallery}" var="i">
		<tr>
			<td style="text-align: left">${i.name}</td>
			<th style="text-align: left">${i.item}</th>
			<th style="text-align: right">
			<form action = "/gallery_images" method="get"  class="btn-group teamButtonsStyle" id = "gallery">
				<button type="submit" class="btn btn-primary">Ver galería</button>
				<input type="hidden" name = "team" value="${team}">
				<input type="hidden" name = "gallery" value="${i.name}">
				
			</form>
			</th>
		 </tr>  
		</c:forEach>
	</tbody>
		
	</table>
</div>
</div>	
    </body>
    
    <script type="text/javascript">
    
    
    
</script>
<%@ include file="../jspf/footer.jspf"%>
