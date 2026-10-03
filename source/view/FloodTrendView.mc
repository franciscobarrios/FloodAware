import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

class FloodTrendView extends WatchUi.View {
    private var _model as FloodDataModel;

    function initialize(model as FloodDataModel) {
        View.initialize();
        _model = model;
    }

    // Pen width logic (sharper lines on high-res AMOLED)
    function setChartPen(dc as Dc, width as Number) as Void {
        if (dc has :setPenWidth) {
            dc.setPenWidth(width);
        }
    }

    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.clear();

        var w = dc.getWidth();
        var h = dc.getHeight();

        // 1. Chart Title (Top Header)
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            w / 2,
            h * 0.08,
            Graphics.FONT_XTINY,
            "10-DAY TREND (m³/s)",
            Graphics.TEXT_JUSTIFY_CENTER
        );

        // 2. Define Chart Area Bounds (Using 80% width, 50% height)
        var chartX = (w * 0.1).toNumber();
        var chartY = (h * 0.22).toNumber();
        var chartW = (w * 0.8).toNumber();
        var chartH = (h * 0.5).toNumber();

        var data = _model.dischargeTrend;
        // Basic error check
        if (data.size() < 2) {
            dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawText(
                w / 2,
                h / 2,
                Graphics.FONT_XTINY,
                "Not enough data.",
                Graphics.TEXT_JUSTIFY_CENTER
            );
            return;
        }

        // 3. Find Max scaling factor (Baseline remains 0)
        var maxVal = 1.0f;
        for (var i = 0; i < data.size(); i++) {
            if (data[i] > maxVal) {
                maxVal = data[i];
            }
        }

        // 4. Draw Chart Frame
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawRectangle(chartX, chartY, chartW, chartH);

        // 5. Linear Discharge Line (Blue, Thick Pen)
        setChartPen(dc, 3);

        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);

        var stepX = chartW.toFloat() / (data.size() - 1);

        for (var i = 0; i < data.size() - 1; i++) {
            // Plot x/y coordinates programmatically
            var x1 = (chartX + i * stepX).toNumber();
            var y1 = (chartY + chartH - (data[i] / maxVal) * chartH).toNumber();
            var x2 = (chartX + (i + 1) * stepX).toNumber();
            var y2 = (
                chartY +
                chartH -
                (data[i + 1] / maxVal) * chartH
            ).toNumber();

            dc.drawLine(x1, y1, x2, y2);
        }

        // 6. Timeline Indicators (Past 3d / Forecast 7d)
        // Use a dashed line for 'Today' (at index _model.pastDaysCount = 3)
        var todayX = chartX + stepX * _model.pastDaysCount;
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawLine(
            todayX.toNumber(),
            chartY,
            todayX.toNumber(),
            chartY + chartH
        );

        // Legend Axis Titles
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            chartX + (todayX - chartX) / 2,
            chartY + chartH + 4,
            Graphics.FONT_XTINY,
            "PAST 3d",
            Graphics.TEXT_JUSTIFY_CENTER
        );
        dc.drawText(
            todayX + (chartX + chartW - todayX) / 2,
            chartY + chartH + 4,
            Graphics.FONT_XTINY,
            "FORECAST 7d",
            Graphics.TEXT_JUSTIFY_CENTER
        );

        // Reset Pen Width
        setChartPen(dc, 1);

        // 7. Peak Subtext (Bottom Footer Highlight)
        // Format discharge to whole number
        var peakStr = Lang.format("Forecast Peak: $1$ m³/s (Thu 12 Oct)", [
            _model.maxForecastDischarge.format("%.0f"),
        ]);
        dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            w / 2,
            h * 0.88,
            Graphics.FONT_XTINY,
            peakStr,
            Graphics.TEXT_JUSTIFY_CENTER
        );
    }
}
