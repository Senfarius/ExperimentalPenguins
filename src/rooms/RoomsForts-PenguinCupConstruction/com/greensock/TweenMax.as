class com.greensock.TweenMax extends com.greensock.TweenLite
{
    var _cyclesComplete, vars, yoyo, _repeat, _repeatDelay, cacheIsDirty, target, cachedTimeScale, setDirtyCache, ratio, timeline, cachedStartTime, gc, setEnabled, _delay, initted, _notifyPluginsOfEnabled, cachedPT1, cachedTime, cachedDuration, killVars, cachedTotalDuration, __get__totalDuration, cachedTotalTime, _rawPrevTime, active, cachedReversed, cachedPaused, _ease, _hasUpdate, _hasPlugins, complete, __get__duration, setTotalTime, __get__currentProgress, __get__totalProgress, __get__currentTime, __set__duration, cachedPauseTime, __get__timeScale, __get__repeat, __get__repeatDelay, __set__currentProgress, __set__currentTime, __set__repeat, __set__repeatDelay, __set__timeScale, __set__totalDuration, __set__totalProgress;
    static var __get__globalTimeScale, __set__globalTimeScale;
    function TweenMax(target, duration, vars)
    {
        super(target, duration, vars);
        if (com.greensock.TweenLite.version < 11.200000)
        {
            trace ("TweenMax warning: Please update your TweenLite class or try deleting your ASO files. TweenMax requires a more recent version. Download updates at http://www.TweenMax.com.");
        } // end if
        _cyclesComplete = 0;
        yoyo = Boolean(this.vars.yoyo);
        _repeat = this.vars.repeat || 0;
        _repeatDelay = this.vars.repeatDelay || 0;
        cacheIsDirty = true;
        if (this.vars.timeScale != undefined && !(this.target instanceof com.greensock.core.TweenCore))
        {
            cachedTimeScale = this.vars.timeScale;
        } // end if
    } // End of the function
    function init()
    {
        if (vars.startAt)
        {
            vars.startAt.overwrite = 0;
            vars.startAt.immediateRender = true;
            var _loc3 = new com.greensock.TweenMax(target, 0, vars.startAt);
        } // end if
        super.init();
    } // End of the function
    function invalidate()
    {
        yoyo = Boolean(vars.yoyo);
        _repeat = vars.repeat || 0;
        _repeatDelay = vars.repeatDelay || 0;
        this.setDirtyCache(true);
        super.invalidate();
    } // End of the function
    function updateTo(vars, resetDuration)
    {
        var _loc7 = ratio;
        if (resetDuration && timeline != undefined && cachedStartTime < timeline.cachedTime)
        {
            cachedStartTime = timeline.cachedTime;
            this.setDirtyCache(false);
            if (gc)
            {
                this.setEnabled(true, false);
            }
            else
            {
                timeline.insert(this, cachedStartTime - _delay);
            } // end if
        } // end else if
        for (var _loc6 in vars)
        {
            this.vars[_loc6] = vars[_loc6];
        } // end of for...in
        if (initted)
        {
            if (resetDuration)
            {
                initted = false;
            }
            else
            {
                if (_notifyPluginsOfEnabled && cachedPT1)
                {
                    com.greensock.TweenLite.onPluginEvent("onDisable", this);
                } // end if
                if (cachedTime / cachedDuration > 0.998000)
                {
                    var _loc8 = cachedTime;
                    this.renderTime(0, true, false);
                    initted = false;
                    this.renderTime(_loc8, true, false);
                }
                else if (cachedTime > 0)
                {
                    initted = false;
                    this.init();
                    var _loc5 = 1 / (1 - _loc7);
                    var _loc2 = cachedPT1;
                    var _loc3;
                    while (_loc2)
                    {
                        _loc3 = _loc2.start + _loc2.change;
                        _loc2.change = _loc2.change * _loc5;
                        _loc2.start = _loc3 - _loc2.change;
                        _loc2 = _loc2.nextNode;
                    } // end while
                } // end if
            } // end else if
        } // end else if
    } // End of the function
    function setDestination(property, value, adjustStartValues)
    {
        var _loc2 = {};
        _loc2[property] = value;
        this.updateTo(_loc2, Boolean(adjustStartValues != false));
    } // End of the function
    function killProperties(names)
    {
        var _loc3 = {};
        var _loc2 = names.length;
        while (--_loc2 > -1)
        {
            _loc3[names[_loc2]] = true;
        } // end while
        this.killVars(_loc3);
    } // End of the function
    function renderTime(time, suppressEvents, force)
    {
        var _loc9 = cacheIsDirty ? (this.__get__totalDuration()) : (cachedTotalDuration);
        var _loc7 = cachedTotalTime;
        var _loc5;
        var _loc11;
        var _loc6;
        if (time >= _loc9)
        {
            cachedTotalTime = _loc9;
            cachedTime = cachedDuration;
            ratio = 1;
            _loc5 = true;
            if (cachedDuration == 0)
            {
                if ((time == 0 || _rawPrevTime < 0) && _rawPrevTime != time)
                {
                    force = true;
                } // end if
                _rawPrevTime = time;
            } // end if
        }
        else if (time <= 0)
        {
            if (time < 0)
            {
                active = false;
                if (cachedDuration == 0)
                {
                    if (_rawPrevTime >= 0)
                    {
                        force = true;
                        _loc5 = true;
                    } // end if
                    _rawPrevTime = time;
                } // end if
            }
            else if (time == 0 && !initted)
            {
                force = true;
            } // end else if
            cachedTotalTime = cachedTime = ratio = 0;
            if (cachedReversed && _loc7 != 0)
            {
                _loc5 = true;
            } // end if
        }
        else
        {
            cachedTotalTime = cachedTime = time;
            _loc6 = true;
        } // end else if
        if (_repeat != 0)
        {
            var _loc4 = cachedDuration + _repeatDelay;
            var _loc12 = _cyclesComplete;
            _cyclesComplete = cachedTotalTime / _loc4 >> 0;
            if (_cyclesComplete == cachedTotalTime / _loc4)
            {
                --_cyclesComplete;
            } // end if
            if (_loc12 != _cyclesComplete)
            {
                _loc11 = true;
            } // end if
            if (_loc5)
            {
                if (yoyo && _repeat % 2)
                {
                    cachedTime = ratio = 0;
                } // end if
            }
            else if (time > 0)
            {
                cachedTime = (cachedTotalTime / _loc4 - _cyclesComplete) * _loc4;
                if (yoyo && _cyclesComplete % 2)
                {
                    cachedTime = cachedDuration - cachedTime;
                }
                else if (cachedTime >= cachedDuration)
                {
                    cachedTime = cachedDuration;
                    ratio = 1;
                    _loc6 = false;
                } // end else if
                if (cachedTime <= 0)
                {
                    cachedTime = ratio = 0;
                    _loc6 = false;
                } // end if
            }
            else
            {
                _cyclesComplete = 0;
            } // end else if
        } // end else if
        if (_loc7 == cachedTotalTime && !force)
        {
            return;
        }
        else if (!initted)
        {
            this.init();
        } // end else if
        if (!active && !cachedPaused)
        {
            active = true;
        } // end if
        if (_loc6)
        {
            ratio = this._ease(cachedTime, 0, 1, cachedDuration);
        } // end if
        if (_loc7 == 0 && vars.onStart && (cachedTotalTime != 0 || cachedDuration == 0) && !suppressEvents)
        {
            vars.onStart.apply(vars.onStartScope, vars.onStartParams);
        } // end if
        for (var _loc2 = cachedPT1; _loc2; _loc2 = _loc2.nextNode)
        {
            _loc2.target[_loc2.property] = _loc2.start + ratio * _loc2.change;
        } // end of for
        if (_hasUpdate && !suppressEvents)
        {
            vars.onUpdate.apply(vars.onUpdateScope, vars.onUpdateParams);
        } // end if
        if (_loc11 && !suppressEvents && !gc)
        {
            if (vars.onRepeat)
            {
                vars.onRepeat.apply(vars.onRepeatScope, vars.onRepeatParams);
            } // end if
        } // end if
        if (_loc5 && !gc)
        {
            if (_hasPlugins && cachedPT1)
            {
                com.greensock.TweenLite.onPluginEvent("onComplete", this);
            } // end if
            this.complete(true, suppressEvents);
        } // end if
    } // End of the function
    static function to(target, duration, vars)
    {
        return (new com.greensock.TweenMax(target, duration, vars));
    } // End of the function
    static function from(target, duration, vars)
    {
        vars.runBackwards = true;
        if (vars.immediateRender != false)
        {
            vars.immediateRender = true;
        } // end if
        return (new com.greensock.TweenMax(target, duration, vars));
    } // End of the function
    static function fromTo(target, duration, fromVars, toVars)
    {
        toVars.startAt = fromVars;
        if (fromVars.immediateRender)
        {
            toVars.immediateRender = true;
        } // end if
        return (new com.greensock.TweenMax(target, duration, toVars));
    } // End of the function
    static function allTo(targets, duration, vars, stagger, onCompleteAll, onCompleteAllParams, onCompleteAllScope)
    {
        var _loc2;
        var _loc3;
        var _loc1;
        if (stagger == undefined)
        {
            stagger = 0;
        } // end if
        var _loc7 = targets.length;
        var _loc6 = [];
        var _loc5 = vars.delay || 0;
        var onCompleteProxy = vars.onComplete;
        var onCompleteParamsProxy = vars.onCompleteParams;
        var onCompleteScopeProxy = vars.onCompleteScope;
        var _loc9 = _loc7 - 1;
        for (var _loc2 = 0; _loc2 < _loc7; ++_loc2)
        {
            _loc3 = {};
            for (var _loc1 in vars)
            {
                _loc3[_loc1] = vars[_loc1];
            } // end of for...in
            _loc3.delay = _loc5;
            if (_loc2 == _loc9 && onCompleteAll != undefined)
            {
                _loc3.onComplete = function ()
                {
                    if (onCompleteProxy != undefined)
                    {
                        onCompleteProxy.apply(onCompleteScopeProxy, onCompleteParamsProxy);
                    } // end if
                    onCompleteAll.apply(onCompleteAllScope, onCompleteAllParams);
                };
            } // end if
            _loc6[_loc2] = new com.greensock.TweenMax(targets[_loc2], duration, _loc3);
            _loc5 = _loc5 + stagger;
        } // end of for
        return (_loc6);
    } // End of the function
    static function allFrom(targets, duration, vars, stagger, onCompleteAll, onCompleteAllParams, onCompleteAllScope)
    {
        vars.runBackwards = true;
        if (vars.immediateRender != false)
        {
            vars.immediateRender = true;
        } // end if
        return (com.greensock.TweenMax.allTo(targets, duration, vars, stagger, onCompleteAll, onCompleteAllParams, onCompleteAllScope));
    } // End of the function
    static function allFromTo(targets, duration, fromVars, toVars, stagger, onCompleteAll, onCompleteAllParams, onCompleteAllScope)
    {
        toVars.startAt = fromVars;
        if (fromVars.immediateRender)
        {
            toVars.immediateRender = true;
        } // end if
        return (com.greensock.TweenMax.allTo(targets, duration, toVars, stagger, onCompleteAll, onCompleteAllParams, onCompleteAllScope));
    } // End of the function
    static function delayedCall(delay, onComplete, onCompleteParams, onCompleteScope, useFrames)
    {
        return (new com.greensock.TweenMax(onComplete, 0, {delay: delay, onComplete: onComplete, onCompleteParams: onCompleteParams, onCompleteScope: onCompleteScope, immediateRender: false, useFrames: useFrames, overwrite: 0}));
    } // End of the function
    static function getTweensOf(target)
    {
        var _loc2 = com.greensock.TweenLite.masterList[target].tweens;
        var _loc3 = [];
        if (_loc2)
        {
            var _loc1 = _loc2.length;
            while (--_loc1 > -1)
            {
                if (!_loc2[_loc1].gc)
                {
                    _loc3[_loc3.length] = _loc2[_loc1];
                } // end if
            } // end while
        } // end if
        return (_loc3);
    } // End of the function
    static function isTweening(target)
    {
        var _loc3 = com.greensock.TweenMax.getTweensOf(target);
        var _loc2 = _loc3.length;
        var _loc1;
        while (--_loc2 > -1)
        {
            _loc1 = _loc3[_loc2];
            if (_loc1.active || _loc1.cachedStartTime == _loc1.timeline.cachedTime && _loc1.timeline.active)
            {
                return (true);
            } // end if
        } // end while
        return (false);
    } // End of the function
    static function getAllTweens()
    {
        var _loc5 = com.greensock.TweenLite.masterList;
        var _loc4 = 0;
        var _loc3 = [];
        var _loc2;
        var _loc1;
        for (var _loc6 in _loc5)
        {
            _loc2 = _loc5[_loc6].tweens;
            _loc1 = _loc2.length;
            while (--_loc1 > -1)
            {
                if (!_loc2[_loc1].gc)
                {
                    _loc3[_loc4++] = _loc2[_loc1];
                } // end if
            } // end while
        } // end of for...in
        return (_loc3);
    } // End of the function
    static function killAll(complete, tweens, delayedCalls)
    {
        if (tweens == undefined)
        {
            tweens = true;
        } // end if
        if (delayedCalls == undefined)
        {
            delayedCalls = true;
        } // end if
        var _loc2 = com.greensock.TweenMax.getAllTweens();
        var _loc3;
        var _loc1 = _loc2.length;
        while (--_loc1 > -1)
        {
            _loc3 = _loc2[_loc1].target == _loc2[_loc1].vars.onComplete;
            if (_loc3 == delayedCalls || _loc3 != tweens)
            {
                if (complete == true)
                {
                    _loc2[_loc1].complete(false, false);
                    continue;
                } // end if
                _loc2[_loc1].setEnabled(false, false);
            } // end if
        } // end while
    } // End of the function
    static function killChildTweensOf(parent, complete)
    {
        var _loc3 = com.greensock.TweenMax.getAllTweens();
        var _loc4;
        var _loc1;
        var _loc2 = _loc3.length;
        while (--_loc2 > -1)
        {
            _loc4 = _loc3[_loc2].target;
            if (_loc4 instanceof MovieClip)
            {
                for (var _loc1 = _loc4._parent; _loc1; _loc1 = _loc1._parent)
                {
                    if (_loc1 == parent)
                    {
                        if (complete == true)
                        {
                            _loc3[_loc2].complete(false, false);
                            continue;
                        } // end if
                        _loc3[_loc2].setEnabled(false, false);
                    } // end if
                } // end of for
            } // end if
        } // end while
    } // End of the function
    static function pauseAll(tweens, delayedCalls)
    {
        com.greensock.TweenMax.changePause(true, tweens, delayedCalls);
    } // End of the function
    static function resumeAll(tweens, delayedCalls)
    {
        com.greensock.TweenMax.changePause(false, tweens, delayedCalls);
    } // End of the function
    static function changePause(pause, tweens, delayedCalls)
    {
        if (tweens == undefined)
        {
            tweens = true;
        } // end if
        if (delayedCalls == undefined)
        {
            delayedCalls = true;
        } // end if
        var _loc2 = com.greensock.TweenMax.getAllTweens();
        var _loc3;
        var _loc1 = _loc2.length;
        while (--_loc1 > -1)
        {
            _loc3 = Boolean(_loc2[_loc1].target == _loc2[_loc1].vars.onComplete);
            if (_loc3 == delayedCalls || _loc3 != tweens)
            {
                _loc2[_loc1].paused = pause;
            } // end if
        } // end while
    } // End of the function
    function get currentProgress()
    {
        //return (cachedTime / this.duration());
    } // End of the function
    function set currentProgress(n)
    {
        if (_cyclesComplete == 0)
        {
            this.setTotalTime(this.__get__duration() * n, false);
        }
        else
        {
            this.setTotalTime(this.__get__duration() * n + _cyclesComplete * cachedDuration, false);
        } // end else if
        //return (this.currentProgress());
        null;
    } // End of the function
    function get totalProgress()
    {
        //return (cachedTotalTime / this.totalDuration());
    } // End of the function
    function set totalProgress(n)
    {
        this.setTotalTime(this.__get__totalDuration() * n, false);
        //return (this.totalProgress());
        null;
    } // End of the function
    function get currentTime()
    {
        return (cachedTime);
    } // End of the function
    function set currentTime(n)
    {
        if (_cyclesComplete == 0)
        {
        }
        else if (yoyo && _cyclesComplete % 2 == 1)
        {
            n = this.__get__duration() - n + _cyclesComplete * (cachedDuration + _repeatDelay);
        }
        else
        {
            n = n + _cyclesComplete * (this.__get__duration() + _repeatDelay);
        } // end else if
        this.setTotalTime(n, false);
        //return (this.currentTime());
        null;
    } // End of the function
    function get totalDuration()
    {
        if (cacheIsDirty)
        {
            cachedTotalDuration = _repeat == -1 ? (999999999999.000000) : (cachedDuration * (_repeat + 1) + _repeatDelay * _repeat);
            cacheIsDirty = false;
        } // end if
        return (cachedTotalDuration);
    } // End of the function
    function set totalDuration(n)
    {
        if (_repeat == -1)
        {
            return;
        } // end if
        this.__set__duration((n - _repeat * _repeatDelay) / (_repeat + 1));
        //return (this.totalDuration());
        null;
    } // End of the function
    function get timeScale()
    {
        return (cachedTimeScale);
    } // End of the function
    function set timeScale(n)
    {
        if (n == 0)
        {
            n = 0.000100;
        } // end if
        var _loc3 = cachedPauseTime || cachedPauseTime == 0 ? (cachedPauseTime) : (timeline.cachedTotalTime);
        cachedStartTime = _loc3 - (_loc3 - cachedStartTime) * cachedTimeScale / n;
        cachedTimeScale = n;
        this.setDirtyCache(false);
        //return (this.timeScale());
        null;
    } // End of the function
    function get repeat()
    {
        return (_repeat);
    } // End of the function
    function set repeat(n)
    {
        _repeat = n;
        this.setDirtyCache(true);
        //return (this.repeat());
        null;
    } // End of the function
    function get repeatDelay()
    {
        return (_repeatDelay);
    } // End of the function
    function set repeatDelay(n)
    {
        _repeatDelay = n;
        this.setDirtyCache(true);
        //return (this.repeatDelay());
        null;
    } // End of the function
    static function get globalTimeScale()
    {
        return (com.greensock.TweenLite.rootTimeline == undefined ? (1) : (com.greensock.TweenLite.rootTimeline.cachedTimeScale));
    } // End of the function
    static function set globalTimeScale(n)
    {
        if (n == 0)
        {
            n = 0.000100;
        } // end if
        if (com.greensock.TweenLite.rootTimeline == undefined)
        {
            com.greensock.TweenLite.to({}, 0, {});
        } // end if
        var _loc1 = com.greensock.TweenLite.rootTimeline;
        var _loc2 = getTimer() * 0.001000;
        _loc1.cachedStartTime = _loc2 - (_loc2 - _loc1.cachedStartTime) * _loc1.cachedTimeScale / n;
        _loc1 = com.greensock.TweenLite.rootFramesTimeline;
        _loc2 = com.greensock.TweenLite.rootFrame;
        _loc1.cachedStartTime = _loc2 - (_loc2 - _loc1.cachedStartTime) * _loc1.cachedTimeScale / n;
        com.greensock.TweenLite.rootFramesTimeline.cachedTimeScale = com.greensock.TweenLite.rootTimeline.cachedTimeScale = n;
        //return (com.greensock.TweenMax.globalTimeScale());
        null;
    } // End of the function
    static var version = 11.691000;
    static var _activatedPlugins = com.greensock.plugins.TweenPlugin.activate([com.greensock.plugins.AutoAlphaPlugin, com.greensock.plugins.EndArrayPlugin, com.greensock.plugins.FramePlugin, com.greensock.plugins.RemoveTintPlugin, com.greensock.plugins.TintPlugin, com.greensock.plugins.VisiblePlugin, com.greensock.plugins.VolumePlugin, com.greensock.plugins.BevelFilterPlugin, com.greensock.plugins.BezierPlugin, com.greensock.plugins.BezierThroughPlugin, com.greensock.plugins.BlurFilterPlugin, com.greensock.plugins.ColorMatrixFilterPlugin, com.greensock.plugins.ColorTransformPlugin, com.greensock.plugins.DropShadowFilterPlugin, com.greensock.plugins.FrameLabelPlugin, com.greensock.plugins.GlowFilterPlugin, com.greensock.plugins.HexColorsPlugin, com.greensock.plugins.RoundPropsPlugin, com.greensock.plugins.ShortRotationPlugin, {}]);
    static var _overwriteMode = com.greensock.OverwriteManager.enabled ? (com.greensock.OverwriteManager.mode) : (com.greensock.OverwriteManager.init(2));
    static var killTweensOf = com.greensock.TweenLite.killTweensOf;
    static var killDelayedCallsTo = com.greensock.TweenLite.killTweensOf;
} // End of Class
