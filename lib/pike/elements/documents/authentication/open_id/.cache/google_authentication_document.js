// /Users/fficnar/.rvm/gems/ruby-1.8.7-p352@Pike/gems/RubyApp-0.6.70/lib/ruby_app/elements/mobile/document.js.haml
String.prototype.blank_if = function(value) {
  return this == value ? '' : this;
};
var RubyApp = new function() {
  var queue = [];
  this.enQueue = function(_function) {
    if ( queue.length <= 0 )
    {
      queue.push('next');
      _function();
    }
    else
      queue.push(_function);
  };
  this.deQueue = function() {
    _function = queue.shift();
    if ( _function )
      if ( _function === 'next' )
        RubyApp.deQueue();
      else
      {
        queue.push('next');
        _function();
      }
  };
  var waitCount = 0;
  this.showWait = function() {
    if ( waitCount == 0 )
    {
      $('div.overlay').css('display', 'block');
      $.mobile.showPageLoadingMsg();
    }
    waitCount++;
  };
  this.hideWait = function() {
    if ( waitCount > 0 )
      waitCount--;
    if ( waitCount == 0 )
    {
      $.mobile.hidePageLoadingMsg();
      $('div.overlay').css('display', 'none');
    }
  };
  now = null;
  this.sendEvent = function(event, wait) {
    // RubyApp.log('ENQUEUE event.class=' + event._class);
    event.now = RubyApp.now == undefined ? new Date().toString() : RubyApp.now;
    event.session = RubyApp.getData('session', null);
    var _wait = wait == undefined ? true : wait;
    RubyApp.enQueue ( function() {
      if (_wait)
        RubyApp.showWait();
      // RubyApp.log('DEQUEUE event.class=' + event._class);
      request = $.ajax({type:'POST', url:location.href, data:event});
      request
        .success( function(event) {
          $.each(event.statements, function(index, statement) {
            RubyApp.log('EVAL    ' + statement)
            eval(statement);
          } );
          // RubyApp.log('SUCCESS event.class=' + event._class);
        } )
        .error( function(request, message, exception) {
          RubyApp.log('ERROR   event.class=' + event._class + ' message=' + message);
          RubyApp.confirmRefreshBrowser(RubyApp.getData('error_message', null));
        } )
        .complete( function() {
          RubyApp.deQueue();
          if (_wait)
              RubyApp.hideWait();
        } )
    } );
  };
  this.showPage = function(id, options) {
    if ($('#' + id).length)
      $.mobile.changePage($('#' + id), options);
    else
    {
      // RubyApp.log('ENQUEUE RubyApp.showPage("' + id + '", ...)');
      RubyApp.enQueue ( function() {
        RubyApp.showWait();
        // RubyApp.log('DEQUEUE RubyApp.showPage("' + id + '", ...)');
        request = $.ajax({type:'GET', url:RubyApp.getData('root', '/').blank_if('/') + '/' + RubyApp.getData('locale', 'en') + '/elements/' + id + '.html'});
        request
          .success( function(content) {
            $('body').prepend(content);
            $.mobile.changePage($('#' + id), options);
            // RubyApp.log('SUCCESS RubyApp.showPage("' + id + '", ...)');
          } )
          .error( function(request, message, exception) {
            RubyApp.log('ERROR   RubyApp.showPage("' + id + '", ...) message=' + message);
            RubyApp.confirmRefreshBrowser(RubyApp.getData('error_message', null));
          } )
          .complete( function() {
            RubyApp.deQueue();
            RubyApp.hideWait();
          } );
      } );
    }
  };
  this.removePage = function(id) {
    $('#' + id).remove();
  };
  this.updateElement = function(id) {
    // RubyApp.log('ENQUEUE RubyApp.updateElement("' + id + '")');
    RubyApp.enQueue ( function() {
      RubyApp.showWait();
      // RubyApp.log('DEQUEUE RubyApp.updateElement("' + id + '")');
      request = $.ajax({type:'GET', url:RubyApp.getData('root', '/').blank_if('/') + '/' + RubyApp.getData('locale', 'en') + '/elements/' + id + '.html'});
      request
        .success( function(content) {
          $('#' + id).prev('form.ui-listview-filter').remove();
          $('#' + id).replaceWith(content);
          $('#' + id).parent().trigger('create');
          $('form.ui-listview-filter input').each( function() {
            $(this).val($(this).parents('form.ui-listview-filter').next('ul.list').attr('data-search-value'));
          });
          // RubyApp.log('SUCCESS RubyApp.updateElement("' + id + '")');
        } )
        .error( function(request, message, exception) {
          RubyApp.log('ERROR   RubyApp.updateElement("' + id + '") message=' + message);
          RubyApp.confirmRefreshBrowser(RubyApp.getData('error_message', null));
        } )
        .complete( function() {
          RubyApp.deQueue();
          RubyApp.hideWait();
        } );
    } );
    RubyApp.sendEvent({_class:'RubyApp::Element::UpdatedEvent', source:id});
  };
  this.createTrigger = function(id, interval) {
    RubyApp.destroyTrigger(id);
    $('#' + id)[0]._trigger = window.setInterval( function() {
      RubyApp.sendEvent({_class:'RubyApp::Element::TriggeredEvent', source:id});
    }, interval );
  };
  this.destroyTrigger = function(id) {
    if ($('#' + id)[0]._trigger) {
      window.clearInterval($('#' + id)[0]._trigger);
      $('#' + id)[0]._trigger = undefined;
    }
  };
  this.triggerElement = function(id) {
    RubyApp.sendEvent({_class:'RubyApp::Element::TriggeredEvent', source:id});
  };
  this.refreshBrowser = function() {
    $(window).clearQueue();
    location.replace(location.href);
  };
  this.confirmRefreshBrowser = function(message) {
    if (confirm(message))
      RubyApp.refreshBrowser();
  };
  this.go = function(url) {
    $(window).clearQueue();
    location.replace(url);
  };
  this.updateStyle = function(selector, property, value) {
    $(selector).css(property, value);
  };
  this.addClass = function(selector, _class) {
    $(selector).addClass(_class);
  };
  this.removeClass = function(selector, _class) {
    $(selector).removeClass(_class);
  };
  this.updateText = function(selector, value) {
    $(selector).text(value);
  };
  this.updateValue = function(selector, value, change) {
    $(selector).val(value);
    if (change)
      $(selector).change();
  };
  this.updateValueFor = function(selector, value, change) {
    var _for = $(selector).attr('for');
    RubyApp.updateValue('#' + _for, value, change);
  };
  this.setCookie = function(name, value, expires) {
    document.cookie = name + '=' + value + '; expires=' + expires.toUTCString();
  };
  this.click = function(selector) {
    $(selector).click();
  };
  this.swipeLeft = function() {
    $('.ui-page-active').swipeleft();
  };
  this.swipeRight = function() {
    $('.ui-page-active').swiperight();
  };
  this.isVisible = function(selector) {
    var windowTop = $(window).scrollTop();
    var windowBottom = windowTop + $(window).height();
    var elementTop = $(selector).offset().top;
    var elementBottom = elementTop + $(selector).height();
    return ((elementBottom >= windowTop) && (elementTop <= windowBottom) && (elementBottom <= windowBottom) &&  (elementTop >= windowTop) );
  };
  this.assertExists = function(selector) {
    RubyApp.assert('selector=' + selector, $(selector).length > 0);
  };
  this.assertNotExists = function(selector) {
    RubyApp.assert('selector=' + selector, $(selector).length <= 0);
  };
  this.assertExistsValue = function(selector, value) {
    var _value = $(selector).val();
    RubyApp.assert('selector=' + selector + ', value=' + value, _value == value);
  };
  this.assertNotExistsValue = function(selector, value) {
    var _value = $(selector).val();
    RubyApp.assert('selector=' + selector + ', value=' + value, _value != value);
  };
  this.assertExistsFor = function(selector) {
    var _for = $(selector).attr('for');
    RubyApp.assert('selector=' + selector + ', for=' + _for, $('#' + _for).length > 0);
  };
  this.assertNotExistsFor = function(selector) {
    var _for = $(selector).attr('for');
    RubyApp.assert('selector=' + selector + ', for=' + _for, $('#' + _for).length <= 0);
  };
  this.assertExistsValueFor = function(selector, value) {
    var _for = $(selector).attr('for');
    var _value = $('#' + _for).val();
    RubyApp.assert('selector=' + selector + ', for=' + _for + ', value=' + value, _value == value);
  };
  this.assertNotExistsValueFor = function(selector, value) {
    var _for = $(selector).attr('for');
    var _value = $('#' + _for).val();
    RubyApp.assert('selector=' + selector + ', for=' + _for + ', value=' + value, _value != value);
  };
  this.assertIsVisible = function(selector) {
    RubyApp.assert('selector=' + selector + ', visible', RubyApp.isVisible(selector) == true);
  };
  this.assertNotIsVisible = function(selector) {
    RubyApp.assert('selector=' + selector + ', not visible', RubyApp.isVisible(selector) == false);
  };
  this.assert = function(name, value) {
    RubyApp.sendEvent({_class:'RubyApp::Element::AssertedEvent', source:$('html').attr('id'), name:name, value:eval(value)});
  };
  this.getData = function(name, _default) {
    var value = $('meta[name="' + name + '"]').attr('content');
    return value == undefined ? _default : value;
  };
  this.log = function(message) {
    if ( window.console )
      window.console.log(message);
  };
  this.alert = function(message) {
    alert(message);
  };
};

$(window).load(function() {
  RubyApp.sendEvent({_class:'RubyApp::Elements::Mobile::Document::LoadedEvent', source:$('html').attr('id')});
  if ($('div[data-role="page"][id]').length)
    RubyApp.sendEvent({_class:'RubyApp::Elements::Mobile::Page::LoadedEvent', source:$('div[data-role="page"]').filter(':first').attr('id')});
});
// /Users/fficnar/.rvm/gems/ruby-1.8.7-p352@Pike/gems/RubyApp-0.6.70/lib/ruby_app/elements/mobile/page.js.haml
$(document).ready( function() {
  $(document).on('pageshow', 'div[data-role="page"]', function(event) {
    RubyApp.sendEvent({_class:'RubyApp::Elements::Mobile::Page::ShownEvent', source:$(this).attr('id')});
  });
  $(document).on('pagehide', 'div[data-role="page"]', function(event) {
    RubyApp.sendEvent({_class:'RubyApp::Elements::Mobile::Page::HiddenEvent', source:$(this).attr('id')});
  });
  $(document).on('swipeleft', 'div[data-role="page"]', function(event) {
    RubyApp.sendEvent({_class:'RubyApp::Elements::Mobile::Page::SwipedLeftEvent', source:$(this).attr('id')});
  });
  $(document).on('swiperight', 'div[data-role="page"]', function(event) {
    RubyApp.sendEvent({_class:'RubyApp::Elements::Mobile::Page::SwipedRightEvent', source:$(this).attr('id')});
  });
});
// /Users/fficnar/.rvm/gems/ruby-1.8.7-p352@Pike/gems/RubyApp-0.6.70/lib/ruby_app/elements/mobile/click.js.haml
$(document).ready( function() {
  $(document).on('click', '.click', function(event) {
    event.preventDefault();
    RubyApp.sendEvent({_class:'RubyApp::Elements::Mobile::Click::ClickedEvent', source:$(this).attr('id')});
  });
});
