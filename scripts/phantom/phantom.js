var system = require('system');

var arguments = system.args;
var url = arguments[1] + '?script=' + arguments[2];

var page = require('webpage').create();

page.onNavigationRequested = function(url, type, willNavigate, mainFrame) {
  console.log('NAVIGATE ' + url);
};
page.onConsoleMessage = function(message) {
  console.log('LOG      ' + message);
};
page.onAlert = function(message) {
  console.log('ALERT    ' + message);
};
page.onConfirm = function(message) {
  console.log('CONFIRM  ' + message);
  phantom.exit(-1);
};
page.onClosing = function(page) {
  console.log('CLOSE    ' + page.url);
  phantom.exit(0);
};

page.open(url);
