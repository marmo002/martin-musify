// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.





function initMap() {
  // Create a map object and specify the DOM element for display.
  $.ajax({
    url: document.URL,
    method:'GET',
    dataType: 'JSON'
  }).done(function(response){

    coord = {lat: response["lat"], lng: response["lng"]};

    var map = new google.maps.Map(document.getElementById('map'), {
      center: coord,
      zoom: 15
    });

    var marker = new google.maps.Marker({
      map: map,
      position: coord,
      title: response["venueName"]
    });

    var contentString = '<div id="content">'+
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
