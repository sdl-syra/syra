// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require best_in_place
//= require jquery.purr
//= require best_in_place.purr
//= require jquery.ui.all

$(document).ready(function() {
  jQuery(".best_in_place").best_in_place();
});


$(document).on('page:load',function(){
    $('#currenthobbies').click(function() {  
        $('#hobbiesedit').toggle();
        $('#currenthobbies').toggle();
    });
});

$(document).on('page:load',function(){
    $('#currentbirthday').click(function() {  
        $('#birthdayedit').toggle();
        $('#currentbirthday').toggle();
    });
});

$(document).ready(function(){
    $('#carouselServices').carousel({
        interval: 4000
    });
});
