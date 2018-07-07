class com.clubpenguin.services.ServerCookieService
{
    var _airtowerListeners, _airtower, _shell, _cookies;
    function ServerCookieService()
    {
        this.init();
    } // End of the function
    function init()
    {
        _airtowerListeners = {};
        if (_airtower != null)
        {
            this.removeAirtowerListeners();
        } // end if
        _airtower = _global.getCurrentAirtower();
        _shell = _global.getCurrentShell();
        _cookies = {};
    } // End of the function
    function registerCookieVO(cookieId, cookieVO)
    {
        if (_cookies[cookieId] != null)
        {
            return (false);
        } // end if
        _cookies[cookieId] = cookieVO;
        if (_airtowerListeners[cookieVO.getReceiveCommandName()] != true)
        {
            _airtowerListeners[cookieVO.getReceiveCommandName()] = true;
            _airtower.addListener(cookieVO.getReceiveCommandName(), com.clubpenguin.util.Delegate.create(this, onServerCookieReceived, cookieId), this);
        } // end if
        return (true);
    } // End of the function
    function getCookieVO(cookieId)
    {
        return (_cookies[cookieId]);
    } // End of the function
    function requestCookieFromServer(cookieId)
    {
        var _loc2 = this.getCookieVO(cookieId);
        if (_loc2 != null)
        {
            _airtower.send(_airtower.PLAY_EXT, _loc2.getCookieHandlerName() + "#" + _loc2.getReceiveCommandName(), [], "str", _shell.getCurrentServerRoomId());
        } // end if
    } // End of the function
    function sendCookieToServer(cookieId)
    {
        var _loc2 = this.getCookieVO(cookieId);
        if (_loc2 != null)
        {
            _airtower.send(_airtower.PLAY_EXT, _loc2.getCookieHandlerName() + "#" + _loc2.getSendCommandName(), [_loc2.serialize()], "str", _shell.getCurrentServerRoomId());
        } // end if
    } // End of the function
    function onServerCookieReceived(data, cookieId)
    {
        var _loc4 = data[0];
        var _loc3 = data[1];
        var _loc2 = _cookies[cookieId];
        if (_loc2 != null)
        {
            _loc2.deserialize(_loc3);
        } // end if
    } // End of the function
    function removeAirtowerListeners()
    {
        for (var _loc2 in _airtowerListeners)
        {
            _airtower.removeListener(_loc2, onServerCookieReceived);
        } // end of for...in
    } // End of the function
} // End of Class
