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

public class CordovaConekta extends CordovaPlugin {

    private Token conektaTokenInstance;
    private static final String TAG = "Conekta";

    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
        conektaTokenInstance = new Token(cordova.getActivity());
    }

    @Override
    public boolean execute(String action, JSONArray data, CallbackContext callbackContext) throws JSONException {
        if (action.equals("setPublicKey")) {
            setPublicKey(data.getString(0), callbackContext);
        } else if (action.equals("createCardToken")) {
            createCardToken(data.getJSONObject(0), callbackContext);
        } else {
            return false;
        }

        return true;
    }

    private void setPublicKey(final String key, final CallbackContext callbackContext) {
        try {
            Conekta.setPublicKey(key);
            callbackContext.success();
        } catch (Exception e) {
            Log.d(TAG, "set key failed");
            callbackContext.error(e.getLocalizedMessage());
        }
    }

    private void createCardToken(final JSONObject creditCard, final CallbackContext callbackContext) {

        Card card = null;

        try {
            card = new Card(
                    creditCard.getString("name"),
                    creditCard.getString("number"),
                    creditCard.getString("cvc"),
                    creditCard.getString("exp_month"),
                    creditCard.getString("exp_year")
            );
        } catch (JSONException e) {
            callbackContext.error("Error: Todos los datos de la tarjeta son requeridos");
        }

        conektaTokenInstance.onCreateTokenListener(new Token.CreateToken() {
            @Override
            public void onCreateTokenReady(JSONObject data) {
                try {
                    callbackContext.success(data.getString("id"));
                } catch (Exception err) {
                    try {
                        callbackContext.error("Conekta - " + data.getString("message_to_purchaser"));
                    } catch (JSONException e) {
                        callbackContext.error("¡Error no especificado! 😱");
                    }
                }
            }
        });

        if (card != null) {
            conektaTokenInstance.create(card);
        }
    }
}
