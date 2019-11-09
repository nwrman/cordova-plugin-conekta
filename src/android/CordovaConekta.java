package com.nwrman.cordova.conekta;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaWebView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import io.conekta.conektasdk.Conekta;
import io.conekta.conektasdk.Card;
import io.conekta.conektasdk.Token;
import android.util.Log;

/**
 * This class echoes a string called from JavaScript.
 */
public class CordovaConekta extends CordovaPlugin {

    private Token conektaTokenInstance;
    private static final String TAG = "Conekta"

    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
        Log.d(TAG, "Init");
        Conekta.collectDevice(cordova.getActivity());
        conektaTokenInstance = new Token(cordova.getActivity());
    }

    @Override
    public boolean execute(String action, JSONArray data, CallbackContext callbackContext) throws JSONException {
        if (action.equals("setPublicKey")) {
            Log.d(TAG, "setKey");
            Log.d(TAG, data.getString(0));
            setPublicKey(data.getString(0), callbackContext);
        } else if (action.equals("createCardToken")) {
            Log.d(TAG, "orderCreateToken");
            createCardToken(data.getJSONObject(0), callbackContext);
        } else {
            return false;
        }

        return true;
    }

    private void setPublicKey(final String key, final CallbackContext callbackContext) {
        Log.d(TAG, "actual set key");
        try {
            Conekta.setPublicKey(key);
            Log.d(TAG, "set key success");
            callbackContext.success();
        } catch (Exception e) {
            Log.d(TAG, "set key failed");
            callbackContext.error(e.getLocalizedMessage());
        }
    }

    private void createCardToken(final JSONObject creditCard, final CallbackContext callbackContext) {

        Log.d(TAG, "actual createToken");

        Card card = new Card("Josue Camara", "4242424242424242", "332", "11", "2019");

        conektaTokenInstance.onCreateTokenListener(new Token.CreateToken() {
            @Override
            public void onCreateTokenReady(JSONObject data) {
                try {
                    callbackContext.success(data.getString("id"));
                    Log.d(TAG, 'Token got: ' + data.getString("id"));
                } catch (Exception err) {
                    callbackContext.error("Error: " + err.toString());
                    Log.d(TAG, "Error: " + err.toString());
                }
            }
        });

        conektaTokenInstance.create(card);//Create token
    }
}
