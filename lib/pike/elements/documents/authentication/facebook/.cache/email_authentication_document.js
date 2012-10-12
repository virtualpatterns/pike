// /Users/fficnar/.rvm/gems/ruby-1.8.7-p352@Pike/gems/RubyApp-0.6.27/lib/ruby_app/elements/mobile/document.js.haml
var RubyApp = new function() {
  this.queue = [],
  this.enQueue = function(_function) {
    if ( RubyApp.queue.length <= 0 )
    {
      RubyApp.queue.push('next');
      _function();
    }
    else
      RubyApp.queue.push(_function);
  },
  this.deQueue = function() {
    _function = RubyApp.queue.shift();
    if ( _function )
      if ( _function === 'next' )
        RubyApp.deQueue();
      else
      {
        RubyApp.queue.push('next');
        _function();
      }
  },
  this.waitCount = 0,
  this.showWait = function() {
    if ( RubyApp.waitCount == 0 )
    {
      $('div.overlay').css('display', 'block');
      $.mobile.showPageLoadingMsg();
    }
    RubyApp.waitCount++;
  },
  this.hideWait = function() {
    if ( RubyApp.waitCount > 0 )
      RubyApp.waitCount--;
    if ( RubyApp.waitCount == 0 )
    {
      $.mobile.hidePageLoadingMsg();
      $('div.overlay').css('display', 'none');
    }
  },
  this.sendEvent = function(event) {
    RubyApp.log('ENQUEUE event.class=' + event._class);
    event.now = new Date().toString();
    event.session = RubyApp.getData('session', null);
    RubyApp.enQueue ( function() {
      RubyApp.showWait();
      RubyApp.log('DEQUEUE event.class=' + event._class);
      request = $.ajax({type:'POST', url:location.href, data:event});
      request
        .success( function(event) {
          $.each(event.statements, function(index, statement) {
            RubyApp.log('EVAL    ' + statement)
            eval(statement);
          } );
          RubyApp.log('SUCCESS event.class=' + event._class);
        } )
        .error( function(request, message, exception) {
          RubyApp.log('ERROR   event.class=' + event._class + ' message=' + message);
          RubyApp.confirmRefreshBrowser(RubyApp.getData('error_message', null));
        } )
        .complete( function() {
          RubyApp.deQueue();
          RubyApp.hideWait();
        } )
    } );
  },
  this.showPage = function(id, options) {
    if ($('#' + id).length)
      $.mobile.changePage($('#' + id), options);
    else
    {
      RubyApp.log('ENQUEUE RubyApp.showPage("' + id + '", ...)');
      RubyApp.enQueue ( function() {
        RubyApp.showWait();
        RubyApp.log('DEQUEUE RubyApp.showPage("' + id + '", ...)');
        request = $.ajax({type:'GET', url:'/' + RubyApp.getData('locale', 'en') + '/elements/' + id + '.html'});
        request
          .success( function(content) {
            $('body').prepend(content);
            $.mobile.changePage($('#' + id), options);
            RubyApp.log('SUCCESS RubyApp.showPage("' + id + '", ...)');
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
  },
  this.removePage = function(id) {
    $('#' + id).remove();
  },
  this.updateElement = function(id) {
    RubyApp.log('ENQUEUE RubyApp.updateElement("' + id + '")');
    RubyApp.enQueue ( function() {
      RubyApp.showWait();
      RubyApp.log('DEQUEUE RubyApp.updateElement("' + id + '")');
      request = $.ajax({type:'GET', url:'/' + RubyApp.getData('locale', 'en') + '/elements/' + id + '.html'});
      request
        .success( function(content) {
          $('#' + id).replaceWith(content);
          $('#' + id).parent().trigger('create');
          RubyApp.log('SUCCESS RubyApp.updateElement("' + id + '")');
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
  },
  this.createTrigger = function(id, interval) {
    RubyApp.destroyTrigger(id);
    $('#' + id)[0]._trigger = window.setInterval( function() {
      RubyApp.sendEvent({_class:'RubyApp::Element::TriggeredEvent', source:id});
    }, interval );
  },
  this.destroyTrigger = function(id) {
    if ($('#' + id)[0]._trigger) {
      window.clearInterval($('#' + id)[0]._trigger);
      $('#' + id)[0]._trigger = undefined;
      RubyApp.log('SUCCESS RubyApp.destroyTrigger("' + id + '")');
    }
  },
  this.refreshBrowser = function() {
    $(window).clearQueue();
    location.replace(location.href);
  },
  this.confirmRefreshBrowser = function(message) {
    if (confirm(message))
      RubyApp.refreshBrowser();
  },
  this.go = function(url) {
    $(window).clearQueue();
    location.replace(url);
  },
  this.updateStyle = function(selector, property, value) {
    $(selector).css(property, value);
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
  this.updateValue = function(selector, value, change) {
    $(selector).val(value);
    if (change)
      $(selector).change();
  },
  this.updateValueFor = function(selector, value, change) {
    var _for = $(selector).attr('for');
    RubyApp.updateValue('#' + _for, value, change);
  },
  this.setCookie = function(name, value, expires) {
    document.cookie = name + '=' + value + '; expires=' + expires.toUTCString();
  },
  this.click = function(selector) {
    $(selector).click();
  },
  this.swipeLeft = function() {
    $('.ui-page-active').swipeleft();
  },
  this.swipeRight = function() {
    $('.ui-page-active').swiperight();
  },
  this.assertExists = function(selector) {
    RubyApp.assert('selector=' + selector, $(selector).length > 0);
  },
  this.assertNotExists = function(selector) {
    RubyApp.assert('selector=' + selector, $(selector).length <= 0);
  },
  this.assertExistsFor = function(selector) {
    var _for = $(selector).attr('for');
    RubyApp.assert('selector=' + selector + ', for=' + _for, $('#' + _for).length > 0);
  },
  this.assertExistsValueFor = function(selector, value) {
    var _for = $(selector).attr('for');
    var _value = $('#' + _for).val();
    RubyApp.assert('selector=' + selector + ', for=' + _for + ', value=' + value, _value == value);
  },
  this.assert = function(name, value) {
    RubyApp.sendEvent({_class:'RubyApp::Element::AssertedEvent', source:$('html').attr('id'), name:name, value:eval(value)});
  },
  this.getData = function(name, _default) {
    var value = $('meta[name="' + name + '"]').attr('content');
    return value == undefined ? _default : value;
  },
  this.log = function(message) {
    if ( window.console )
      window.console.log(message);
  }
};

$(window).load(function() {
  RubyApp.sendEvent({_class:'RubyApp::Elements::Mobile::Document::LoadedEvent', source:$('html').attr('id')});
  if ($('div[data-role="page"][id]').length)
    RubyApp.sendEvent({_class:'RubyApp::Elements::Mobile::Page::LoadedEvent', source:$('div[data-role="page"]').filter(':first').attr('id')});
});
