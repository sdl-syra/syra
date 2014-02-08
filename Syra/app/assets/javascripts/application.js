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

$(document).ready(function() {
  /* Activating Best In Place */
  jQuery(".best_in_place").best_in_place();
});

function toggleModeHobbies() {
	var hobbiesedit = document.getElementById("hobbiesedit");
	var buttonToggle = document.getElementById("buttonToggle");
	var currenthobbies = document.getElementById("currenthobbies");
	if (hobbiesedit.style.display == "block") {
		hobbiesedit.style.display = "none";
		buttonToggle.style.display = "block";
		currenthobbies.style.display = "block";
	} else {
		buttonToggle.style.display = "none";
		hobbiesedit.style.display = "block";
		currenthobbies.style.display = "none";
	}
}

