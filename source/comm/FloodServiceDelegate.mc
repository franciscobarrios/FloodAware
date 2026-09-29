import Toybox.System;
import Toybox.Communications;
import Toybox.Lang;

class FloodServiceDelegate {

    private var _notifyCallback as Method(data as Dictionary or String or Null) as Void;

    function initialize(handler as Method(data as Dictionary or String or Null) as Void) {
        _notifyCallback = handler;
    }

    // Requests river discharge data using the GloFAS model endpoint
    function fetchFloodData(lat as Float, lon as Float) as Void {
        var url = "https://flood-api.open-meteo.com/v1/flood";
        
        var params = {
            "latitude" => lat.toString(),
            "longitude" => lon.toString(),
            "daily" => "river_discharge,river_discharge_median,river_discharge_max",
            "timezone" => "auto",
            "past_days" => "3",
            "forecast_days" => "7"
        };

        var options = {
            :method => Communications.HTTP_REQUEST_METHOD_GET,
            :headers => {
                "Content-Type" => Communications.REQUEST_CONTENT_TYPE_JSON
            },
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
        };

        System.println("Requesting Flood Data: " + url);
        Communications.makeWebRequest(url, params, options, method(:onReceiveResponse));
    }

    // Callback when response is returned
    function onReceiveResponse(responseCode as Number, data as Dictionary or String or Null) as Void {
        if (responseCode == 200 && data instanceof Dictionary) {
            System.println("Open-Meteo response received successfully.");
            System.println("data: " + data.toString());
            _notifyCallback.invoke(data);
        } else {
            System.println("HTTP Error Code: " + responseCode);
            _notifyCallback.invoke(null);
        }
    }
}