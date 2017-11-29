// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function venueIndexMap() {

  $.ajax({
    url: document.URL,
    method:'GET',
    dataType: 'JSON'
  }).done(function(response){

    coord = {lat: response[0]["lat"], lng: response[0]["lng"]};

    googleMap = new google.maps.Map(document.getElementById('venues-map'), {
      center: coord,
      disableDefaultUI: true,
      zoom: 13
    });


    response.map(function(venue, i) {
        var marker = new google.maps.Marker({
          map: googleMap,
          position: { lat: venue["lat"], lng: venue["lng"] },
          title: venue["venueName"]
         });

         var venueLink = document.getElementById('venue'+venue["venueId"]).href

         var contentString = '<div class="content">'+
         '<h1>'+ venue["venueName"] +'</h1> ' +
         '<p>'+ venue["address_1"] + '</p>' +
         '<p>'+ venue["city"] + '</p>' +
         '<p>'+ venue["postal_code"] + '</p>' +
         '<a href="'+ venueLink +'">take me there</a>' +
         '</div>';

         var infowindow = new google.maps.InfoWindow({
           content: contentString
         });

         marker.addListener('click', function() {
           infowindow.open(googleMap, marker);
         });

    });
    $.ajax({

      url: '/venues/location',
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
}
