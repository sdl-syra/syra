$(document).ready(function(){
	$('.msgsdisplayer').click(function() {
		if ($("#conversations_container").children().length==0) {
			$.ajax({
			  url: "/all_conversations",
			  type: "get"
			});
		}
	});
});