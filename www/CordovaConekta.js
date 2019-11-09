var exec = require('cordova/exec');
var noop = function(){};

/**
 * @namespace cordova.plugins
 */

/**
 * Parameters to create a credit card token
 * @typedef module:stripe.CreditCardTokenParams
 * @type {Object}
 * @property {string} number Card number
 * @property {number} expMonth Expiry month
 * @property {number} expYear Expiry year
 * @property {string} [cvc] CVC/CVV
 * @property {string} [name] Cardholder name
 * @property {string} [address_line1] Address line 1
 * @property {string} [address_line2] Address line 2
 * @property {string} [address_city] Address line 2
 * @property {string} [address_state] State/Province
 * @property {string} [address_country] Country
 * @property {string} [postalCode] Postal/Zip code
 * @property {string} [currency] 3-letter code for currency
 */

/**
 * @exports conekta
 */
module.exports = {

  /**
   * Set publishable key
   * @param key {string} Publishable key
   * @param [success] {Function} Success callback
   * @param [error] {Function} Error callback
   */
  setPublicKey: function(key, success, error) {
    success = success || noop;
    error = error || noop;
    exec(success, error, "CordovaConekta", "setPublicKey", [key]);
  },

  /**
   * Create a credit card token
   * @param creditCard {module:stripe.CreditCardTokenParams} Credit card information
   * @param success {Function} Success callback
   * @param error {Function} Error callback
   */
  createCardToken: function(creditCard, success, error) {
    success = success || noop;
    error = error || noop;
    exec(success, error, "CordovaConekta", "createCardToken", [creditCard]);
  },
};
