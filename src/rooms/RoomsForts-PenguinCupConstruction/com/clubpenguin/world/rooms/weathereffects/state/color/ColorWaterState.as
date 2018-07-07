class com.clubpenguin.world.rooms.weathereffects.state.color.ColorWaterState extends com.clubpenguin.world.rooms.weathereffects.state.color.ColorState implements com.clubpenguin.world.rooms.weathereffects.state.color.IColorState
{
    var _wem, _rainEffectGenerator, applyTinting, showClouds, removeClouds, waterEffect;
    function ColorWaterState(manager)
    {
        super(manager);
        _rainEffectGenerator = new com.clubpenguin.world.rooms.weathereffects.effect.RainEffectGenerator(_wem);
        this.setMovieClips();
    } // End of the function
    function toFireState()
    {
        this.resetState();
        _wem.__set__currentColorState(_wem.colorFireState);
        trace ("from WATER state to FIRE state");
    } // End of the function
    function toWaterState()
    {
        if (_wem.__get__currentColorMode().getMode() == _wem.__get__nextColorMode().getMode())
        {
            return;
        } // end if
        this.applyTinting(_wem.__get__nextColorMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_WATER);
        if (_wem.__get__currentColorMode().getMode() == "A")
        {
            this.showClouds();
        } // end if
        if (_wem.__get__nextColorMode().getMode() == "A")
        {
            this.removeClouds();
        } // end if
        if (_wem.__get__currentColorMode().getMode() == "C")
        {
            this.stopWaterEffect();
        } // end if
        if (_wem.__get__nextColorMode().getMode() == "C")
        {
            this.playWaterEffect();
        } // end if
        _wem.__set__currentColorMode(_wem.nextColorMode);
        trace ("MODE CHANGED TO: " + _wem.__get__nextColorMode());
        trace ("from WATER state to WATER state");
    } // End of the function
    function toSnowState()
    {
        this.resetState();
        _wem.__set__currentColorState(_wem.colorSnowState);
        trace ("from WATER state to SNOW state");
    } // End of the function
    function toTieState()
    {
        this.resetState();
        _wem.__set__currentColorState(_wem.colorTieState);
        trace ("from WATER state to TIE state");
    } // End of the function
    function toDefaultState()
    {
        if (_wem.__get__currentColorMode().getMode() == "C")
        {
            this.stopWaterEffect();
        } // end if
        if (_wem.__get__currentColorMode().getMode() != "A")
        {
            this.removeClouds();
        } // end if
        _wem.__set__currentColorState(_wem.colorDefaultState);
        trace ("from WATER state to DEFAULT state");
    } // End of the function
    function setMovieClips()
    {
        waterEffect = _wem.getBackogrundMC().weatherEffects_mc.waterEffect;
    } // End of the function
    function applyState()
    {
        this.applyTinting(_wem.__get__currentColorMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_WATER);
        if (_wem.__get__currentColorMode().getMode() == "B" || _wem.__get__currentColorMode().getMode() == "C")
        {
            this.showClouds();
        } // end if
        if (_wem.__get__currentColorMode().getMode() == "C")
        {
            this.playWaterEffect();
        } // end if
        trace ("APPLYING WATER STATE IN MODE " + _wem.__get__currentColorMode());
    } // End of the function
    function playWeatherEffect(effectType)
    {
        trace ("DO NOTHING");
    } // End of the function
    function resetState()
    {
        if (_wem.__get__currentColorMode().getMode() != "A" && _wem.__get__nextColorMode().getMode() == "A")
        {
            this.removeClouds();
        } // end if
        if (_wem.__get__currentColorMode().getMode() == "C")
        {
            this.stopWaterEffect();
        } // end if
    } // End of the function
    function playWaterEffect()
    {
        _rainEffectGenerator.startEffect();
        trace ("START WATER EFFECT");
    } // End of the function
    function stopWaterEffect()
    {
        _rainEffectGenerator.stopEffect();
        trace ("STOP WATER EFFECT");
    } // End of the function
} // End of Class
