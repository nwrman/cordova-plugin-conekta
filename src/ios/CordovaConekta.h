#import <Cordova/CDV.h>
#import "Conekta.h"

@interface CordovaConekta : CDVPlugin
@property (nonatomic, retain) Conekta *client;

- (void) setPublicKey:(CDVInvokedUrlCommand *) command;
- (void) createCardToken:(CDVInvokedUrlCommand *) command;

@end
