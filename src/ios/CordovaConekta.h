#import <Cordova/CVDPlugin.h>

@interface CordovaConekta : CVDPlugin {

}


- (void) setPublicKey:(CDVInvokedUrlCommand *) command;
- (void) createCardToken:(CDVInvokedUrlCommand *) command;
