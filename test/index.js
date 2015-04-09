// hacked together unit testing framework that I put together to make absolutely
// sure that the bot can tweet "Praise the Sun!"

var fs   = require('fs');
var path = require('path');

var currentTest;
var failedTests  = [];
var passedTests  = 0;
var runningTests = 0;

var maybePrintResults = function() {
  if (runningTests != 0) return;
  if (failedTests.length == 0) {
    console.log('All tests passed');
  } else {
    console.log(failedTests.length + ' tests failed!');
    console.log('Failing tests:');
    console.log('');
    for (var i = failedTests.length - 1; i >= 0; i--) {
      console.log(failedTests[i]);
    }
  }
};

GLOBAL.test = function(name) {
  runningTests++;
  currentTest = name;
};

GLOBAL.pass = function() {
  passedTests++;
  runningTests--;
  maybePrintResults();
};

GLOBAL.fail = function(msg) {
  failedTests.push(msg);
  runningTests--;
  maybePrintResults();
};

GLOBAL.out = function(file, str) {
  fs.writeFile(path.join(__dirname, 'out', file), str);
};

require('./unit/tweets_praise_the_sun');
