$(document).ready(function($) {

    // [CJL] Seeing things like 'accessToken' or API keys defined in code is a red flag for me.
    //       Having this checked into source code means anyone can pretend to be you, effectively.
    //
    // Since you have Figaro in your Gemfile, you should be able to:
    //   => Change this file name to map.js.erb and make it an ERB template.
    //   => Write something like this:
    //        L.mapbox.accessToken = <%= ENV['MAPBOX_ACCESS_TOKEN'] %>;
    //
    // You can make sure .erb works by trying to do a JS alert with ERB tags.

    L.mapbox.accessToken = 'pk.eyJ1IjoiY291bHRvbnZlbnRvIiwiYSI6ImZGVVkzWTgifQ.jP4KGmxaZT5mHuIHHcrNEg';

    var map = L.mapbox.map('map', 'map', { zoomControl: false, minZoom : 2, maxZoom : 15, titleLayer: { detectRetina: true }})
         .setView([36.597889, -53.789063], 2)
         .addLayer(L.mapbox.tileLayer('coultonvento.k26eeaal'));

    var featureLayer = L.mapbox.featureLayer('testing');
    featureLayer.loadURL('/map/show.json');

    var clusterGroup = new L.MarkerClusterGroup({spiderfyOnMaxZoom: false, zoomToBoundsOnClick: false});

    featureLayer.on('ready', function(event) {
        event.target.eachLayer(function(layer) {
            clusterGroup.addLayer(layer);
        });
        map.addLayer(clusterGroup);
    });

    clusterGroup.on('clusterclick', function(ev) {
      var markers = ev.layer.getAllChildMarkers();
      var markersTitles = Array();
      for (var i = 0; i < markers.length; i++) {
        var marker = markers[i];
        console.log(marker.options);
        markersTitles.push(marker.feature.properties.title);
      }
      ev.layer.zoomToBounds();
      if (map.getZoom() == map.getMaxZoom()) {
        var popup = L.popup({maxHeight: 150, closeButton: false})
                    .setContent(markersTitles.join('<br>'));
        console.log("hello");
        ev.layer.bindPopup(popup).openPopup();
      }
    });
});
