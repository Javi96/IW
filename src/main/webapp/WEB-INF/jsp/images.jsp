<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>

<div class="starter-template">
	<p class="lead">Hi, this is the image page</p>
</div>

<div>
  <button class="add">ADD IMAGE</button> 
  <button class="add">DEL IMAGE</button> 
  <h2 >Images from folder (insert here folder name)</h2>
</div>

<div class="responsive">
  <div class="gallery">
    <a target="_blank" href="${s}/img/image-alignment-300x200.jpg">
      <img src="${s}/img/image-alignment-300x200.jpg" alt="Trolltunga Norway" width="300" height="400">
    </a>
    <div class="desc">Add a description of the image here</div>
  </div>
</div>

<div class="responsive">
  <div class="gallery">
    <a target="_blank" href="${s}/img/image-alignment-300x200.jpg">
      <img src="${s}/img/image-alignment-300x200.jpg" alt="Forest" width="600" height="400">
    </a>
    <div class="desc">Add a description of the image here</div>
  </div>
</div>

<div class="responsive">
  <div class="gallery">
    <a target="_blank" href="${s}/img/image-alignment-300x200.jpg">
      <img src="${s}/img/image-alignment-300x200.jpg" alt="Northern Lights" width="600" height="400">
    </a>
    <div class="desc">Add a description of the image here</div>
  </div>
</div>

<div class="responsive">
  <div class="gallery">
    <a target="_blank" href="${s}/img/image-alignment-300x200.jpg">
      <img src="${s}/img/image-alignment-300x200.jpg" alt="Mountains" width="600" height="400">
    </a>
    <div class="desc">Add a description of the image here</div>
  </div>
</div>

<div class="responsive">
  <div class="gallery">
    <a target="_blank" href="${s}/img/image-alignment-300x200.jpg">
      <img src="${s}/img/image-alignment-300x200.jpg" alt="Trolltunga Norway" width="600" height="400">
    </a>
    <div class="desc">Add a description of the image here</div>
  </div>
</div>

<div class="responsive">
  <div class="gallery">
    <a target="_blank" href="${s}/img/image-alignment-300x200.jpg">
      <img src="${s}/img/image-alignment-300x200.jpg" alt="Forest" width="600" height="400">
    </a>
    <div class="desc">Add a description of the image here</div>
  </div>
</div>

<div class="responsive">
  <div class="gallery">
    <a target="_blank" href="${s}/img/image-alignment-300x200.jpg">
      <img src="${s}/img/image-alignment-300x200.jpg" alt="Northern Lights" width="600" height="400">
    </a>
    <div class="desc">Add a description of the image here</div>
  </div>
</div>

<div class="responsive">
  <div class="gallery">
    <a target="_blank" href="${s}/img/image-alignment-300x200.jpg">
      <img src="${s}/img/image-alignment-300x200.jpg" alt="Mountains" width="600" height="400">
    </a>
    <div class="desc">Add a description of the image here</div>
  </div>
</div>
<div class="clearfix"></div>


<h2>Images page</h2>




<%@ include file="../jspf/footer.jspf"%>
