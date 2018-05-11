<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../jspf/header.jspf"%>



<!------ Include the above in your HEAD tag ---------->

<!DOCTYPE html>
<html>
<head>
<link type="text/css" media="screen" rel="stylesheet" href="${s}/css/calendarPrueba.css" />
<script src = "${s}/js/calendarPrueba.js"></script>


<link href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500,500i,700,700i,900,900i" rel="stylesheet">

<script>

	$(document).ready(function() {
	    var date = new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();
		
		/*  className colors
		
		className: default(transparent), important(red), chill(pink), success(green), info(blue)
		
		*/		
		
		  
		/* initialize the external events
		-----------------------------------------------------------------*/
	
		$('#external-events div.external-event').each(function() {
		
			// create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
			// it doesn't need to have a start or end
			var eventObject = {
				title: $.trim($(this).text()) // use the element's text as the event title
			};
			
			// store the Event Object in the DOM element so we can get to it later
			$(this).data('eventObject', eventObject);
			
			// make the event draggable using jQuery UI
			$(this).draggable({
				zIndex: 999,
				revert: true,      // will cause the event to go back to its
				revertDuration: 0  //  original position after the drag
			});
			
		});
	
	
		/* initialize the calendar
		-----------------------------------------------------------------*/
		
		var calendar =  $('#calendar').fullCalendar({
			header: {
				left: 'title',
				center: 'agendaDay,agendaWeek,month',
				right: 'prev,next today'
			},
			editable: true,
			firstDay: 1, //  1(Monday) this can be changed to 0(Sunday) for the USA system
			selectable: true,
			defaultView: 'month',
			
			axisFormat: 'h:mm',
			columnFormat: {
                month: 'ddd',    // Mon
                week: 'ddd d', // Mon 7
                day: 'dddd M/d',  // Monday 9/7
                agendaDay: 'dddd d'
            },
            titleFormat: {
                month: 'MMMM yyyy', // September 2009
                week: "MMMM yyyy", // September 2009
                day: 'MMMM yyyy'                  // Tuesday, Sep 8, 2009
            },
			allDaySlot: false,
			selectHelper: true,
			select: function(start, end, allDay) {
				var title = prompt('Event Title:');
				if (title) {
					calendar.fullCalendar('renderEvent',
						{
							title: title,
							start: start,
							end: end,
							allDay: allDay
						},
						true // make the event "stick"
					);
				}
				calendar.fullCalendar('unselect');
			},
			droppable: true, // this allows things to be dropped onto the calendar !!!
			drop: function(date, allDay) { // this function is called when something is dropped
			
				// retrieve the dropped element's stored Event Object
				var originalEventObject = $(this).data('eventObject');
				
				// we need to copy it, so that multiple events don't have a reference to the same object
				var copiedEventObject = $.extend({}, originalEventObject);
				
				// assign it the date that was reported
				copiedEventObject.start = date;
				copiedEventObject.allDay = allDay;
				
				// render the event on the calendar
				// the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
				$('#calendar').fullCalendar('renderEvent', copiedEventObject, true);
				
				// is the "remove after drop" checkbox checked?
				if ($('#drop-remove').is(':checked')) {
					// if so, remove the element from the "Draggable Events" list
					$(this).remove();
				}
				
			},
			
			events: [
				{
					title: 'All Day Event',
					start: new Date(y, m, 1)
				},
				{
					id: 999,
					title: 'Repeating Event',
					start: new Date(y, m, d-3, 16, 0),
					allDay: false,
					className: 'info'
				},
				{
					id: 999,
					title: 'Repeating Event',
					start: new Date(y, m, d+4, 16, 0),
					allDay: false,
					className: 'info'
				},
				{
					title: 'Meeting',
					start: new Date(y, m, d, 10, 30),
					allDay: false,
					className: 'important'
				},
				{
					title: 'Lunch',
					start: new Date(y, m, d, 12, 0),
					end: new Date(y, m, d, 14, 0),
					allDay: false,
					className: 'important'
				},
				{
					title: 'Birthday Party',
					start: new Date(y, m, d+1, 19, 0),
					end: new Date(y, m, d+1, 22, 30),
					allDay: false,
				},
				{
					title: 'Click for Google',
					start: new Date(y, m, 28),
					end: new Date(y, m, 29),
					url: 'http://google.com/',
					className: 'success'
				}
			],			
		});
		
		
	});

</script>
<style>

	body {
	    margin-bottom: 40px;
		margin-top: 40px;
		text-align: center;
		font-size: 14px;
		font-family: 'Roboto', sans-serif;
		}
		
	#wrap {
		width: 1100px;
		margin: 0 auto;
		}
		
	#external-events {
		float: left;
		width: 150px;
		padding: 0 10px;
		text-align: left;
		}
		
	#external-events h4 {
		font-size: 16px;
		margin-top: 0;
		padding-top: 1em;
		}
		
	.external-event { /* try to mimick the look of a real event */
		margin: 10px 0;
		padding: 2px 4px;
		background: #3366CC;
		color: #fff;
		font-size: .85em;
		cursor: pointer;
		}
		
	#external-events p {
		margin: 1.5em 0;
		font-size: 11px;
		color: #666;
		}
		
	#external-events p input {
		margin: 0;
		vertical-align: middle;
		}

	#calendar {
/* 		float: right; */
        margin: 0 auto;
		width: 900px;
		background-color: #FFFFFF;
		  border-radius: 6px;
        box-shadow: 0 1px 2px #C3C3C3;
		-webkit-box-shadow: 0px 0px 21px 2px rgba(0,0,0,0.18);
-moz-box-shadow: 0px 0px 21px 2px rgba(0,0,0,0.18);
box-shadow: 0px 0px 21px 2px rgba(0,0,0,0.18);
		}

</style>
</head>
<body>

<div id='wrap'>

<div id='calendar' class="fc fc-ltr">
 
<table class="fc-header" style="width:100%">
   <tbody>
      <tr>
         <td class="fc-header-left">
            <span class="fc-header-title">
               <h2>March 2018</h2>
            </span>
         </td>
         <td class="fc-header-right"><span class="fc-button fc-button-prev fc-state-default fc-corner-left" unselectable="on" style="-moz-user-select: none;"><span class="fc-text-arrow">‹</span></span><span class="fc-button fc-button-next fc-state-default fc-corner-right" unselectable="on" style="-moz-user-select: none;"><span class="fc-text-arrow">›</span></span><span class="fc-header-space"></span><span class="fc-button fc-button-today fc-state-default fc-corner-left fc-corner-right fc-state-disabled" unselectable="on" style="-moz-user-select: none;">today</span></td>
      </tr>
   </tbody>
</table>
<div class="fc-content" style="position: relative;">
   <div class="fc-view fc-view-month fc-grid" style="position: relative; -moz-user-select: none;" unselectable="on">
     
      <table class="fc-border-separate" style="width:100%" cellspacing="0">
         <thead>
            <tr class="fc-first fc-last">
               <th class="fc-day-header fc-mon fc-widget-header fc-first" style="width: 128px;">Mon</th>
               <th class="fc-day-header fc-tue fc-widget-header" style="width: 128px;">Tue</th>
               <th class="fc-day-header fc-wed fc-widget-header" style="width: 128px;">Wed</th>
               <th class="fc-day-header fc-thu fc-widget-header" style="width: 128px;">Thu</th>
               <th class="fc-day-header fc-fri fc-widget-header" style="width: 128px;">Fri</th>
               <th class="fc-day-header fc-sat fc-widget-header" style="width: 128px;">Sat</th>
               <th class="fc-day-header fc-sun fc-widget-header fc-last">Sun</th>
            </tr>
         </thead>
         <tbody>
            <tr class="fc-week fc-first">
               <td class="fc-day fc-mon fc-widget-content fc-other-month fc-past fc-first" data-date="2018-02-26">
                  <div style="min-height: 106px;">
                     <div class="fc-day-number">26</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 28px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-tue fc-widget-content fc-other-month fc-past" data-date="2018-02-27">
                  <div>
                     <div class="fc-day-number">27</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 28px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-wed fc-widget-content fc-other-month fc-past" data-date="2018-02-28">
                  <div>
                     <div class="fc-day-number">28</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 28px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-thu fc-widget-content fc-past" data-date="2018-03-01">
                  <div>
                     <div class="fc-day-number">1</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 28px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-fri fc-widget-content fc-past" data-date="2018-03-02">
                  <div>
                     <div class="fc-day-number">2</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 28px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-sat fc-widget-content fc-past" data-date="2018-03-03">
                  <div>
                     <div class="fc-day-number">3</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 28px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-sun fc-widget-content fc-past fc-last" data-date="2018-03-04">
                  <div>
                     <div class="fc-day-number">4</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 28px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
            </tr>
            <tr class="fc-week">
               <td class="fc-day fc-mon fc-widget-content fc-past fc-first" data-date="2018-03-05">
                  <div style="min-height: 105px;">
                     <div class="fc-day-number">5</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 0px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-tue fc-widget-content fc-past" data-date="2018-03-06">
                  <div>
                     <div class="fc-day-number">6</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 0px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-wed fc-widget-content fc-past" data-date="2018-03-07">
                  <div>
                     <div class="fc-day-number">7</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 0px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-thu fc-widget-content fc-past" data-date="2018-03-08">
                  <div>
                     <div class="fc-day-number">8</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 0px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-fri fc-widget-content fc-past" data-date="2018-03-09">
                  <div>
                     <div class="fc-day-number">9</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 0px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-sat fc-widget-content fc-past" data-date="2018-03-10">
                  <div>
                     <div class="fc-day-number">10</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 0px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-sun fc-widget-content fc-past fc-last" data-date="2018-03-11">
                  <div>
                     <div class="fc-day-number">11</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 0px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
            </tr>
            <tr class="fc-week">
               <td class="fc-day fc-mon fc-widget-content fc-past fc-first" data-date="2018-03-12">
                  <div style="min-height: 105px;">
                     <div class="fc-day-number">12</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 28px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-tue fc-widget-content fc-past" data-date="2018-03-13">
                  <div>
                     <div class="fc-day-number">13</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 28px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-wed fc-widget-content fc-past" data-date="2018-03-14">
                  <div>
                     <div class="fc-day-number">14</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 28px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-thu fc-widget-content fc-past" data-date="2018-03-15">
                  <div>
                     <div class="fc-day-number">15</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 28px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-fri fc-widget-content fc-past" data-date="2018-03-16">
                  <div>
                     <div class="fc-day-number">16</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 28px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-sat fc-widget-content fc-past" data-date="2018-03-17">
                  <div>
                     <div class="fc-day-number">17</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 28px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-sun fc-widget-content fc-past fc-last" data-date="2018-03-18">
                  <div>
                     <div class="fc-day-number">18</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 28px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
            </tr>
            <tr class="fc-week">
               <td class="fc-day fc-mon fc-widget-content fc-past fc-first" data-date="2018-03-19">
                  <div style="min-height: 105px;">
                     <div class="fc-day-number">19</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 56px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-tue fc-widget-content fc-today fc-state-highlight" data-date="2018-03-20">
                  <div>
                     <div class="fc-day-number">20</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 56px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-wed fc-widget-content fc-future" data-date="2018-03-21">
                  <div>
                     <div class="fc-day-number">21</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 56px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-thu fc-widget-content fc-future" data-date="2018-03-22">
                  <div>
                     <div class="fc-day-number">22</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 56px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-fri fc-widget-content fc-future" data-date="2018-03-23">
                  <div>
                     <div class="fc-day-number">23</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 56px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-sat fc-widget-content fc-future" data-date="2018-03-24">
                  <div>
                     <div class="fc-day-number">24</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 56px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-sun fc-widget-content fc-future fc-last" data-date="2018-03-25">
                  <div>
                     <div class="fc-day-number">25</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 56px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
            </tr>
            <tr class="fc-week">
               <td class="fc-day fc-mon fc-widget-content fc-future fc-first" data-date="2018-03-26">
                  <div style="min-height: 105px;">
                     <div class="fc-day-number">26</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 28px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-tue fc-widget-content fc-future" data-date="2018-03-27">
                  <div>
                     <div class="fc-day-number">27</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 28px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-wed fc-widget-content fc-future" data-date="2018-03-28">
                  <div>
                     <div class="fc-day-number">28</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 28px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-thu fc-widget-content fc-future" data-date="2018-03-29">
                  <div>
                     <div class="fc-day-number">29</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 28px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-fri fc-widget-content fc-future" data-date="2018-03-30">
                  <div>
                     <div class="fc-day-number">30</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 28px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-sat fc-widget-content fc-future" data-date="2018-03-31">
                  <div>
                     <div class="fc-day-number">31</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 28px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-sun fc-widget-content fc-other-month fc-future fc-last" data-date="2018-04-01">
                  <div>
                     <div class="fc-day-number">1</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 28px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
            </tr>
            <tr class="fc-week fc-last">
               <td class="fc-day fc-mon fc-widget-content fc-other-month fc-future fc-first" data-date="2018-04-02">
                  <div style="min-height: 105px;">
                     <div class="fc-day-number">2</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 0px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-tue fc-widget-content fc-other-month fc-future" data-date="2018-04-03">
                  <div>
                     <div class="fc-day-number">3</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 0px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-wed fc-widget-content fc-other-month fc-future" data-date="2018-04-04">
                  <div>
                     <div class="fc-day-number">4</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 0px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-thu fc-widget-content fc-other-month fc-future" data-date="2018-04-05">
                  <div>
                     <div class="fc-day-number">5</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 0px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-fri fc-widget-content fc-other-month fc-future" data-date="2018-04-06">
                  <div>
                     <div class="fc-day-number">6</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 0px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-sat fc-widget-content fc-other-month fc-future" data-date="2018-04-07">
                  <div>
                     <div class="fc-day-number">7</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 0px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
               <td class="fc-day fc-sun fc-widget-content fc-other-month fc-future fc-last" data-date="2018-04-08">
                  <div>
                     <div class="fc-day-number">8</div>
                     <div class="fc-day-content">
                        <div style="position: relative; height: 0px;">&nbsp;</div>
                     </div>
                  </div>
               </td>
            </tr>
         </tbody>
      </table>
      
   </div> 
</div>

</div>

<div style='clear:both'></div>
</div>
</body>
</html>


<%@ include file="../jspf/footer.jspf"%>

