
var exec = require('cordova/exec');

var PLUGIN_NAME = 'pluginjson';

var pluginjson = {
  getJSONData: function(url, headers,cb, cberror){
    exec(cb, cberror, PLUGIN_NAME, 'getJSONData', [url, headers]);
  }
};

module.exports = pluginjson;
