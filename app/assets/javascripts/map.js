$(document).ready(function($) {
    L.mapbox.accessToken = 'pk.eyJ1IjoiY291bHRvbnZlbnRvIiwiYSI6ImZGVVkzWTgifQ.jP4KGmxaZT5mHuIHHcrNEg';

    var map = L.mapbox.map('map', 'map', { zoomControl: false, minZoom : 2, maxZoom : 15 })
         .setView([36.597889, -53.789063], 2)
         .addLayer(L.mapbox.tileLayer('coultonvento.k26eeaal'));

    // $.ajax({
    //   dataType: 'text',
    //   url: '/map/show.json',
    //   type: 'GET',
    //   success: function(data, textStatus, xhr) {
    //     var geojson = $.parseJSON(data);
    //     map.featureLayer.setGeoJSON(geojson);
    //   }
    // });

    

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
        markersTitles.push(marker.options.title);
      }
      ev.layer.zoomToBounds();
      if (map.getZoom() == map.getMaxZoom()) {
        var popup = L.popup({maxHeight: 150, closeButton: false})
                    .setContent(markersTitles.join('<br>'))
        console.log("hello");
        ev.layer.bindPopup(popup).openPopup();
      }
    });
});