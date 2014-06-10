/**
 * Created by colin on 6/10/14
 */

var patt = /\babc\d{5}\.jpg\b/;
var ret = patt.test("afbc45967.jpg");

console.log(ret);