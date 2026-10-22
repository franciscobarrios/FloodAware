import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Graphics;

(:glance)
class FloodGlanceView extends WatchUi.GlanceView {
    private var _model as FloodDataModel;

    function initialize(model as FloodDataModel) {
        GlanceView.initialize();
        _model = model;
    }

    // Draw a clean minimalist wave icon at top-left
    private function drawWaveLogo(dc as Dc, x as Number, y as Number) as Void {
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_WHITE);

        // Wave crest polygon points
        var wavePoints = [
            [x, y + 12],
            [x + 6, y + 6],
            [x + 12, y + 10],
            [x + 18, y + 4],
            [x + 24, y + 12],
            [x + 24, y + 16],
            [x, y + 16],
        ];
        dc.fillPolygon(wavePoints);

        // Base accent line
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawLine(x, y + 18, x + 24, y + 18);
    }

    function onUpdate(dc as Dc) as Void {
        var height = dc.getHeight();
        var width = dc.getWidth();

        // 1. Header Title
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        drawWaveLogo(dc, 5, 8);

        // 2. Offline / Loading Fallback State
        if (!_model.isValid) {
            dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawText(
                5,
                (height * 0.5).toNumber(),
                Graphics.FONT_GLANCE,
                "Updating...",
                Graphics.TEXT_JUSTIFY_LEFT
            );
            return;
        }

        // 3. Status Badge Color and Text Mapping based on Surge Ratio
        var statusColor = Graphics.COLOR_GREEN;
        var statusText = "NORMAL";

        if (_model.surgeRatio >= 2.0f) {
            statusColor = Graphics.COLOR_RED;
            statusText = "SEVERE";
        } else if (_model.surgeRatio >= 1.5f) {
            statusColor = Graphics.COLOR_ORANGE;
            statusText = "HIGH";
        } else if (_model.surgeRatio >= 1.2f) {
            statusColor = Graphics.COLOR_YELLOW;
            statusText = "WATCH";
        }

        // 4. Draw Pill Status Box (Top Right)
        var pillWidth = 75;
        var pillHeight = 24;
        var pillX = width - pillWidth - 5;
        var pillY = 20;

        dc.setColor(statusColor, Graphics.COLOR_WHITE);
        dc.fillRoundedRectangle(pillX, pillY, pillWidth, pillHeight, 4);

        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            pillX + pillWidth / 2,
            pillY,
            Graphics.FONT_GLANCE,
            statusText,
            Graphics.TEXT_JUSTIFY_CENTER
        );

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            5,
            (height * 0.52).toNumber(),
            Graphics.FONT_XTINY,
            _model.currentDischarge.format("%.0f") + " m³/s",
            Graphics.TEXT_JUSTIFY_LEFT
        );
    }
}
