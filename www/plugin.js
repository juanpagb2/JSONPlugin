
var exec = require('cordova/exec');

var PLUGIN_NAME = 'JsonTest';

var JsonTest = {
  echo: function(phrase, cb) {
    exec(cb, null, PLUGIN_NAME, 'echo', [phrase]);
  },
  getDate: function(cb) {
    exec(cb, null, PLUGIN_NAME, 'getDate', []);
  },
  getJSONData: function(url,cb, cberror){
    exec(cb, cberror, PLUGIN_NAME, 'getJSONData', [url]);
  }
};

module.exports = JsonTest;
