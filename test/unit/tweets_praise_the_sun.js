// checks to see if "Praise the Sun!" can even be tweeted by tweeting tons of
// times and seeing if it was tweeted.

test('Tweets "Praise the sun!"');

var cp   = require('child_process');
var path = require('path');

process.chdir(path.join(__dirname, '..', '..', 'bin'));

var trys = 3000;

var tweets = (function(msgs) {
  var res = {};
  for (var i in msgs) {
    res[msgs[i]] = 0;
  }
  return res;
})(require('./../../config/all_messages'));

var reportTweets = function() {
  out('tweet-distribution.json', JSON.stringify(tweets, undefined, 2));
};

var loop = function(attempts) {
  if (attempts > 0) {
    cp.exec('./orange-soapstone test', function(err, stdout, stderr) {
      if (stderr.length > 0) {
        fail(stderr);
      } else {
        tweets[stdout.replace(/Tweeting:|\n/g, '')]++;
        if (/sun/i.test(stdout)) {
          reportTweets();
          pass();
        } else {
          loop(attempts - 1);
        }
      }
    });
  } else {
    reportTweets();
    fail('Praise the sun wasn\'t tweeted after trying ' + trys + ' times');
  }
};

loop(trys);
