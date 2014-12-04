var app = {
  init: function () {
    var self = this;
    self.initSignIn();
  },

  flash: function (type, message, prependTo) {
    $('.alert').remove();
    //$("html, body").animate({ scrollTop: 0 }, 'fast');
    if (type == 'notice') {
      type = 'success';
    }
    var flashContent = '<div class="alert alert-' + type + '">' + message + '</div>';
    if (prependTo) {
      prependTo.prepend(flashContent);
      prependTo.find('.alert').hide().fadeIn(500);
    } else {
      $('#flash').html(flashContent).hide().fadeIn(500);
    }
  },

  user_signed_in: function () {
    return $('body').data('signed-in');
  },

  initSignIn: function () {
    $(document).on('submit', '#login_form', function (e) {
    }).on('ajax:success', '#login_form', function (e, data, status, xhr) {
    }).on('ajax:error', '#login_form', function (e, data, status, xhr) {
    });
  }
};
