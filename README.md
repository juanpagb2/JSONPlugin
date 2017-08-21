Cordova Plugin 
======

This plugin has the capability to consume JSON Services
To install this plugin you just need the following comands in the root of your phonegap project:
- phonegap plugin add https://github.com/juanpagb2/JSONPlugin.git 

Example of how to use it:

        var urlTest = "Your URL Here";
        var header = "Your parameters Here Ej: example=301"
        
        //Callback success function
        var successArray = function(obj){
            alert(obj);
        };
        
        //Callback failure function
        var failure = function(message) {
            alert(message);
        };
        
        //Create an instance of the plugin
        var pluginTests =  window.PluginJSON;
        //Call to the plugin method
        //Parameters: 
        // - URL 
        // - The parameters needed for the service
        // - Success Callback Method
        // - Failure Callback Method
        pluginTests.getJSONData(urlTest, header,successArray,failure);
