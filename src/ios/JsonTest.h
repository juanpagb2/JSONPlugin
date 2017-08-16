#import <Cordova/CDVPlugin.h>

@interface JsonTest : CDVPlugin {
}

// The hooks for our plugin commands
- (void)echo:(CDVInvokedUrlCommand *)command;
- (void)getDate:(CDVInvokedUrlCommand *)command;
- (void)getJSONData:(CDVInvokedUrlCommand *)command;

@end
