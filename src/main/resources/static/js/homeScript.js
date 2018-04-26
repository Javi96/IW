"use strict"
$(function () {
    $('.button-checkbox').each(function () {

        // Settings
        var $widget = $(this),
            $button = $widget.find('button'),
            $checkbox = $widget.find('input:checkbox'),
            color = $button.data('color'),
            settings = {
                on: {
                    icon: 'glyphicon glyphicon-check'
                },
                off: {
                    icon: 'fa fa-square-o'
                }
            };

        // Event Handlers
        $button.on('click', function () {
            $checkbox.prop('checked', !$checkbox.is(':checked'));
            $checkbox.triggerHandler('change');
            updateDisplay();
        });
        $checkbox.on('change', function () {
            updateDisplay();
        });

        // Actions
        function updateDisplay() {
            var isChecked = $checkbox.is(':checked');
            	if(isChecked){
            		$button.data('state',"on")
            	}
            	else{
            		$button.data('state',"off");
            		
            	}
            
            // Set the button's icon
            $button.find('.state-icon')
                .removeClass()
                .addClass('state-icon ' + settings[$button.data('state')].icon);

            // Update the button's color
            if (isChecked) {
            	$('.sub').removeClass('btn-danger active');
                $button
                    .removeClass('btn-default')
                    .addClass('btn-' + color + ' active');
            }
            else {
                $button
                    .removeClass('btn-' + color + ' active')
                    .addClass('btn-default');
            }
        }
 
        // Initialization
        function init() {
            updateDisplay();
            // Inject the icon if applicable
            if ($button.find('.state-icon').length == 0) {
                $button.prepend('<i class="state-icon ' + settings[$button.data('state')].icon + '"></i> ');
            }
        }
        init();
    });
    
    $("#maleBtn").click(function(o){
    	$( "#female" ).prop( "checked", false );
    	$( "#femBtn i").removeClass().addClass('state-icon fa fa-square-o');
    	$('#arrowHeader').hide();
    	$('#teams').empty();
    	$('#teamNameList').remove();
    });
    
    $("#femBtn").click(function(o){
    	$( "#male" ).prop( "checked", false );
    	$( "#maleBtn i").removeClass().addClass('state-icon fa fa-square-o');
    	$('#arrowHeader').hide();
    	$('#teams').empty();
    	$('#teamNameList').remove();
    });
    
    //Sports list
    $(".sub").click(function (o) {
		o.preventDefault();
		$('#sportsHeader').show();
		$('#sports').show();
		let category = $('#male').is(":checked") ? "Femenino" : "Masculino";
		$('#sports').empty();
		$.get("/showSportsByGender", {category: category},
		function(data) {
			//$('#sports').empty();
			let teamInfo = data.split("'");
			for(let i = 0; i < teamInfo.length; i++){
				let team = JSON.parse(teamInfo[i]);
				let sport = $('<input>').addClass('list-group-item inputSports all pull-center').attr('type','submit').attr('value',team.sport)
				.attr('onClick', 'getTeams(\"' + team.sport + '\");');
				let li = $('<li>').addClass('list-group-item');
				li.append(sport);
				$('#sports').append(li);
			}
		});
	});
    
    $('#sportsHeader').hide();
    $('#sports').hide();
    $('#arrowHeader').hide();
});

function getTeams(sport) {
	if($('#sportsHeader').children().length == 1)
		$('#sportsHeader').append($('<div>').addClass('col-md-6 spHeader').text('Equipos').attr('id','teamNameList'));
	let category = $('#male').is(":checked") ? "Femenino" : "Masculino";
	$('#teams').empty();
	$.get("/showTeamsBySportsAndGender", {category: category, sport: sport},	
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
	});
}

