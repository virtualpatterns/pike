var page = require('webpage').create();
page.open('http://localhost:8000/?script=phantom');
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
