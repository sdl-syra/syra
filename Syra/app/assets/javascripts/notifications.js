$(document).ready(function() {
	$('.resetbadgenotif').click(function() {
		if ($("#notifications_container").children().length==0) {
			$.ajax({
			  url: "/get_notifs_header",
			  type: "get"
			});
		}
		if ($("#badgeNotif").length==1) { 
			$("#badgeNotif").hide();
			$.ajax({
			  url: "/all_notif_checked",
			  type: "post"
			});
		}
	});
});
