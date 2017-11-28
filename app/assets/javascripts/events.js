// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function eventShowMap() {
  // Create a map object and specify the DOM element for display.
  console.log(document.URL)
  $.ajax({
    url: document.URL,
    method:'GET',
    dataType: 'JSON'
  }).done(function(response){
    console.log(response);
    coord = {lat: response["lat"], lng: response["lng"]};

    var postalCode = document.querySelector('#postal-code-input').value;

    if (postalCode) {
      console.log("Postal code found:" + postalCode);
      x = response['clientLocation']
      // alert('found postal code:' + document.querySelector('#postal-code-input'));
    }

    map = new google.maps.Map(document.getElementById('map'), {
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

document.addEventListener("DOMContentLoaded", function(){
  var formElement = document.querySelector("#map_form form")
  formElement.addEventListener("submit", function(e){
    e.preventDefault();
    var postalCode = document.querySelector("#postal-code-input").value


    $.ajax({

      url: '/events/location',
      method:'post',
      data: {postal_code: postalCode},
      dataType: 'JSON'
    }).done(function(response){
      clientLocation = response["clientLocation"]
      console.log(clientLocation)
      var marker = new google.maps.Marker({
        map: map,
        position: clientLocation,
        title: "your location"
      });

    })
  })
})
