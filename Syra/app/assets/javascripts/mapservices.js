var showYoureHere = true;

function getAvgPosition() {
	var markersArray = jQuery.parseJSON($("#json").text());
	var avgLat = 0;
	var avgLng = 0;
	for(var i = 0; i < markersArray.length ; i++) {
		var latitude2 = markersArray[i].address.y;
        avgLat += latitude2;
        var longitude2 = markersArray[i].address.x;
        avgLng += longitude2;
	}
	var position = new Object();
	position.coords = new Object();
	position.coords.latitude = (avgLat/markersArray.length);
	position.coords.longitude = (avgLng/markersArray.length);
	return position;
}

function addMarkerArray( markersArray, map)
    { 
        for(var i = 0; i < markersArray.length ; i++) 
        {
          var latitude2 = markersArray[i].address.y;
          var longitude2 = markersArray[i].address.x;
          var myLatlng2 = new google.maps.LatLng(latitude2,longitude2);
          var titreService = markersArray[i].title;
          var idService = markersArray[i].id;
          //alert(idService);
          var marker2 = new google.maps.Marker({
              position: myLatlng2,
              map: map,
              url: '/services/'+idService,
              title:titreService
          });

          google.maps.event.addListener(marker2, 'click', function() {
            window.location.href = this.url;
          });
        }
    }



function GoogleMap(position) {  
    var location = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
    $('#q_address_x').val(position.coords.latitude);
    $('#q_address_y').val(position.coords.longitude);
    var myMapOptions = {
      zoom:8,
      center:location,
      mapTypedId: google.maps.MapTypeId.ROADMAP
    };

    var map = new google.maps.Map(
      document.getElementById('map'),
      myMapOptions
    );

    var pinColor = "FE7569";
    var pinImage = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|" + pinColor,
        new google.maps.Size(21, 34),
        new google.maps.Point(0,0),
        new google.maps.Point(10, 34));
    var pinShadow = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_shadow",
        new google.maps.Size(40, 37),
        new google.maps.Point(0, 0),
        new google.maps.Point(12, 35));

	if (showYoureHere) {
	    var marker = new google.maps.Marker({  
	                    map: map,  
	                    position: location,  
	                    animation: google.maps.Animation.DROP,  
	                    title: "Vous êtes ici",
	                    icon: pinImage,
	                    shadow: pinShadow  
	                });
    }  
    map.setCenter(location);
    var myJSON = [
{lat : 10.010232,long: 34.123232},
{lat : 23.122323,long: 76.343434},
{lat : 43.123434,long: 74.12343}
]; //Test data

      var services = jQuery.parseJSON($("#json").text());
      addMarkerArray(services,map); 
  
}

function handleError() {  
    console.log("Location cant be found");
    showYoureHere = false;
 	GoogleMap(getAvgPosition());    
} 


window.onload = function() {
  if (navigator.geolocation) {
  	  $.ajaxSetup({ cache: false });
      navigator.geolocation.getCurrentPosition(GoogleMap, handleError);
      navigator.geolocation.getCurrentPosition(function(pos){
        $.post('/set_geolocation', {latitude: pos.coords.latitude, longitude: pos.coords.longitude});
        /* document.cookie = document.cookie + '; latitude=pos.coords.latitude; longitude=pos.coords.longitude' */
    });
  }  
  else {  
      alert("Your browser does not support Geolocation.");  
  }
};