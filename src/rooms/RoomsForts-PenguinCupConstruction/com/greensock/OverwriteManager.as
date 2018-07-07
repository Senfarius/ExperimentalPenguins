class com.greensock.OverwriteManager
{
    static var mode, enabled;
    function OverwriteManager()
    {
    } // End of the function
    static function init(defaultMode)
    {
        if (com.greensock.TweenLite.version < 11.600000)
        {
            trace ("Warning: Your TweenLite class needs to be updated to work with OverwriteManager (or you may need to clear your ASO files). Please download and install the latest version from http://www.tweenlite.com.");
        } // end if
        com.greensock.TweenLite.overwriteManager = com.greensock.OverwriteManager;
        mode = defaultMode == undefined ? (2) : (defaultMode);
        enabled = true;
        return (com.greensock.OverwriteManager.mode);
    } // End of the function
    static function manageOverwrites(tween, props, targetTweens, mode)
    {
        var _loc3;
        var _loc10;
        var _loc1;
        if (mode >= 4)
        {
            var _loc17 = targetTweens.length;
            for (var _loc3 = 0; _loc3 < _loc17; ++_loc3)
            {
                _loc1 = targetTweens[_loc3];
                if (_loc1 != tween)
                {
                    if (_loc1.setEnabled(false, false))
                    {
                        _loc10 = true;
                    } // end if
                    continue;
                } // end if
                if (mode == 5)
                {
                    break;
                } // end if
            } // end of for
            return (_loc10);
        } // end if
        var _loc5 = tween.cachedStartTime + 0.000000;
        var _loc9 = [];
        var _loc13 = [];
        var _loc15 = 0;
        var _loc12 = 0;
        _loc3 = targetTweens.length;
        while (--_loc3 > -1)
        {
            _loc1 = targetTweens[_loc3];
            if (_loc1 == tween || _loc1.gc || !_loc1.initted && _loc5 - _loc1.cachedStartTime <= 0.000000)
            {
                continue;
            } // end if
            if (_loc1.timeline != tween.timeline)
            {
                if (!com.greensock.OverwriteManager.getGlobalPaused(_loc1))
                {
                    _loc13[_loc15++] = _loc1;
                } // end if
                continue;
            } // end if
            if (_loc1.cachedStartTime <= _loc5 && _loc1.cachedStartTime + _loc1.__get__totalDuration() + 0.000000 > _loc5 && !_loc1.cachedPaused && !(tween.cachedDuration == 0 && _loc5 - _loc1.cachedStartTime <= 0.000000))
            {
                _loc9[_loc12++] = _loc1;
            } // end if
        } // end while
        if (_loc15 != 0)
        {
            var _loc6 = tween.cachedTimeScale;
            var _loc7 = _loc5;
            var _loc4;
            var _loc11;
            var _loc2;
            for (var _loc2 = tween.timeline; _loc2; _loc2 = _loc2.timeline)
            {
                _loc6 = _loc6 * _loc2.cachedTimeScale;
                _loc7 = _loc7 + _loc2.cachedStartTime;
            } // end of for
            _loc5 = _loc6 * _loc7;
            _loc3 = _loc15;
            while (--_loc3 > -1)
            {
                _loc4 = _loc13[_loc3];
                _loc6 = _loc4.cachedTimeScale;
                _loc7 = _loc4.cachedStartTime;
                for (var _loc2 = _loc4.timeline; _loc2; _loc2 = _loc2.timeline)
                {
                    _loc6 = _loc6 * _loc2.cachedTimeScale;
                    _loc7 = _loc7 + _loc2.cachedStartTime;
                } // end of for
                _loc11 = _loc6 * _loc7;
                if (_loc11 <= _loc5 && (_loc11 + _loc4.__get__totalDuration() * _loc6 + 0.000000 > _loc5 || _loc4.cachedDuration == 0))
                {
                    _loc9[_loc12++] = _loc4;
                } // end if
            } // end while
        } // end if
        if (_loc12 == 0)
        {
            return (_loc10);
        } // end if
        _loc3 = _loc12;
        if (mode == 2)
        {
            while (--_loc3 > -1)
            {
                _loc1 = _loc9[_loc3];
                if (_loc1.killVars(props))
                {
                    _loc10 = true;
                } // end if
                if (_loc1.cachedPT1 == undefined && _loc1.initted)
                {
                    _loc1.setEnabled(false, false);
                } // end if
            } // end while
        }
        else
        {
            while (--_loc3 > -1)
            {
                if (_loc9[_loc3].setEnabled(false, false))
                {
                    _loc10 = true;
                } // end if
            } // end while
        } // end else if
        return (_loc10);
    } // End of the function
    static function getGlobalPaused(tween)
    {
        while (tween)
        {
            if (tween.cachedPaused)
            {
                return (true);
            } // end if
            tween = tween.timeline;
        } // end while
        return (false);
    } // End of the function
    static var version = 6.100000;
    static var NONE = 0;
    static var ALL_IMMEDIATE = 1;
    static var AUTO = 2;
    static var CONCURRENT = 3;
    static var ALL_ONSTART = 4;
    static var PREEXISTING = 5;
} // End of Class
