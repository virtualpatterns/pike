// /Users/fficnar/Dropbox/Projects/pike/lib/pike/elements/work_list.js.haml
$(document).ready(function() {
  $('ul.list > li.item > div.item > a.start').live('click', function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'Pike::Elements::WorkList::StartedEvent', source_id:$(this).parents('ul.list').attr('id'), index:$(this).attr('index')}, false);
  });
  $('ul.list > li.item > div.item > a.edit').live('click', function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'Pike::Elements::WorkList::EditedEvent', source_id:$(this).parents('ul.list').attr('id'), index:$(this).attr('index')}, true);
  });
});

