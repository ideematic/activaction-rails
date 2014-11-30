// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


$("form#new_user").bind("ajax:success", function (e, data, status, xhr) {
  if (data.success) {
    console.log('success');
    $('#sign_in').modal('hide');
    $('#sign_in_button').hide();
    $('#submit_comment').slideToggle(1000, "easeOutBack");
  } else {
    console.log('failure');
    alert('failure!')
  }
});