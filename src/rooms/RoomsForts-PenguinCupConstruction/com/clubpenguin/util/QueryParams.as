class com.clubpenguin.util.QueryParams
{
    function QueryParams()
    {
    } // End of the function
    static function getQueryParams(testingQueryString)
    {
        var _loc8;
        if (testingQueryString)
        {
            _loc8 = testingQueryString;
        }
        else
        {
            _loc8 = String(flash.external.ExternalInterface.call("parent.window.location.search.substring", 1));
        } // end else if
        var _loc7 = {};
        var _loc6 = _loc8.split("&");
        var _loc3 = 0;
        var _loc2 = -1;
        while (_loc3 < _loc6.length)
        {
            var _loc1 = _loc6[_loc3];
            _loc2 = _loc1.indexOf("=");
            if (_loc1.indexOf("=") > 0)
            {
                var _loc4 = _loc1.substring(0, _loc2);
                _loc4.toLowerCase();
                var _loc5 = _loc1.substring(_loc2 + 1);
                _loc7[_loc4] = _loc5;
            } // end if
            ++_loc3;
        } // end while
        return (_loc7);
    } // End of the function
} // End of Class
