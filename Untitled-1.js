var urlTest = "http://196.40.44.246:80/api/v1/bank_api/pcrc_qa/validate_alias?alias_id=502520329";
var header = "alias_id=502520329";

var successArray = function(obj){
    alert("Test 2 " + obj);
    console.log('String Array: '+ obj);
};

var failure = function(message) {
    alert(message);
};

var pluginTests =  window.PluginJSON;
pluginTests.getJSONData(urlTest, header,successArray,failure);

//Plugin location.
//phonegap plugin add https://github.com/juanpagb2/JSONPlugin.git --verbose


