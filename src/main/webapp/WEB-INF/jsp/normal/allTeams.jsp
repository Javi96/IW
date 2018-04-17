<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	

<%@ include file="../../jspf/header.jspf"%>
<link type="text/css" media="screen" rel="stylesheet" href="${s}/css/home.css" />

<div class = "container">
	<h1 class = "redColor" >Bienvenido a U-SPORTS</h1>
	<nav class="container navbar navbar-default" role="navigation" id="menu">
		<div class="collapse navbar-collapse navbar-ex1-collapse">
    		<ul class="nav nav-justified" id="contenidomenu">
       			<li class="dropdown resalte lead">
					<a class="dropdown-toggle" data-toggle="dropdown">Rugby</a>
					<ul class="dropdown-menu" role="menu">
						<li><a  href="/rugbyTeams">Masculino</a></li>
						<li><a  href="">Femenino</a></li>
						<li></li>
					</ul>
				</li>
       			<li class="dropdown resalte lead"> <a >Volveivol</a></li>
       			<li class="dropdown-resalte lead"><a href="">Futbol</a></li>
       			<li class="dropdown-resalte lead"><a href="">Balonmano</a></li>
       			<li class="dropdown-resalte lead"><a href="">Tenis</a></li>
       			<li class="dropdown-resalte lead"><a href="">Padel</a></li>
       			<li class="dropdown-resalte lead"><a href="">Baloncesto</a></li>
       			<li class="dropdown-resalte lead"><a href="">Futbol Sala</a></li>
    		</ul>
    	</div>	
	</nav>
</div>
<%@ include file="../../jspf/footer.jspf"%>
