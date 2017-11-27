// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function eventShowMap() {
  // Create a map object and specify the DOM element for display.
  $.ajax({
    url: document.URL,
    method:'GET',
    dataType: 'JSON'
  }).done(function(response){

    coord = {lat: response["lat"], lng: response["lng"]};

    var map = new google.maps.Map(document.getElementById('map'), {
      center: coord,
      disableDefaultUI: true,
      zoom: 15
    });

    var marker = new google.maps.Marker({
      map: map,
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
      infowindow.open(map, marker);
    });

  })


}

//
// document.addEventListener("DOMContentLoaded", function() {
//
//   (function(window, google){
//
//     //map options
//     var options = {
//       center: {
//         lat: 37.791350,
//         lng: -122.435883
//       },
//       zoon: 10
//     },
//
//     element = document.getElementById('map'),
//     //map
//     map = new google.maps.Map(element, options);
//
//   }(window, google));
//
//
// });
