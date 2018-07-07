class com.greensock.core.TweenCore
{
    var vars, cachedTotalDuration, cachedDuration, _delay, cachedTimeScale, active, cachedTime, cachedTotalTime, data, cachedReversed, cachedPaused, cacheIsDirty, initted, gc, _rawPrevTime, __set__paused, __set__reversed, __get__totalDuration, timeline, cachedOrphan, cachedStartTime, cachedPauseTime, __get__delay, __get__duration, __set__duration, __get__currentTime, __get__totalTime, __get__startTime, __get__reversed, __get__paused, __set__currentTime, __set__delay, __set__startTime, __set__totalDuration, __set__totalTime;
    static var _classInitted;
    function TweenCore(duration, vars)
    {
        this.vars = vars || {};
        cachedDuration = cachedTotalDuration = duration || 0;
        _delay = Number(this.vars.delay) || 0;
        cachedTimeScale = this.vars.timeScale || 1;
        active = Boolean(duration == 0 && _delay == 0 && this.vars.immediateRender != false);
        cachedTotalTime = cachedTime = 0;
        data = this.vars.data;
        gc = initted = cacheIsDirty = cachedPaused = cachedReversed = false;
        _rawPrevTime = -1;
        if (!com.greensock.core.TweenCore._classInitted)
        {
            if (com.greensock.TweenLite.rootFrame == undefined && com.greensock.TweenLite.initClass != undefined)
            {
                com.greensock.TweenLite.initClass();
                _classInitted = true;
            }
            else
            {
                return;
            } // end if
        } // end else if
        var _loc2 = this.vars.timeline instanceof com.greensock.core.SimpleTimeline ? (this.vars.timeline) : (this.vars.useFrames == true ? (com.greensock.TweenLite.rootFramesTimeline) : (com.greensock.TweenLite.rootTimeline));
        _loc2.insert(this, _loc2.cachedTotalTime);
        if (this.vars.reversed)
        {
            cachedReversed = true;
        } // end if
        if (this.vars.paused)
        {
            this.__set__paused(true);
        } // end if
    } // End of the function
    function play()
    {
        this.__set__reversed(false);
        this.__set__paused(false);
    } // End of the function
    function pause()
    {
        this.__set__paused(true);
    } // End of the function
    function resume()
    {
        this.__set__paused(false);
    } // End of the function
    function restart(includeDelay, suppressEvents)
    {
        this.__set__reversed(false);
        this.__set__paused(false);
        this.setTotalTime(includeDelay ? (-_delay) : (0), Boolean(suppressEvents != false));
    } // End of the function
    function reverse(forceResume)
    {
        this.__set__reversed(true);
        if (forceResume != false)
        {
            this.__set__paused(false);
        }
        else if (gc)
        {
            this.setEnabled(true, false);
        } // end else if
    } // End of the function
    function renderTime(time, suppressEvents, force)
    {
    } // End of the function
    function complete(skipRender, suppressEvents)
    {
        if (!skipRender)
        {
            this.renderTime(this.__get__totalDuration(), suppressEvents, false);
            return;
        } // end if
        if (timeline.autoRemoveChildren)
        {
            this.setEnabled(false, false);
        }
        else
        {
            active = false;
        } // end else if
        if (!suppressEvents)
        {
            if (vars.onComplete && cachedTotalTime >= cachedTotalDuration && !cachedReversed)
            {
                vars.onComplete.apply(vars.onCompleteScope, vars.onCompleteParams);
            }
            else if (cachedReversed && cachedTotalTime == 0 && vars.onReverseComplete)
            {
                vars.onReverseComplete.apply(vars.onReverseCompleteScope, vars.onReverseCompleteParams);
            } // end if
        } // end else if
    } // End of the function
    function invalidate()
    {
    } // End of the function
    function setEnabled(enabled, ignoreTimeline)
    {
        gc = !enabled;
        if (enabled)
        {
            active = Boolean(!cachedPaused && cachedTotalTime > 0 && cachedTotalTime < cachedTotalDuration);
            if (ignoreTimeline != true && cachedOrphan)
            {
                timeline.insert(this, cachedStartTime - _delay);
            } // end if
        }
        else
        {
            active = false;
            if (ignoreTimeline != true && !cachedOrphan)
            {
                timeline.remove(this, true);
            } // end if
        } // end else if
        return (false);
    } // End of the function
    function kill()
    {
        this.setEnabled(false, false);
    } // End of the function
    function setDirtyCache(includeSelf)
    {
        for (var _loc2 = includeSelf != false ? (this) : (timeline); _loc2; _loc2 = _loc2.timeline)
        {
            _loc2.cacheIsDirty = true;
        } // end of for
    } // End of the function
    function setTotalTime(time, suppressEvents)
    {
        if (timeline)
        {
            var _loc3 = cachedPaused ? (cachedPauseTime) : (timeline.cachedTotalTime);
            if (cachedReversed)
            {
                var _loc4 = cacheIsDirty ? (this.__get__totalDuration()) : (cachedTotalDuration);
                cachedStartTime = _loc3 - (_loc4 - time) / cachedTimeScale;
            }
            else
            {
                cachedStartTime = _loc3 - time / cachedTimeScale;
            } // end else if
            if (!timeline.cacheIsDirty)
            {
                this.setDirtyCache(false);
            } // end if
            if (cachedTotalTime != time)
            {
                this.renderTime(time, suppressEvents, false);
            } // end if
        } // end if
    } // End of the function
    function get delay()
    {
        return (_delay);
    } // End of the function
    function set delay(n)
    {
        startTime = startTime + (n - _delay);
        _delay = n;
        //return (this.delay());
        null;
    } // End of the function
    function get duration()
    {
        return (cachedDuration);
    } // End of the function
    function set duration(n)
    {
        var _loc2 = n / cachedDuration;
        cachedDuration = cachedTotalDuration = n;
        if (active && !cachedPaused && n != 0)
        {
            this.setTotalTime(cachedTotalTime * _loc2, true);
        } // end if
        this.setDirtyCache(false);
        //return (this.duration());
        null;
    } // End of the function
    function get totalDuration()
    {
        return (cachedTotalDuration);
    } // End of the function
    function set totalDuration(n)
    {
        this.__set__duration(n);
        //return (this.totalDuration());
        null;
    } // End of the function
    function get currentTime()
    {
        return (cachedTime);
    } // End of the function
    function set currentTime(n)
    {
        this.setTotalTime(n, false);
        //return (this.currentTime());
        null;
    } // End of the function
    function get totalTime()
    {
        return (cachedTotalTime);
    } // End of the function
    function set totalTime(n)
    {
        this.setTotalTime(n, false);
        //return (this.totalTime());
        null;
    } // End of the function
    function get startTime()
    {
        return (cachedStartTime);
    } // End of the function
    function set startTime(n)
    {
        if (timeline != undefined && (n != cachedStartTime || gc))
        {
            timeline.insert(this, n - _delay);
        }
        else
        {
            cachedStartTime = n;
        } // end else if
        //return (this.startTime());
        null;
    } // End of the function
    function get reversed()
    {
        return (cachedReversed);
    } // End of the function
    function set reversed(b)
    {
        if (b != cachedReversed)
        {
            cachedReversed = b;
            this.setTotalTime(cachedTotalTime, true);
        } // end if
        //return (this.reversed());
        null;
    } // End of the function
    function get paused()
    {
        return (cachedPaused);
    } // End of the function
    function set paused(b)
    {
        if (b != cachedPaused && timeline)
        {
            if (b)
            {
                cachedPauseTime = timeline.rawTime;
            }
            else
            {
                cachedStartTime = cachedStartTime + (timeline.__get__rawTime() - cachedPauseTime);
                cachedPauseTime = NaN;
                this.setDirtyCache(false);
            } // end else if
            cachedPaused = b;
            active = Boolean(!cachedPaused && cachedTotalTime > 0 && cachedTotalTime < cachedTotalDuration);
        } // end if
        if (!b && gc)
        {
            this.setEnabled(true, false);
        } // end if
        //return (this.paused());
        null;
    } // End of the function
    static var version = 1.691000;
} // End of Class
