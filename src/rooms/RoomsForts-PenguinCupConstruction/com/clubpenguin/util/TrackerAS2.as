class com.clubpenguin.util.TrackerAS2
{
    var _shell, currentContext;
    static var singletonInstance;
    function TrackerAS2()
    {
        trace ("TrackerAS2()");
        if (!_shell && _global.getCurrentShell())
        {
            _shell = _global.getCurrentShell();
        }
        else
        {
            trace ("\tERROR: _shell = " + _shell);
        } // end else if
        currentContext = "load.login";
    } // End of the function
    static function getInstance()
    {
        trace ("\tTrackerAS2.getInstance()");
        if (!com.clubpenguin.util.TrackerAS2.singletonInstance)
        {
            singletonInstance = new com.clubpenguin.util.TrackerAS2();
        } // end if
        return (com.clubpenguin.util.TrackerAS2.singletonInstance);
    } // End of the function
    function startTracker()
    {
        trace ("\tTrackerAS2.startTracker()");
        _shell.startTracker();
    } // End of the function
    function sendTrackingEvent(trackingKey, paramsJSONString)
    {
        trace ("\tTrackerAS2.sendTrackingEvent()");
        _shell.sendTrackingEvent(trackingKey, paramsJSONString);
    } // End of the function
    function sendToAS3StartAssetLoad(context)
    {
        currentContext = context;
        _shell.sendToAS3StartAssetLoad(context);
    } // End of the function
    function sendToAS3EndAssetLoad(context, bytesTotal, path, result)
    {
        trace ("\tTrackerAS2.sendToAS3EndAssetLoad(" + context + ")");
        _shell.sendToAS3EndAssetLoad(context, bytesTotal, path, result);
    } // End of the function
    function sendToAS3StartSubContextAssetLoad(context, location)
    {
        this.recordStartTime(location);
        _shell.sendToAS3StartSubContextAssetLoad(context, location);
    } // End of the function
    function sendToAS3EndSubContextAssetLoad(location, pathName)
    {
        trace ("\tTrackerAS2.sendToAS3EndSubContextAssetLoad(" + location + ")");
        if (!pathName)
        {
            pathName = "";
        } // end if
        var _loc3 = this.fetchElapsedTime(location);
        location = location;
        _shell.sendToAS3EndSubContextAssetLoad(location, pathName, _loc3);
    } // End of the function
    function sendToAS3LogGameAction(context, action, itemName, payload)
    {
        _shell.sendToAS3LogGameAction(context, action, itemName, payload);
    } // End of the function
    function sendTrackLoginError()
    {
        trace ("\tTrackerAS2.sendTrackLoginError()");
        _shell.sendTrackLoginError();
    } // End of the function
    function sendToAS3LogError(reason, context, message)
    {
        trace ("\tTrackerAS2.sendToAS3LogError()");
        _shell.sendToAS3LogError(reason, context, message);
    } // End of the function
    function sendToAS3LogMovieClipTimeout(reason, context, message)
    {
        trace ("\tTrackerAS2.sendToAS3LogMovieClipTimeout()");
        _shell.sendToAS3LogMovieClipTimeout(reason, context, message);
    } // End of the function
    function sendToAS3LogMovieClipLoadError(reason, context, fileURL, errorCode, httpStatus)
    {
        trace ("\tTrackerAS2.sendToAS3LogMovieClipLoadError()");
        _shell.sendToAS3LogMovieClipLoadError(reason, context, fileURL, errorCode, httpStatus);
    } // End of the function
    function sendToAS3LogMovieClipParamError(reason, context, fileURL, caller)
    {
        trace ("\tTrackerAS2.sendToAS3LogMovieClipParamError()");
        _shell.sendToAS3LogMovieClipParamError(reason, context, fileURL, caller);
    } // End of the function
    function sendWorldSelectedStartLog(world_id)
    {
        currentContext = "load.world";
        _shell.sendWorldSelectedStartLog(currentContext, world_id);
    } // End of the function
    function trackUserInfo(transaction_id, isMember, player_id, city, state, country, zip)
    {
        var _loc2 = {};
        _loc2.type = com.clubpenguin.util.TrackerAS2.USER_INFO;
        _loc2.transaction_id = transaction_id;
        _loc2.isMember = isMember;
        _loc2.player_id = player_id;
        _loc2.city = city;
        _loc2.state = state;
        _loc2.country = country;
        _loc2.zip = zip;
        _shell.sendPlaydomTracking(_loc2);
    } // End of the function
    function trackTestImpression(test, variant, control)
    {
        trace ("\tTrackerAS2.trackTestImpression()");
        var _loc2 = {};
        _loc2.type = com.clubpenguin.util.TrackerAS2.TEST_IMPRESSION;
        _loc2.test = test;
        _loc2.variant = variant;
        _loc2.control = control;
        _shell.sendPlaydomTracking(_loc2);
    } // End of the function
    function trackStepTimingEvent(context, location, pathName, result)
    {
        var _loc2 = {};
        _loc2.type = com.clubpenguin.util.TrackerAS2.STEP_TIMING;
        _loc2.context = context;
        _loc2.location = location;
        _loc2.path_name = pathName;
        _loc2.result = result;
        _shell.sendPlaydomTracking(_loc2);
    } // End of the function
    function trackRewardEarned(currency, amount, maintype, subtype, balance, context, options)
    {
        if (amount == 0)
        {
            amount = -1;
        } // end if
        var _loc2 = {};
        _loc2.type = com.clubpenguin.util.TrackerAS2.MONEY;
        _loc2.amount = amount;
        _loc2.currency = currency;
        _loc2.maintype = maintype;
        _loc2.subtype = subtype;
        _loc2.balance = balance;
        _loc2.context = context;
        _loc2.options = options;
        _shell.sendPlaydomTracking(_loc2);
    } // End of the function
    function trackGameAction(action, context, options)
    {
        var _loc2 = {};
        _loc2.type = com.clubpenguin.util.TrackerAS2.GAME_ACTION;
        _loc2.action = action;
        _loc2.context = context;
        _loc2.options = options;
        _shell.sendPlaydomTracking(_loc2);
    } // End of the function
    function trackPopup(tracking_code, step)
    {
        var _loc2 = {};
        _loc2.type = com.clubpenguin.util.TrackerAS2.POPUP;
        _loc2.tracking_code = tracking_code;
        _loc2.step = step;
        _shell.sendPlaydomTracking(_loc2);
    } // End of the function
    function recordStartTime(location)
    {
        if (_trackerStartTimes[location] != null)
        {
            trace ("\t\tERROR: _trackerStartTimes[" + location + "] already exists");
        } // end if
        _trackerStartTimes[location] = getTimer();
    } // End of the function
    function fetchElapsedTime(location)
    {
        if (_trackerStartTimes[location] == null)
        {
            trace ("\t\tERROR: _trackerStartTimes[" + location + "] does not exist");
        } // end if
        var _loc4 = _trackerStartTimes[location];
        var _loc3 = getTimer();
        var _loc5 = _loc3 - _loc4;
        _trackerStartTimes[location] = null;
        return (_loc5);
    } // End of the function
    static var ERROR = 0;
    static var GAME_ACTION = 1;
    static var PAGEVIEW = 2;
    static var POPUP = 3;
    static var LEVEL_UP = 4;
    static var MONEY = 5;
    static var STEP_TIMING = 6;
    static var USER_STAT_CHANGE = 7;
    static var SEND_MONEY = 8;
    static var SEND_SOCIAL_ACTION = 9;
    static var PERFORMANCE = 10;
    static var SYSTEM = 11;
    static var TEST_IMPRESSION = 12;
    static var USER_INFO = 13;
    static var CURRENCY_COINS = "coins";
    static var CURRENCY_MEDALS = "medals";
    static var CURRENCY_STAMPS = "stamps";
    static var CURRENCY_ITEMS = "items";
    var _trackerStartTimes = [];
} // End of Class
