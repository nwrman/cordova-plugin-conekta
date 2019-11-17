#import "CordovaConekta.h"
#import "Conekta.h"

@implementation CordovaConekta
@synthesize publicKeyString;

- (void)setPublicKey:(CDVInvokedUrlCommand*)command
{
    
    CDVPluginResult* pluginResult = nil;
    
    publicKeyString = [[command arguments] objectAtIndex:0];
    
    NSLog(@"%@", publicKeyString);
    
    pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
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
    [self.commandDelegate runInBackground:^{
        
        Conekta *conekta = [[Conekta alloc] init];
        [conekta setPublicKey:self->publicKeyString];
        NSLog(@"%@", self->publicKeyString);
        
        NSDictionary* const cardInfo = [[command arguments] objectAtIndex:0];
        
        Card *card = [conekta.Card
                  initWithNumber: cardInfo[@"number"]
                  name: cardInfo[@"name"]
                  cvc: cardInfo[@"cvc"]
                  expMonth: cardInfo[@"exp_month"]
                  expYear: cardInfo[@"exp_year"]
              ];
        
        Token *token = [conekta.Token initWithCard:card];
        
        
        [token createWithSuccess:[self handleTokenCallback:command] andError:[self handleErrorCallback:command]];
        
    }];
    
}

@end
