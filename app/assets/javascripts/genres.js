// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function genreShowMap() {

  $.ajax({
    url: document.URL,
    method:'GET',
    dataType: 'JSON'
  }).done(function(response){

    // STEP 1: SETUP MAP'S COORDINATES AND STYLES
    coord = {
      lat: response[0]["lat"],
      lng: response[0]["lng"]
    };

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

    // STEP 2: GENERATING MAP
    googleMap = new google.maps.Map(document.getElementById('genre-map'), {
      center: coord,
      disableDefaultUI: true,
      zoom: 13,
      styles: styles
    });

    // STEP 3: GENERATE THE MARKERS AND ITS LOCATION
    response.map(function(venue, i) {
      var marker = new google.maps.Marker({
        map: googleMap,
        position: { lat: venue["lat"], lng: venue["lng"] },
        title: venue["eventName"]
       });

       var eventLink = document.getElementById('event'+venue["eventId"]).href

       // STEP 4: DISPLAY POPUP WINDOW CONTENT FOR EACH MARKER WHEN CLICK
       var contentString = '<div class="content">'+
       '<h1>'+ venue["eventName"] +'</h1> ' +
       '<p>'+ venue["address_1"] + '</p>' +
       '<p>'+ venue["city"] + '</p>' +
       '<p>'+ venue["postal_code"] + '</p>' +
       '<a href="'+ eventLink +'">take me there</a>' +
       '</div>';

       var infowindow = new google.maps.InfoWindow({
         content: contentString
       });

       // STEP 4.1: ADD CLICK EVENT LISTENER
       marker.addListener('click', function() {
         infowindow.open(googleMap, marker);
       });

    }); // END OF GENERATING MAP AND THE MARKERS FOR EACH EVENT

    // STEP 1: GENERATE USER'S LOCATION
    $.ajax({
      url: '/genres/location',
      method:'get',
      dataType: 'JSON'
    }).done(function(response){
      clientLocation = response["clientLocation"]
      var marker = new google.maps.Marker({
        map: googleMap,
        position: clientLocation,
        title: "your location"
      });
    }) // END OF AJAX REQUEST FOR USER'S LOCATION
  })
}; // END OF GENRESHOWMAP

// STEP 1: FAVOURITE AND UNFAVOURITE BUTTON
document.addEventListener("turbolinks:load", function(){
console.log("DOMContentLoaded");
  var cardDivs = document.querySelector('.card-deck');

  cardDivs.addEventListener('click', function(e){
    console.log("click");
    var anchorId = e.target.parentNode.getAttribute('id');

    if (e.target.classList.contains('favourite')) {
      e.preventDefault();
      e.target.classList.remove('favourite');
      e.target.classList.add('unfavourite');

      e.target.parentNode.setAttribute('data-method', 'delete');
      e.target.parentNode.href = '/genres/'+ anchorId +'/unfavourite';

    }else if (e.target.classList.contains('unfavourite')) {
      e.preventDefault();
      e.target.classList.remove('unfavourite');
      e.target.classList.add('favourite');

      e.target.parentNode.setAttribute('data-method', 'post');
      e.target.parentNode.href = '/genres/'+ anchorId +'/favourite';
    }
  });


}); // END OF FAVOURITE/UNFAVOURITE
