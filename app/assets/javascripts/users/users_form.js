app.users.form = {
  init: function () {
    $('.btn-edit-private').click(function () {
      $('.user-private-info-form').removeClass('form-state-static').addClass('form-state-editing');
      $('.btn-edit-private').hide();
      return false;
    });
    $('.btn-cancel-private').click(function () {
      $('.user-private-info-form').removeClass('form-state-editing').addClass('form-state-static');
      $('.btn-edit-private').show();
      return false;
    });

    $('.btn-edit-public').click(function () {
      $('.user-public-info-form').removeClass('form-state-static').addClass('form-state-editing');
      $('.btn-edit-public').hide();
      return false;
    });
    $('.btn-cancel-public').click(function () {
      $('.user-public-info-form').removeClass('form-state-editing').addClass('form-state-static');
      $('.btn-edit-public').show();
      return false;
    });

    $('.btn-edit-social').click(function () {
      $('.user-social-form').removeClass('form-state-static').addClass('form-state-editing');
      $('.btn-edit-social').hide();
      return false;
    });
    $('.btn-cancel-social').click(function () {
      $('.user-social-form').removeClass('form-state-editing').addClass('form-state-static');
      $('.btn-edit-social').show();
      return false;
    });

    $('.user-private-info-form .birthdate').mask('99/99/9999', {
      placeholder: '_'
    });
  }
};