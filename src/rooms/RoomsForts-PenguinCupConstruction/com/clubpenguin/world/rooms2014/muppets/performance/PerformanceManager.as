class com.clubpenguin.world.rooms2014.muppets.performance.PerformanceManager
{
    var _service, _performances, _performanceControllers, _performanceUnloadedPlayers, _playerLoadedDelegates, _participantsAddedHelper, _participantsRemovedHelper, _updateClip, _shell, _interface, _engine, _tracker, __get__service;
    function PerformanceManager()
    {
        _service = new com.clubpenguin.world.rooms2014.muppets.performance.PerformanceService();
        _service.performanceUpdated.add(onPerformancesUpdated, this);
        _service.performanceRemoved.add(onPerformanceRemoved, this);
        _performances = new Object();
        _performanceControllers = new Object();
        _performanceUnloadedPlayers = new Object();
        _playerLoadedDelegates = new Object();
        _participantsAddedHelper = new Array();
        _participantsRemovedHelper = new Array();
        var _loc3 = com.clubpenguin.world.rooms.BaseRoom.__get__current().getStage();
        _updateClip = _loc3._parent.createEmptyMovieClip("_updateClip", _loc3.getNextHighestDepth());
        _updateClip.onEnterFrame = com.clubpenguin.util.Delegate.create(this, onEnterFrame);
        _shell = _global.getCurrentShell();
        _interface = _global.getCurrentInterface();
        _engine = _global.getCurrentEngine();
        _tracker = com.clubpenguin.util.TrackerAS2.getInstance();
    } // End of the function
    function destroy()
    {
        _service.destroy();
        _updateClip.onEnterFrame = null;
        _updateClip.removeMovieClip();
        for (var _loc2 in _performanceControllers)
        {
            _performanceControllers[_loc2].destroy();
        } // end of for...in
        for (var _loc2 in _playerLoadedDelegates)
        {
            _engine.penguinTransformComplete.remove(_playerLoadedDelegates[_loc2], this);
            delete _playerLoadedDelegates[_loc2];
        } // end of for...in
    } // End of the function
    function get service()
    {
        return (_service);
    } // End of the function
    function onEnterFrame()
    {
        for (var _loc2 in _performanceControllers)
        {
            _performanceControllers[_loc2].onUpdate();
        } // end of for...in
    } // End of the function
    function onPerformancesUpdated(performances)
    {
        com.clubpenguin.util.Log.info("[PerformanceManager] onPerformancesUpdated: " + performances);
        for (var _loc4 = 0; _loc4 < performances.length; ++_loc4)
        {
            var _loc2 = performances[_loc4];
            var _loc3 = _performances[_loc2.hostId];
            if (_loc3 == null)
            {
                com.clubpenguin.util.Log.info("[PerformanceManager] assembleNewPerformance: " + _loc2);
                this.assembleNewPerformance(_loc2);
                continue;
            } // end if
            com.clubpenguin.util.Log.info("[PerformanceManager] existing peformance: " + _loc2);
            var _loc5 = _performanceControllers[_loc2.hostId];
            _loc3.participant = performances[_loc4].participant;
            if (_loc3.state != _loc2.state)
            {
                _loc3.state = _loc2.state;
                if (_loc2.state == com.clubpenguin.world.rooms2014.muppets.performance.states.PerformanceStateEnum.PERFORMING)
                {
                    _loc5.onClosed();
                    continue;
                } // end if
                if (_loc2.state == com.clubpenguin.world.rooms2014.muppets.performance.states.PerformanceStateEnum.BOARDING)
                {
                    _loc5.onOpened();
                } // end if
            } // end if
        } // end of for
    } // End of the function
    function assembleNewPerformance(performance)
    {
        com.clubpenguin.util.Log.info("[PerformanceManager] initPerformance: " + performance);
        this.initPerformance(performance);
    } // End of the function
    function onPlayerLoaded(player, performance, unloadedPlayers)
    {
        for (var _loc2 = 0; _loc2 < unloadedPlayers.length; ++_loc2)
        {
            if (unloadedPlayers[_loc2] == player.player_id)
            {
                unloadedPlayers.splice(_loc2, 1);
                break;
            } // end if
        } // end of for
        if (unloadedPlayers.length == 0)
        {
            _engine.penguinTransformComplete.remove(_playerLoadedDelegates[performance.hostId], this);
            delete _performanceUnloadedPlayers[performance.hostId];
            delete _playerLoadedDelegates[performance.hostId];
            this.initPerformance(performance);
        } // end if
    } // End of the function
    function initPerformance(performance)
    {
        com.clubpenguin.util.Log.info("[PerformanceManager] initPerformance: " + performance);
        _performances[performance.hostId] = performance;
        _performanceControllers[performance.hostId] = new com.clubpenguin.world.rooms2014.muppets.performance.PerformanceController(performance, _service);
    } // End of the function
    function getUnloadedPlayers(performance)
    {
        var _loc2 = new Array();
        var _loc3 = performance.participant;
        var _loc4 = _engine.getPlayerMovieClip(_loc3);
        if (!_loc4.is_ready)
        {
            _loc2.push(_loc3);
        } // end if
        var _loc6 = _engine.getPlayerMovieClip(performance.hostId);
        if (!_loc6.is_ready)
        {
            _loc2.push(performance.hostId);
        } // end if
        return (_loc2);
    } // End of the function
    function onPerformanceRemoved(performance)
    {
        var _loc4 = _performances[performance.hostId];
        if (_loc4 != null)
        {
            if (performance.hostId == _shell.getMyPlayerId())
            {
            } // end if
            var _loc3 = _performanceControllers[performance.hostId];
            _loc3.onPerformanceRemoved();
            _loc3.destroy();
            delete _performanceControllers[performance.hostId];
            delete _performances[performance.hostId];
        } // end if
    } // End of the function
    function isPlayerAHost(playerId)
    {
        return (_performances[playerId] != null || com.clubpenguin.world.rooms2014.muppets.MuppetsParty.isWearingInteractiveItem(playerId) && this.getPlayerPerformance() == null);
    } // End of the function
    function getPlayerPerformance(playerId)
    {
        if (_performances[playerId] != null)
        {
            return (_performances[playerId]);
        } // end if
        for (var _loc4 in _performances)
        {
            var _loc2 = _performances[_loc4];
            if (_loc2.containsParticipant(playerId))
            {
                return (_loc2);
            } // end if
        } // end of for...in
        return (null);
    } // End of the function
} // End of Class
