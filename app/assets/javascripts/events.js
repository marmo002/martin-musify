// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function eventShowMap() {
  // Create a map object and specify the DOM element for display.
  $.ajax({
    url: document.URL,
    method:'GET',
    dataType: 'JSON'
  }).done(function(response){
    eventLat = response["lat"];
    eventLng = response["lng"];

    coord = {lat: response["lat"], lng: response["lng"]};
    var styles = [
            {elementType: 'geometry', stylers: [{color: '#242f3e'}]},
            {elementType: 'labels.text.stroke', stylers: [{color: '#242f3e'}]},
            {elementType: 'labels.text.fill', stylers: [{color: '#746855'}]},
            {
              featureType: 'administrative.locality',
              elementType: 'labels.text.fill',
              stylers: [{color: '#d59563'}]
            },
            {
              featureType: 'poi',
              elementType: 'labels.text.fill',
              stylers: [{color: '#d59563'}]
            },
            {
              featureType: 'poi.park',
              elementType: 'geometry',
              stylers: [{color: '#263c3f'}]
            },
            {
              featureType: 'poi.park',
              elementType: 'labels.text.fill',
              stylers: [{color: '#6b9a76'}]
            },
            {
              featureType: 'road',
              elementType: 'geometry',
              stylers: [{color: '#38414e'}]
            },
            {
              featureType: 'road',
              elementType: 'geometry.stroke',
              stylers: [{color: '#212a37'}]
            },
            {
              featureType: 'road',
              elementType: 'labels.text.fill',
              stylers: [{color: '#9ca5b3'}]
            },
            {
              featureType: 'road.highway',
              elementType: 'geometry',
              stylers: [{color: '#746855'}]
            },
            {
              featureType: 'road.highway',
              elementType: 'geometry.stroke',
              stylers: [{color: '#1f2835'}]
            },
            {
              featureType: 'road.highway',
              elementType: 'labels.text.fill',
              stylers: [{color: '#f3d19c'}]
            },
            {
              featureType: 'transit',
              elementType: 'geometry',
              stylers: [{color: '#2f3948'}]
            },
            {
              featureType: 'transit.station',
              elementType: 'labels.text.fill',
              stylers: [{color: '#d59563'}]
            },
            {
              featureType: 'water',
              elementType: 'geometry',
              stylers: [{color: '#17263c'}]
            },
            {
              featureType: 'water',
              elementType: 'labels.text.fill',
              stylers: [{color: '#515c6d'}]
            },
            {
              featureType: 'water',
              elementType: 'labels.text.stroke',
              stylers: [{color: '#17263c'}]
            }
          ]

    googleMap = new google.maps.Map(document.getElementById('map'), {
      center: coord,
      disableDefaultUI: true,
      zoom: 13,
      styles: styles
    });
    var marker = new google.maps.Marker({
      map: googleMap,
      position: coord,
      title: response["venueName"]
    });
    var contentString = '<div class="content">'+
            '<h1>'+ response["venueName"] +'</h1> ' +
            '<p>'+ response["address_1"] + '</p>' +
            '<p>'+ response["city"] + '</p>' +
            '<p>'+ response["postal_code"] + '</p>' +
            '</div>';

    var infowindow = new google.maps.InfoWindow({
      content: contentString
    });

    marker.addListener('click', function() {
      infowindow.open(googleMap, marker);
    });
  })
  var formElement = document.querySelector("#map-form form")

  formElement.addEventListener("submit", function(e){
    e.preventDefault();

    var postalCode = document.querySelector("#postal-code-input").value

    $.ajax({
      url: '/events/location',
      method:'post',
      data: {postal_code: postalCode},
      dataType: 'JSON'
    }).done(function(response){


      //WAYPOINTS CREATION
      clientLocation = response["clientLocation"]
      clientLat = response["clientLocation"]["lat"];
      clientLng = response["clientLocation"]["lng"];
      var directionsDisplay;
      var directionsService = new google.maps.DirectionsService();
      directionsDisplay = new google.maps.DirectionsRenderer();
      directionsDisplay.setMap(googleMap);
      var start = new google.maps.LatLng(eventLat, eventLng);
      var end = new google.maps.LatLng(clientLat, clientLng);
      var request = {
        origin: start,
        destination: end,
        travelMode: 'WALKING'
      };

      directionsService.route(request, function(result, status) {
        if (status == 'OK') {
          directionsDisplay.setDirections(result);
        }
      });
    })
  })
}
