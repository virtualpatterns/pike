// /Users/fficnar/Dropbox/Projects/gems/ruby_app/lib/ruby_app/elements/click.js.haml
$(document).ready(function() {
  $('.click').live('click', function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'RubyApp::Elements::Click::ClickedEvent', source_id:$(this).attr('id')}, true);
  });
});
// /Users/fficnar/Dropbox/Projects/gems/ruby_app/lib/ruby_app/elements/click.js.haml
$(document).ready(function() {
  $('.click').live('click', function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'RubyApp::Elements::Click::ClickedEvent', source_id:$(this).attr('id')}, true);
  });
});

