class com.clubpenguin.world.rooms.weathereffects.state.color.ColorState
{
    var _wem, _tintObject, bgCloudsColor, bgDistantColor, bgSkyColor, cloudsEffectColor;
    function ColorState(manager)
    {
        _wem = manager;
        _tintObject = new Object();
        _tintObject.tintType = "color";
        this.setDefaultMovieClips();
    } // End of the function
    function tweenComplete(obj)
    {
    } // End of the function
    function setDefaultMovieClips()
    {
        var _loc2 = _wem.getBackogrundMC().weatherEffects_mc;
        bgCloudsColor = _loc2.bgClouds.bgCloudsShadow.bgCloudsColor;
        bgDistantColor = _loc2.bgDistant.bgDistantShadow.bgDistantColor;
        bgSkyColor = _loc2.bgSky.bgSkyShadow.bgSkyColor;
        cloudsEffectColor = _wem.getBackogrundMC().weatherEffects_mc.cloudsEffect.cloudsEffectColor;
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
    } // End of the function
    function applyTinting(mode, effectType)
    {
        this.setTintValues(mode, effectType);
        com.greensock.TweenLite.to(bgSkyColor, 2, {colorTransform: _tintObject.sky, onComplete: tweenComplete});
        com.greensock.TweenLite.to(bgDistantColor, 2, {colorTransform: _tintObject.distantObjects, onComplete: tweenComplete});
        com.greensock.TweenLite.to(bgCloudsColor, 2, {colorTransform: _tintObject.clouds, onComplete: tweenComplete});
        com.greensock.TweenLite.to(cloudsEffectColor, 2, {colorTransform: _tintObject.topCoulds, onComplete: tweenComplete});
        trace ("PLAYING WEATHER EFFECT: " + _tintObject.tintType + " " + _tintObject.state + " " + _tintObject.effectType);
    } // End of the function
    function showClouds()
    {
        if (cloudsEffectColor._currentFrame != 1)
        {
            return;
        } // end if
        cloudsEffectColor.gotoAndPlay("enter");
        trace ("SHOW CLOUDS");
    } // End of the function
    function removeClouds()
    {
        trace ("NEXT SHADOW MODE: " + _wem.__get__nextShadowMode().getMode());
        trace ("NEXT COLOR MODE: " + _wem.__get__nextColorMode().getMode());
        trace ("CLOUDS FRAME: " + cloudsEffectColor._currentFrame);
        if (_wem.__get__nextShadowMode().getMode() == "A" && _wem.__get__nextColorMode().getMode() == "A" && cloudsEffectColor._currentFrame != 1)
        {
            cloudsEffectColor.gotoAndPlay("leave");
            trace ("REMOVE CLOUDS");
        } // end if
    } // End of the function
} // End of Class
