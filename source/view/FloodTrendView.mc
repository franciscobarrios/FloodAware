import Toybox.Graphics;
import Toybox.WatchUi;

class FloodTrendView extends WatchUi.View {

    private var _model as FloodDataModel;

    function initialize(model as FloodDataModel) {
        View.initialize();
        _model = model;
    }

    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.clear();
    }
    
}