"use strict"

function getGET()
{
    // capturamos la url
    var loc = document.location.href;
    // si existe el interrogante
    if(loc.indexOf('?')>0)
    {
        // cogemos la parte de la url que hay despues del interrogante
        var getString = loc.split('?')[1];
        // obtenemos un array con cada clave=valor
        var GET = getString.split('&');
        var get = {};
        // recorremos todo el array de valores
        for(var i = 0, l = GET.length; i < l; i++){
            var tmp = GET[i].split('=');
            get[tmp[0]] = unescape(decodeURI(tmp[1]));
        }
        
        return get;
    }
}
    
$( document ).ready(function() {
	
	var valores = getGET();	
	var team = valores['team'];
	console.log(team);
	$.get("/fillGallery", {team: team},
			function(data) {
				$('#gallery_body').empty();
				let galleries = data.split("'");
				for(let i = 0; i < galleries.length; i++){
					let gallery = JSON.parse(galleries[i]);
					var name = galleries[i].split('"')[5];
					var files = galleries[i].split('"')[9];
					var text = '<tr> <td style="text-align: left">"'+name+'"</td>';
					text += '<th style="text-align: left">"'+files+'"</th>';
					text += '<th style="text-align: right"><form action = "/gallery_good" method="get"  class="btn-group teamButtonsStyle" id = "gallery">';
					text += '<button type="submit" class="btn btn-primary">Ver galería</button>';
					text += '<input type="hidden" name = "team" value="team">';
					text += '<input type="hidden" name = "gallery" value="${gallery.name}"></form></th></tr>';
					$('#gallery_body').append(text);
					
				}
			});
});