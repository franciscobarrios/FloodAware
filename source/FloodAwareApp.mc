import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

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

    function onDataReceived(data as Dictionary or String or Null) as Void {
        if (data instanceof Dictionary) {
            _model.parseJson(data as Dictionary);
            WatchUi.requestUpdate(); // Redraw UI
        }
    }

    function onStop(state as Dictionary?) as Void {}

    function getInitialView() as [Views] or [Views, InputDelegates] {
        var view = new FloodAwareView(_model);
        var delegate = new FloodAwareViewDelegate(_model);
        return [view, delegate];
    }
}

function getApp() as FloodAwareApp {
    return Application.getApp() as FloodAwareApp;
}
