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

    var coord = {lat: response["lat"], lng: response["lng"]};
    var styles = [
        {
            "featureType": "all",
            "elementType": "labels.text.fill",
            "stylers": [
                {
                    "saturation": 36
                },
                {
                    "color": "#333333"
                },
                {
                    "lightness": 40
                }
            ]
        },
        {
            "featureType": "all",
            "elementType": "labels.text.stroke",
            "stylers": [
                {
                    "visibility": "on"
                },
                {
                    "color": "#ffffff"
                },
                {
                    "lightness": 16
                }
            ]
        },
        {
            "featureType": "all",
            "elementType": "labels.icon",
            "stylers": [
                {
                    "visibility": "off"
                }
            ]
        },
        {
            "featureType": "administrative",
            "elementType": "geometry.fill",
            "stylers": [
                {
                    "color": "#fefefe"
                },
                {
                    "lightness": 20
                }
            ]
        },
        {
            "featureType": "administrative",
            "elementType": "geometry.stroke",
            "stylers": [
                {
                    "color": "#fefefe"
                },
                {
                    "lightness": 17
                },
                {
                    "weight": 1.2
                }
            ]
        },
        {
            "featureType": "administrative",
            "elementType": "labels",
            "stylers": [
                {
                    "visibility": "on"
                }
            ]
        },
        {
            "featureType": "administrative",
            "elementType": "labels.text",
            "stylers": [
                {
                    "visibility": "on"
                }
            ]
        },
        {
            "featureType": "administrative",
            "elementType": "labels.icon",
            "stylers": [
                {
                    "weight": "1.09"
                },
                {
                    "visibility": "simplified"
                },
                {
                    "color": "#0cacd2"
                }
            ]
        },
        {
            "featureType": "administrative.locality",
            "elementType": "labels",
            "stylers": [
                {
                    "visibility": "on"
                }
            ]
        },
        {
            "featureType": "administrative.locality",
            "elementType": "labels.text",
            "stylers": [
                {
                    "visibility": "off"
                }
            ]
        },
        {
            "featureType": "administrative.locality",
            "elementType": "labels.text.stroke",
            "stylers": [
                {
                    "visibility": "on"
                }
            ]
        },
        {
            "featureType": "administrative.locality",
            "elementType": "labels.icon",
            "stylers": [
                {
                    "visibility": "simplified"
                },
                {
                    "hue": "#ff0000"
                },
                {
                    "weight": "5.13"
                }
            ]
        },
        {
            "featureType": "landscape",
            "elementType": "geometry",
            "stylers": [
                {
                    "color": "#f5f5f5"
                },
                {
                    "lightness": 20
                }
            ]
        },
        {
            "featureType": "poi",
            "elementType": "geometry",
            "stylers": [
                {
                    "color": "#f5f5f5"
                },
                {
                    "lightness": 21
                }
            ]
        },
        {
            "featureType": "poi.park",
            "elementType": "geometry",
            "stylers": [
                {
                    "color": "#dedede"
                },
                {
                    "lightness": 21
                }
            ]
        },
        {
            "featureType": "road.highway",
            "elementType": "geometry.fill",
            "stylers": [
                {
                    "color": "#343a40"
                },
                {
                    "lightness": 17
                }
            ]
        },
        {
            "featureType": "road.highway",
            "elementType": "geometry.stroke",
            "stylers": [
                {
                    "color": "#ffffff"
                },
                {
                    "lightness": 29
                },
                {
                    "weight": 0.2
                }
            ]
        },
        {
            "featureType": "road.arterial",
            "elementType": "geometry",
            "stylers": [
                {
                    "color": "#ffffff"
                },
                {
                    "lightness": 18
                }
            ]
        },
        {
            "featureType": "road.local",
            "elementType": "geometry",
            "stylers": [
                {
                    "color": "#ffffff"
                },
                {
                    "lightness": 16
                }
            ]
        },
        {
            "featureType": "transit",
            "elementType": "geometry",
            "stylers": [
                {
                    "color": "#f2f2f2"
                },
                {
                    "lightness": 19
                }
            ]
        },
        {
            "featureType": "water",
            "elementType": "geometry",
            "stylers": [
                {
                    "color": "#e9e9e9"
                },
                {
                    "lightness": 17
                }
            ]
        }
    ];

    map = new google.maps.Map(document.getElementById('map'), {
      // center: coord,
      disableDefaultUI: true,
      zoom: 13,
      styles: styles
    });

    // var marker = new google.maps.Marker({
    //   map: map,
    //   position: coord,
    //   title: response["venueName"]
    // });
    //
    // var contentString = '<div class="content">'+
    //         '<h1>'+ response["venueName"] +'</h1> ' +
    //         '<p>'+ response["address_1"] + '</p>' +
    //         '<p>'+ response["city"] + '</p>' +
    //         '<p>'+ response["postal_code"] + '</p>' +
    //         '</div>';
    //
    // var infowindow = new google.maps.InfoWindow({
    //   content: contentString
    // });
    //
    // marker.addListener('click', function() {
    //   infowindow.open(map, marker);
    // });


    var directionsDisplay;
    var directionsService = new google.maps.DirectionsService();

    directionsDisplay = new google.maps.DirectionsRenderer();
    directionsDisplay.setMap(map);

    var start = new google.maps.LatLng(43.652836, -79.397891);
    var end = new google.maps.LatLng(43.665045, -79.410884);

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

  // var formElement = document.querySelector("#map_form form")
  //
  // formElement.addEventListener("submit", function(e){
  //   e.preventDefault();
  //
  //   var postalCode = document.querySelector("#postal-code-input").value
  //
  //   $.ajax({
  //     url: '/events/location',
  //     method:'post',
  //     data: {postal_code: postalCode},
  //     dataType: 'JSON'
  //   }).done(function(response){
  //
  //     clientLat = response["clientLocation"]["lat"];
  //     clientLng = response["clientLocation"]["lng"];
  //
  //     clientLocation = response["clientLocation"]
  //
  //     var marker = new google.maps.Marker({
  //       map: map,
  //       position: clientLocation,
  //       title: "your location"
  //     });
  //
  //   })
  // })


  //WAYPOINTS CREATION

}
