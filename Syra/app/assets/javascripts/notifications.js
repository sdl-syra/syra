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