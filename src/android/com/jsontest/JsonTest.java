/**
 */
package com.cordova.jsontest;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.PluginResult;
import org.apache.cordova.PluginResult.Status;
import org.json.JSONObject;
import org.json.JSONArray;
import org.json.JSONException;


import android.app.AlertDialog;
import android.util.Log;

import java.io.BufferedReader;
import java.io.Console;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.Date;

public class JsonTest extends CordovaPlugin {
  private static final String TAG = "JsonTest";

  public void initialize(CordovaInterface cordova, CordovaWebView webView) {
    super.initialize(cordova, webView);

    Log.d(TAG, "Initializing JsonTest");
  }

  public boolean execute(String action, JSONArray args, final CallbackContext callbackContext)throws JSONException {
    if(action.equals("echo")) {
      String phrase = args.getString(0);
      // Echo back the first argument
      Log.d(TAG, phrase);
    } else if(action.equals("getDate")) {
      // An example of returning data back to the web layer
      final PluginResult result = new PluginResult(PluginResult.Status.OK, (new Date()).toString());
      callbackContext.sendPluginResult(result);
    } else if(action.equals("getJSONData")){

        final String serviceUrl = args.getString(0);

        this.cordova.getThreadPool().execute(new Runnable() {
            @Override
            public void run() {
                try {
                    String jsonResult = "";
                    String data = URLEncoder.encode("alias_id", "UTF-8") + "=" + URLEncoder.encode("502520329", "UTF-8");

                    // Defined URL  where to send data
                    URL url = new URL(serviceUrl);

                    // Send POST data request
                    URLConnection conn = url.openConnection();
                    conn.setDoOutput(true);
                    OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
                    wr.write( data );
                    wr.flush();

                    // Get the server response
                    BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                    StringBuilder sb = new StringBuilder();
                    String line = null;

                    // Read Server Response
                    while((line = reader.readLine()) != null)
                    {
                        // Append server response in string
                        sb.append(line + "\n");
                    }

                    jsonResult = sb.toString();

                    PluginResult result = new PluginResult(PluginResult.Status.OK, jsonResult);
                    callbackContext.sendPluginResult(result);
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        });
    }
    return true;
  }
}
