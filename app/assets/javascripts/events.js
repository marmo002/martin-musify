// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function initMap() {
  // Create a map object and specify the DOM element for display.
  var bitmaker = {lat: 43.647649, lng: -79.387082}
  var map = new google.maps.Map(document.getElementById('map'), {
    center: bitmaker,
    zoom: 15
  });

  var marker = new google.maps.Marker({
    map: map,
    position: bitmaker,
    title: 'bitmaker'
  });

}

document.addEventListener('DOMContentLoaded', function () {

  $.ajax({
    url: document.URL,
    method:'GET',
    dataType: 'JSON'
  }).done(function(response){
    console.log(response);
  })

});
