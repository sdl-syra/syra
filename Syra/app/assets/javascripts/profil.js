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
        $('#currentbirthday').hide();
    });
};

function readURL(input) {
    if (input.files && input.files[0]) {
    	var ext = input.value.split(".")[1].toUpperCase();
    	if (ext != "PNG" && ext != "JPG" && ext != "JPEG") {
    		alert("Formats jpg et png uniquement.");
    		input.value = "";
    		return;
    	}
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#imgtopreview').attr('src', e.target.result);
        };
        reader.readAsDataURL(input.files[0]);
    }
}

$(document).ready(function() {
	$("#user_avatar").change(function(){
    	readURL(this);
	});
});

var launchModal = function() {
    $('#currentavatar').click(function() {
    	$('#myModal').appendTo($("body"));
    	$('#myModal').modal('show');
    });
};

$(document).ready(function(){
	$( "#banformexpander" ).click(function() {
		$( "#banformexpander" ).hide();
		$('#toexpand').collapse("toggle");
	});
});

$(document).ready(function() {
    $("#content").find("[id^='tab']").hide(); 
    $("#tabs li:first").attr("id","current"); 
    $("#content #tab1").fadeIn(); 
    $('#tabs a').click(function(e) {
        e.preventDefault();
        if ($(this).closest("li").attr("id") == "current"){ 
         return;       
        }
        else{             
          $("#content").find("[id^='tab']").hide(); 
          $("#tabs li").attr("id",""); 
          $(this).parent().attr("id","current"); 
          $('#' + $(this).attr('name')).fadeIn();
        }
    });
});

$(document).ready(launchBestInPlace);
$(document).ready(toggleHobbies);
$(document).ready(toggleBirthday);
$(document).ready(launchModal);