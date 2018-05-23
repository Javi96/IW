<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>


<link type="text/css" media="screen" rel="stylesheet" href="${s}/css/gallery_good.css" />

<body>
<h2 style="text-align:center">Galleria de imagenes</h2>

<form action = "/photo/${team}/${gallery}" enctype="multipart/form-data" method="post">
	<p>
		Please specify a file, or a set of files:<br> 
		<input id="img" type="file" name="photo" size="40" required="required">
	</p>
	 <input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}" />
	
	<div>
		<button type="submit">Send</button>
		<input  id="team" type="hidden" name = "id" value="${team}">		
	</div>	
</form>

<div id="test" class="row">
<c:forEach items="${images}" var="i">
<div class="column">
<img src="${i}" style="width:100%; max-height: 320px;" class="hover-shadow cursor"/> 
</div>       
</c:forEach>
</div>

<div id="images" class="row">
  
</div>

<%@ include file="../jspf/footer.jspf"%>