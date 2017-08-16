#import <Cordova/CDVPlugin.h>

@interface pluginjson : CDVPlugin {
}
// The hooks for our plugin commands
- (void)getJSONData:(CDVInvokedUrlCommand *)command;

@end
