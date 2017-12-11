// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function genreShowMap() {

  $.ajax({
    url: document.URL,
    method:'GET',
    dataType: 'JSON'
  }).done(function(response){
    coord = {lat: response[0]["lat"], lng: response[0]["lng"]};
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
    googleMap = new google.maps.Map(document.getElementById('genre-map'), {
      center: coord,
      disableDefaultUI: true,
      zoom: 13,
      styles: styles
    });


    response.map(function(venue, i) {
      var marker = new google.maps.Marker({
        map: googleMap,
        position: { lat: venue["lat"], lng: venue["lng"] },
        title: venue["eventName"]
       });

       var eventLink = document.getElementById('event'+venue["eventId"]).href

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

       marker.addListener('click', function() {
         infowindow.open(googleMap, marker);
       });

    });
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
    })
  })
};

document.addEventListener("turbolinks:load", function(){

  var cardDivs = document.querySelector('.card-deck');

  cardDivs.addEventListener('click', function(e){
    // console.log("click");
    var ourTarget = e.target;
    var anchorId = ourTarget.parentNode.getAttribute('id');
    console.log(ourTarget);
    console.log(anchorId);

    if (ourTarget.classList.contains('favourite')) {
      e.preventDefault();

      $.ajax({
        url: '/genres/' + anchorId + '/unfavourite',
        method: "GET",
        dataType: "JSON"
      }).done(function(){

        ourTarget.classList.remove('favourite');
        ourTarget.classList.add('unfavourite');

      })

    }else if (ourTarget.classList.contains('unfavourite')) {
      e.preventDefault();

      $.ajax({
        url: '/genres/' + anchorId + '/favourite',
        method: "GET",
        dataType: "JSON"
      }).done(function(){

        ourTarget.classList.remove('unfavourite');
        ourTarget.classList.add('favourite');

      });

    }

  });

});
