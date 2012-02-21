// /Users/frank.ficnar/.rvm/gems/ruby-1.8.7-p352@Pike/gems/RubyApp-0.0.91/lib/ruby_app/elements/base/base_page.js.haml
var RubyApp = new function() {
  this._interval = 0,
  this._waitCount = 0,
  this.getData = function(name, _default) {
    var value = $('meta[name="' + name + '"]').attr('content');
    return value == undefined ? _default : value;
  },
  this.maximize = function(selector) {
    var element = $(selector);
    var _document = $(document);
    element.css('width', '0px');
    element.css('height', '0px');
    element.css('width', _document.width() + 'px');
    element.css('height', _document.height() + 'px');
  },
  this.center = function(selector) {
    var element = $(selector);
    var _window = $(window);
    element.css('top', _window.scrollTop() + (_window.height() - element.outerHeight(true)) / 2 + 'px');
    element.css('left', _window.scrollLeft() + (_window.width() - element.outerWidth(true)) / 2 + 'px');
  },
  this.maximizeWait = function() {
    RubyApp.maximize('body div.wait');
  },
  this.centerWaitImage = function() {
    RubyApp.center('body div.wait > div.image');
  },
  this.maximizeOverlay = function() {
    RubyApp.maximize('body div.overlay');
  },
  this.centerDialog = function(id) {
    RubyApp.center('#'+id);
  },
  this.log = function(message) {
    $('ul.log > li.status').text(new Date().toString() + ' - ' + message);
    $('ul.log').append('<li>' + new Date().toString() + ' - ' + message + '</li>');
  },
  this.queueEvent = function(event, wait) {
    event.session_id = RubyApp.getData('session_id', null);
    event.now = new Date().toString();
    RubyApp.log('RubyApp.queueEvent ENQUEUE event.class=' + event._class + ' wait=' + wait);
    $(window).queue( function() {
      RubyApp.log('RubyApp.queueEvent SEND event.class=' + event._class + ' wait=' + wait);
      request = $.ajax({type:'POST', url:location.href, data:event, wait:wait});
      request
        .success( function(event) {
          RubyApp.log('RubyApp.queueEvent SUCCESS event.class=' + event._class + ' wait=' + wait);
          $.each(event.statements, function(index, statement) {
            eval(statement);
          } );
        } )
        .error( function(request, message, exception) {
          RubyApp.log('RubyApp.queueEvent ERROR event.class=' + event._class + ' wait=' + wait);
          if ($.parseJSON(RubyApp.getData('event_error', 'true')) == true)
            RubyApp.confirm_refresh(RubyApp.getData('event_error_message', null));
        } )
        .complete( function() {
          RubyApp.log('RubyApp.queueEvent COMPLETE event.class=' + event._class + ' wait=' + wait);
          $(window).dequeue();
        } )
    } );
  },
  this.alert = function(message) {
    alert(message);
  },
  this.refresh = function() {
    RubyApp.showWait();
    $(window).clearQueue();
    location.assign(location.href);
  },
  this.confirm_refresh = function(message) {
    if (confirm(message))
    {
      RubyApp.refresh();
    }
  },
  this.go = function(url) {
    RubyApp.showWait();
    $(window).clearQueue();
    location.assign(url);
  },
  this.showWait = function() {
    if (RubyApp._waitCount <= 0)
    {
      var wait = $('body div.wait');
      wait.show();
      RubyApp.maximizeWait();
      RubyApp.centerWaitImage();
      $(window).bind('resize.wait', function() {
        RubyApp.maximizeWait();
        RubyApp.centerWaitImage();
      } );
      $(window).bind('scroll.wait', function() {
        RubyApp.centerWaitImage();
      } );
    }
    RubyApp._waitCount ++;
  },
  this.hideWait = function() {
    if (RubyApp._waitCount == 1)
    {
      $(window).unbind('.wait');
      $('body div.wait').hide();
    }
    RubyApp._waitCount --;
  },
  this.showDialog = function(id) {
    request = $.ajax({type:'GET', url:'/' + RubyApp.getData('locale', 'en') + '/elements/' + id + '.html', wait:true});
    request
      .success( function(dialog) {
        var overlay = $('body div.overlay');
        overlay.append(dialog);
        overlay.show();
        RubyApp.maximizeOverlay();
        RubyApp.centerDialog(id);
        $(window).bind('resize.dialog', function() {
          RubyApp.maximizeOverlay();
          RubyApp.centerDialog(id);
        } );
        $(window).bind('scroll.dialog', function() {
          RubyApp.centerDialog(id);
        } );
        RubyApp.queueEvent({_class:'RubyApp::Elements::Dialog::ShownEvent', source_id:id}, false);
      } );
  },
  this.hideDialog = function(id) {
    $(window).unbind('.dialog');
    $('body div.overlay').hide();
    $('#'+id).remove();
    RubyApp.queueEvent({_class:'RubyApp::Elements::Dialog::HiddenEvent', source_id:id}, false);
  },
  this.updateElement = function(id) {
    request = $.ajax({type:'GET', url:'/' + RubyApp.getData('locale', 'en') + '/elements/' + id + '.html', wait:true});
    request
      .success( function(content) {
        $('#'+id).replaceWith(content);
      } );
  },
  this.addClass = function(selector, _class) {
    $(selector).addClass(_class);
  },
  this.removeClass = function(selector, _class) {
    $(selector).removeClass(_class);
  },
  this.updateText = function(selector, value) {
    $(selector).text(value);
  },
  this.updateValue = function(selector, value) {
    $(selector).val(value);
  },
  this.setCookie = function(name, value, expires) {
    document.cookie = name + '=' + value + '; expires=' + expires.toUTCString();
  }
};

$(document).ready(function() {
  $('body div.wait')
    .bind('ajaxSend', function(event, request, options) {
      if (options.wait)
        RubyApp.showWait();
    } )
    .bind('ajaxComplete', function(event, request, options) {
      if (options.wait)
        RubyApp.hideWait();
    } );
});

$(window).load(function() {
  RubyApp.queueEvent({_class:'RubyApp::Elements::Page::LoadedEvent', source_id:$('html').attr('id')}, false);
  interval = parseInt(RubyApp.getData('interval', 0)) * 1000;
  if ( interval > 0 ) {
    RubyApp._interval = window.setInterval(function() {
      RubyApp.queueEvent({_class:'RubyApp::Elements::Page::TriggeredEvent', source_id:$('html').attr('id')}, false);
    }, interval);
  }
});

$(window).unload(function() {
  if ( RubyApp._interval != 0 ) {
    window.clearInterval(RubyApp._interval);
    $(window).clearQueue();
  }
});
// /Users/frank.ficnar/.rvm/gems/ruby-1.8.7-p352@Pike/gems/RubyApp-0.0.91/lib/ruby_app/elements/list.js.haml
$(document).ready(function() {
  $('ul.list > li.item > a.item').live('click', function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'RubyApp::Elements::List::ClickedEvent', source_id:$(this).parents('ul.list').attr('id'), index:$(this).attr('index')}, true);
  });
});
// /Users/frank.ficnar/.rvm/gems/ruby-1.8.7-p352@Pike/gems/RubyApp-0.0.91/lib/ruby_app/elements/click.js.haml
$(document).ready(function() {
  $('.click').live('click', function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'RubyApp::Elements::Click::ClickedEvent', source_id:$(this).attr('id')}, true);
  });
});
// /Users/frank.ficnar/.rvm/gems/ruby-1.8.7-p352@Pike/gems/RubyApp-0.0.91/lib/ruby_app/elements/markdown.js.haml
$(document).ready(function() {
  $('div.markdown a').live('click', function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'RubyApp::Elements::Markdown::ClickedEvent', source_id:$(this).parents('div.markdown').attr('id'), name:$(this).attr('href')}, true);
  });
});
