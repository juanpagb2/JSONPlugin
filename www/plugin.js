
var exec = require('cordova/exec');

var PLUGIN_NAME = 'PluginJSON';

var PluginJSON = {
  getJSONData: function(url, headers,cb, cberror){
    exec(cb, cberror, PLUGIN_NAME, 'getJSONData', [url, headers]);
  }
};

module.exports = PluginJSON;
