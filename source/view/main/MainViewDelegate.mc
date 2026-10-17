import Toybox.WatchUi;
import Toybox.Lang;

class MainViewDelegate extends WatchUi.BehaviorDelegate {
    private var _model as FloodDataModel;

    function initialize(model as FloodDataModel) {
        BehaviorDelegate.initialize();
        _model = model;
    }

    function onTap(keyEvent as WatchUi.ClickEvent) as Lang.Boolean {
        WatchUi.pushView(
            new DetailView(_model),
            new DetailViewDelegate(),
            WatchUi.SLIDE_LEFT
        );
        System.println("Tapped on MainView, pushed DetailView");
        return true;
    }

    function onKey(keyEvent as WatchUi.KeyEvent) as Lang.Boolean {
        WatchUi.pushView(
            new DetailView(_model),
            new DetailViewDelegate(),
            WatchUi.SLIDE_LEFT
        );
        System.println("Key pressed: " + keyEvent.getKey());
        return true;
    }

    function onBack() as Lang.Boolean {
        System.println("Back button pressed");
        return true;
    }
}
