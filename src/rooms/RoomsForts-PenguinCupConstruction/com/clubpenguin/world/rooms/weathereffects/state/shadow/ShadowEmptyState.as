class com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowEmptyState extends com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowState implements com.clubpenguin.world.rooms.weathereffects.state.shadow.IShadowState
{
    var _wem, applyTinting;
    function ShadowEmptyState(manager)
    {
        super(manager);
    } // End of the function
    function toFireState()
    {
        _wem.__set__currentShadowState(_wem.shadowFireState);
        trace ("[SHADOW] from EMPTY state to FIRE state");
    } // End of the function
    function toWaterState()
    {
        _wem.__set__currentShadowState(_wem.shadowWaterState);
        trace ("[SHADOW] from EMPTY state to WATER state");
    } // End of the function
    function toSnowState()
    {
        _wem.__set__currentShadowState(_wem.shadowSnowState);
        trace ("[SHADOW] from EMPTY state to SNOW state");
    } // End of the function
    function toTieState()
    {
        _wem.__set__currentShadowState(_wem.shadowTieState);
        trace ("[SHADOW] from EMPTY state to TIE state");
    } // End of the function
    function toDefaultState()
    {
        _wem.__set__currentShadowState(_wem.shadowDefaultState);
        trace ("[SHADOW] from EMPTY state to DEFAULT state");
    } // End of the function
    function toEmptyState()
    {
        if (_wem.__get__currentShadowMode().getMode() == _wem.__get__nextShadowMode().getMode())
        {
            return;
        } // end if
    } // End of the function
    function applyState()
    {
        this.applyTinting(_wem.__get__currentShadowMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_EMPTY);
        trace ("[SHADOW] APPLYING EMPTY STATE IN MODE " + _wem.__get__currentShadowMode());
    } // End of the function
} // End of Class
