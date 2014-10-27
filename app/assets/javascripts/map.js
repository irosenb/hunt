// L.mapbox.accessToken = 'pk.eyJ1IjoiY291bHRvbnZlbnRvIiwiYSI6ImZGVVkzWTgifQ.jP4KGmxaZT5mHuIHHcrNEg';

// var map = L.mapbox.map('map')
//  .setView([36.597889, -53.789063], 2)
//  .addLayer(L.mapbox.tileLayer('coultonvento.k26eeaal'));

// jQuery.ajax({
//   dataType: 'text', 
//   url: '/map/show.json',
//   type: 'GET',
//   success: function(data, textStatus, xhr) {
//     var geojson = $.parseJSON(data);
//     map.featureLayer.setGeoJSON(geojson);
//   }
// });


// var clusterGroup = new L.MarkerClusterGroup();
// featureLayer.eachLayer(function(layer) {
//   clusterGroup.addLayer(layer);
// });
// map.addLayer(clusterGroup);

// clusterGroup.on('clusterclick', function(ev) {
//   var markers = ev.layer.getAllChildMarkers();
//   var markersTitles = Array();
//   for (var i = 0; i < markers.length; i++) {
//       var marker = markers[i];
//       markersTitles.push(marker.options.title);
//   }
//   if (markersTitles.length > 0) {
//       alert(markersTitles.join('\n'));
//   }
// });