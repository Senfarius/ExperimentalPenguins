class com.clubpenguin.services.vo.JsonServerCookieVO extends com.clubpenguin.services.vo.ServerCookieVO
{
    var deserialized, _jsonObject;
    function JsonServerCookieVO(cookieId)
    {
        super(cookieId);
        deserialized = new org.osflash.signals.Signal();
        _jsonObject = new Object();
    } // End of the function
    function destroy()
    {
        super.destroy();
    } // End of the function
    function isInitialized()
    {
        return (_jsonObject != null);
    } // End of the function
    function update(vo)
    {
        this.deserialize((com.clubpenguin.services.vo.JsonServerCookieVO)(vo).serialize());
    } // End of the function
    function toString()
    {
        return ("[JsonServerCookie:" + this.serialize() + "]");
    } // End of the function
    function serialize()
    {
        return (com.clubpenguin.util.JSONParser.stringify(_jsonObject));
    } // End of the function
    function deserialize(data)
    {
        if (data == undefined || data.length == 0)
        {
            _jsonObject = new Object();
        }
        else
        {
            var _loc2 = com.clubpenguin.util.JSONParser.parse(data);
            if (_jsonObject == null)
            {
                _jsonObject = new Object();
            } // end if
            for (var _loc3 in _loc2)
            {
                _jsonObject[_loc3] = _loc2[_loc3];
            } // end of for...in
        } // end else if
        deserialized.dispatch();
    } // End of the function
} // End of Class
