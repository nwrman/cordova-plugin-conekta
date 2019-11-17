#import <Cordova/CDV.h>
#import "Conekta.h"

@interface CordovaConekta : CDVPlugin
@property (nonatomic, copy) NSString *publicKeyString;

- (void) setPublicKey:(CDVInvokedUrlCommand *) command;
- (void) createCardToken:(CDVInvokedUrlCommand *) command;

@end
