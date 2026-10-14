import Toybox.WatchUi;
import Toybox.Lang;

class MainViewDelegate extends WatchUi.BehaviorDelegate {
    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onTap(keyEvent as WatchUi.ClickEvent) as Lang.Boolean {
        WatchUi.pushView(
            new DetailView(),
            new DetailViewDelegate(),
            WatchUi.SLIDE_LEFT
        );
        System.println("Tapped on MainView, pushed DetailView");
        return true;
    }

    function onKey(keyEvent as WatchUi.KeyEvent) as Lang.Boolean {
        WatchUi.pushView(
            new DetailView(),
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
