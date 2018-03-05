<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	

<%@ include file="../jspf/header.jspf"%>
<link type="text/css" media="screen" rel="stylesheet" href="${s}/css/home.css" />

<div class = "container">
	<h1>Bienvenido a U-SPORTS</h1>
	<nav class="navbar navbar-default"  >
		<div class="navbar-collapse collapse">
    		<ul class="nav navbar-justified navbar-left">
       			 <li><a href="#">Equipo 1</a></li>
    		</ul>
    	</div>	
	</nav>
	<div class="row">
	   	<div class="col-sm-4 col-xs-12" >
			<div class="column">	
				<div class="_4bl9">
					<ul>
						<li><a  target="_blank"  title="" href="">Reservar pista</a></li>
						<li><a  target="_blank"  title="" href="">Ver Clasificacion</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="../jspf/footer.jspf"%>
