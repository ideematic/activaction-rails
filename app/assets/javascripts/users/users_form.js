app.users.form = {
  init: function () {
    $('.btn-edit-private').click(function () {
      $('.user-private-info-form').removeClass('form-state-static').addClass('form-state-editing');
//      $('.btn-cancel-private').show();
      $('.btn-edit-private').hide();
      return false;
    });
    $('.btn-cancel-private').click(function () {
      $('.user-private-info-form').removeClass('form-state-editing').addClass('form-state-static');
      $('.btn-edit-private').show();
//      $('.btn-cancel-private').hide();
      return false;
    });

    $('.user-private-info-form .birthdate').mask('99/99/9999', {
      placeholder: '_'
    });
  }
}