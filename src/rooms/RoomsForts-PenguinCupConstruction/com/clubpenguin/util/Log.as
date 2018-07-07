class com.clubpenguin.util.Log
{
    function Log()
    {
    } // End of the function
    static function info(msg, channel)
    {
        com.clubpenguin.util.Log.writeLog(com.clubpenguin.util.Log.INFO, msg, channel);
    } // End of the function
    static function debug(msg, channel)
    {
        com.clubpenguin.util.Log.writeLog(com.clubpenguin.util.Log.DEBUG, msg, channel);
    } // End of the function
    static function warn(msg, channel)
    {
        com.clubpenguin.util.Log.writeLog(com.clubpenguin.util.Log.WARNING, msg, channel);
    } // End of the function
    static function error(msg, channel)
    {
        com.clubpenguin.util.Log.writeLog(com.clubpenguin.util.Log.ERROR, msg, channel);
    } // End of the function
    static function fatal(msg, channel)
    {
        com.clubpenguin.util.Log.writeLog(com.clubpenguin.util.Log.FATAL, msg, channel);
    } // End of the function
    static function writeLog(level, msg, channel)
    {
        if (channel == undefined)
        {
            channel = com.clubpenguin.util.Log.DEFAULT;
        } // end if
        if (com.clubpenguin.util.Log._enabled && channel.__get__bitMask() & com.clubpenguin.util.Log.getChannelMask() && level <= com.clubpenguin.util.Log._logLevel)
        {
            var _loc3 = _global.getCurrentShell().getMyPlayerNickname().substr(0, 4);
            trace ("" + com.clubpenguin.util.Log.getTimestamp() + " [AS2] " + com.clubpenguin.util.Log.getLevelAsString(level) + " |-" + channel.__get__name().toUpperCase() + "-|-" + _loc3 + "-| " + msg);
        } // end if
    } // End of the function
    static function generateChannelMask()
    {
        _channelMask = 0;
        for (var _loc1 = 0; _loc1 < com.clubpenguin.util.Log._openChannels.length; ++_loc1)
        {
            _channelMask = com.clubpenguin.util.Log._channelMask | com.clubpenguin.util.Log._openChannels[_loc1].bitMask;
        } // end of for
    } // End of the function
    static function getChannelMask()
    {
        if (com.clubpenguin.util.Log._channelMask == undefined)
        {
            com.clubpenguin.util.Log.generateChannelMask();
        } // end if
        return (com.clubpenguin.util.Log._channelMask);
    } // End of the function
    static function setLogLevel(newLogLevel)
    {
        _logLevel = newLogLevel;
    } // End of the function
    static function getLevelAsString(level)
    {
        switch (level)
        {
            case com.clubpenguin.util.Log.INFO:
            {
                return ("[INFO]");
            } 
            case com.clubpenguin.util.Log.DEBUG:
            {
                return ("[DEBUG]");
            } 
            case com.clubpenguin.util.Log.WARNING:
            {
                return ("[WARNING]");
            } 
            case com.clubpenguin.util.Log.ERROR:
            {
                return ("[*ERROR*]");
            } 
            case com.clubpenguin.util.Log.FATAL:
            {
                return ("[***FATAL***]");
            } 
        } // End of switch
        return ("[???]");
    } // End of the function
    static function getTimestamp()
    {
        var _loc1 = new Date();
        return (com.clubpenguin.util.Log.stringPadNumber(_loc1.getHours() + 1, 2) + ":" + com.clubpenguin.util.Log.stringPadNumber(_loc1.getMinutes(), 2) + ":" + com.clubpenguin.util.Log.stringPadNumber(_loc1.getSeconds(), 2) + "::" + com.clubpenguin.util.Log.stringPadNumber(_loc1.getMilliseconds(), 3));
    } // End of the function
    static function stringPadNumber(num, padding)
    {
        var _loc2 = "" + num;
        for (var _loc1 = 1; _loc1 <= padding - 1; ++_loc1)
        {
            if (num / Math.pow(10, _loc1) < 1)
            {
                _loc2 = "0" + _loc2;
            } // end if
        } // end of for
        return (_loc2);
    } // End of the function
    static var INFO = 4;
    static var DEBUG = 3;
    static var WARNING = 2;
    static var ERROR = 1;
    static var FATAL = 0;
    static var ALL = new com.clubpenguin.util.LogChannel("all");
    static var DEFAULT = new com.clubpenguin.util.LogChannel("default");
    static var SOCKET = new com.clubpenguin.util.LogChannel("socket");
    static var HTTP = new com.clubpenguin.util.LogChannel("http");
    static var UI = new com.clubpenguin.util.LogChannel("ui");
    static var BRIDGE = new com.clubpenguin.util.LogChannel("bridge");
    static var DEBUGGING = new com.clubpenguin.util.LogChannel("debugging");
    static var PARTY = new com.clubpenguin.util.LogChannel("party");
    static var ENGINE = new com.clubpenguin.util.LogChannel("engine");
    static var PUFFLES = new com.clubpenguin.util.LogChannel("puffles");
    static var TRANSFORMATIONS = new com.clubpenguin.util.LogChannel("transformations");
    static var _logLevel = 4;
    static var _enabled = true;
    static var _openChannels = [com.clubpenguin.util.Log.ALL];
    static var _channelMask = undefined;
} // End of Class
