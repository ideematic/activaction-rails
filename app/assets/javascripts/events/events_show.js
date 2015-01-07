app.events.show = {
  init: function () {
    var self = this;
    self.initAttendBtn();
    self.initAttendCancelBtn();
    self.initCommentEdit()
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

  initCommentEdit: function() {
    $('.edit-comment').click(function() {
      alert('Ce qui est dit est dit. Impossible de modifier le commentaire.')
    });
  }
};