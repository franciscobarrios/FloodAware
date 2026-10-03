import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

(:glance)
class FloodAwareApp extends Application.AppBase {
    private var _model as FloodDataModel;
    private var _serviceDelegate as FloodServiceDelegate;

    function initialize() {
        AppBase.initialize();
        _model = new FloodDataModel();
        _serviceDelegate = new FloodServiceDelegate(method(:onDataReceived));
    }

    function onStart(state as Dictionary?) as Void {
        _serviceDelegate.fetchFloodData(13.83f, 100.58f);
    }

    function onStop(state as Dictionary?) as Void {}

    function getInitialView() as [Views] or [Views, InputDelegates] {
        var initialView = new FloodAwareView(_model);
        var initialDelegate = new FloodAwareViewDelegate(_model);
        return [initialView, initialDelegate];
    }

    function onDataReceived(data as Dictionary or String or Null) as Void {
        if (data instanceof Dictionary) {
            _model.parseJson(data as Dictionary);
            WatchUi.requestUpdate(); // Redraw UI
        }
    }

    function getGlanceView() {
        return [new FloodGlanceView(_model)];
    }
}

function getApp() as FloodAwareApp {
    return Application.getApp() as FloodAwareApp;
}
