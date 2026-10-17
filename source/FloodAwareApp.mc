import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class FloodAwareApp extends Application.AppBase {
    private var _model as FloodDataModel;
    private var _floodService as FloodService;

    function initialize() {
        AppBase.initialize();
        _model = new FloodDataModel();
        _floodService = new FloodService(method(:onDataReceived));
    }

    function onStart(state as Dictionary?) as Void {
        _floodService.fetchData(13.83f, 100.58f); //Bangkok coordinates for testing
    }

    function onDataReceived(data as Dictionary or String or Null) as Void {
        if (data instanceof Dictionary) {
            _model.parseJson(data as Dictionary);
            WatchUi.requestUpdate(); // Redraw UI
        }
    }

    function onStop(state as Dictionary?) as Void {}

    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [new MainView(_model), new MainViewDelegate(_model)];
    }
}

function getApp() as FloodAwareApp {
    return Application.getApp() as FloodAwareApp;
}
