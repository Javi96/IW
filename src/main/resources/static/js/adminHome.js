"use strict"

$(function(){
	loadData();
});

function loadData(){
	$.ajax({
	    method: "GET",  
	    url: "/getTeam",
	    data: {teamId: teamId},
	    success: (data)=>{
	    	data = JSON.parse(data);
	    	let date = data.date.split('-');
	    	
	    },
	    error: (XMLHttpRequest, textStatus, errorThrown)=> { 
	        alert("Status: " + textStatus);
	        alert("Error: " + errorThrown); 
	    }       
	});
}