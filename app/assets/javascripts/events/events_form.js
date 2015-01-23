app.events.form = {
  init: function () {
    var self = this;
    self.initDatepicker();
    self.fixGoogleMap();
    self.initGoogleMap();
  },

  initDatepicker: function () {
    $('.event-form #datepicker').datepicker({
      dateFormat: 'dd/mm/yy',
      prevText: '<i class="fa fa-chevron-left"></i>',
      nextText: '<i class="fa fa-chevron-right"></i>'
    });
    $('.event-form .hour').mask('99h99', {
      placeholder: '_'
    });
  },

  fixGoogleMap: function () {
    // Fix for map to show up
    $(window).resize(function () {
      $('#map-canvas').css('height', 250);
    }).resize();
    // Fix for enter in map
    $('#pac-input').keydown(function (e) {
      if (e.which == 13 && $('.pac-container:visible').length) return false;
    });
    $('#pac-input').on('input', function () {
      $('#map-check').hide();
    });
  },

  initializeGoogleMap: function () {
    var mapOptions = {
      center: new google.maps.LatLng(
          $('#event_latitude').val() || 48.856614,
          $('#event_longitude').val() || 2.3522219000000177),
      zoom: 13,
      scrollwheel: false,
    };

    var map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);

    var input = /** @type {HTMLInputElement} */(
      document.getElementById('pac-input'));

    var types = document.getElementById('type-selector');
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(types);

    var autocomplete = new google.maps.places.Autocomplete(input);
    autocomplete.bindTo('bounds', map);

    var infowindow = new google.maps.InfoWindow();
    var marker = new google.maps.Marker({
      map: map,
      anchorPoint: new google.maps.Point(0, -29)
    });

    // if we already know the address, set the marker and check
    if ($('#event_address').val()) {
      var marker2 = new google.maps.Marker({
        position: new google.maps.LatLng($('#event_latitude').val(), $('#event_longitude').val()),
        map: map
      });
      // to set the map-check, we have to wait that gmaps is loaded
      // see http://stackoverflow.com/questions/832692/how-can-i-check-whether-google-maps-is-fully-loaded
      google.maps.event.addListenerOnce(map, 'idle', function(){
        $('#map-check').appendTo('#map-canvas');
        $('#map-check').show();
      });
    }


    google.maps.event.addListener(autocomplete, 'place_changed', function () {
      infowindow.close();
      marker.setVisible(false);
      var place = autocomplete.getPlace();

      if (!place.geometry) {
        return;
      }

      // If the place has a geometry, then present it on a map.
      if (place.geometry.viewport) {
        map.fitBounds(place.geometry.viewport);
      } else {
        map.setCenter(place.geometry.location);
        map.setZoom(17);  // Why 17? Because it looks good.
      }
      marker.setIcon(/** @type {google.maps.Icon} */({
        url: place.icon,
        size: new google.maps.Size(71, 71),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(17, 34),
        scaledSize: new google.maps.Size(35, 35)
      }));
      marker.setPosition(place.geometry.location);
      marker.setVisible(true);
      marker2 && marker2.setVisible(false);

      infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + place.formatted_address);
      infowindow.open(map, marker);

//      console.log(place, address);
//      console.log('got place:', place);
//      console.log('lat lng', place.geometry.location.lat(), place.geometry.location.lng());

      $('#event_address').val(place.formatted_address);
      $('#event_latitude').val(place.geometry.location.lat());
      $('#event_longitude').val(place.geometry.location.lng());

      $('#map-check').appendTo('#map-canvas');
      $('#map-check').show();
    });
  },

  initGoogleMap: function () {
    google.maps.event.addDomListener(window, 'load', app.events.form.initializeGoogleMap);
  }
};