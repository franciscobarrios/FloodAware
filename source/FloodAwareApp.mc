import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Background;
import Toybox.Time;

(:background)
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

        if (Background has :registerForTemporalEvent) {
            var lastTime = Background.getLastTemporalEventTime();
            if (lastTime == null) {
                Background.registerForTemporalEvent(new Time.Duration(30 * 60));
            }
        }

        loadCache();
    }

    function onDataReceived(data as Dictionary or String or Null) as Void {
        if (data instanceof Dictionary) {
            _model.parseJson(data as Dictionary);
            WatchUi.requestUpdate(); // Redraw UI
        }
    }

    function onStop(state as Dictionary?) as Void {}

    function loadCache() as Void {
        var cacheData = Application.Storage.getValue("flood_json");
        if (cacheData instanceof Dictionary) {
            _model.parseJson(cacheData as Dictionary);
        }
    }

    function onBackgroundData(data as Application.PersistableType) as Void {
        if (data instanceof Dictionary) {
            Application.Storage.setValue("flood_json", data);
            _model.parseJson(data as Dictionary);
            WatchUi.requestUpdate();
        }
    }

    (:glance)
    function getGlanceView() as
        [WatchUi.GlanceView] or [GlanceView, GlanceViewDelegate] or Null
    {
        return [new FloodGlanceView(_model)];
    }

    function getInitialView() as [Views] or [Views, InputDelegates] {
        var mainView = new MainView(_model);
        var mainDelegate = new MainViewDelegate(_model);
        return [mainView, mainDelegate];
    }
}

function getApp() as FloodAwareApp {
    return Application.getApp() as FloodAwareApp;
}
