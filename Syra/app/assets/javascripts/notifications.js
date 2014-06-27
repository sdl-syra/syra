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
/*$(document).ready(function() {
	$('.deletenotif').click(function() {
		var li = this.parentNode.parentNode;
		$(li).fadeOut(400, function() {
			li.remove();
			if ($(".notifmenu").children().size()==1) {
				$("#showallnotifs").remove();
				$(".notifmenu").append("<li><a href=#>Aucune notification</a></li>");
			}
		});
		$('.notifmenu').dropdown('toggle');
		$.ajax({
		  url: "/notifications/" + $(this).attr('data-id'),
		  type: "delete",
		  dataType: "json"
		});
	});
});*/