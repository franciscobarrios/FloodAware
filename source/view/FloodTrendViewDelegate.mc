using Toybox.WatchUi;
using Toybox.Lang;

class FloodTrendViewDelegate extends WatchUi.BehaviorDelegate {
    private var _model as FloodDataModel;

    function initialize(model as FloodDataModel) {
        BehaviorDelegate.initialize();
        _model = model;
    }

    function onBack() as Lang.Boolean {
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
        return true;
    }

    function onPreviousPage() as Lang.Boolean {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
        return true;
    }
}
