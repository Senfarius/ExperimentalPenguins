class com.clubpenguin.shell.puffle.PuffleHatVO
{
    var assetLinkage, hatFrontAsset, hatBackAsset, id, name, label, hatType;
    function PuffleHatVO()
    {
    } // End of the function
    function getAS2AssetPath()
    {
        var _loc2 = assetLinkage.indexOf("/") + 1;
        var _loc4 = assetLinkage.indexOf(".");
        var _loc3 = assetLinkage.substring(_loc2, _loc4);
        return (_loc3);
    } // End of the function
    function setHatFrontAsset()
    {
        var _loc2 = this.getAS2AssetPath() + com.clubpenguin.shell.puffle.PuffleHatVO.HAT + com.clubpenguin.shell.puffle.PuffleHatVO.FRONT;
        _loc2 = _loc2.toLowerCase();
        _loc2 = _loc2 + com.clubpenguin.shell.puffle.PuffleHatVO.SWF;
        hatFrontAsset = _loc2;
    } // End of the function
    function setHatBackAsset()
    {
        var _loc2 = this.getAS2AssetPath() + com.clubpenguin.shell.puffle.PuffleHatVO.HAT + com.clubpenguin.shell.puffle.PuffleHatVO.BACK;
        _loc2 = _loc2.toLowerCase();
        _loc2 = _loc2 + com.clubpenguin.shell.puffle.PuffleHatVO.SWF;
        hatBackAsset = _loc2;
    } // End of the function
    static function getEmptyHatVO()
    {
        var _loc1 = new com.clubpenguin.shell.puffle.PuffleHatVO();
        _loc1.id = com.clubpenguin.shell.puffle.PuffleHatVO.EMPTY_HAT_ID;
        _loc1.name = "";
        _loc1.label = "";
        _loc1.assetLinkage = "";
        _loc1.hatType = com.clubpenguin.shell.puffle.PuffleHatEnum.EMPTY_HAT;
        return (_loc1);
    } // End of the function
    function outputHatVO()
    {
        trace ("\n");
        trace ("**********************************************************************");
        trace ("**********************************************************************");
        trace ("outputHatVO");
        trace ("id: " + id);
        trace ("name: " + name);
        trace ("label: " + label);
        trace ("assetLinkage: " + assetLinkage);
        trace ("hatType: " + hatType.__get__name());
        trace ("**********************************************************************");
        trace ("**********************************************************************");
    } // End of the function
    static var HAT_DATA_DELIMITER = "@";
    static var EMPTY_HAT_ID = 0;
    static var HAT = "_hat";
    static var FRONT = "_front";
    static var BACK = "_back";
    static var SWF = ".swf";
} // End of Class
