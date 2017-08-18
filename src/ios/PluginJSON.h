#import <Cordova/CDVPlugin.h>

@interface PluginJSON : CDVPlugin {
}
// The hooks for our plugin commands
- (void)getJSONData:(CDVInvokedUrlCommand *)command;

@end
