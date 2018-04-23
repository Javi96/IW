<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>


<%@ include file="../jspf/header.jspf"%>
<link type="text/css" media="screen" rel="stylesheet" href="${s}/css/home.css" />

<style>
        .main_container{
        	margin-top: 10%;
        	margin-left: 15%;
        	margin-right: 15%;
        }
        .left_container{
        	float: left;
        	width: 100%;
        }
        .right_container{
        	float: right;
			margin-top: 10%;
        }
        .teams{
        	float: right;
        	width: 40%;
        }
        .sports{
        	float: left;
        	width: 40%;
        }
        .changesIn{
            font-family: "Times New Roman", Times, serif;
            text-align: center;
            float: left;
            width: 40%;
        }
        .changesOut{
            font-family: "Times New Roman", Times, serif;
            float: right;
            width: 40%;
            text-align: center;
             margin-top: -1px;
			vertical-align: middle;
        }

        </style>





<style>
	.list{
		width:33%;
		float:left;
	}
	p:hover{
		color:blue;
		cursor:pointer;
	}
	a{
		color:black;
		text-decoration:none;
	}
	h1{
		margin-bottom:18px;
	}
</style>


<div class="container main_container">
	<div class="left_container">
		<h2>Género:</h2>
		<!--<form>
		    <label class="radio-inline">
		    	<input type="radio" name="optradio" value="0">Masculino
		    </label>
		    <label class="radio-inline">
		    	<input type="radio" name="optradio" value="1">Femenino
		    </label>
		</form>-->
	</div>


	<form class="form-inline">

	    <div class="form-check">
	        <input class="form-check-input" name="group20" type="radio" id="radio120" onclick="loadSport('male');">
	        <label class="form-check-label" for="radio120" onclick="loadSport('male');">Masculino</label>
	    </div>

	    <div class="form-check">
	        <input class="form-check-input" name="group20" type="radio" id="radio121" onclick="loadSport('female');">
	        <label class="form-check-label" for="radio121" onclick="loadSport('female');">Femenino</label>
	    </div>

	</form>






	<div class="left_container">
		<div class="sports">
			<div id="Sports" class="list">
				<h1>Sports</h1>
			</div>
		</div>
		<div class="teams">
			<div id="Teams" class="list">
				<h1>Teams</h1>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">


	//fill the list with elements
	loadSport = function(genre){
		$("#Sports").empty();
		$("#Sports").append($("<h1>Sports</h1>"));
		sports = getSports();
		for(let s of sports){
			let el = $("<p></p>");
			el.click(function(){
				$("#Teams").empty();
				$("#Teams").append($("<h1>Teams</h1>"));
				$("#Sports").children().css("color", "black");
				$(this).css("color", "red");
				//loadGenre(s);
				loadTeams(s, genre);
			});
			el.text(s);
			$("#Sports").append(el);
		}
	}

	loadTeams = function(sport, genre){
		teams = getTeams(sport);
		for(let t of teams){
			let el = $("<p></p>");
			let route = "/team/" +  t + "/" + sport + "/" + genre;
			let ref = $("<a href=" + route + "></a>");
			el.append(ref);
			ref.text(t);

			$("#Teams").append(el);
		}
	}

	//implement here the comunication with de database
	getSports = function(){
		return ["Balonmano", "Rugby", "Remo"];
	}

	getGenre = function(sport){
		return ["male", "female"];
	}

	getTeams = function(){
		return ["Fisicas", "mates", "Biologicas"];
	}
</script>

<%@ include file="../jspf/footer.jspf"%>
