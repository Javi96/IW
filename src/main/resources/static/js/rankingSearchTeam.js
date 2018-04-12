"use strict";

function searchTeam(){
    let searchedTeam =  String($('#searchTeam').prop('value').toLowerCase());
    $("table tbody tr").each(function(index) {
        let team = String($(this).children("td:eq(0)").text().toLowerCase());
        let contains = team.includes(searchedTeam);
        if(contains && searchedTeam !== ''){
            $(this).css('background-color', '#4BB543');
        }
        if(searchedTeam === '' || !contains){
            $(this).css('background-color', 'white');
        }
    });
};

function search(){
    searchTeam();
    setInterval(searchTeam,200);
};
