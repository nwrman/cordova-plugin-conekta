/********* CordovaConekta.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>

@interface CordovaConekta : CDVPlugin {
  // Member variables go here.
}

- (void)coolMethod:(CDVInvokedUrlCommand*)command;
@end

@implementation CordovaConekta

- (void)coolMethod:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];

    if (echo != nil && [echo length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setPublicKey:(CDVInvokedUrlCommand*)command
{

    CDVPluginResult* pluginResult = nil;


    NSString* publicKey = [[command arguments] objectAtIndex:0];

    NSLog(@"%@", publicKey);

    // [[STPPaymentConfiguration sharedConfiguration] setPublicKey:publicKey];


    // if (self.client == nil) {
    //     // init client if doesn't exist
    //     client = [[STPAPIClient alloc] init];
    // } else {
    //     [self.client setPublicKey:publicKey];
    // }


    pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)createCardToken:(CDVInvokedUrlCommand*)command
{

    CDVPluginResult* pluginResult = nil;


    NSString* tokenId = @"tokenASDXXXXX";

    NSLog(@"%@", tokenId);

    // NSLog(@"%@", publicKey);

    // [[STPPaymentConfiguration sharedConfiguration] setPublicKey:publicKey];


    // if (self.client == nil) {
    //     // init client if doesn't exist
    //     client = [[STPAPIClient alloc] init];
    // } else {
    //     [self.client setPublicKey:publicKey];
    // }


    pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsString:tokenId];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

@end
