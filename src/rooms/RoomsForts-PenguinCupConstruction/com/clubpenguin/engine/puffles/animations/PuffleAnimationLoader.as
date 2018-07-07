class com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader extends mx.events.EventDispatcher
{
    var _SHELL, _ENGINE, _playerMC, _puffleMC, _playerID, _puffleID, _usesEvent, dispatchEvent;
    function PuffleAnimationLoader(playerID, puffleID, shell_mc, engine_mc, usesEvent)
    {
        super();
        _SHELL = shell_mc;
        _ENGINE = engine_mc;
        _playerMC = _ENGINE.getPlayerMovieClip(playerID);
        _puffleMC = _ENGINE.puffleManager.getPuffleByID(puffleID).clip;
        _playerID = playerID;
        _puffleID = puffleID;
        _usesEvent = usesEvent;
    } // End of the function
    function playPuffleAnimation(animationURL, overPuffle)
    {
        _SHELL.addListener(_SHELL.ROOM_DESTROYED, cleanup, this);
        var _loc4 = _ENGINE.puffleAvatarController.getPuffleClip(_puffleID);
        var _loc2 = _ENGINE.getRoomMovieClip().createEmptyMovieClip("puffleAnimationClip" + _puffleID, _loc4.getDepth() + 1);
        _loc2._x = _playerMC._x;
        _loc2._y = _playerMC._y;
        _loc2._xscale = _playerMC._xscale;
        _loc2._yscale = _playerMC._yscale;
        _loc2._visible = false;
        if (overPuffle && _puffleMC)
        {
            _loc2._x = _puffleMC._x;
            _loc2._y = _puffleMC._y;
        } // end if
        var _loc3 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        _loc3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onAnimationLoaded, _loc2));
        _loc3.loadClip(animationURL, _loc2, "PuffleAnimationLoader playPuffleAnimation()");
    } // End of the function
    function onAnimationLoaded(event, puffleAnimationClip)
    {
        com.clubpenguin.util.Log.debug("PuffleAnimationLoader onAnimationLoaded()");
        _ENGINE.puffleAvatarController.hidePuffle(_puffleID);
        puffleAnimationClip._visible = true;
        var scope = this;
        puffleAnimationClip.onEnterFrame = function ()
        {
            if (puffleAnimationClip.puffle._currentframe >= puffleAnimationClip.puffle._totalframes)
            {
                scope.onAnimationFinished(puffleAnimationClip);
            } // end if
        };
    } // End of the function
    function onAnimationFinished(puffleAnimationClip)
    {
        if (_usesEvent)
        {
            this.dispatchEvent({target: this, type: com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_EVENT, playerID: _playerID, puffleID: _puffleID});
        } // end if
        puffleAnimationClip.onEnterFrame = null;
        puffleAnimationClip.removeMovieClip();
        this.cleanup();
    } // End of the function
    function cleanup()
    {
        com.clubpenguin.util.Log.debug("PuffleAnimationLoader cleanup()");
        _ENGINE.puffleAvatarController.showPuffle(_puffleID);
        _SHELL.removeListener(_SHELL.ROOM_DESTROYED, onAnimationFinished);
    } // End of the function
    static var PUFFLE_ANIMATION_EVENT = "puffleAnimation";
} // End of Class
