var system = require('system');
var arguments = system.args;
console.log('MESSAGE Running test script on ' + arguments[1] + ' ...');

var page = require('webpage').create();
page.open(arguments[1] + '?script=phantom');

page.onNavigationRequested = function(url, type, willNavigate, mainFrame) {
  console.log('NAVIGATE ' + url);
};
page.onConsoleMessage = function(message) {
  console.log('CONSOLE ' + message);
};
page.onConfirm = function(message) {
  console.log('FAIL    ' + message);
  phantom.exit();
};
page.onClosing = function(page) {
  console.log('SUCCESS ' + page.url);
  phantom.exit();
};
