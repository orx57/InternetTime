using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;

class InternetTimeView extends Ui.WatchFace {

    //! Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    //! Restore the state of the app and prepare the view to be shown
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
        // Get and show the current time
        var clockTime = Sys.getClockTime();
        var beats = ((clockTime.sec + (clockTime.min * 60) + (clockTime.hour * 3600) + (3600 - clockTime.timeZoneOffset)) / 86.4);
        //var beats = (((clockTime.sec + (clockTime.min * 60) + (clockTime.hour * 3600) + (3600 - clockTime.timeZoneOffset)) / 86.4) % 1000);
        // var test = beats.toNumber() % 1000;
        if (beats > 1000) {
            beats = beats - 1000;
        }
        else if (beats < 0) {
            beats = beats + 1000;
        }
        var beatsString = beats.format("%.3d");
        var timeString = Lang.format("@$1$", [beatsString]);
        var timeString2 = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%.2d")]);
        var view = View.findDrawableById("TimeLabel");
        view.setText(timeString);
        var view2 = View.findDrawableById("TimeLabel2");
        view2.setText(timeString2);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    //! The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    //! Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
