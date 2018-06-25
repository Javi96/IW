"use strict"

$(function () {
	$('#sendAgain').click(function(e) {
		
		 let p = $('#message').val();
	     let trans = $('#transmitter_id').val(); 
	     let res = $('#receiver2').val();
	     
	     $.ajax({
	 	    method: "post",  
	 	    url: "/contactUser",
	 	    data:
	 	    {
	 	    	message: p,
	 	    	transmitter_id: trans,
	 	    	receiver_id : res
	 	    },
	 	    success: (data)=>{
	 	    	console.log(data);
	 	    },
	 	    error: (XMLHttpRequest, textStatus, errorThrown)=> {
	 	    	console.log(XMLHttpRequest);
	 	    	console.log(textStatus);
	 	    	console.log(errorThrown);
	 	        alert("Ha ocurrido un error inesperado"); 
	 	    }       
	 	});
	     
		
	});
});
