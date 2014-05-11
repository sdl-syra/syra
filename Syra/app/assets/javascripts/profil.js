$(document).ready(function() {
  jQuery(".best_in_place").best_in_place();
});

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

$(document).ready(toggleHobbies);
$(document).on('page:load',toggleHobbies);
$(document).ready(toggleBirthday);
$(document).on('page:load',toggleBirthday);
