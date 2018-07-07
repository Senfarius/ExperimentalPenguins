class com.clubpenguin.world.rooms2014.muppets.performance.PerformanceAnimation
{
    var _shell, _interface, _engine, _party;
    function PerformanceAnimation(swfName, hostId, participantId, callback)
    {
        com.clubpenguin.util.Log.info("PerformanceAnimation " + swfName);
        _shell = _global.getCurrentShell();
        _interface = _global.getCurrentInterface();
        _engine = _global.getCurrentEngine();
        _party = _global.getCurrentParty();
        var _loc7 = _engine.getPlayerMovieClip(hostId);
        var _loc10 = _loc7.getNextHighestDepth();
        var _loc6 = _engine.getRoomMovieClip();
        var _loc4 = _loc6["performance_" + hostId] == undefined ? (_loc6.createEmptyMovieClip("performance_" + hostId, _loc10)) : (_loc6["performance_" + hostId]);
        _engine.updateItemDepth(_loc4, _loc7.getDepth());
        if (_loc4["performance_" + hostId + "_" + swfName] == undefined)
        {
            var _loc8 = _loc4.createEmptyMovieClip("performance_" + hostId + "_" + swfName, _loc4.getNextHighestDepth());
            var _loc11 = _shell.getGlobalContentPath() + com.clubpenguin.world.rooms2014.muppets.performance.PerformanceAnimation.PERFORMANCE_ASSETS_PATH + swfName + ".swf";
            var _loc9 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            _loc9.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, handleExternalAssetLoaded, _loc8, hostId, participantId, callback));
            _loc9.loadClip(_loc11, _loc8, "AvatarManager loadAnimations() " + swfName);
        }
        else
        {
            com.clubpenguin.util.Log.info("PerformanceAnimation showing existing anim");
            _loc4["performance_" + hostId + "_" + swfName]._visible = true;
            this.handleExternalAssetLoaded(undefined, _loc4["performance_" + hostId + "_" + swfName], hostId, participantId, callback);
        } // end else if
    } // End of the function
    function handleExternalAssetLoaded(event, performanceMC, hostId, participantId, callback)
    {
        com.clubpenguin.util.Log.info("PerformanceAnimation loaded");
        performanceMC.gotoAndStop(1);
        performanceMC.host.gotoAndStop(1);
        performanceMC.participant.gotoAndStop(1);
        var _loc3 = _engine.getPlayerMovieClip(hostId);
        performanceMC._x = _loc3._x;
        performanceMC._y = _loc3._y;
        com.clubpenguin.util.Log.info("PerformanceAnimation playerMC scale " + _loc3._xscale);
        performanceMC._xscale = performanceMC._yscale = _loc3._xscale;
        var _loc4 = Number(_shell.getPlayerHexFromId(_shell.getPlayerObjectById(hostId).colour_id));
        _shell.setColourFromHex(performanceMC.host, Number(_loc4));
        _loc4 = Number(_shell.getPlayerHexFromId(_shell.getPlayerObjectById(participantId).colour_id));
        _shell.setColourFromHex(performanceMC.participant, Number(_loc4));
        var _loc6 = new com.clubpenguin.world.rooms2013.common.CallbackAnimation(performanceMC, com.clubpenguin.util.Delegate.create(this, onAnimationComplete, performanceMC, hostId, callback));
        performanceMC.host.gotoAndPlay(1);
        performanceMC.participant.gotoAndPlay(1);
    } // End of the function
    function onAnimationComplete(performanceMC, hostId, callback)
    {
        com.clubpenguin.util.Log.info("PerformanceAnimation onAnimationComplete callback " + callback);
        callback();
    } // End of the function
    function clean(hostId)
    {
        com.clubpenguin.util.Log.info("PerformanceAnimation Clean " + hostId);
        var _loc4 = _engine.getRoomMovieClip();
        var _loc5 = _shell.getPlayerObjectById(hostId);
        var _loc3 = _party.MuppetsParty.getMuppetByInteractiveItem(_loc5.hand);
        _loc4["performance_" + hostId]["performance_" + hostId + "_muppets_" + _loc3]._visible = false;
    } // End of the function
    static var PERFORMANCE_ASSETS_PATH = "avatar/sprites/";
} // End of Class
