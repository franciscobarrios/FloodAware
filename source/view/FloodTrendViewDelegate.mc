using Toybox.WatchUi;
using Toybox.Lang;

class FloodTrendViewDelegate extends WatchUi.BehaviorDelegate {
    
    var _model as FloodDataModel;
    
    function initialize(model as FloodDataModel) {
        BehaviorDelegate.initialize();
        _model = model;
    }

    function onBack() as Lang.Boolean {
        //WatchUi.popView(WatchUi.SLIDE_RIGHT);
        return true;
    }
}
