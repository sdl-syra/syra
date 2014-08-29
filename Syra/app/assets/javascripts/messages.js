$(document).ready(function(){
	$('.msgsdisplayer').on('shown.bs.dropdown', function() {
		$.ajax({
		  url: "/all_conversations",
		  type: "get"
		});
	});
});