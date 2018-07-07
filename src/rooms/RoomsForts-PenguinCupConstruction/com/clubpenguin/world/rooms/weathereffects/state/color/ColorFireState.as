class com.clubpenguin.world.rooms.weathereffects.state.color.ColorFireState extends com.clubpenguin.world.rooms.weathereffects.state.color.ColorState implements com.clubpenguin.world.rooms.weathereffects.state.color.IColorState
{
    var _wem, _fireEffectGenerator, applyTinting, showClouds, removeClouds, fireEffect;
    function ColorFireState(manager)
    {
        super(manager);
        _fireEffectGenerator = new com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator(_wem);
        this.setMovieClips();
    } // End of the function
    function tweenComplete(obj)
    {
    } // End of the function
    function toFireState()
    {
        if (_wem.__get__currentColorMode().getMode() == _wem.__get__nextColorMode().getMode())
        {
            return;
        } // end if
        this.applyTinting(_wem.__get__nextColorMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_FIRE);
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
            this.stopFireEffect();
        } // end if
        if (_wem.__get__nextColorMode().getMode() == "C")
        {
            this.playFireEffect();
        } // end if
        _wem.__set__currentColorMode(_wem.nextColorMode);
        trace ("MODE CHANGED TO: " + _wem.__get__nextColorMode().getMode());
        trace ("from FIRE state to FIRE state");
    } // End of the function
    function toWaterState()
    {
        this.resetState();
        _wem.__set__currentColorState(_wem.colorWaterState);
        trace ("from FIRE state to WATER state");
    } // End of the function
    function toSnowState()
    {
        this.resetState();
        _wem.__set__currentColorState(_wem.colorSnowState);
        trace ("from FIRE state to SNOW state");
    } // End of the function
    function toTieState()
    {
        this.resetState();
        _wem.__set__currentColorState(_wem.colorTieState);
        trace ("from FIRE state to TIE state");
    } // End of the function
    function toDefaultState()
    {
        if (_wem.__get__currentColorMode().getMode() == "C")
        {
            this.stopFireEffect();
        } // end if
        if (_wem.__get__currentColorMode().getMode() != "A")
        {
            this.removeClouds();
        } // end if
        _wem.__set__currentColorState(_wem.colorDefaultState);
        trace ("from FIRE state to DEFAULT state");
    } // End of the function
    function setMovieClips()
    {
        fireEffect = _wem.getBackogrundMC().weatherEffects_mc.fireEffect;
    } // End of the function
    function applyState()
    {
        this.applyTinting(_wem.__get__currentColorMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_FIRE);
        if (_wem.__get__currentColorMode().getMode() == "B" || _wem.__get__currentColorMode().getMode() == "C")
        {
            this.showClouds();
        } // end if
        if (_wem.__get__currentColorMode().getMode() == "C")
        {
            this.playFireEffect();
        } // end if
        trace ("APPLYING FIRE STATE IN MODE " + _wem.__get__currentColorMode());
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
            this.stopFireEffect();
        } // end if
    } // End of the function
    function playFireEffect()
    {
        _fireEffectGenerator.startEffect();
        trace ("START FIRE EFFECT");
    } // End of the function
    function stopFireEffect()
    {
        _fireEffectGenerator.stopEffect();
        fireEffect.gotoAndStop("off");
        trace ("STOP FIRE EFFECT");
    } // End of the function
} // End of Class
