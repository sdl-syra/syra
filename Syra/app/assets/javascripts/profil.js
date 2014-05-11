var launchBestInPlace = function() {
  jQuery(".best_in_place").best_in_place();
};

var toggleHobbies = function(){
    $('#currenthobbies').click(function() {  
        $('#hobbiesedit').toggle();
        $('#currenthobbies').toggle();
    });
};

var toggleBirthday = function(){
    $('#currentbirthday').click(function() {  
        $('#birthdayedit').toggle();
        $('#currentbirthday').toggle();
    });
};


$(document).ready(launchBestInPlace);
$(document).ready(toggleHobbies);
$(document).ready(toggleBirthday);
