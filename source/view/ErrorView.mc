using Toybox.WatchUi as WatchUi;

class ErrorView extends WatchUi.View {

    hidden var _messageLbl;

    function initialize() {
        View.initialize();
        _messageLbl = View.findDrawableById("errorMsg") as WatchUi.Text;
    }

    function onLayout(dc) as Void {
        setLayout(Rez.Layouts.ErrorLayout(dc));
    }
}
