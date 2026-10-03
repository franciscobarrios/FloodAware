using Toybox.WatchUi;
using Toybox.Lang;

class FloodAwareViewDelegate extends WatchUi.BehaviorDelegate {
    var _model as FloodDataModel;

    function initialize(model as FloodDataModel) {
        BehaviorDelegate.initialize();
        _model = model;
    }

    function onSelect() as Lang.Boolean {
        WatchUi.pushView(
            new FloodTrendView(_model),
            new FloodTrendViewDelegate(_model),
            WatchUi.SLIDE_LEFT
        );
        return true;
    }

    function onNextPage() as Lang.Boolean {
        WatchUi.pushView(
            new FloodTrendView(_model),
            new FloodTrendViewDelegate(_model),
            WatchUi.SLIDE_LEFT
        );
        return true;
    }

    function onKey(keyEvent as WatchUi.KeyEvent) as Lang.Boolean {
        if (
            keyEvent.getKey() == WatchUi.KEY_UP ||
            keyEvent.getKey() == WatchUi.KEY_DOWN ||
            keyEvent.getKey() == WatchUi.KEY_START
        ) {
            WatchUi.pushView(
                new FloodTrendView(_model),
                new FloodTrendViewDelegate(_model),
                WatchUi.SLIDE_LEFT
            );
            return true;
        }

        WatchUi.pushView(
            new FloodTrendView(_model),
            new FloodTrendViewDelegate(_model),
            WatchUi.SLIDE_LEFT
        );
        return true;
    }
}
