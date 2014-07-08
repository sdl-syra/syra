$(document).ready(function() {
	$('.resetbadgenotif').click(function() { 
		if ($("#badgeNotif").length==1) { 
			$("#badgeNotif").hide();
			$.ajax({
			  url: "/all_notif_checked",
			  type: "post"
			});
		}
	});
});

$(document).ready(function() {
    var $lightbox = $('#allnotifs');    
    $lightbox.on('shown.bs.modal', function (e) {
        var w = $(window).width() - ($(window).width()/2);
        $lightbox.find('.toexpandnotifs').css({'width': w});
        $lightbox.find('.close').removeClass('hidden');
    });
});
