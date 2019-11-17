#import "CordovaConekta.h"
#import "Conekta.h"

@implementation CordovaConekta
@synthesize client;

- (void)setPublicKey:(CDVInvokedUrlCommand*)command
{
    
    CDVPluginResult* pluginResult = nil;
    
    NSString* publicKey = [[command arguments] objectAtIndex:0];
    
    NSLog(@"%@", publicKey);
    
    if (self.client == nil) {
        self.client = [[Conekta alloc] init];
    } else {
        [self.client setPublicKey:publicKey];
    }
    
    
    pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

- (void)throwNotInitializedError:(CDVInvokedUrlCommand *) command
{
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"You must call setPublicKey method before executing this command."];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void (^)(NSDictionary *data))handleTokenCallback: (CDVInvokedUrlCommand *) command
{
    return ^(NSDictionary *data) {
        
        CDVPluginResult* result;
        NSString *tokenId = data[@"id"];
        
        if (tokenId == nil){
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:data];
            
        } else {
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:tokenId];
        }
        
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    };
}

- (void (^)(NSError *error))handleErrorCallback: (CDVInvokedUrlCommand *) command
{
    return ^(NSError *error) {
        CDVPluginResult* result;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: error.localizedDescription];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    };
}

- (void)createCardToken:(CDVInvokedUrlCommand*)command
{
    
    if (self.client == nil) {
        [self throwNotInitializedError:command];
        return;
    }
    
    
    [self.commandDelegate runInBackground:^{
        
        NSDictionary* const cardInfo = [[command arguments] objectAtIndex:0];
        
        Card *card = [self.client.Card
                  initWithNumber: cardInfo[@"number"]
                  name: cardInfo[@"name"]
                  cvc: cardInfo[@"cvc"]
                  expMonth: cardInfo[@"exp_month"]
                  expYear: cardInfo[@"exp_year"]
              ];
        
        Token *token = [self.client.Token initWithCard:card];
        
        [token createWithSuccess:[self handleTokenCallback:command] andError:[self handleErrorCallback:command]];
        
    }];
    
}

@end
