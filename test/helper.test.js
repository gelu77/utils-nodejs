/**
 * Created by colin on 6/10/14
 */

var helper = require('../lib/helper.js');
var path = require('path');
var sprintf = require('sprintf').sprintf;

function testHelper(done) {
  var target = {a: '1'};

  var opt = {b: '2'};

  helper.extend(target, opt);

  console.log(JSON.stringify(target));

  var dirPath = '../public/tmp/1/2/3/4/5/';

  helper.makeSureEmptyDirSync(dirPath);

  console.log(path.dirname(dirPath));

  for(var i = 0; i < 5; i++) {
    console.log(helper.tmpName( {postfix: '.txt', prefix: 'my', dir: './../../f'}));
  }

  console.log(Number.MAX_VALUE);
  console.log(Number.MIN_VALUE);

  for(var i = 0; i < 10; i++) {
    console.log(sprintf('%016X', helper.randomInt()));
  }

  done();
}

function defaultDone(err) {
  if(err) {
    console.log(err);
  }
}

function doTest() {
  testHelper(defaultDone);
}

doTest();