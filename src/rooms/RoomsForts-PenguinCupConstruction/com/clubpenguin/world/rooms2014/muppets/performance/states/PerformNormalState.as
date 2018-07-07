class com.clubpenguin.world.rooms2014.muppets.performance.states.PerformNormalState extends com.clubpenguin.world.rooms2014.muppets.performance.states.BasePerformanceState
{
    var _active, _shell, _interface, _engine, _party, _performance, _controller, performanceCallbackDelegate, performanceAnimation;
    function PerformNormalState(manager, controller, performance)
    {
        super("PerformNormalState", manager, controller, performance);
        _active = false;
        _shell = _global.getCurrentShell();
        _interface = _global.getCurrentInterface();
        _engine = _global.getCurrentEngine();
        _party = _global.getCurrentParty();
    } // End of the function
    function onEnterState()
    {
        _active = true;
        var _loc7 = _engine.getPlayerMovieClip(_performance.hostId);
        var _loc8 = _engine.getNicknameMovieClip(_performance.hostId);
        var _loc2 = _shell.getPlayerObjectById(_performance.hostId);
        if (_loc2 != undefined)
        {
            _engine.avatarManager.effectManager.playEffectForPlayer(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE, _loc2);
        } // end if
        var _loc6 = _engine.getPlayerMovieClip(_performance.participant);
        var _loc5 = _engine.getNicknameMovieClip(_performance.participant);
        var _loc4 = _shell.getPlayerObjectById(_performance.participant);
        if (_loc4 != undefined)
        {
            _engine.avatarManager.effectManager.playEffectForPlayer(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE, _loc4);
        } // end if
        _loc7._visible = false;
        _loc6._visible = false;
        _loc8._visible = false;
        _loc5._visible = false;
        if (_controller.__get__isLocalPlayerPerformance())
        {
            _engine.disableMouseMovement();
            com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.playPoofIn();
            _party.MuppetsParty.logMuppetDanceJoinEvent(_performance.hostId);
        } // end if
        var _loc3 = "muppets_" + _party.MuppetsParty.getMuppetByInteractiveItem(_loc2.hand);
        performanceCallbackDelegate = com.clubpenguin.util.Delegate.create(this, onExitState);
        if (_loc3 != undefined)
        {
            performanceAnimation = new com.clubpenguin.world.rooms2014.muppets.performance.PerformanceAnimation(_loc3, _performance.hostId, _performance.participant, performanceCallbackDelegate);
            if (_controller.__get__isLocalPlayerPerformance())
            {
                com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.playMuppetAnimationSoundByItem(_loc2.hand);
            } // end if
        } // end if
    } // End of the function
    function onExitState()
    {
        com.clubpenguin.util.Log.info("----------- PerformNormalState onExitState" + _shell.getMyPlayerId() + "---------------");
        _active = false;
        performanceAnimation.clean(_performance.hostId);
        var _loc3 = _engine.getPlayerMovieClip(_performance.hostId);
        var _loc8 = _engine.getNicknameMovieClip(_performance.hostId);
        var _loc5 = _shell.getPlayerObjectById(_performance.hostId);
        if (_loc3._visible == false)
        {
            if (_loc5 != undefined)
            {
                _engine.avatarManager.effectManager.playEffectForPlayer(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE, _loc5);
            } // end if
            var _loc7 = _engine.getPlayerMovieClip(_performance.participant);
            var _loc6 = _engine.getNicknameMovieClip(_performance.participant);
            var _loc4 = _performance.participant;
            if (_loc4 != undefined)
            {
                _engine.avatarManager.effectManager.playEffectForPlayer(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE, _shell.getPlayerObjectById(_loc4));
            } // end if
        } // end if
        _loc3._visible = true;
        _loc7._visible = true;
        _loc8._visible = true;
        _loc6._visible = true;
        if (_controller.__get__isLocalPlayerPerformance())
        {
            com.clubpenguin.util.Log.info("PerformNormalState This is a local player performance " + _shell.getMyPlayerId());
            _engine.enableMouseMovement();
            _party.MuppetsParty.checkForFirstTimePerformance(_performance.hostId);
            com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.playPoofOut();
        } // end if
        _global.getCurrentRoom().performanceManager.onPerformanceRemoved(_performance);
    } // End of the function
} // End of Class
