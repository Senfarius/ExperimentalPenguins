class com.clubpenguin.world.rooms2014.muppets.vo.MuppetsPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
{
    var _jsonObject, __get__muppets, __get__login;
    function MuppetsPartyCookieVO(cookieId)
    {
        super(cookieId);
    } // End of the function
    function getCookieHandlerName()
    {
        return (com.clubpenguin.world.rooms2014.muppets.vo.MuppetsPartyCookieVO.MUPPETS_COOKIE_HANDLER_NAME);
    } // End of the function
    function getSendCommandName()
    {
        return ("ERROR-NO-COOKIE-SEND-COMMAND");
    } // End of the function
    function getReceiveCommandName()
    {
        return (com.clubpenguin.world.rooms2014.muppets.vo.MuppetsPartyCookieVO.MUPPETS_RECEIVE_COMMAND_NAME);
    } // End of the function
    function get muppets()
    {
        if (_jsonObject.muppets == undefined)
        {
            return (new Object());
        } // end if
        return (_jsonObject.muppets);
    } // End of the function
    function get login()
    {
        if (_jsonObject.login == undefined)
        {
            return (0);
        } // end if
        return (_jsonObject.login);
    } // End of the function
    function getMessageViewedByMuppetId(muppetId)
    {
        var _loc2 = this.__get__muppets()[String(muppetId)].mv;
        if (_loc2 == undefined)
        {
            return ([0, 0]);
        } // end if
        return (_loc2);
    } // End of the function
    function isMuppetMessageViewed(muppetId, messageIndex)
    {
        var _loc2 = this.getMessageViewedByMuppetId(muppetId);
        return (_loc2[messageIndex] == 1);
    } // End of the function
    function setMessageViewed(muppetId, messageIndex)
    {
        if (muppetId < 0 && muppetId > 7)
        {
            return;
        } // end if
        if (this.isMuppetMessageViewed(muppetId, messageIndex))
        {
            return;
        } // end if
        _jsonObject[String(muppetId)].mv[messageIndex] = 1;
        var _loc4 = _global.getCurrentAirtower();
        _loc4.send(_loc4.PLAY_EXT, com.clubpenguin.world.rooms2014.muppets.vo.MuppetsPartyCookieVO.MUPPETS_COOKIE_HANDLER_NAME + "#" + "mmsgviewed", [muppetId, messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
    } // End of the function
    function traceSetError(propertyName, value)
    {
        trace ("MuppetsPartyCookieVO - ERROR - " + value + " is not a valid value for " + propertyName);
    } // End of the function
    static var MUPPETS_COOKIE_HANDLER_NAME = "muppets";
    static var MUPPETS_RECEIVE_COMMAND_NAME = "partycookie";
} // End of Class
