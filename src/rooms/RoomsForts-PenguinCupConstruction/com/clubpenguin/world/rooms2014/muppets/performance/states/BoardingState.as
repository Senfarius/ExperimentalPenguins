class com.clubpenguin.world.rooms2014.muppets.performance.states.BoardingState extends com.clubpenguin.world.rooms2014.muppets.performance.states.BasePerformanceState
{
    var _active, _shell, _interface, _engine, _joinButton, _performance, _controller, _playerMoveDelegate;
    function BoardingState(manager, controller, performance)
    {
        super("BoardingState", manager, controller, performance);
        _active = false;
        _shell = _global.getCurrentShell();
        _interface = _global.getCurrentInterface();
        _engine = _global.getCurrentEngine();
    } // End of the function
    function onEnterState()
    {
        com.clubpenguin.util.Log.info("[BoardingState] onEnterState");
        _active = true;
        this.showJoinButton();
    } // End of the function
    function onExitState()
    {
        _active = false;
        this.removeJoinButton();
    } // End of the function
    function onParticipantAdded(added)
    {
        for (var _loc2 = 0; _loc2 < added.length; ++_loc2)
        {
            if (_shell.isMyPlayer(added[_loc2]))
            {
                _engine.disableMouseMovement();
            } // end if
        } // end of for
    } // End of the function
    function onParticipantRemoved(removed)
    {
        for (var _loc2 = 0; _loc2 < removed.length; ++_loc2)
        {
            if (_shell.isMyPlayer(removed[_loc2]))
            {
                _engine.enableMouseMovement();
            } // end if
        } // end of for
    } // End of the function
    function showJoinButton()
    {
        com.clubpenguin.util.Log.info("[BoardingState] showJoinButton");
        _global.getCurrentParty().BaseParty.pebug("BoardingState - showJoinButton");
        if (_joinButton == null)
        {
            var _loc3 = _global.getCurrentParty().MuppetsParty.determineInteractiveItemIcon(_performance.hostId);
            com.clubpenguin.util.Log.info("[BoardingState] icon " + _loc3);
            _joinButton = _engine.avatarManager.effectManager.playEffectForPlayer(_loc3, _shell.getPlayerObjectById(_performance.hostId));
            _joinButton.btn.onRelease = com.clubpenguin.util.Delegate.create(this, onJoinButtonClicked);
            if (_controller.__get__isLocalPlayerPerformance())
            {
                _global.getCurrentParty().MuppetsParty.logMuppetDanceEvent(_performance.hostId);
            } // end if
        } // end if
    } // End of the function
    function removeJoinButton()
    {
        _joinButton.btn.onRelease = null;
        _joinButton.removeMovieClip();
        _joinButton = null;
    } // End of the function
    function onJoinButtonClicked()
    {
        if (!_controller.__get__isLocalPlayerPerformance())
        {
            var _loc2 = _engine.getPlayerMovieClip(_performance.hostId);
            var _loc3 = _engine.getPlayerMovieClip(_shell.getMyPlayerId());
            if (_loc3.hitTest(_loc2._x, _loc2._y, true))
            {
                _controller.requestJoinPerformance();
            }
            else
            {
                _engine.sendPlayerMove(_loc2._x, _loc2._y);
                _playerMoveDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerMoveDone);
                _shell.addListener(_shell.PLAYER_MOVE_DONE, _playerMoveDelegate);
            } // end if
        } // end else if
    } // End of the function
    function handlePlayerMoveDone()
    {
        com.clubpenguin.util.Log.info("[BoardingState] handlePlayerMoveDone");
        _shell.removeListener(_shell.PLAYER_MOVE_DONE, _playerMoveDelegate);
        var _loc2 = _engine.getPlayerMovieClip(_performance.hostId);
        var _loc3 = _engine.getPlayerMovieClip(_shell.getMyPlayerId());
        if (_loc3.hitTest(_loc2._x, _loc2._y, true))
        {
            _controller.requestJoinPerformance();
        } // end if
    } // End of the function
} // End of Class
