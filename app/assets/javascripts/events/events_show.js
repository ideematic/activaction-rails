app.events.show = {
  init: function () {
    var self = this;
    self.initAttendBtn();
    self.initAttendCancelBtn();
    self.initCommentEdit();
    self.initLikeBtn();
    self.initGoogleMap();
  },

  initAttendBtn: function () {
    // tooltip
//    $('.attend-btn').tooltip({container: 'body'});

    // ajax
//    $('body').on('click', '.attend-btn', function (e) {
//      e.preventDefault();
//      e.stopPropagation();
//      var $button = $(this);
//      if (!app.user_signed_in()) {
//        app.flash('error', "Vous devez être connecté pour pouvoir rejoindre l'évènement.");
//        return false;
//      }
//
//      $.ajax({
//        type: 'POST',
//        url: $button.data('url'),
//        //dataType: 'json',
//        data: {event_id: $button.data('event-id')},
//        success: function (data) {
//          //$spinner.hide();
//          if (data) {
//            $button.replaceWith(data);
//          } else {
//            app.flash('error', "Erreur. Impossible de rejoindre cet évènement.");
//          }
//        }, error: function () {
//          app.flash('error', "Erreur. Impossible de rejoindre cet évènement.");
//        }
//      });
//      return false;
//    });
  },

  initAttendCancelBtn: function () {
    $('body').on('click', '.attend-btn-cancel', function (e) {
      e.preventDefault();
      e.stopPropagation();
      var confirmation = confirm('Êtes vous sûr de vouloir annuler votre participation à cet évènement ?');
      if (!confirmation) {
        return false;
      }
      window.location.href = $(this).data('url');
//      var $button = $(this).closest('.attend-btn');

//      $.ajax({
//        type: 'DELETE',
//        url: $button.data('url'),
//        //dataType: 'json',
//        data: {event_id: $button.data('event-id')},
//        success: function (data) {
//          //$spinner.hide();
//          if (data) {
//            $button.replaceWith(data);
//          } else {
//            app.flash('error', "Erreur. Impossible d'annuler la participation à cet évènement.");
//          }
//        }, error: function () {
//          app.flash('error', "Erreur. Impossible d'annuler la participation à cet évènement.");
//        }
//      });
      return false;
    });
  },

  initCommentEdit: function () {
    $('.edit-comment').click(function () {
      alert('Ce qui est dit est dit. Impossible de modifier le commentaire.')
    });
  },

  initLikeBtn: function () {
    $('body').on('click', '.btn-like-event', function () {
      if (!app.user_signed_in()) {
        app.flash('error', 'Vous devez être connecté pour liker un évènement.');
        return false;
      }
      var action = $(this).data('id') ? 'unliking' : 'liking';
      var url = $(this).data('url') + {unliking: '/' + $(this).data('id'), liking: ''}[action];
      var data = {like: {event_id: $(this).data('event-id'), user_id: $(this).data('user-id')}};
      console.log('test', url, data, action);
      $.ajax({
        type: {unliking: 'DELETE', liking: 'POST'}[action],
        url: url,
        data: data,
        success: function () {
          app.flash('success', {unliking: 'Vous n\'aimez plus cet évènement.', liking: 'Vous likez cet évènement'}[action]);
        },
        failure: function () {
          app.flash('error', "Erreur. Impossible de liker (1)");
        },
        error: function () {
          app.flash('error', "Erreur. Impossible de liker (2)");
        }
      });
    });
  },

  initializeGoogleMap: function () {
    if (!$('#event_address').data('address')) return;
    var myLatlng = new google.maps.LatLng($('#event_address').data('latitude'), $('#event_address').data('longitude'));
    var mapOptions = {
      zoom: 17,
      center: myLatlng,
      scrollwheel: false,
    };
    var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

    var marker = new google.maps.Marker({
      position: myLatlng,
      map: map,
      title: 'Hello World!'
    });
  },

  initGoogleMap: function () {
    if (!$('#event_address').data('address')) return;

    $(window).resize(function () {
      $('#map-canvas').css('height', 250);
    }).resize();

    google.maps.event.addDomListener(window, 'load', app.events.show.initializeGoogleMap);
  }
};