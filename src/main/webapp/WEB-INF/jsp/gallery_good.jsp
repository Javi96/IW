<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>


<style>
body {
  font-family: Verdana, sans-serif;
  margin: 0;
}

* {
  box-sizing: border-box;
}

.row > .column {
  padding: 0 8px;
  margin-bottom: 10px;
  margin-left: : 10px;
  margin-right: : 10px;
}

.row:after {
  content: "";
  display: table;
  clear: both;
}

.column {
  float: left;
  width: 25%;
}

/* The Modal (background) */
.modal {
  display: none;
  position: fixed;
  z-index: 1;
  padding-top: 100px;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: black;
}

/* Modal Content */
.modal-content {
  position: relative;
  background-color: #fefefe;
  margin: auto;
  padding: 0;
  width: 90%;
  max-width: 1200px;
}

/* The Close Button */
.close {
  color: white;
  position: absolute;
  top: 10px;
  right: 25px;
  font-size: 35px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: #999;
  text-decoration: none;
  cursor: pointer;
}

.mySlides {
  display: none;
}

.cursor {
  cursor: pointer
}

/* Next & previous buttons */
.prev,
.next {
  cursor: pointer;
  position: absolute;
  top: 50%;
  width: auto;
  padding: 16px;
  margin-top: -50px;
  color: white;
  font-weight: bold;
  font-size: 20px;
  transition: 0.6s ease;
  border-radius: 0 3px 3px 0;
  user-select: none;
  -webkit-user-select: none;
}

/* Position the "next button" to the right */
.next {
  right: 0;
  border-radius: 3px 0 0 3px;
}

/* On hover, add a black background color with a little bit see-through */
.prev:hover,
.next:hover {
  background-color: rgba(0, 0, 0, 0.8);
}

/* Number text (1/3 etc) */
.numbertext {
  color: #f2f2f2;
  font-size: 12px;
  padding: 8px 12px;
  position: absolute;
  top: 0;
}

img {
  margin-bottom: -4px;
}

.caption-container {
  text-align: center;
  background-color: black;
  padding: 2px 16px;
  color: white;
}

.demo {
  opacity: 0.6;
}

.active,
.demo:hover {
  opacity: 1;
}

img.hover-shadow {
  transition: 0.3s
}

.hover-shadow:hover {
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)
}
</style>
<body>
<h2 style="text-align:center">Galleria de imagenes</h2>


<form action = "/admin/photo" enctype="multipart/form-data" method="post">
	<p>
		Please specify a file, or a set of files:<br> 
		<input type="file" name="photo" size="40">
	</p>
	 <input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}" />
	<div>
		<button type="submit">Send</button>
		<input id="team" type="hidden" name = "id" value="${team}">		
	</div>
</form>

<div id="images" class="row">
  
</div>



<div id="mycarousel" class="modal"> Files ${files} sd<!--carousel imagenes-->
  <span class="close cursor" onclick="window.open('https://www.w3schools.com')">&times;</span>
  <div class="modal-content">

  </div>
</div>

<script>
    var slideIndex = 0;
    var slides = ['admin/photo/1',
                    'static/img/cat.jpeg',
                    'static/img/card.svg',
                    'static/img/cat.jpeg',
                    'static/img/card.svg',
                    'static/img/cat.jpeg',
                    'static/img/card.svg',
                    'static/img/cat.jpeg',
                    'static/img/card.svg',
                    'static/img/cat.jpeg',
                    'static/img/card.svg',
                    'static/img/cat.jpeg',
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


// onclick="openModal();currentSlide('+i+')" esto para carousel
function loadSlices() {
    $("#images").empty();
    for(i=0; i<slides.length; i++){
        let data = $('<div class="column"><img src="'+slides[i]+'" style="width:100%; max-height: 320px;" onclick="window.open("https://www.w3schools.com"); class="hover-shadow cursor"></div>');
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


function showSlides(n) {
    var i;
    var carousel = document.getElementsByClassName("mySlides");
    var dots = document.getElementsByClassName("demo");
    var captionText = document.getElementById("caption");
    if (n > carousel.length) {
        slideIndex = 1;
    }
    if (n < 1) {
        slideIndex = carousel.length;
    }
    for (i = 0; i < carousel.length; i++) {
      carousel[i].style.display = "none";
    }
    for (i = 0; i < dots.length; i++) {
      dots[i].className = dots[i].className.replace(" active", "");
    }
    //console.log(carousel);
    carousel[slideIndex-1].style.display = "block";
    dots[slideIndex-1].className += " active";
    captionText.innerHTML = dots[slideIndex-1].alt;
}

$(document).ready(function(){
	console.log(document.getElementById("mycarousel").textContent[6,7]);
  //loadSlices();
  	var team = $('#team').attr("value");
    files = document.getElementById("mycarousel").textContent[6,7];

    $("#images").empty();
    for(i=1; i<=files; i++){
    	$.get("/admin/photo/"+team, {file: i},
    	function(data) {
    		var b64Response = btoa(unescape(encodeURIComponent(data)));
    		var outputImg = document.createElement('img');
    		outputImg.src = '.~/tmp/iw/'+team+'/'+b64Response;
    	    let img = $('<div class="column"><img src="'+outputImg.src+'" style="width:100%; max-height: 320px;" onclick="window.open("https://www.w3schools.com"); class="hover-shadow cursor"></div>');
    	    $("#images").append(img);
    	    
    		//console.log(data);
   			//$('#sports').empty();
   			/*let teamInfo = data.split("'");
   			for(let i = 0; i < teamInfo.length; i++){
   				let team = JSON.parse(teamInfo[i]);
   				let sport = $('<input>').addClass('list-group-item inputSports all pull-center').attr('type','submit').attr('value',team.sport)
   				.attr('onClick', 'getTeams(\"' + team.sport + '\");');
   				let li = $('<li>').addClass('list-group-item');
   				li.append(sport);
   				$('#sports').append(li);
   			}*/
     	});
    }
    
    
    
    
	/*$.get("/showImages", {team: $("#team").attr("value"), files: $("#files").attr("value")},
		function(data) {
	
			//$('#teams').empty();
			let teamInfo = data.split("'");
			$('#arrowHeader').show();
			for(let i = 0; i < teamInfo.length; i++){
				let team = JSON.parse(teamInfo[i]);
				let teamName = $('<input>').addClass('list-group-item inputSports all pull-center').attr('type','submit').attr('value',team.name);
				let teamID = $('<input>').attr('type','hidden').attr('name',"id").prop('value',team.id);
				let li = $('<li>').addClass('list-group-item');
				li.append(teamName);
				li.append(teamID);
				$('#teams').append(li);
			}
		});*/
});
</script>


<%@ include file="../jspf/footer.jspf"%>