// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.





function initMap() {
  // Create a map object and specify the DOM element for display.
  $.ajax({
    url: document.URL,
    method:'GET',
    dataType: 'JSON'
  }).done(function(response){

    bitmaker = {lat: response["lat"], lng: response["lng"]}

    var map = new google.maps.Map(document.getElementById('map'), {
      center: bitmaker,
      zoom: 15
    });

    var marker = new google.maps.Marker({
      map: map,
      position: bitmaker,
      title: 'bitmaker'
    });
  })


}
