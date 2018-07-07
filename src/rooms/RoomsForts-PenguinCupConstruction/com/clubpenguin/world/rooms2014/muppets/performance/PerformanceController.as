class com.clubpenguin.world.rooms2014.muppets.performance.PerformanceController
{
    var _shell, _interface, _engine, participantAdded, participantRemoved, _performance, _service, _stateManager, _isLocalPlayerPerformance, _playerMoveDelegate, __get__isLocalPlayerPerformance, __get__performance;
    function PerformanceController(performance, service)
    {
        _shell = _global.getCurrentShell();
        _interface = _global.getCurrentInterface();
        _engine = _global.getCurrentEngine();
        participantAdded = new org.osflash.signals.Signal(Array);
        participantRemoved = new org.osflash.signals.Signal(Array);
        _performance = performance;
        _service = service;
        this.initPerformance();
    } // End of the function
    function get performance()
    {
        return (_performance);
    } // End of the function
    function initPerformance()
    {
        com.clubpenguin.util.Log.info("[PerformanceController] initPerformance ");
        _stateManager = new com.clubpenguin.util.state.StateManager();
        this.checkIsLocalPlayerPerformance();
        if (_performance.state == com.clubpenguin.world.rooms2014.muppets.performance.states.PerformanceStateEnum.PERFORMING)
        {
            com.clubpenguin.util.Log.info("[PerformanceController] initPerformance PerformanceStateEnum.PERFORMING");
            _stateManager.changeState(this.createPerformingState());
        }
        else
        {
            com.clubpenguin.util.Log.info("[PerformanceController] initPerformance PerformanceStateEnum.BOARDING");
            _stateManager.changeState(new com.clubpenguin.world.rooms2014.muppets.performance.states.BoardingState(_stateManager, this, _performance));
        } // end else if
        if (_isLocalPlayerPerformance && _performance.hostId != _shell.getMyPlayerId())
        {
            _engine.disableMouseMovement();
        } // end if
        if (_shell.getMyPlayerId() != _performance.hostId)
        {
            var _loc3 = _engine.getPlayerMovieClip(_performance.hostId);
            if (_loc3._x == 0 && _loc3._y == 0)
            {
                var _loc2 = _engine.getPlayerMovieClip(_shell.getMyPlayerId());
                this.updatePlayerPosition(_performance.hostId, _loc2._x, _loc2._y);
            } // end if
        } // end if
        _playerMoveDelegate = com.clubpenguin.util.Delegate.create(this, onPlayerMove);
        if (!_shell.isMyPlayer(_performance.hostId))
        {
            _shell.addListener(_shell.PLAYER_MOVE, _playerMoveDelegate);
        }
        else
        {
            _shell.addListener(_shell.LOCAL_PLAYER_MOVE, _playerMoveDelegate);
        } // end else if
    } // End of the function
    function destroy()
    {
        _stateManager.changeState(null);
        if (!_shell.isMyPlayer(_performance.hostId))
        {
            _shell.removeListener(_shell.PLAYER_MOVE, _playerMoveDelegate);
        }
        else
        {
            _shell.removeListener(_shell.LOCAL_PLAYER_MOVE, _playerMoveDelegate);
        } // end else if
        if (_isLocalPlayerPerformance)
        {
            _engine.enableMouseMovement();
        } // end if
    } // End of the function
    function onUpdate()
    {
    } // End of the function
    function get isLocalPlayerPerformance()
    {
        return (_isLocalPlayerPerformance);
    } // End of the function
    function onOpened()
    {
        _stateManager.changeState(new com.clubpenguin.world.rooms2014.muppets.performance.states.BoardingState(_stateManager, this, _performance));
    } // End of the function
    function onClosed()
    {
        com.clubpenguin.util.Log.info("[PerformanceController] onClosed");
        _stateManager.changeState(this.createPerformingState());
    } // End of the function
    function onPerformanceRemoved()
    {
        com.clubpenguin.util.Log.info("[PerformanceController] onPerformanceRemoved");
    } // End of the function
    function createPerformingState()
    {
        com.clubpenguin.util.Log.info("[PerformanceController] createPerformingState " + _shell.getMyPlayerId());
        var _loc2;
        _loc2 = new com.clubpenguin.world.rooms2014.muppets.performance.states.PerformNormalState(_stateManager, this, _performance);
        this.checkIsLocalPlayerPerformance();
        return (_loc2);
    } // End of the function
    function updatePlayerPosition(playerId, x, y)
    {
        _engine.updatePlayerPosition(playerId, x, y);
    } // End of the function
    function updatePlayerFrame(playerId, frame)
    {
        _engine.updatePlayerFrame(playerId, frame);
    } // End of the function
    function onPlayerMove(event)
    {
    } // End of the function
    function checkIsLocalPlayerPerformance()
    {
        _isLocalPlayerPerformance = _performance.containsPlayer(_shell.getMyPlayerId());
    } // End of the function
    function requestJoinPerformance()
    {
        var _loc3 = _global.getCurrentRoom().performanceManager;
        if (_loc3.getPlayerPerformance(_shell.getMyPlayerId()) == null)
        {
            _service.sendJoinPerformance(_performance.hostId);
        } // end if
    } // End of the function
} // End of Class
