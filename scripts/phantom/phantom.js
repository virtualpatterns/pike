var system = require('system');

var arguments = system.args;
var url = arguments[1] + '?script=' + arguments[2];

var page = require('webpage').create();

page.onLoadStarted = function() {
  console.log('LOAD     ' + url);
};
page.onNavigationRequested = function(url, type, willNavigate, mainFrame) {
  console.log('NAVIGATE ' + url);
};
page.onConsoleMessage = function(message) {
  console.log('         ' + message);
};
page.onConfirm = function(message) {
  console.log('FAIL     ' + message);
  phantom.exit();
};
page.onClosing = function(page) {
  console.log('SUCCESS  ' + page.url);
  phantom.exit();
};

page.open(url);
