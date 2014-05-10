function addMarkerArray( markersArray, map)
    { 
        for(var i = 0; i < markersArray.length ; i++) 
        {
          var latitude2 = markersArray[i].y;
          var longitude2 = markersArray[i].x;
          var myLatlng2 = new google.maps.LatLng(latitude2,longitude2);
          var marker2 = new google.maps.Marker({
              position: myLatlng2,
              map: map,
              title:"One title"
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

    var marker = new google.maps.Marker({  
                    map: map,  
                    position: location,  
                    animation: google.maps.Animation.DROP,  
                    title: "Vous êtes ici",
                    icon: pinImage,
                    shadow: pinShadow  
                });  
    map.setCenter(location);
    var myJSON = [
{lat : 10.010232,long: 34.123232},
{lat : 23.122323,long: 76.343434},
{lat : 43.123434,long: 74.12343}
]; //Test data

      $.getJSON('', function(data) {
      // you can access your data here in the "data" variable passed to this success handler
          addMarkerArray(data,map);          
      });  
  
}

function showError() {  
    alert("Location cant be found");  
} 


$(document).ready(function() {
  if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(GoogleMap, showError);
      navigator.geolocation.getCurrentPosition(function(pos){
        $.post('/set_geolocation', {latitude: pos.coords.latitude, longitude: pos.coords.longitude});
        /* document.cookie = document.cookie + '; latitude=pos.coords.latitude; longitude=pos.coords.longitude' */
    });
  }  
  else {  
      alert("Your browser does not support Geolocation.");  
  }
});