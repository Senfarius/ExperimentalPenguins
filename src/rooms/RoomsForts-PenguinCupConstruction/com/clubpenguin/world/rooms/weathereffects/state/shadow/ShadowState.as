class com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowState
{
    var _wem, _tintObject, bgCloudsShadow, bgDistantShadow, bgSkyShadow, cloudsEffect, cloudsEffectShadow, shadowEffect;
    function ShadowState(manager)
    {
        _wem = manager;
        _tintObject = new Object();
        _tintObject.tintType = "shadow";
        this.setDefaultMovieClips();
    } // End of the function
    function tweenComplete(obj)
    {
    } // End of the function
    function setDefaultMovieClips()
    {
        var _loc2 = _wem.getBackogrundMC().weatherEffects_mc;
        bgCloudsShadow = _loc2.bgClouds.bgCloudsShadow;
        bgDistantShadow = _loc2.bgDistant.bgDistantShadow;
        bgSkyShadow = _loc2.bgSky.bgSkyShadow;
        cloudsEffect = _wem.getBackogrundMC().weatherEffects_mc.cloudsEffect.cloudsEffectColor;
        cloudsEffectShadow = _wem.getBackogrundMC().weatherEffects_mc.cloudsEffect;
        shadowEffect = _wem.getBackogrundMC().weatherEffects_mc.shadowEffect;
    } // End of the function
    function setTintValues(mode, effectType)
    {
        _tintObject.state = "Mode" + mode;
        _tintObject.effectType = effectType;
        _tintObject.stateForSettings = "Mode" + (mode == "A" ? ("A") : ("B"));
        _tintObject.sky = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[_tintObject.tintType + effectType + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_SKY + _tintObject.stateForSettings];
        _tintObject.clouds = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[_tintObject.tintType + effectType + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_CLOUDS + _tintObject.stateForSettings];
        _tintObject.distantObjects = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[_tintObject.tintType + effectType + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_DISTANT_OBJ + _tintObject.stateForSettings];
        _tintObject.topCoulds = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[_tintObject.tintType + effectType + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_TOP_CLOUDS + _tintObject.stateForSettings];
        _tintObject.shell = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[_tintObject.tintType + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_SHELL + _tintObject.state];
        if (effectType == com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_EMPTY)
        {
            _tintObject.shell = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[_tintObject.tintType + effectType + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_SHELL + _tintObject.stateForSettings];
        } // end if
    } // End of the function
    function applyTinting(mode, effectType)
    {
        this.setTintValues(mode, effectType);
        com.greensock.TweenLite.to(bgSkyShadow, 2, {colorTransform: _tintObject.sky, onComplete: tweenComplete});
        com.greensock.TweenLite.to(bgDistantShadow, 2, {colorTransform: _tintObject.distantObjects, onComplete: tweenComplete});
        com.greensock.TweenLite.to(bgCloudsShadow, 2, {colorTransform: _tintObject.clouds, onComplete: tweenComplete});
        com.greensock.TweenLite.to(cloudsEffectShadow, 2, {colorTransform: _tintObject.topCoulds, onComplete: tweenComplete});
        com.greensock.TweenLite.to(_wem.SHELL, 0, {colorTransform: _tintObject.shell, onComplete: tweenComplete});
        trace ("[SHADOW] PLAYING WEATHER EFFECT: " + _tintObject.tintType + " " + _tintObject.state + " " + _tintObject.effectType);
    } // End of the function
    function showClouds()
    {
        if (cloudsEffect._currentFrame != 1)
        {
            return;
        } // end if
        cloudsEffect.gotoAndPlay("enter");
        trace ("[SHADOW] SHOW CLOUDS");
    } // End of the function
    function removeClouds()
    {
        trace ("[SHADOW] NEXT COLOR MODE: " + _wem.__get__nextColorMode().getMode());
        if (_wem.__get__nextShadowMode().getMode() == "A" && _wem.__get__nextColorMode().getMode() == "A" && cloudsEffect._currentFrame != 1)
        {
            cloudsEffect.gotoAndPlay("leave");
            trace ("[SHADOW] REMOVE CLOUDS");
        } // end if
    } // End of the function
    function playShadowEffect()
    {
        if (shadowEffect._currentFrame == 1)
        {
            shadowEffect.gotoAndPlay("enter");
        } // end if
        trace ("[SHADOW] START SHADOW EFFECT");
    } // End of the function
    function stopShadowEffect()
    {
        if (shadowEffect._currentFrame != 1)
        {
            shadowEffect.gotoAndPlay("leave");
        } // end if
        trace ("[SHADOW] STOP SHADOW EFFECT");
    } // End of the function
} // End of Class
