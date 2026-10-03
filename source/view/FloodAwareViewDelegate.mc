using Toybox.WatchUi;
using Toybox.Lang;

class FloodAwareViewDelegate extends WatchUi.BehaviorDelegate {
    var _model as FloodDataModel;

    function initialize(model as FloodDataModel) {
        BehaviorDelegate.initialize();
        _model = model;
    }

    function onSelect() as Lang.Boolean {
        WatchUi.switchToView(
            new FloodTrendView(_model),
            new FloodTrendViewDelegate(_model),
            WatchUi.SLIDE_LEFT
        );
        return true;
    }

    function onKey(keyEvent as WatchUi.KeyEvent) as Lang.Boolean {
        var key = keyEvent.getKey();
        if (key == WatchUi.KEY_ENTER || key == WatchUi.KEY_START) {
            WatchUi.switchToView(
                new FloodTrendView(_model),
                new FloodTrendViewDelegate(_model),
                WatchUi.SLIDE_LEFT
            );
            return true; // Handled
        }
        return false; // Let OS / BehaviorDelegate process other keys
    }

    function onBack() as Lang.Boolean {
        return true;
    }
}
