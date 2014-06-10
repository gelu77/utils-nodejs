/**
 * Created by colin on 6/9/14
 */

var extend = function(target, opt) {
  if (!opt) {
    return target;
  }

  target = target || {};
  for (var p in opt) {
    if (!target.hasOwnProperty(p)) {
      target[p] = opt[p];
    }
  }

  return target;
}

exports.extend = extend;
