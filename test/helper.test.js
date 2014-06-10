/**
 * Created by colin on 6/10/14
 */

var helper = require('../lib/helper.js');

function testHelper(done) {
  var target = {a: '1'};

  var opt = {b: '2'};

  helper.extend(target, opt);

  console.log(JSON.stringify(target));

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