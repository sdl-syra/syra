$(document).ready(function() {
	$('.resetbadgenotif').click(function() {  
		$("#badgeNotif").hide();
		$.ajax({
		  url: "/all_notif_checked",
		  type: "post"
		});
	});
});
$(document).ready(function() {
	$('.deletenotif').click(function() {
		var li = this.parentNode.parentNode;
		$(li).fadeOut(400, function() {
			li.remove();
			if ($(".notifmenu").children().size()==1) {
				$("#toutsupprnotif").remove();
				$(".notifmenu").append("<li><a href=#>Aucune notification</a></li>");
			}
		});
		$('.dropdown-menu').dropdown('toggle');
		$.ajax({
		  url: "/notifications/" + $(this).attr('data-id'),
		  type: "post",
		  dataType: "json",
		  data: {"_method":"delete"}
		});
	});
});