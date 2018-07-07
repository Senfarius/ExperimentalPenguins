class com.clubpenguin.world.rooms2014.muppets.MuppetsParty_EngineOverrides
{
    var _shell, _airtower, _interface, _engine, _party, defaultUpdatePlayerFrame, defaultSendPlayerFrame;
    function MuppetsParty_EngineOverrides()
    {
    } // End of the function
    function init()
    {
        _shell = _global.getCurrentShell();
        _airtower = _global.getCurrentAirtower();
        _interface = _global.getCurrentInterface();
        _engine = _global.getCurrentEngine();
        _party = _global.getCurrentParty();
        defaultUpdatePlayerFrame = _engine.updatePlayerFrame;
        defaultSendPlayerFrame = _engine.sendPlayerFrame;
    } // End of the function
    function sendPlayerFrame(frame)
    {
        var _loc3 = this;
        var _loc5 = _loc3.SHELL.getMyPlayerId();
        if (_loc3.validateUpdateFrame(_loc5, frame))
        {
            if (frame == _loc3.SHELL.DANCE_FRAME)
            {
                var _loc4 = _global.getCurrentRoom().performanceManager;
                var _loc7 = _loc3.SHELL.getMyPlayerId();
                if (_loc4.isPlayerAHost(_loc7))
                {
                    var _loc8 = _loc4.getPlayerPerformance(_loc7);
                    if (_loc8 == null)
                    {
                        _loc4.__get__service().sendOpenPerformance();
                        return;
                    }
                    else if (_loc8.state == com.clubpenguin.world.rooms2014.muppets.performance.states.PerformanceStateEnum.BOARDING)
                    {
                        _loc4.__get__service().sendCancelPerformance();
                    } // end if
                } // end if
            } // end else if
            _loc3.updatePlayerFrame(_loc5, frame);
            _loc3.setPlayerAction("custom");
            _loc3.SHELL.sendPlayerFrame(frame);
        } // end if
    } // End of the function
    static var CLASS_NAME = "MuppetsParty_EngineOverrides";
} // End of Class
