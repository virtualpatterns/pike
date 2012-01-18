// /Users/fficnar/.rvm/gems/ruby-1.8.7-p352@Pike/gems/RubyApp-0.0.72/lib/ruby_app/elements/inputs/email_input.js.haml
$(document).ready(function() {
  $('input[type="email"]').live('change', function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'RubyApp::Elements::Inputs::EmailInput::ChangedEvent', source_id:$(this).attr('id'), value:$(this).val()}, false);
  });
});
// /Users/fficnar/.rvm/gems/ruby-1.8.7-p352@Pike/gems/RubyApp-0.0.72/lib/ruby_app/elements/click.js.haml
$(document).ready(function() {
  $('.click').live('click', function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'RubyApp::Elements::Click::ClickedEvent', source_id:$(this).attr('id')}, true);
  });
});
