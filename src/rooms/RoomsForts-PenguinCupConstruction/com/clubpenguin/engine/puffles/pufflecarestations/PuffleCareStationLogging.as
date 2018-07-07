class com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging
{
    function PuffleCareStationLogging()
    {
    } // End of the function
    static function sendPuffleCareStationBI(careStationName, careStationAction, careItem)
    {
        var _loc2 = new Object();
        var _loc5 = _global.getCurrentShell().getMyPlayerObject().attachedPuffle.color;
        var _loc3;
        if (careItem != undefined && careItem != null)
        {
            _loc3 = "|menu=" + String(careItem);
        }
        else
        {
            _loc3 = "";
        } // end else if
        _loc2.message = "station_type=" + careStationName + "|puffle=" + _loc5 + _loc3;
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(careStationAction, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging.LOGGING_TYPE, _loc2);
    } // End of the function
    static var LOGGING_TYPE = "puffle_station";
} // End of Class
