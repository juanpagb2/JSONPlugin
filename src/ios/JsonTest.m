#import "JsonTest.h"

#import <Cordova/CDVAvailability.h>

@implementation JsonTest

- (void)pluginInitialize {
}

- (void)echo:(CDVInvokedUrlCommand *)command {
  NSString* phrase = [command.arguments objectAtIndex:0];
  NSLog(@"%@", phrase);
}

- (void)getDate:(CDVInvokedUrlCommand *)command {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
  [dateFormatter setLocale:enUSPOSIXLocale];
  [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];

  NSDate *now = [NSDate date];
  NSString *iso8601String = [[dateFormatter stringFromDate:now] stringByAppendingString: @" PluginTest"];

  CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:iso8601String];
  [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

-(void)getJSONData:(CDVInvokedUrlCommand *)command{
    //This is used in order to make the code run in background
    [self.commandDelegate runInBackground:^{
        
        //Retrieves the URL from the parameters inside the command variable
        NSString* parameterUrl = [command.arguments objectAtIndex:0];
        
        //The Url came in String format, therefore must be changed to NSURL
        NSURL *url = [NSURL URLWithString:parameterUrl];
        
        //NSURLSessionConfiguration is a configuration object that defines behavior and policies for a URL session.
        //In this case we use the default settings
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        //An object that coordinates a group of related network data transfer tasks.
        //In this case we use the defaultConfigObject that we created before
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        //Creates the request
        NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
        //We save the parameters for the service in the variable
        NSString * params =@"alias_id=502520329";
        //Specifies that is a POST action
        [urlRequest setHTTPMethod:@"POST"];
        //Adds the parameters to the request
        [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
        
        //Executes the request
        NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                               //Once the request has finished aks if there are any errors
                                                               if (error == nil) {
                                                                   //Parse the data from the service to a JSON string
                                                                   NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                                   
                                                                   //Returns the string and a succes state
                                                                   CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
                                                                   [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
                                                               }
                                                               else {
                                                                   //In case of error the plugin will return the text for it
                                                                   CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: error.description];
                                                                   [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
                                                                   NSLog(@"Error parsing JSON.");
                                                               }
                                                               
                                                           }];
        [dataTask resume];
        
    }];
}

@end
