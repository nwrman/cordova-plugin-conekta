# Cordova Conekta Plugin
A Cordova plugin that lets you use Conekta's Native SDKs for Android and iOS.

## Installation
```shell
cordova plugin add cordova-plugin-conekta
```

## Usage

First we need to set our public key. 
```javascript
cordova.plugins.conekta.setPublicKey('key_MyPublicKey');
```

or if using TypeScript

```typescript
(<any>window)['cordova'].plugins.conekta.setPublicKey('key_MyPublicKey');
```
Get a token:

```javascript
let card = {
    "number": '4242424242424242',
    "name": 'Jorge López',
    "exp_year": 2025,
    "exp_month": 12,
    "cvc": 123,
};

let onSuccess = (tokenId) => {
    console.log('Got card token!', tokenId);
};

let onError = (errorMessage) => {
    console.log('Error getting card token', errorMessage);
};

cordova.plugins.conekta.createCardToken(card, onSuccess, onError);
```
