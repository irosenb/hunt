// $(document).ready(function($) {
//     L.mapbox.accessToken = 'pk.eyJ1IjoiY291bHRvbnZlbnRvIiwiYSI6ImZGVVkzWTgifQ.jP4KGmxaZT5mHuIHHcrNEg';

//     var map = L.mapbox.map('map', 'map', { zoomControl: false, minZoom : 2, maxZoom : 15, titleLayer: { detectRetina: true }})
//          .setView([36.597889, -53.789063], 2)
//          .addLayer(L.mapbox.tileLayer('coultonvento.k26eeaal'));

//     var featureLayer = L.mapbox.featureLayer('testing');
//     featureLayer.loadURL('/map/show.json');

//     var clusterGroup = new L.MarkerClusterGroup({spiderfyOnMaxZoom: false, zoomToBoundsOnClick: false});

//     featureLayer.on('ready', function(event) {
//         event.target.eachLayer(function(layer) {
//             clusterGroup.addLayer(layer);
//         });
//         map.addLayer(clusterGroup);
//     });

//     clusterGroup.on('clusterclick', function(ev) {
//       var markers = ev.layer.getAllChildMarkers();
//       var markersTitles = Array();
//       for (var i = 0; i < markers.length; i++) {
//         var marker = markers[i];
//         console.log(marker.options);
//         // var html = marker.feature.properties.title + " built " + marker.feature.properties.product 
//         markersTitles.push(marker.feature.properties.title);
//       }
//       ev.layer.zoomToBounds();
//       if (map.getZoom() == map.getMaxZoom()) {
//         var popup = L.popup({maxHeight: 150, closeButton: false})
//                     .setContent(markersTitles.join('<br>'));
//         console.log("hello");
//         ev.layer.bindPopup(popup).openPopup();
//       }
//     });
// });