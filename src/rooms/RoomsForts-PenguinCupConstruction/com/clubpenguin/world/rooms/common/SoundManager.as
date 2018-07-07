class com.clubpenguin.world.rooms.common.SoundManager
{
    var _layersMap, _target, _defaultLayer, _activeSoundsMap, _registeredSymbolNamesMap, _soundLoopsMap, _delayedSoundsMap, _layerNameMap, _nextSoundId, _nextSymbolId, _nextLayerId, _nextDelayedSoundId, _nextLoopId, _frameCounter, _frameCountersToDelete, _sfxHolder;
    function SoundManager(target)
    {
        _layersMap = new Object();
        _target = target;
        this.init();
    } // End of the function
    function init()
    {
        _defaultLayer = new com.clubpenguin.world.rooms.common.SoundLayer(this.getLayerId("default"), "default", -1);
        _activeSoundsMap = new Object();
        _registeredSymbolNamesMap = new Object();
        _soundLoopsMap = new Object();
        _delayedSoundsMap = new Object();
        _layerNameMap = new Object();
        _nextSoundId = 0;
        _nextSymbolId = 0;
        _nextLayerId = 0;
        _nextDelayedSoundId = 0;
        _nextLoopId = 0;
        if (_frameCounter != null)
        {
            _frameCounter.removeMovieClip();
        } // end if
        _frameCounter = _target.createEmptyMovieClip("SoundManager_frameCounter", _target.getNextHighestDepth());
        _frameCounter.onEnterFrame = com.clubpenguin.util.Delegate.create(this, updateFrameCounters);
        _frameCountersToDelete = new Array();
        if (_sfxHolder != null)
        {
            _sfxHolder.removeMovieClip();
        } // end if
        _sfxHolder = _target.createEmptyMovieClip("SoundManager_sfxHolder", _target.getNextHighestDepth());
    } // End of the function
    function destroy()
    {
        for (var _loc5 in _soundLoopsMap)
        {
            var _loc2 = _soundLoopsMap[_loc5];
            this.stopSoundLoop(_loc2.loopId);
        } // end of for...in
        for (var _loc4 in _delayedSoundsMap)
        {
            var _loc3 = _delayedSoundsMap[_loc4];
            this.cancelDelayedSound(_loc3.delayedSoundId);
        } // end of for...in
        _frameCounter.removeMovieClip();
        _frameCounter = null;
        var _loc6 = new Sound(_target);
        _loc6.setVolume(0);
        _sfxHolder.removeMovieClip();
        _sfxHolder = null;
    } // End of the function
    function registerSymbolName(symbolName)
    {
        ++_nextSymbolId;
        for (var _loc3 in _registeredSymbolNamesMap)
        {
            if (_loc3 == symbolName)
            {
                trace ("WARNING \'" + symbolName + "\' has already been registered. A new ID for the duplicate name will be returned.");
            } // end if
        } // end of for...in
        _registeredSymbolNamesMap[_nextSymbolId] = symbolName;
        return (_nextSymbolId);
    } // End of the function
    function getRegisteredSymbolId(symbolName)
    {
        for (var _loc2 in _registeredSymbolNamesMap)
        {
            if (_loc2 == symbolName)
            {
                return (Number(_loc2));
            } // end if
        } // end of for...in
        return (null);
    } // End of the function
    function addLayer(layerName, maxConcurrent)
    {
        var _loc2 = this.getLayerId(layerName);
        if (this.getLayer(_loc2) == null)
        {
            _layersMap[_loc2] = new com.clubpenguin.world.rooms.common.SoundLayer(_loc2, layerName, maxConcurrent);
        } // end if
        return (_loc2);
    } // End of the function
    function removeLayer(layerId)
    {
        var _loc2 = _layersMap[layerId];
        if (_loc2 != null)
        {
            delete _layerNameMap[_loc2.name];
            delete _layersMap[layerId];
        } // end if
    } // End of the function
    function getLayer(layerId)
    {
        return (_layersMap[layerId]);
    } // End of the function
    function getLayerId(layerName)
    {
        if (_layerNameMap[layerName] != null)
        {
            return (_layerNameMap[layerName]);
        }
        else
        {
            ++_nextLayerId;
            _layerNameMap[layerName] = _nextLayerId;
            return (_nextLayerId);
        } // end else if
    } // End of the function
    function getSoundId()
    {
        ++_nextSoundId;
        return (_nextSoundId);
    } // End of the function
    function getDelayedSoundId()
    {
        ++_nextDelayedSoundId;
        return (_nextDelayedSoundId);
    } // End of the function
    function getSoundLoopId()
    {
        ++_nextLoopId;
        return (_nextLoopId);
    } // End of the function
    function playSound(symbolId, layerId, volume, tag, callback)
    {
        if (volume == null)
        {
            volume = 100;
        } // end if
        var _loc4 = this.getLayer(layerId);
        if (_loc4 == null)
        {
            _loc4 = _defaultLayer;
        } // end if
        if (_loc4.canPlaySound())
        {
            var _loc7 = _registeredSymbolNamesMap[symbolId];
            if (_loc7 == null || _sfxHolder == null)
            {
                return (-1);
            } // end if
            var _loc8 = _sfxHolder.getNextHighestDepth();
            var _loc5 = _sfxHolder.createEmptyMovieClip("sfx_" + symbolId + "_" + _loc8, _loc8);
            var _loc3 = new Sound(_loc5);
            _loc3.attachSound(_loc7);
            if (_loc3.duration != undefined)
            {
                var _loc2 = new Object();
                var _loc6 = this.getSoundId();
                _loc2.soundId = _loc6;
                _loc2.tag = tag;
                _loc2.sfx = _loc3;
                _loc2.layerId = layerId;
                _loc2.targetHolder = _loc5;
                _loc2.callback = callback;
                _loc2.symbolId = symbolId;
                _loc2.layer = _loc4;
                _activeSoundsMap[_loc6] = _loc2;
                ++_loc4.numSoundsPlaying;
                _loc3.onSoundComplete = com.clubpenguin.util.Delegate.create(this, onSoundComplete, _loc3, _loc4, _loc5, tag, callback);
                _loc3.setVolume(volume);
                _loc3.start(0, 1);
                return (_loc6);
            } // end if
        } // end if
        return (-1);
    } // End of the function
    function playSoundAfterDelay(symbolId, layerId, frameDelay, volume, tag, callback)
    {
        if (frameDelay <= 0)
        {
            return;
        } // end if
        var _loc3 = this.getDelayedSoundId();
        if (_delayedSoundsMap[_loc3] != null)
        {
            this.cancelDelayedSound(_loc3);
        } // end if
        var _loc2 = {};
        _loc2.delay = frameDelay;
        _loc2.delayedSoundId = _loc3;
        _loc2.symbolId = symbolId;
        _loc2.layerId = layerId;
        _loc2.callback = callback;
        _loc2.volume = volume;
        _loc2.tag = tag;
        _delayedSoundsMap[_loc3] = _loc2;
        return (_loc3);
    } // End of the function
    function cancelDelayedSound(delayedSoundId)
    {
        var _loc2 = _delayedSoundsMap[delayedSoundId];
        if (_loc2 != null)
        {
            delete _delayedSoundsMap[delayedSoundId];
        } // end if
    } // End of the function
    function playSoundLoop(symbolIds, layerId, volume, tag)
    {
        var _loc3 = this.getSoundLoopId();
        if (_soundLoopsMap[_loc3] != null)
        {
            this.stopSoundLoop(_loc3);
        } // end if
        var _loc2 = new Object();
        _loc2.loopId = _loc3;
        _loc2.symbolIds = symbolIds.slice();
        _loc2.layerId = layerId;
        _loc2.currentSymbolIndex = -1;
        _loc2.isActive = true;
        _loc2.volume = volume;
        _loc2.tag = tag;
        _soundLoopsMap[_loc3] = _loc2;
        this.playSoundLoopObject(_soundLoopsMap[_loc3]);
        return (_loc3);
    } // End of the function
    function stopSoundLoop(loopId)
    {
        var _loc2 = _soundLoopsMap[loopId];
        if (_loc2 != null)
        {
            _loc2.isActive = false;
            delete _soundLoopsMap[loopId];
        } // end if
    } // End of the function
    function updateFrameCounters()
    {
        for (var _loc5 in _delayedSoundsMap)
        {
            var _loc4 = Number(_loc5);
            var _loc2 = _delayedSoundsMap[_loc4];
            --_loc2.delay;
            if (_loc2.delay <= 0)
            {
                this.playSound(_loc2.symbolId, _loc2.layerId, _loc2.volume, _loc2.tag, _loc2.callback);
                _frameCountersToDelete.push(_loc2);
            } // end if
        } // end of for...in
        for (var _loc3 = 0; _loc3 < _frameCountersToDelete.length; ++_loc3)
        {
            delete _delayedSoundsMap[_frameCountersToDelete[_loc3].delayedSoundId];
        } // end of for
        _frameCountersToDelete.length = 0;
    } // End of the function
    function playSoundLoopObject(loop)
    {
        ++loop.currentSymbolIndex;
        if (loop.currentSymbolIndex >= loop.symbolIds.length)
        {
            loop.currentSymbolIndex = 0;
        } // end if
        this.playSound(loop.symbolIds[loop.currentSymbolIndex], loop.layerId, loop.volume, loop.tag, com.clubpenguin.util.Delegate.create(this, soundLoopCallback, loop));
    } // End of the function
    function soundLoopCallback(loop)
    {
        if (loop.isActive)
        {
            this.playSoundLoopObject(loop);
        } // end if
    } // End of the function
    function onSoundComplete(sfx, layer, targetHolder, tag, callback)
    {
        targetHolder.removeMovieClip();
        false;
        --layer.numSoundsPlaying;
        if (layer.numSoundsPlaying < 0)
        {
            layer.numSoundsPlaying = 0;
        } // end if
        callback();
    } // End of the function
    function stopSoundsForTag(tag)
    {
        for (var _loc6 in _activeSoundsMap)
        {
            var _loc3 = _activeSoundsMap[_loc6];
            if (_loc3.tag == tag)
            {
                _loc3.sfx.stop();
                this.onSoundComplete(_loc3.sfx, _loc3.layer, _loc3.targetHolder, _loc3.callback);
                delete _activeSoundsMap[_loc3.soundId];
            } // end if
        } // end of for...in
        for (var _loc7 in _soundLoopsMap)
        {
            var _loc2 = _soundLoopsMap[_loc7];
            if (_loc2.tag == tag)
            {
                this.stopSoundLoop(_loc2.loopId);
            } // end if
        } // end of for...in
        for (var _loc5 in _delayedSoundsMap)
        {
            _loc3 = _delayedSoundsMap[_loc5];
            if (_loc3.tag == tag)
            {
                this.cancelDelayedSound(_loc3.delayedSoundId);
            } // end if
        } // end of for...in
    } // End of the function
} // End of Class
