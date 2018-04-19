<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	

<%@ include file="../jspf/header.jspf"%>
<link type="text/css" media="screen" rel="stylesheet" href="${s}/css/home.css" />

<script type="text/javascript">
	$(document).ready(function(){
			loadSport();
	});
	
	//fill the list with elements
	loadSport = function(){
		sports = getSports();
		for(let s of sports){
			let el = $("<p></p>");
			el.click(function(){
				$("#Genre").empty();
				$("#Genre").append($("<h1>Genre</h1>"));
				$("#Teams").empty();
				$("#Teams").append($("<h1>Teams</h1>"));
				$("#Sports").children().css("color", "black");
				$(this).css("color", "red");
				loadGenre(s);
			});
			el.text(s);
			$("#Sports").append(el);
		}
	}
	
	loadGenre = function(sport){
		genres = getGenre(sport);
		for(let g of genres){
			let el = $("<p></p>");
			el.text(g);
			el.click( function(){
				$("#Teams").empty();
				$("#Teams").append($("<h1>Teams</h1>"));
				$("#Genre").children().css("color", "black");
				$(this).css("color", "red");
				loadTeams(sport, g);
			});
			$("#Genre").append(el);
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
<div class="container">
<div id = "Sports" class="list">
	<h1>Sports</h1>
</div>

<div id = "Genre" class ="list">
	<h1>Genre</h1>
</div>

<div id = "Teams" class="list">
	<h1>Teams</h1>
</div>
</div>

<%@ include file="../jspf/footer.jspf"%>
