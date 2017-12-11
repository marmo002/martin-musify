// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

document.addEventListener("turbolinks:load", function() {

  var favouriteGenreGroup = document.querySelector('.favourite-list');

  favouriteGenreGroup.addEventListener('click',function(e) {
    if (e.target.classList.contains('delete-genre')) {
      var genreID = e.target.id
      e.preventDefault();
      
      $.ajax({
        url: '/genres/' + genreID + '/unfavourite',
        method: "GET",
        dataType: "JSON"
      }).done(function(){
        e.target.parentNode.remove();
      });
    }

  })
});
