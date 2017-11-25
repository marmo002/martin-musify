// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function initMap() {

  // var map = new google.maps.Map(document.getElementById('venues_map'), {
  //   center: {lat: 43.650325, lng: -79.383795},
  //   zoom: 15
  // });

  // Create a map object and specify the DOM element for display.
  $.ajax({
    url: document.URL,
    method:'GET',
    dataType: 'JSON'
  }).done(function(response){

    coord = {lat: response[0]["lat"], lng: response[0]["lng"]};

    var map = new google.maps.Map(document.getElementById('venues_map'), {
      center: coord,
      zoom: 13
    });


    response.forEach(function(venue) {
        new google.maps.Marker({
          map: map,
          position: { lat: venue["lat"], lng: venue["lng"] },
          title: venue["venueName"]

         });

    });



  })


}
