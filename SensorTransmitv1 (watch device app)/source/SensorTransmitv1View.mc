using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Activity as Act;
using Toybox.ActivityMonitor as AM;
using Toybox.Communications as COMM;

class SensorTransmitv1View extends WatchUi.View {

var sleeping = false;

// functions here
//Heart Rate
function GetHeartRate(dc) {
var ret = "--";
var hr = Activity.getActivityInfo().currentHeartRate;
if(hr != null) {ret = hr.toString();}
else {
var hrI = ActivityMonitor.getHeartRateHistory(1, true);
var hrs = hrI.next().heartRate;
if(hrs != null && hrs != ActivityMonitor.INVALID_HR_SAMPLE) {ret = hrs.toString();}
}
return ret;
}
    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {

        // Set variables
var HRsupport = (ActivityMonitor has :getHeartRateHistory) ? true : false; //check HR support
var ret = GetHeartRate(dc);

    // Get and show the current time
var clockTime = System.getClockTime();
var clock_hours = Lang.format("$1$", [clockTime.hour.format("%02d")]);
var clock_minutes = Lang.format("$1$", [clockTime.min.format("%02d")]);

        
    
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

          // Normal mode (not sleep)
if(sleeping == false)
{
dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
dc.clear();
//hours
dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_BLACK);
dc.drawText(dc.getWidth() / 2 - 10, dc.getHeight() / 3, Gfx.FONT_NUMBER_THAI_HOT, clock_hours, Gfx.TEXT_JUSTIFY_RIGHT);

//minutes
dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_BLACK);
dc.drawText(dc.getWidth() / 2 + 10, dc.getHeight() / 3, Gfx.FONT_NUMBER_THAI_HOT, clock_minutes, Gfx.TEXT_JUSTIFY_LEFT);

//Indicate mode
dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
dc.drawText(dc.getWidth() / 2, dc.getHeight() / 1.5, Gfx.FONT_SMALL, "normal mode", Gfx.TEXT_JUSTIFY_CENTER);

// draw heart rate if supported
if (HRsupport == true) {
GetHeartRate(dc);
dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_BLACK);
dc.drawText(dc.getWidth() / 2, dc.getHeight() / 1.25, Gfx.FONT_SMALL, ret, Gfx.TEXT_JUSTIFY_CENTER);
}
}
else
{
//hours
dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
dc.drawText(dc.getWidth() / 2 - 10, dc.getHeight() / 3, Gfx.FONT_SMALL, clock_hours, Gfx.TEXT_JUSTIFY_RIGHT);

//minutes
dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
dc.drawText(dc.getWidth() / 2 + 10, dc.getHeight() / 3, Gfx.FONT_SMALL, clock_minutes, Gfx.TEXT_JUSTIFY_LEFT);

//Indicate mode
dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
dc.drawText(dc.getWidth() / 2, dc.getHeight() / 1.5, Gfx.FONT_SYSTEM_XTINY, "sleep mode", Gfx.TEXT_JUSTIFY_CENTER);
}

    }


class PhoneListener extends Communications.ConnectionListener {

    //transmit HR across BLE link
        transmit(ret, null, PhoneListener);  //I have no idea how to set up the "listener"
}

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
