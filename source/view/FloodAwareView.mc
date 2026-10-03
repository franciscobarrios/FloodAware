import Toybox.Graphics;
import Toybox.WatchUi;

class FloodAwareView extends WatchUi.View {

    private var _model as FloodDataModel;

    function initialize(model as FloodDataModel) {
        View.initialize();
        _model = model;
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    function onShow() as Void {}

    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);

        var w = dc.getWidth();
        var h = dc.getHeight();

        // city
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(w / 2, h * 0.12, Graphics.FONT_SMALL, "BANGKOK", Graphics.TEXT_JUSTIFY_CENTER);

        // valid data   
        if(_model.isValid) {
            //dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
            //dc.drawText(w * 0.5, h * 0.5, Graphics.FONT_SMALL, "Loading data ...", Graphics.TEXT_JUSTIFY_CENTER);
            //return;
        }

        // Main metric (discharge)
        var dischargeStr = _model.currentDischarge.format("%.0f");

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(w / 2, h * 0.26, Graphics.FONT_NUMBER_HOT, dischargeStr, Graphics.TEXT_JUSTIFY_CENTER);
        
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(w / 2, h * 0.56, Graphics.FONT_SMALL, "m³/s", Graphics.TEXT_JUSTIFY_CENTER);

        dc.setColor(Graphics.COLOR_YELLOW,  Graphics.COLOR_TRANSPARENT);
        dc.fillRoundedRectangle(
            (w * 0.15).toNumber(), // x
            (h * 0.75).toNumber(), // y
            (w * 0.7).toNumber(), // width
            32, // height
            20 // radius
        );            

        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.drawText(w / 2, h * 0.75, Graphics.FONT_SMALL, "HIGH SURGE", Graphics.TEXT_JUSTIFY_CENTER);
    }

    function onHide() as Void {}
}
