/**
 * Created by colin on 6/10/14
 */
var tmp = require('tmp');
var async = require('async');

tmp.tmpName({
  mode: 0644,
  prefix: 'prefix-',
  postfix: '.txt',
  dir: '/fwefdf/ff/sf',
  keep: false,
  unsafeCleanup: true
}, function _tempNameGenerated(err, path) {
  if (err) throw err;

  console.log("Created temporary filename: ", path);
});

tmp.file(
  {
    mode: 0644,
    prefix: 'prefix-',
    postfix: '.txt',
    dir: '.',
    keep: false,
    unsafeCleanup: true
  }, function _tempFileCreated(err, path, fd) {
  if (err) throw err;

  console.log("File: ", path);
  console.log("Filedescriptor: ", fd);
});

function splitSpeed(speed, minSpeed, maxSpeed) {
  var speeds = [];

  var curSpeed = speed;

  while(curSpeed < minSpeed) {
    speeds.push(minSpeed);
    curSpeed /= minSpeed;
  }

  while(curSpeed > maxSpeed) {
    speeds.push(maxSpeed);
    curSpeed /= maxSpeed;
  }

  speeds.push(curSpeed);

  return speeds;
}

function testSplitSpeed(callback) {
  var arr = [0.5, 2.0, 0.005, 10, 0.51, 2.1, 1.9, 1.0];
  async.eachSeries(arr, function(speed, cb) {
    var speeds = splitSpeed(speed, 0.5, 2.0);
    console.log(speeds.join(' '));
    cb();
  }, callback);
}

function defaultDone(err) {
  if(err) {
    console.log(err);
  }
}

function doTest() {
  testSplitSpeed(defaultDone);
}

doTest();