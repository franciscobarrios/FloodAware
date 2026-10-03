using Toybox.System;
using Toybox.Lang;

class Utils {
    static function log(message) {
        if (DEBUG) {
            System.println(message);
        }
    }
}
