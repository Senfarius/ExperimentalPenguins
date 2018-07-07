class com.greensock.TweenLite extends com.greensock.core.TweenCore
{
    var ratio, target, _targetID, vars, cachedTimeScale, propTweenLookup, _ease, _overwrite, active, cachedPT1, _notifyPluginsOfEnabled, _hasPlugins, _hasUpdate, _overwrittenProps, initted, cachedTime, cachedDuration, cachedTotalTime, _rawPrevTime, cachedReversed, cachedPaused, gc, complete;
    static var _timingClip, overwriteManager, rootFrame, rootTimeline, rootFramesTimeline, onPluginEvent;
    function TweenLite(target, duration, vars)
    {
        super(duration, vars);
        if (com.greensock.TweenLite._timingClip.onEnterFrame != com.greensock.TweenLite.updateAll)
        {
            com.greensock.TweenLite.jumpStart(_root);
        } // end if
        ratio = 0;
        this.target = target;
        _targetID = com.greensock.TweenLite.getID(target, true);
        if (this.vars.timeScale != undefined && this.target instanceof com.greensock.core.TweenCore)
        {
            cachedTimeScale = 1;
        } // end if
        propTweenLookup = {};
        _ease = com.greensock.TweenLite.defaultEase;
        _overwrite = vars.overwrite == undefined || !com.greensock.TweenLite.overwriteManager.enabled && vars.overwrite > 1 ? (com.greensock.TweenLite.overwriteManager.mode) : (Number(vars.overwrite));
        var _loc5 = com.greensock.TweenLite.masterList[_targetID].tweens;
        if (_loc5.length == 0)
        {
            _loc5[0] = this;
        }
        else if (_overwrite == 1)
        {
            var _loc4 = _loc5.length;
            while (--_loc4 > -1)
            {
                if (!_loc5[_loc4].gc)
                {
                    _loc5[_loc4].setEnabled(false, false);
                } // end if
            } // end while
            com.greensock.TweenLite.masterList[_targetID].tweens = [this];
        }
        else
        {
            _loc5[_loc5.length] = this;
        } // end else if
        if (active || this.vars.immediateRender)
        {
            this.renderTime(0, false, true);
        } // end if
    } // End of the function
    static function initClass()
    {
        rootFrame = 0;
        rootTimeline = new com.greensock.core.SimpleTimeline(null);
        rootFramesTimeline = new com.greensock.core.SimpleTimeline(null);
        com.greensock.TweenLite.rootTimeline.autoRemoveChildren = com.greensock.TweenLite.rootFramesTimeline.autoRemoveChildren = true;
        com.greensock.TweenLite.rootTimeline.cachedStartTime = getTimer() * 0.001000;
        com.greensock.TweenLite.rootTimeline.cachedTotalTime = com.greensock.TweenLite.rootFramesTimeline.cachedTotalTime = 0;
        com.greensock.TweenLite.rootFramesTimeline.cachedStartTime = com.greensock.TweenLite.rootFrame;
        if (com.greensock.TweenLite.overwriteManager == undefined)
        {
            overwriteManager = {mode: 1, enabled: false};
        } // end if
        com.greensock.TweenLite.jumpStart(_root);
    } // End of the function
    function init()
    {
        if (vars.onInit)
        {
            vars.onInit.apply(null, vars.onInitParams);
        } // end if
        var _loc2;
        var _loc5;
        var _loc3;
        var _loc6;
        var _loc7;
        if (typeof(vars.ease) == "function")
        {
            _ease = vars.ease;
        } // end if
        if (vars.easeParams != undefined)
        {
            vars.proxiedEase = _ease;
            _ease = easeProxy;
        } // end if
        cachedPT1 = undefined;
        propTweenLookup = {};
        for (var _loc2 in vars)
        {
            if (com.greensock.TweenLite._reservedProps[_loc2] && !(_loc2 == "timeScale" && target instanceof com.greensock.core.TweenCore))
            {
                continue;
            } // end if
            _loc3 = new com.greensock.TweenLite.plugins[_loc2]();
            if (com.greensock.TweenLite.plugins[_loc2] && new com.greensock.TweenLite.plugins[_loc2]().onInitTween(target, vars[_loc2], this))
            {
                cachedPT1 = new com.greensock.core.PropTween(_loc3, "changeFactor", 0, 1, _loc3.overwriteProps.length == 1 ? (_loc3.overwriteProps[0]) : ("_MULTIPLE_"), true, cachedPT1);
                if (cachedPT1.name == "_MULTIPLE_")
                {
                    _loc5 = _loc3.overwriteProps.length;
                    while (--_loc5 > -1)
                    {
                        propTweenLookup[_loc3.overwriteProps[_loc5]] = cachedPT1;
                    } // end while
                }
                else
                {
                    propTweenLookup[cachedPT1.name] = cachedPT1;
                } // end else if
                if (_loc3.priority)
                {
                    cachedPT1.priority = _loc3.priority;
                    _loc6 = true;
                } // end if
                if (_loc3.onDisable || _loc3.onEnable)
                {
                    _notifyPluginsOfEnabled = true;
                } // end if
                _hasPlugins = true;
                continue;
            } // end if
            cachedPT1 = new com.greensock.core.PropTween(target, _loc2, Number(target[_loc2]), typeof(vars[_loc2]) == "number" ? (Number(vars[_loc2]) - target[_loc2]) : (Number(vars[_loc2])), _loc2, false, cachedPT1);
            propTweenLookup[_loc2] = cachedPT1;
        } // end of for...in
        if (_loc6)
        {
            com.greensock.TweenLite.onPluginEvent("onInitAllProps", this);
        } // end if
        if (vars.runBackwards)
        {
            for (var _loc4 = cachedPT1; _loc4; _loc4 = _loc4.nextNode)
            {
                _loc4.start = _loc4.start + _loc4.change;
                _loc4.change = -_loc4.change;
            } // end of for
        } // end if
        _hasUpdate = Boolean(typeof(vars.onUpdate) == "function");
        if (_overwrittenProps)
        {
            this.killVars(_overwrittenProps);
            if (cachedPT1 == undefined)
            {
                this.setEnabled(false, false);
            } // end if
        } // end if
        _loc7 = com.greensock.TweenLite.masterList[_targetID].tweens;
        if (_overwrite > 1 && cachedPT1 && com.greensock.TweenLite.masterList[_targetID].tweens && _loc7.length > 1)
        {
            if (com.greensock.TweenLite.overwriteManager.manageOverwrites(this, propTweenLookup, _loc7, _overwrite))
            {
                this.init();
            } // end if
        } // end if
        initted = true;
    } // End of the function
    function renderTime(time, suppressEvents, force)
    {
        var _loc4;
        var _loc5 = cachedTime;
        if (time >= cachedDuration)
        {
            cachedTotalTime = cachedTime = cachedDuration;
            ratio = 1;
            _loc4 = true;
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
            cachedTotalTime = cachedTime = ratio = 0;
            if (time < 0)
            {
                active = false;
                if (cachedDuration == 0)
                {
                    if (_rawPrevTime >= 0)
                    {
                        force = true;
                        _loc4 = true;
                    } // end if
                    _rawPrevTime = time;
                } // end if
            } // end if
            if (cachedReversed && _loc5 != 0)
            {
                _loc4 = true;
            } // end if
        }
        else
        {
            cachedTotalTime = cachedTime = time;
            ratio = this._ease(time, 0, 1, cachedDuration);
        } // end else if
        if (cachedTime == _loc5 && !force)
        {
            return;
        }
        else if (!initted)
        {
            this.init();
            if (!_loc4 && cachedTime)
            {
                ratio = this._ease(cachedTime, 0, 1, cachedDuration);
            } // end if
        } // end else if
        if (!active && !cachedPaused)
        {
            active = true;
        } // end if
        if (_loc5 == 0 && vars.onStart && (cachedTime != 0 || cachedDuration == 0) && !suppressEvents)
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
        if (_loc4 && !gc)
        {
            if (_hasPlugins && cachedPT1)
            {
                com.greensock.TweenLite.onPluginEvent("onComplete", this);
            } // end if
            this.complete(true, suppressEvents);
        } // end if
    } // End of the function
    function killVars(vars, permanent)
    {
        if (_overwrittenProps == undefined)
        {
            _overwrittenProps = {};
        } // end if
        var _loc3;
        var _loc2;
        var _loc5;
        for (var _loc3 in vars)
        {
            if (propTweenLookup[_loc3])
            {
                _loc2 = propTweenLookup[_loc3];
                if (_loc2.isPlugin && _loc2.name == "_MULTIPLE_")
                {
                    _loc2.target.killProps(vars);
                    if (_loc2.target.overwriteProps.length == 0)
                    {
                        _loc2.name = "";
                    } // end if
                    if (_loc3 != _loc2.target.propName || _loc2.name == "")
                    {
                        delete propTweenLookup[_loc3];
                    } // end if
                } // end if
                if (_loc2.name != "_MULTIPLE_")
                {
                    if (_loc2.nextNode)
                    {
                        _loc2.nextNode.prevNode = _loc2.prevNode;
                    } // end if
                    if (_loc2.prevNode)
                    {
                        _loc2.prevNode.nextNode = _loc2.nextNode;
                    }
                    else if (cachedPT1 == _loc2)
                    {
                        cachedPT1 = _loc2.nextNode;
                    } // end else if
                    if (_loc2.isPlugin && _loc2.target.onDisable)
                    {
                        _loc2.target.onDisable();
                        if (_loc2.target.activeDisable)
                        {
                            _loc5 = true;
                        } // end if
                    } // end if
                    delete propTweenLookup[_loc3];
                } // end if
            } // end if
            if (permanent != false && vars != _overwrittenProps)
            {
                _overwrittenProps[_loc3] = 1;
            } // end if
        } // end of for...in
        return (_loc5);
    } // End of the function
    function invalidate()
    {
        if (_notifyPluginsOfEnabled)
        {
            com.greensock.TweenLite.onPluginEvent("onDisable", this);
        } // end if
        cachedPT1 = undefined;
        _overwrittenProps = undefined;
        _hasUpdate = initted = active = _notifyPluginsOfEnabled = false;
        propTweenLookup = {};
    } // End of the function
    function setEnabled(enabled, ignoreTimeline)
    {
        if (enabled && gc)
        {
            var _loc4 = com.greensock.TweenLite.masterList[_targetID].tweens;
            if (_loc4)
            {
                var _loc3 = _loc4.length;
                _loc4[_loc3] = this;
                while (--_loc3 > -1)
                {
                    if (_loc4[_loc3] == this)
                    {
                        _loc4.splice(_loc3, 1);
                    } // end if
                } // end while
            }
            else
            {
                com.greensock.TweenLite.masterList[_targetID] = {target: target, tweens: [this]};
            } // end if
        } // end else if
        super.setEnabled(enabled, ignoreTimeline);
        if (_notifyPluginsOfEnabled && cachedPT1)
        {
            return (com.greensock.TweenLite.onPluginEvent(enabled ? ("onEnable") : ("onDisable"), this));
        } // end if
        return (false);
    } // End of the function
    function easeProxy(t, b, c, d)
    {
        return (vars.proxiedEase.apply(null, arguments.concat(vars.easeParams)));
    } // End of the function
    static function to(target, duration, vars)
    {
        return (new com.greensock.TweenLite(target, duration, vars));
    } // End of the function
    static function from(target, duration, vars)
    {
        vars.runBackwards = true;
        if (vars.immediateRender != false)
        {
            vars.immediateRender = true;
        } // end if
        return (new com.greensock.TweenLite(target, duration, vars));
    } // End of the function
    static function delayedCall(delay, onComplete, onCompleteParams, onCompleteScope, useFrames)
    {
        return (new com.greensock.TweenLite(onComplete, 0, {delay: delay, onComplete: onComplete, onCompleteParams: onCompleteParams, onCompleteScope: onCompleteScope, immediateRender: false, useFrames: useFrames, overwrite: 0}));
    } // End of the function
    static function updateAll()
    {
        com.greensock.TweenLite.rootTimeline.renderTime((getTimer() * 0.001000 - com.greensock.TweenLite.rootTimeline.cachedStartTime) * com.greensock.TweenLite.rootTimeline.cachedTimeScale, false, false);
        rootFrame = ++com.greensock.TweenLite.rootFrame;
        com.greensock.TweenLite.rootFramesTimeline.renderTime((com.greensock.TweenLite.rootFrame - com.greensock.TweenLite.rootFramesTimeline.cachedStartTime) * com.greensock.TweenLite.rootFramesTimeline.cachedTimeScale, false, false);
        if (!(com.greensock.TweenLite.rootFrame % 60))
        {
            var _loc3 = com.greensock.TweenLite.masterList;
            var _loc2;
            var _loc1;
            for (var _loc4 in _loc3)
            {
                _loc1 = _loc3[_loc4].tweens;
                _loc2 = _loc1.length;
                while (--_loc2 > -1)
                {
                    if (_loc1[_loc2].gc)
                    {
                        _loc1.splice(_loc2, 1);
                    } // end if
                } // end while
                if (_loc1.length == 0)
                {
                    delete _loc3[_loc4];
                } // end if
            } // end of for...in
        } // end if
    } // End of the function
    static function killTweensOf(target, complete, vars)
    {
        var _loc6 = com.greensock.TweenLite.getID(target, true);
        var _loc4 = com.greensock.TweenLite.masterList[_loc6].tweens;
        var _loc3;
        var _loc1;
        if (_loc4 != undefined)
        {
            _loc3 = _loc4.length;
            while (--_loc3 > -1)
            {
                _loc1 = _loc4[_loc3];
                if (!_loc1.gc)
                {
                    if (complete == true)
                    {
                        _loc1.complete(false, false);
                    } // end if
                    if (vars != undefined)
                    {
                        _loc1.killVars(vars);
                    } // end if
                    if (vars == undefined || _loc1.cachedPT1 == undefined && _loc1.initted)
                    {
                        _loc1.setEnabled(false, false);
                    } // end if
                } // end if
            } // end while
            if (vars == undefined)
            {
                delete com.greensock.TweenLite.masterList[_loc6];
            } // end if
        } // end if
    } // End of the function
    static function getID(target, lookup)
    {
        var _loc2;
        if (lookup)
        {
            var _loc1 = com.greensock.TweenLite.masterList;
            if (typeof(target) == "movieclip")
            {
                if (_loc1[String(target)] != undefined)
                {
                    return (String(target));
                }
                else
                {
                    _loc2 = String(target);
                    com.greensock.TweenLite.masterList[_loc2] = {target: target, tweens: []};
                    return (_loc2);
                } // end else if
            }
            else
            {
                for (var _loc3 in _loc1)
                {
                    if (_loc1[_loc3].target == target)
                    {
                        return (_loc3);
                    } // end if
                } // end of for...in
            } // end if
        } // end else if
        _cnt = ++com.greensock.TweenLite._cnt;
        _loc2 = "t" + com.greensock.TweenLite._cnt;
        com.greensock.TweenLite.masterList[_loc2] = {target: target, tweens: []};
        return (_loc2);
    } // End of the function
    static function easeOut(t, b, c, d)
    {
        t = t / d;
        return (-1 * (t) * (t - 2));
    } // End of the function
    static function findSubloadedSWF(mc)
    {
        for (var _loc3 in mc)
        {
            if (typeof(mc[_loc3]) == "movieclip")
            {
                if (mc[_loc3]._url != _root._url && mc[_loc3].getBytesLoaded() != undefined)
                {
                    return (mc[_loc3]);
                    continue;
                } // end if
                if (com.greensock.TweenLite.findSubloadedSWF(mc[_loc3]) != undefined)
                {
                    return (com.greensock.TweenLite.findSubloadedSWF(mc[_loc3]));
                } // end if
            } // end if
        } // end of for...in
        return;
    } // End of the function
    static function jumpStart(root)
    {
        if (com.greensock.TweenLite._timingClip != undefined)
        {
            com.greensock.TweenLite._timingClip.removeMovieClip();
        } // end if
        var _loc2 = root.getBytesLoaded() == undefined ? (com.greensock.TweenLite.findSubloadedSWF(root)) : (root);
        for (var _loc1 = 999; _loc2.getInstanceAtDepth(_loc1) != undefined; ++_loc1)
        {
        } // end of for
        _timingClip = _loc2.createEmptyMovieClip("__tweenLite" + String(com.greensock.TweenLite.version).split(".").join("_"), _loc1);
        com.greensock.TweenLite._timingClip.onEnterFrame = com.greensock.TweenLite.updateAll;
        com.greensock.TweenLite.to({}, 0, {});
        com.greensock.TweenLite.rootTimeline.cachedTime = com.greensock.TweenLite.rootTimeline.cachedTotalTime = (getTimer() * 0.001000 - com.greensock.TweenLite.rootTimeline.cachedStartTime) * com.greensock.TweenLite.rootTimeline.cachedTimeScale;
    } // End of the function
    static var version = 11.691000;
    static var plugins = {};
    static var killDelayedCallsTo = com.greensock.TweenLite.killTweensOf;
    static var defaultEase = com.greensock.TweenLite.easeOut;
    static var masterList = {};
    static var _cnt = -16000;
    static var _reservedProps = {ease: 1, delay: 1, overwrite: 1, onComplete: 1, onCompleteParams: 1, useFrames: 1, runBackwards: 1, startAt: 1, onUpdate: 1, onUpdateParams: 1, onStart: 1, onStartParams: 1, onReverseComplete: 1, onReverseCompleteParams: 1, onRepeat: 1, onRepeatParams: 1, proxiedEase: 1, easeParams: 1, yoyo: 1, onCompleteListener: 1, onUpdateListener: 1, onStartListener: 1, orientToBezier: 1, timeScale: 1, immediateRender: 1, repeat: 1, repeatDelay: 1, timeline: 1, data: 1, paused: 1};
} // End of Class
