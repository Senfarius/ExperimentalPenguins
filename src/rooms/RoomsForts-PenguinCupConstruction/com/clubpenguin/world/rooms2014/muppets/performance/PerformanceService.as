class com.clubpenguin.world.rooms2014.muppets.performance.PerformanceService
{
    var _msgThrottler, performanceUpdated, performanceRemoved, _shell, _engine, _airtower, _airtowerOpenDelegate, _airtowerCancelDelegate, _airtowerJoinDelegate, _airtowerCloseDelegate, _airtowerListDelegate;
    function PerformanceService()
    {
        _msgThrottler = new com.clubpenguin.util.EventThrottler();
        _msgThrottler.__set__delayBetweenEvents(500);
        _msgThrottler.__set__maxQueueSize(4);
        performanceUpdated = new org.osflash.signals.Signal(Array);
        performanceRemoved = new org.osflash.signals.Signal(com.clubpenguin.world.rooms2014.muppets.performance.PerformanceVO);
        _shell = _global.getCurrentShell();
        _engine = _global.getCurrentEngine();
        _airtower = _global.getCurrentAirtower();
        this.addAirtowerListeners();
    } // End of the function
    function addAirtowerListeners()
    {
        this.logCommand("Add listeners");
        _airtowerOpenDelegate = com.clubpenguin.util.Delegate.create(this, onReceiveOpenCommand);
        _airtowerCancelDelegate = com.clubpenguin.util.Delegate.create(this, onReceiveCancelCommand);
        _airtowerJoinDelegate = com.clubpenguin.util.Delegate.create(this, onReceiveJoinCommand);
        _airtowerCloseDelegate = com.clubpenguin.util.Delegate.create(this, onReceiveCloseCommand);
        _airtowerListDelegate = com.clubpenguin.util.Delegate.create(this, onReceiveListCommand);
        _airtower.addListener(com.clubpenguin.world.rooms2014.muppets.performance.PerformanceService.SERVER_COMMAND_OPEN, _airtowerOpenDelegate);
        _airtower.addListener(com.clubpenguin.world.rooms2014.muppets.performance.PerformanceService.SERVER_COMMAND_JOIN, _airtowerJoinDelegate);
        _airtower.addListener(com.clubpenguin.world.rooms2014.muppets.performance.PerformanceService.SERVER_COMMAND_CANCEL, _airtowerCancelDelegate);
        _airtower.addListener(com.clubpenguin.world.rooms2014.muppets.performance.PerformanceService.SERVER_COMMAND_CLOSE, _airtowerCloseDelegate);
        _airtower.addListener(com.clubpenguin.world.rooms2014.muppets.performance.PerformanceService.SERVER_COMMAND_LIST, _airtowerListDelegate);
    } // End of the function
    function removeAirtowerListeners()
    {
        _airtower.removeListener(com.clubpenguin.world.rooms2014.muppets.performance.PerformanceService.SERVER_COMMAND_OPEN, _airtowerOpenDelegate);
        _airtower.removeListener(com.clubpenguin.world.rooms2014.muppets.performance.PerformanceService.SERVER_COMMAND_JOIN, _airtowerJoinDelegate);
        _airtower.removeListener(com.clubpenguin.world.rooms2014.muppets.performance.PerformanceService.SERVER_COMMAND_CANCEL, _airtowerCancelDelegate);
        _airtower.removeListener(com.clubpenguin.world.rooms2014.muppets.performance.PerformanceService.SERVER_COMMAND_CLOSE, _airtowerCloseDelegate);
        _airtower.removeListener(com.clubpenguin.world.rooms2014.muppets.performance.PerformanceService.SERVER_COMMAND_LIST, _airtowerListDelegate);
    } // End of the function
    function destroy()
    {
        performanceUpdated.removeAll();
        performanceRemoved.removeAll();
        this.removeAirtowerListeners();
    } // End of the function
    function sendOpenPerformance()
    {
        this.logCommand("Send: open");
        _airtower.send(_airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.muppets.performance.PerformanceService.SERVER_HANDLER + "#" + com.clubpenguin.world.rooms2014.muppets.performance.PerformanceService.SERVER_COMMAND_OPEN, [0], "str", _shell.getCurrentServerRoomId());
    } // End of the function
    function sendCancelPerformance()
    {
        this.logCommand("Send: cancel");
        _airtower.send(_airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.muppets.performance.PerformanceService.SERVER_HANDLER + "#" + com.clubpenguin.world.rooms2014.muppets.performance.PerformanceService.SERVER_COMMAND_CANCEL, [0], "str", _shell.getCurrentServerRoomId());
    } // End of the function
    function sendClosePerformance()
    {
        this.logCommand("Send: close");
        _airtower.send(_airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.muppets.performance.PerformanceService.SERVER_HANDLER + "#" + com.clubpenguin.world.rooms2014.muppets.performance.PerformanceService.SERVER_COMMAND_CLOSE, [0], "str", _shell.getCurrentServerRoomId());
    } // End of the function
    function sendJoinPerformance(hostId)
    {
        this.logCommand("Send: join", hostId);
        _airtower.send(_airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.muppets.performance.PerformanceService.SERVER_HANDLER + "#" + com.clubpenguin.world.rooms2014.muppets.performance.PerformanceService.SERVER_COMMAND_JOIN, [hostId], "str", _shell.getCurrentServerRoomId());
    } // End of the function
    function onReceiveOpenCommand(data)
    {
        this.logCommand("Updating a performance", data);
        var _loc2 = Number(data[1]);
        var _loc3 = {hostId: _loc2, participant: null, open: true};
        performanceUpdated.dispatch([com.clubpenguin.world.rooms2014.muppets.performance.PerformanceVO.fromObject(_loc3)]);
    } // End of the function
    function onReceiveCancelCommand(data)
    {
        this.logCommand("Canceling a performance", data);
        var _loc2 = Number(data[1]);
        var _loc3 = {hostId: _loc2, participant: null, open: false};
        performanceRemoved.dispatch(com.clubpenguin.world.rooms2014.muppets.performance.PerformanceVO.fromObject(_loc3));
    } // End of the function
    function onReceiveJoinCommand(data)
    {
        this.logCommand("Updating a performance", data);
        var _loc2 = Number(data[1]);
        var _loc5 = Number(data[2]);
        var _loc3 = {hostId: _loc2, participant: _loc5, open: false};
        performanceUpdated.dispatch([com.clubpenguin.world.rooms2014.muppets.performance.PerformanceVO.fromObject(_loc3)]);
    } // End of the function
    function onReceiveCloseCommand(data)
    {
        this.logCommand("Closing a performance", data);
        var _loc2 = Number(data[1]);
        var _loc5 = Number(data[2]);
        var _loc3 = {hostId: _loc2, participant: _loc5, open: false};
        performanceRemoved.dispatch(com.clubpenguin.world.rooms2014.muppets.performance.PerformanceVO.fromObject(_loc3));
    } // End of the function
    function onReceiveListCommand(data)
    {
        this.logCommand("Performance List", data);
        var _loc9 = data[1];
        var _loc4 = _loc9.split("|");
        var _loc8 = new Array();
        this.logCommand("Performance List performances ", _loc4);
        for (var _loc2 = 0; _loc2 < _loc4.length; ++_loc2)
        {
            if (_loc4[_loc2] == "")
            {
                continue;
            } // end if
            var _loc3 = {hostId: Number(_loc4[_loc2]), participant: null, open: true};
            this.logCommand("Performance List jsonObject ", _loc3);
            _loc8.push(com.clubpenguin.world.rooms2014.muppets.performance.PerformanceVO.fromObject(_loc3));
        } // end of for
        performanceUpdated.dispatch(_loc8);
    } // End of the function
    function logCommand(msg, data)
    {
        var _loc1 = com.clubpenguin.util.JSONParser.stringify(data);
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty.logPerformanceMessage("[PerformanceService] " + msg + " : DATA=" + _loc1);
        com.clubpenguin.util.Log.info("[PerformanceService] " + msg + " : DATA=" + _loc1, com.clubpenguin.util.Log.PARTY);
    } // End of the function
    static var SERVER_HANDLER = "muppets";
    static var SERVER_COMMAND_ERROR = "error";
    static var SERVER_COMMAND_LIST = "mperformancelist";
    static var SERVER_COMMAND_JOIN = "mperformancejoin";
    static var SERVER_COMMAND_OPEN = "mperformanceopen";
    static var SERVER_COMMAND_CANCEL = "mperformancecancel";
    static var SERVER_COMMAND_CLOSE = "mperformanceclose";
} // End of Class
