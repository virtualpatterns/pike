var page = require('webpage').create();
page.open('http://localhost:8000/?script=phantom', function(status) {
  phantom.exit();
});
