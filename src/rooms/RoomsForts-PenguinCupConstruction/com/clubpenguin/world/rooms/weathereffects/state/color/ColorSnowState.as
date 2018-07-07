class com.clubpenguin.world.rooms.weathereffects.state.color.ColorSnowState extends com.clubpenguin.world.rooms.weathereffects.state.color.ColorState implements com.clubpenguin.world.rooms.weathereffects.state.color.IColorState
{
    var _wem, _snowEffectGenerator, applyTinting, showClouds, removeClouds, snowEffect;
    function ColorSnowState(manager)
    {
        super(manager);
        _snowEffectGenerator = new com.clubpenguin.world.rooms.weathereffects.effect.SnowEffectGenerator(_wem);
        this.setMovieClips();
    } // End of the function
    function toFireState()
    {
        this.resetState();
        _wem.__set__currentColorState(_wem.colorFireState);
        trace ("from SNOW state to FIRE state");
    } // End of the function
    function toWaterState()
    {
        this.resetState();
        _wem.__set__currentColorState(_wem.colorWaterState);
        trace ("from SNOW state to WATER state");
    } // End of the function
    function toSnowState()
    {
        if (_wem.__get__currentColorMode().getMode() == _wem.__get__nextColorMode().getMode())
        {
            return;
        } // end if
        this.applyTinting(_wem.__get__nextColorMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_SNOW);
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
            this.stopSnowEffect();
        } // end if
        if (_wem.__get__nextColorMode().getMode() == "C")
        {
            this.playSnowEffect();
        } // end if
        _wem.__set__currentColorMode(_wem.nextColorMode);
        trace ("MODE CHANGED TO: " + _wem.__get__nextColorMode());
        trace ("from SNOW state to SNOW state");
    } // End of the function
    function toTieState()
    {
        this.resetState();
        _wem.__set__currentColorState(_wem.colorTieState);
        trace ("from SNOW state to TIE state");
    } // End of the function
    function toDefaultState()
    {
        if (_wem.__get__currentColorMode().getMode() == "C")
        {
            this.stopSnowEffect();
        } // end if
        if (_wem.__get__currentColorMode().getMode() != "A")
        {
            this.removeClouds();
        } // end if
        _wem.__set__currentColorState(_wem.colorDefaultState);
        trace ("from SNOW state to DEFAULT state");
    } // End of the function
    function setMovieClips()
    {
        snowEffect = _wem.getBackogrundMC().weatherEffects_mc.snowEffect;
    } // End of the function
    function applyState()
    {
        this.applyTinting(_wem.__get__currentColorMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_SNOW);
        if (_wem.__get__currentColorMode().getMode() == "B" || _wem.__get__currentColorMode().getMode() == "C")
        {
            this.showClouds();
        } // end if
        if (_wem.__get__currentColorMode().getMode() == "C")
        {
            this.playSnowEffect();
        } // end if
        trace ("APPLYING SNOW STATE IN MODE " + _wem.__get__currentColorMode());
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
            this.stopSnowEffect();
        } // end if
    } // End of the function
    function playSnowEffect()
    {
        _snowEffectGenerator.startEffect();
        trace ("START SNOW EFFECT");
    } // End of the function
    function stopSnowEffect()
    {
        _snowEffectGenerator.stopEffect();
        trace ("STOP SNOW EFFECT");
    } // End of the function
} // End of Class
