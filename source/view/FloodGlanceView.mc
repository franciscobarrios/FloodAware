import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Lang;

(:glance)
class FloodGlanceView extends WatchUi.GlanceView {

    private var _model as FloodDataModel;

    function initialize(model as FloodDataModel) {
        GlanceView.initialize();
        _model = model;
    }

    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        var width = dc.getWidth();
        var height = dc.getHeight();

        // Title
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(5, 5, Graphics.FONT_GLANCE, "FLOODAWARE", Graphics.TEXT_JUSTIFY_LEFT);

        if (!_model.isValid) {
            dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawText(5, height / 2, Graphics.FONT_GLANCE, "Loading data...", Graphics.TEXT_JUSTIFY_LEFT);
            return;
        }

        // Status Badge Color based on Surge Ratio
        var statusColor = Graphics.COLOR_GREEN;
        var statusText = "NORMAL";

        if (_model.surgeRatio >= 2.0f) {
            statusColor = Graphics.COLOR_RED;
            statusText = "SEVERE";
        } else if (_model.surgeRatio >= 1.5f) {
            statusColor = Graphics.COLOR_ORANGE;
            statusText = "WARNING";
        } else if (_model.surgeRatio >= 1.2f) {
            statusColor = Graphics.COLOR_YELLOW;
            statusText = "WATCH";
        }

        // Draw Status Pill Background
        dc.setColor(statusColor, Graphics.COLOR_TRANSPARENT);
        dc.fillRoundedRectangle(width - 85, 5, 80, 20, 4);

        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.drawText(width - 45, 6, Graphics.FONT_GLANCE, statusText, Graphics.TEXT_JUSTIFY_CENTER);

        // Render Discharge Metric
        var dischargeStr = Lang.format("$1$ m³/s", [_model.currentDischarge.format("%.0f")]);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(5, height * 0.52, Graphics.FONT_GLANCE_NUMBER, dischargeStr, Graphics.TEXT_JUSTIFY_LEFT);
    }
}