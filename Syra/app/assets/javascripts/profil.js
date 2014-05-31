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
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#imgtopreview').attr('src', e.target.result);
            $("#imgtopreview").attr("width",$('#avatarcontainer').width());
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



$(document).ready(launchBestInPlace);
$(document).ready(toggleHobbies);
$(document).ready(toggleBirthday);
$(document).ready(launchModal);