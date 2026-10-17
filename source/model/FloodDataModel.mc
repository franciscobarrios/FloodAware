import Toybox.Lang;
import Toybox.System;

class FloodDataModel {
    var currentDischarge as Float = 0.0f;
    var medianDischarge as Float = 0.0f;
    var maxForecastDischarge as Float = 0.0f;
    var surgeRatio as Float = 1.0f;
    var dischargeTrend as Array<Float> = [];
    var pastDaysCount as Number = 3;
    var isValid as Boolean = false;

    // Parses raw JSON payload returned by Open-Meteo
    function parseJson(json as Dictionary) as Boolean {
        if (!json.hasKey("daily")) {
            isValid = false;
            return false;
        }

        var daily = json.get("daily") as Dictionary;

        if (daily.hasKey("river_discharge")) {
            var rawDischarge = daily.get("river_discharge") as Array;
            dischargeTrend = [];

            // Process discharge array
            for (var i = 0; i < rawDischarge.size(); i++) {
                if (rawDischarge[i] != null) {
                    dischargeTrend.add((rawDischarge[i] as Number).toFloat());
                } else {
                    dischargeTrend.add(0.0f);
                }
            }

            // Extract today's value (Index pastDaysCount = day 3)
            if (dischargeTrend.size() > pastDaysCount) {
                currentDischarge = dischargeTrend[pastDaysCount];
            }
        }

        // Parse median discharge baseline
        if (daily.hasKey("river_discharge_median")) {
            var medArray = daily.get("river_discharge_median") as Array;
            if (
                medArray.size() > pastDaysCount &&
                medArray[pastDaysCount] != null
            ) {
                medianDischarge = (medArray[pastDaysCount] as Number).toFloat();
            }
        }

        // Parse maximum forecasted discharge peak
        if (daily.hasKey("river_discharge_max")) {
            var maxArray = daily.get("river_discharge_max") as Array;
            var tempMax = 0.0f;
            for (var j = pastDaysCount; j < maxArray.size(); j++) {
                if (maxArray[j] != null) {
                    var val = (maxArray[j] as Number).toFloat();
                    if (val > tempMax) {
                        tempMax = val;
                    }
                }
            }
            maxForecastDischarge = tempMax;
        }

        if (medianDischarge > 0.0f) {
            surgeRatio = maxForecastDischarge / medianDischarge;
        } else {
            surgeRatio = 1.0f;
        }

        isValid = true;
        return true;
    }
}
