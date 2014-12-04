app.events.form = {
  init: function () {
    var self = this;
    self.initDatepicker();
  },

  initDatepicker: function () {
    console.log('init date picker');
    $('.event-form #datepicker').datepicker({
      dateFormat: 'dd/mm/yy',
      prevText: '<i class="fa fa-chevron-left"></i>',
      nextText: '<i class="fa fa-chevron-right"></i>'
    });
    $('.event-form .hour').mask('99h99', {
      placeholder: '_'
    });
  }
};