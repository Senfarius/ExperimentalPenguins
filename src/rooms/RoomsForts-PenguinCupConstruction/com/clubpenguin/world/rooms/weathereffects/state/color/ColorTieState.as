class com.clubpenguin.world.rooms.weathereffects.state.color.ColorTieState extends com.clubpenguin.world.rooms.weathereffects.state.color.ColorState implements com.clubpenguin.world.rooms.weathereffects.state.color.IColorState
{
    var _wem, _fireEffectGenerator, _rainEffectGenerator, _snowEffectGenerator, applyTinting, showClouds, removeClouds, lightningEffect, tieEffect, fireEffect, waterEffect, snowEffect;
    function ColorTieState(manager)
    {
        super(manager);
        _fireEffectGenerator = new com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator(_wem);
        _rainEffectGenerator = new com.clubpenguin.world.rooms.weathereffects.effect.RainEffectGenerator(_wem);
        _snowEffectGenerator = new com.clubpenguin.world.rooms.weathereffects.effect.SnowEffectGenerator(_wem);
        this.setMovieClips();
    } // End of the function
    function toFireState()
    {
        this.resetState();
        _wem.__set__currentColorState(_wem.colorFireState);
        trace ("from TIE state to FIRE state");
    } // End of the function
    function toWaterState()
    {
        this.resetState();
        _wem.__set__currentColorState(_wem.colorWaterState);
        trace ("from TIE state to WATER state");
    } // End of the function
    function toSnowState()
    {
        this.resetState();
        _wem.__set__currentColorState(_wem.colorSnowState);
        trace ("from TIE state to SNOW state");
    } // End of the function
    function toTieState()
    {
        if (_wem.__get__currentColorMode().getMode() == _wem.__get__nextColorMode().getMode())
        {
            return;
        } // end if
        this.applyTinting(_wem.__get__nextColorMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_TIE);
        if (_wem.__get__currentColorMode().getMode() == "A")
        {
            this.showClouds();
            this.showLightningEffect();
        } // end if
        if (_wem.__get__nextColorMode().getMode() == "A")
        {
            this.removeClouds();
            this.hideLightningEffect();
        } // end if
        if (_wem.__get__currentColorMode().getMode() == "C" || _wem.__get__nextColorMode().getMode() != "C")
        {
            this.stopTieEffect();
        } // end if
        if (_wem.__get__nextColorMode().getMode() == "C")
        {
            this.playTieEffect();
        } // end if
        _wem.__set__currentColorMode(_wem.nextColorMode);
        trace ("MODE CHANGED TO: " + _wem.__get__nextColorMode());
        trace ("from TIE state to TIE state");
    } // End of the function
    function toDefaultState()
    {
        this.resetState();
        _wem.__set__currentColorState(_wem.colorDefaultState);
        trace ("from TIE state to DEFAULT state");
    } // End of the function
    function setMovieClips()
    {
        lightningEffect = _wem.getBackogrundMC().weatherEffects_mc.lightningEffect;
        tieEffect = _wem.getBackogrundMC().weatherEffects_mc.tieEffect;
        fireEffect = _wem.getBackogrundMC().weatherEffects_mc.fireEffect;
        waterEffect = _wem.getBackogrundMC().weatherEffects_mc.waterEffect;
        snowEffect = _wem.getBackogrundMC().weatherEffects_mc.snowEffect;
    } // End of the function
    function applyState()
    {
        this.applyTinting(_wem.__get__currentColorMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_TIE);
        if (_wem.__get__currentColorMode().getMode() == "A")
        {
            this.showTieCloudsEffect();
        } // end if
        if (_wem.__get__currentColorMode().getMode() == "B" || _wem.__get__currentColorMode().getMode() == "C")
        {
            this.showTieCloudsEffect();
            this.showLightningEffect();
            this.showClouds();
        } // end if
        if (_wem.__get__currentColorMode().getMode() == "C")
        {
            this.playTieEffect();
        } // end if
        trace ("APPLYING SNOW STATE IN MODE " + _wem.__get__currentColorMode());
    } // End of the function
    function playWeatherEffect(effectType)
    {
        if (_wem.__get__currentColorMode().getMode() != "C")
        {
            return;
        } // end if
        _fireEffectGenerator.stopEffect();
        _rainEffectGenerator.stopEffect();
        _snowEffectGenerator.stopEffect();
        switch (effectType)
        {
            case "fire":
            {
                _fireEffectGenerator.startEffect();
                break;
            } 
            case "water":
            {
                _rainEffectGenerator.startEffect();
                break;
            } 
            case "snow":
            {
                _snowEffectGenerator.startEffect();
                break;
            } 
        } // End of switch
    } // End of the function
    function resetState()
    {
        this.removeTieCloudsEffect();
        if (_wem.__get__currentColorMode().getMode() != "A" && _wem.__get__nextColorMode().getMode() == "A")
        {
            this.removeClouds();
        } // end if
        if (_wem.__get__currentColorMode().getMode() == "C")
        {
            this.stopTieEffect();
        } // end if
    } // End of the function
    function playTieEffect()
    {
        _fireEffectGenerator.startEffect();
        trace ("START TIE EFFECT");
        var _loc2 = new com.clubpenguin.world.rooms.weathereffects.effect.SnowEffectGenerator(_wem, 10, 100);
    } // End of the function
    function stopTieEffect()
    {
        _fireEffectGenerator.stopEffect();
        _rainEffectGenerator.stopEffect();
        _snowEffectGenerator.stopEffect();
        trace ("STOP TIE EFFECT");
    } // End of the function
    function showLightningEffect()
    {
        lightningEffect.gotoAndPlay("on");
        trace ("START LIGHTNING EFFECT");
    } // End of the function
    function hideLightningEffect()
    {
        lightningEffect.gotoAndStop("hide");
        trace ("HID LIGHTNING EFFECT");
    } // End of the function
    function stopLightningEffect()
    {
        lightningEffect.gotoAndStop("off");
        trace ("STOP LIGHTNING EFFECT");
    } // End of the function
    function showTieCloudsEffect()
    {
        this.hideLightningEffect();
        tieEffect.gotoAndPlay("enter");
        trace ("START TIE CLOUDS EFFECT");
    } // End of the function
    function removeTieCloudsEffect()
    {
        this.stopLightningEffect();
        tieEffect.gotoAndPlay("leave");
        trace ("STOP TIE CLOUDS EFFECT");
    } // End of the function
} // End of Class
