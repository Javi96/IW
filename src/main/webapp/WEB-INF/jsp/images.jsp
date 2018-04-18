<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>
<link type="text/css" media="screen" rel="stylesheet" href="${s}/css/images.css" />
<link type="text/js" media="screen" rel="stylesheet" href="${s}/js/images.js" />

<body>
<h2 style="text-align:center">Galleria de imagenes</h2>




<div id="images" class="row">
  
</div>



<div id="mycarousel" class="modal"> <!--carousel imagenes-->
  <span class="close cursor" onclick="closeModal()">&times;</span>
  <div class="modal-content">

  </div>
</div>

<script>
    var slideIndex = 0;
    var slides = ['static/img/card.svg',
                    'static/img/card.svg',
                    'static/img/card.svg',
                    'static/img/card.svg',
                    'static/img/card.svg',
                    'static/img/card.svg',
                    'static/img/card.svg',
                    'static/img/card.svg',
                    'static/img/card.svg',
                    'static/img/card.svg',
                    'static/img/card.svg',
                    'static/img/card.svg',
                    'static/img/card.svg',
                    'static/img/card.svg'];

function openModal() {
  document.getElementById('mycarousel').style.display = "block";
}

function closeModal() {
  document.getElementById('mycarousel').style.display = "none";
}


function plusSlides(n) {
  showSlides(slideIndex += n);
}

function currentSlide(n) {
  showSlides(slideIndex = n);
}



function loadSlices() {
    $("#images").empty();
    for(i=0; i<slides.length; i++){
        let data = $('<div class="column"><img src="'+slides[i]+'" style="width:100%; max-height: 320px;" onclick="openModal();currentSlide('+i+')" class="hover-shadow cursor"></div>');
        $("#images").append(data);
    }
    
}

function loadCarousel() {
    $("#mycarousel").empty();
    for(i=0; i<slides.length; i++){
        //console.log('mycarousel'+i);
        let data = $('<div class="mySlides"><div class="numbertext">'+ i +' / '+slides.length+'</div><img src="'+slides[i]+'" style="width:100%"></div>');
        $("#mycarousel").append(data);

    }   
    $("#mycarousel").append('<a class="prev" onclick="plusSlides(-1)">&#10094;</a><a class="next" onclick="plusSlides(1)">&#10095;</a><div class="caption-container"><p id="caption"></p></div>');
}

$(document).ready(function(){
    loadSlices();

});


</script>




<%@ include file="../jspf/footer.jspf"%>
