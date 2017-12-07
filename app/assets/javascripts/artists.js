// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

document.addEventListener('DOMContentLoaded', function() {
  var artistName = document.getElementById('artist-name').innerText
  var token = "d6fbb8c1f037a6f0f2ba5b3af409099c"

  $.ajax({
    url: `http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist=${artistName}&api_key=${token}&format=json`,
    method: 'GET',
    dataType: 'JSON'
  }).done(function(responseData) {
    console.log(responseData);

    var artistImage = document.getElementById('artist-image');
    var imageSRC = responseData['artist']['image'][3]['#text'];

    artistImage.setAttribute("src", imageSRC);

  })

})
