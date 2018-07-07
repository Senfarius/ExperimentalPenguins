class com.greensock.core.SimpleTimeline extends com.greensock.core.TweenCore
{
    var __get__rawTime, _lastChild, _firstChild, cachedTotalTime, cachedTime;
    function SimpleTimeline(vars)
    {
        super(0, vars);
    } // End of the function
    function insert(tween, time)
    {
        if (time == undefined)
        {
            time = 0;
        } // end if
        var _loc3 = tween.timeline;
        if (!tween.cachedOrphan && _loc3)
        {
            _loc3.remove(tween, true);
        } // end if
        tween.timeline = this;
        tween.cachedStartTime = Number(time) + tween.__get__delay();
        if (tween.gc)
        {
            tween.setEnabled(true, true);
        } // end if
        if (tween.cachedPaused && _loc3 != this)
        {
            tween.cachedPauseTime = tween.cachedStartTime + (this.__get__rawTime() - tween.cachedStartTime) / tween.cachedTimeScale;
        } // end if
        if (_lastChild)
        {
            _lastChild.nextNode = tween;
        }
        else
        {
            _firstChild = tween;
        } // end else if
        tween.prevNode = _lastChild;
        _lastChild = tween;
        tween.nextNode = undefined;
        tween.cachedOrphan = false;
        return (tween);
    } // End of the function
    function remove(tween, skipDisable)
    {
        if (tween.cachedOrphan)
        {
            return;
        }
        else if (skipDisable != true)
        {
            tween.setEnabled(false, true);
        } // end else if
        if (tween.nextNode)
        {
            tween.nextNode.prevNode = tween.prevNode;
        }
        else if (_lastChild == tween)
        {
            _lastChild = tween.prevNode;
        } // end else if
        if (tween.prevNode)
        {
            tween.prevNode.nextNode = tween.nextNode;
        }
        else if (_firstChild == tween)
        {
            _firstChild = tween.nextNode;
        } // end else if
        tween.cachedOrphan = true;
    } // End of the function
    function renderTime(time, suppressEvents, force)
    {
        var _loc2 = _firstChild;
        var _loc4;
        var _loc5;
        cachedTotalTime = time;
        cachedTime = time;
        while (_loc2)
        {
            _loc5 = _loc2.nextNode;
            if (_loc2.active || time >= _loc2.cachedStartTime && !_loc2.cachedPaused && !_loc2.gc)
            {
                if (!_loc2.cachedReversed)
                {
                    _loc2.renderTime((time - _loc2.cachedStartTime) * _loc2.cachedTimeScale, suppressEvents, false);
                }
                else
                {
                    _loc4 = _loc2.cacheIsDirty ? (_loc2.__get__totalDuration()) : (_loc2.cachedTotalDuration);
                    _loc2.renderTime(_loc4 - (time - _loc2.cachedStartTime) * _loc2.cachedTimeScale, suppressEvents, false);
                } // end if
            } // end else if
            _loc2 = _loc5;
        } // end while
    } // End of the function
    function get rawTime()
    {
        return (cachedTotalTime);
    } // End of the function
} // End of Class
