class com.clubpenguin.shell.PuffleModel
{
    var mood, hat, stats, color;
    function PuffleModel()
    {
        mood = new com.clubpenguin.shell.PuffleMoodVO();
        hat = new com.clubpenguin.shell.puffle.PuffleHatVO();
        stats = new com.clubpenguin.shell.PuffleStatsVO();
    } // End of the function
    function hasHat()
    {
        return (hat.hatType == com.clubpenguin.shell.puffle.PuffleHatEnum.ACTUAL_HAT ? (true) : (false));
    } // End of the function
    function updateStats()
    {
        trace ("Update stats");
    } // End of the function
    function updatePuffleState(puffleState)
    {
        _puffleState = puffleState;
    } // End of the function
    function getPuffleState()
    {
        return (_puffleState);
    } // End of the function
    function getFormattedAssetURL(assetURL)
    {
        return (com.clubpenguin.shell.PuffleModel.formatAssetURL(assetURL, color, subTypeID));
    } // End of the function
    function isWildPuffle()
    {
        return (subTypeID != null && subTypeID != undefined && subTypeID != -1 && !isNaN(subTypeID));
    } // End of the function
    static function formatAssetURL(assetURL, puffleColor, puffleSubTypeID)
    {
        var _loc2 = isNaN(puffleSubTypeID) || puffleSubTypeID == 0 ? ("") : (puffleSubTypeID);
        assetURL = com.clubpenguin.util.StringUtils.replaceString("%color%", puffleColor, assetURL);
        assetURL = com.clubpenguin.util.StringUtils.replaceString("%wildTypeId%", _loc2, assetURL);
        return (assetURL);
    } // End of the function
    var id = -1;
    var typeID = -1;
    var subTypeID = -1;
    var name = "";
    var _puffleState = 0;
} // End of Class
