import Toybox.Lang;
import Toybox.WatchUi;

class SensorTransmitv1Delegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new SensorTransmitv1MenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}