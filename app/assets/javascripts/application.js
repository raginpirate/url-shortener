// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require turbolinks
//= require rails-ujs
//= require_tree .
//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require jquery.validate
//= require jquery.validate.additional-methods

//jquery.validation for form submission with regex
//source: http://andrewcallahan.github.io/blog/2014/02/26/make-your-own-url-shortener-with-rails-4-and-heroku/

$.validator.addMethod(
        "regex",
        function(value, element, regexp) {
            var re = new RegExp(regexp);
            return this.optional(element) || re.test(value);
        },
        "Please Enter a Valid URL (http://...)"
)

//enable reloading after a turbolinks jump
$(document).on('turbolinks:load', function() {
  $('new_link').ready(function() {
    var password_validator = $('#new_link').validate({
      rules: {
        'link[given_url]': {
          required: true,
          regex: "^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}",
        },
      },
      messages: {
        'link[given_url]': {
          required: 'Please Enter a URL',
        }
      },
      errorLabelContainer: '.errors'
    });
  })
})