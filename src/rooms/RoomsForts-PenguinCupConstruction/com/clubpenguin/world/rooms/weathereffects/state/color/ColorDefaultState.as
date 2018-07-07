class com.clubpenguin.world.rooms.weathereffects.state.color.ColorDefaultState extends com.clubpenguin.world.rooms.weathereffects.state.color.ColorState implements com.clubpenguin.world.rooms.weathereffects.state.color.IColorState
{
    var _wem, applyTinting;
    function ColorDefaultState(manager)
    {
        super(manager);
    } // End of the function
    function toFireState()
    {
        _wem.__set__currentColorState(_wem.colorFireState);
        trace ("from DEFAULT state to FIRE state");
    } // End of the function
    function toWaterState()
    {
        _wem.__set__currentColorState(_wem.colorWaterState);
        trace ("from DEFAULT state to WATER state");
    } // End of the function
    function toSnowState()
    {
        _wem.__set__currentColorState(_wem.colorSnowState);
        trace ("from DEFAULT state to SNOW state");
    } // End of the function
    function toTieState()
    {
        _wem.__set__currentColorState(_wem.colorTieState);
        trace ("from DEFAULT state to TIE state");
    } // End of the function
    function toDefaultState()
    {
        if (_wem.__get__currentColorMode().getMode() == _wem.__get__nextColorMode().getMode())
        {
            return;
        } // end if
        this.applyTinting(_wem.__get__nextColorMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_DEFAULT);
        _wem.__set__currentColorState(_wem.colorDefaultState);
        trace ("from DEFAULT state to DEFAULT state");
    } // End of the function
    function applyState()
    {
        this.applyTinting(_wem.__get__currentColorMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_DEFAULT);
        trace ("APPLYING DEFAULT STATE IN MODE " + _wem.__get__currentColorMode());
    } // End of the function
    function playWeatherEffect(effectType)
    {
        trace ("DO NOTHING");
    } // End of the function
} // End of Class
