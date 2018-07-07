class com.clubpenguin.services.vo.ServerCookieVO implements com.clubpenguin.util.ISerializable, com.clubpenguin.util.IVO
{
    var _cookieId;
    function ServerCookieVO(cookieId)
    {
        _cookieId = cookieId;
    } // End of the function
    function destroy()
    {
    } // End of the function
    function getID()
    {
        return (_cookieId);
    } // End of the function
    function getCookieHandlerName()
    {
        return (null);
    } // End of the function
    function getSendCommandName()
    {
        return (null);
    } // End of the function
    function getReceiveCommandName()
    {
        return (null);
    } // End of the function
    function update(vo)
    {
    } // End of the function
    function requestFromServer()
    {
        _global.getCurrentShell().getServerCookieService().requestCookieFromServer(this.getID());
    } // End of the function
    function sendToServer()
    {
        _global.getCurrentShell().getServerCookieService().sendCookieToServer(this.getID());
    } // End of the function
    function toString()
    {
        return ("[ServerCookieVO:id=" + this.getID() + "]");
    } // End of the function
    function equals(vo)
    {
        return (_cookieId == vo.getID());
    } // End of the function
    function serialize()
    {
        return (null);
    } // End of the function
    function deserialize(data)
    {
    } // End of the function
} // End of Class
