class com.clubpenguin.login.LoginFloodManager
{
    function LoginFloodManager()
    {
    } // End of the function
    null[] = (Error)() == null ? (null, throw , function ()
    {
        trace ("clearFloodControl");
        try
        {
            var _loc1 = SharedObject.getLocal(com.clubpenguin.login.LoginFloodManager.SHARED_OBJECT_NAME, "/");
            _loc1.clear();
            _loc1 = null;
        } // End of try
        catch ()
        {
        } // End of catch
    }) : (var e = (Error)(), trace ("Error while clearing floodControl SharedObject"), "clearFloodControl");
    static function setLoginAttempt()
    {
        var _loc2 = SharedObject.getLocal(com.clubpenguin.login.LoginFloodManager.SHARED_OBJECT_NAME, "/");
        var _loc4;
        var _loc5 = new Date();
        var _loc1 = 0;
        var _loc3 = 0;
        trace ("setLoginAttempt");
        try
        {
            if (_loc2.data[com.clubpenguin.login.LoginFloodManager.LOGIN_ATTEMPTS] != undefined)
            {
                _loc1 = _loc2.data[com.clubpenguin.login.LoginFloodManager.LOGIN_ATTEMPTS];
            } // end if
            ++_loc1;
            if (_loc1 > com.clubpenguin.login.LoginFloodManager.LOGIN_DELAYS.length - 1)
            {
                _loc1 = 0;
            } // end if
            if (_loc1 == 0)
            {
                _loc3 = com.clubpenguin.login.LoginFloodManager.MIN_DELAY;
            } // end if
            _loc2.data[com.clubpenguin.login.LoginFloodManager.LOGIN_ATTEMPTS] = _loc1;
            _loc2.data[com.clubpenguin.login.LoginFloodManager.NEXT_LOGIN_TIME] = Number(_loc5.getTime() + (com.clubpenguin.login.LoginFloodManager.LOGIN_DELAYS[_loc1] + com.clubpenguin.math.MathHelper.getRandomNumberInRange(_loc3, com.clubpenguin.login.LoginFloodManager.RANDOM_RANGE)) * com.clubpenguin.login.LoginFloodManager.ONE_SECOND);
            trace ("so.data[LOGIN_ATTEMPTS] : " + _loc2.data[com.clubpenguin.login.LoginFloodManager.LOGIN_ATTEMPTS]);
            trace ("so.data[NEXT_LOGIN_TIME] : " + _loc2.data[com.clubpenguin.login.LoginFloodManager.NEXT_LOGIN_TIME]);
            _loc4 = _loc2.flush();
            trace ("soResult : " + _loc4);
        } // End of try
        catch ()
        {
        } // End of catch
        return (true);
    } // End of the function
    static var SHARED_OBJECT_NAME = "floodControl";
    static var NEXT_LOGIN_TIME = "nlt";
    static var LOGIN_ATTEMPTS = "att";
    static var LOGIN_DELAYS = [0, 20, 40];
    static var RANDOM_RANGE = 20;
    static var MIN_DELAY = 10;
    static var ONE_SECOND = 1000;
} // End of Class
