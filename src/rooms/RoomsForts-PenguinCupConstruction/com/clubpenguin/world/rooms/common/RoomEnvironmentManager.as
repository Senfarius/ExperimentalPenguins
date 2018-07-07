class com.clubpenguin.world.rooms.common.RoomEnvironmentManager
{
    var _stageReference, _SHELL, _ENGINE, _roomBehaviorFactory, _playerMoveDoneFunc, _environmentMovieClips;
    function RoomEnvironmentManager(stageReference, shellMC, engineMC)
    {
        _stageReference = stageReference;
        _SHELL = shellMC;
        _ENGINE = engineMC;
        _roomBehaviorFactory = com.clubpenguin.world.rooms.common.behaviors.RoomBehaviorFactory.getInstance();
        _playerMoveDoneFunc = com.clubpenguin.util.Delegate.create(this, onPlayerMoveDone);
        _SHELL.addListener(_SHELL.PLAYER_MOVE_DONE, _playerMoveDoneFunc);
    } // End of the function
    function destroy()
    {
        _SHELL.removeListener(_SHELL.PLAYER_MOVE_DONE, _playerMoveDoneFunc);
    } // End of the function
    function setupEnvironmentTriggers()
    {
        _environmentMovieClips = new Array();
        this.searchForEnvironmentMovieClips();
    } // End of the function
    function searchForEnvironmentMovieClips()
    {
        for (var _loc2 in _stageReference)
        {
            if (_stageReference[_loc2].environmentType)
            {
                _environmentMovieClips.push(_stageReference[_loc2]);
            } // end if
        } // end of for...in
    } // End of the function
    function checkTriggers(player_obj)
    {
        for (var _loc2 = 0; _loc2 < _environmentMovieClips.length; ++_loc2)
        {
            var _loc3 = _ENGINE.puffleAvatarController.getPuffleClip(player_obj.attachedPuffle.id);
            if (_loc3 && _environmentMovieClips[_loc2].hitTest(_loc3._x, _loc3._y, true))
            {
                var _loc4 = _roomBehaviorFactory.getRoomBehavior(_environmentMovieClips[_loc2].environmentType);
                _loc4.applyEffect(player_obj.player_id);
            } // end if
        } // end of for
    } // End of the function
    function onPlayerMoveDone(player_obj)
    {
        if (player_obj.attachedPuffle)
        {
            this.checkTriggers(player_obj);
        } // end if
    } // End of the function
    function checkHitTestWithEnvironmentMC(targetMC)
    {
        for (var _loc2 = 0; _loc2 < _environmentMovieClips.length; ++_loc2)
        {
            if (_environmentMovieClips[_loc2].hitTest(targetMC._x, targetMC._y, true))
            {
                return (true);
            } // end if
        } // end of for
        return (false);
    } // End of the function
} // End of Class
