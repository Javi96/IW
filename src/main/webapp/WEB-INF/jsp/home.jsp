<%@ page pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
            <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
                <%@ include file="../jspf/header.jspf"%>
                <link type="text/css" media="screen" rel="stylesheet" href="${s}/css/home.css" />
                <script src = "${s}/js/homeScript.js"></script>			

<div class="container">
	<h1 class = "col-md-12 text-center">Categoria</h1>
	<div class = "col-md-12 text-center" id = "gender">
		<span class="button-checkbox">
			<button  id = "femBtn" type="button" class="btn sub" data-color="danger">Masculino</button>
			<input id = "female"  name= "category" value = "Masculino" type="checkbox" class="hidden" />
		</span>
		<span class="button-checkbox">
			<button  id = "maleBtn" type="button" class="btn sub" data-color="danger">Femenino</button>
			<input id = "male" name = "category" value = "Femenino" type="checkbox" class="hidden" />
		</span>
	</div>
	<div class="row">
		<div class="col-md-12 text-center" id = "sportsHeader">
  			<div class="col-md-6 spHeader">Deportes</div>
		</div>
		<div class="col-sm-4 col-sm-offset-1">
       		<div class="list-group" id="sports"></div>       
      	</div>
      	
      	<div class="col-md-2 text-center" id = "arrowHeader">
   			<div class="glyphicon glyphicon-arrow-right"></div>
      	</div>
      	
		<div class="col-sm-4" id = "teamHeader">
			<form action="/team" method="get">
				<div class="list-group" id="teams"></div>
			</form>
		</div>
	</div>
</div>

<%@ include file="../jspf/footer.jspf"%>