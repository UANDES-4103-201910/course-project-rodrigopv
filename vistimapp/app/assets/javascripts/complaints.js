   $('.comment_username').click(function(e) {
       console.log("clicked");
       $('#comment_content').val( $('#comment_content').val() + $(this)[0].innerText + " " );
       $('#comment_content').focus();
       console.log($(this));
       e.stopPropagation();
   });

var input = document.getElementById('pac-input');
var hidden_lat = document.getElementById('complaint_lat');
var hidden_lng = document.getElementById('complaint_lng');

var searchBox = new google.maps.places.SearchBox(input);

searchBox.addListener('places_changed', function() {
   var places = searchBox.getPlaces()
   if (places.length == 0) {
      return;
   }

   hidden_lat.value = places[0].geometry.location.lat();
   hidden_lng.value = places[0].geometry.location.lng();

   console.log(places[0].geometry.location.lat());
   console.log(places[0].geometry.location.lng());


});
