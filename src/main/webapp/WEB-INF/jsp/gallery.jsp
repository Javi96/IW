<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>
<link href="${s}/css/gallery.css" rel="stylesheet">

<div class="starter-template">
	<p class="lead">Hi, this is the gallery</p>
</div>

<div>
  <button class="add">ADD GALLERY</button> 
  <button class="add">DEL GALLERY</button> 
  <h2 >Image Gallery</h2>
</div>

<div class="responsive">
  <div class="gallery">
    <a target="_blank" href="${s}/img/example.png">
      <img src="${s}/img/example.png" alt="Trolltunga Norway" width="300" height="400">
    </a>
    <div class="desc">Add a description of the image here</div>
  </div>
</div>


<div class="responsive">
  <div class="gallery">
    <a target="_blank" href="${s}/img/example.png">
      <img src="${s}/img/example.png" alt="Forest" width="600" height="400">
    </a>
    <div class="desc">Add a description of the image here</div>
  </div>
</div>

<div class="responsive">
  <div class="gallery">
    <a target="_blank" href="${s}/img/example.png">
      <img src="${s}/img/example.png" alt="Northern Lights" width="600" height="400">
    </a>
    <div class="desc">Add a description of the image here</div>
  </div>
</div>

<div class="responsive">
  <div class="gallery">
    <a target="_blank" href="${s}/img/example.png">
      <img src="${s}/img/example.png" alt="Mountains" width="600" height="400">
    </a>
    <div class="desc">Add a description of the image here</div>
  </div>
</div>

<div class="responsive">
  <div class="gallery">
    <a target="_blank" href="${s}/img/example.png">
      <img src="${s}/img/example.png" alt="Trolltunga Norway" width="600" height="400">
    </a>
    <div class="desc">Add a description of the image here</div>
  </div>
</div>


<div class="responsive">
  <div class="gallery">
    <a target="_blank" href="${s}/img/example.png">
      <img src="${s}/img/example.png" alt="Forest" width="600" height="400">
    </a>
    <div class="desc">Add a description of the image here</div>
  </div>
</div>

<div class="responsive">
  <div class="gallery">
    <a target="_blank" href="${s}/img/example.png">
      <img src="${s}/img/example.png" alt="Northern Lights" width="600" height="400">
    </a>
    <div class="desc">Add a description of the image here</div>
  </div>
</div>

<div class="responsive">
  <div class="gallery">
    <a target="_blank" href="${s}/img/example.png">
      <img src="${s}/img/example.png" alt="Mountains" width="600" height="400">
    </a>
    <div class="desc">Add a description of the image here</div>
  </div>
</div>
<div class="clearfix"></div>


<h2>Image Gallery</h2>




<%@ include file="../jspf/footer.jspf"%>
