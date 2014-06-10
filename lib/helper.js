/**
 * Created by colin on 6/9/14
 */

var fs = require('fs');
var path = require('path');
var sprintf = require('sprintf').sprintf;

exports.extend = function(target, opt) {
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

var removeDirSync = exports.removeDirSync = function(path) {
  var files = [];

  if( fs.existsSync(path) ) {
    files = fs.readdirSync(path);

    files.forEach(function(file, index) {
      var curPath = path + "/" + file;
      if(fs.lstatSync(curPath).isDirectory()) {
        removeDirSync(curPath);
      } else {
        fs.unlinkSync(curPath);
      }
    });

    fs.rmdirSync(path);
  }
};

/**
 * clearDirSync remove all the files and sub directories of the folder, but don't remove the folder itself.
 * To remove the folder as well, call 'removeDirSync'
 */
var clearDirSync = exports.clearDirSync = function(path) {
  if( !fs.existsSync(path) ) {
    return;
  }

  var files = fs.readdirSync(path);
  files.forEach(function(file) {
    var curPath = path + "/" + file;
    if(fs.lstatSync(curPath).isDirectory()) {
      removeDirSync(curPath);
    } else { // delete file
      fs.unlinkSync(curPath);
    }
  });
}

/**
 * Make sure the dirPath existing and is an empty directory
 * @param dirPath
 */
exports.makeSureEmptyDirSync = function(dirPath) {
  //DISASTER!
  if(dirPath == '/') {
    return;
  }

  //mkdir -p if needed
  var dirs = [];
  var currPath = dirPath;

  while(!fs.existsSync(currPath)) {
    dirs.unshift(currPath);
    currPath = path.dirname(currPath);
  }

  for(var i = 0; i < dirs.length; i++) {
    fs.mkdirSync(dirs[i]);
  }

  clearDirSync(dirPath);
}

exports.isUndefined = function (obj) {
  return typeof obj === 'undefined';
}

exports.randomInt = function() {
  return Math.floor((1 + Math.random()) * 0x7FFFFFFF);
}

exports.tmpName = function(opts) {
  opts = opts || {};

  var name = (opts.prefix || '');
  name += new Date().getTime();
  name += '_' + Math.floor((1 + Math.random()) * 0x1000000000).toString(16);
  name += (opts.postfix || '');

  return path.join(opts.dir || '', name);
}
