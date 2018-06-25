"use strict"

$(function(){
	$(".checkMale").click(function() {
		$(".checkFemale").prop('checked', false);
	});
	$(".checkFemale").click(function() {
		$(".checkMale").prop('checked', false);
	});
});


function loadData(id){
	$.ajax({
	    method: "GET",  
	    url: "/getTeam",
	    data: {id: id},
	    success: (data)=>{
	    	data = JSON.parse(data);
	    	$("#teamName").val(data.name);
	    	$("#sport").val(data.sport);
	    	$("#school").val(data.school);
	    	$("#deputyEmail").val(data.deputyEmail);
	    	$("#nextMatchSchedule").val(data.nextMatchSchedule);
	    	$("#nextMatchFacilities").val(data.nextMatchFacilities);
	    	$("#trainingSchedule").val(data.trainingSchedule);
	    	$("#teamId").val(id);
	    	$("#searchSport").val(data.sport);
	    	$("#description").val(data.description);
	    	if(data.category === "Masculino")
	    		$(".checkMale").prop('checked', true);
	    	else
	    		$(".checkFemale").prop('checked', true);
	    	
	    },
	    error: (XMLHttpRequest, textStatus, errorThrown)=> { 
	        alert("Status: " + textStatus);
	        alert("Error: " + errorThrown); 
	    }       
	});
}
