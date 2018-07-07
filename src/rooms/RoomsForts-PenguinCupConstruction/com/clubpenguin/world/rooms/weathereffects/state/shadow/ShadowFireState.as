class com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowFireState extends com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowState implements com.clubpenguin.world.rooms.weathereffects.state.shadow.IShadowState
{
    var _wem, applyTinting, showClouds, removeClouds, stopShadowEffect, playShadowEffect;
    function ShadowFireState(manager)
    {
        super(manager);
    } // End of the function
    function tweenComplete(obj)
    {
        trace ("[SHADOW] TWEEN COMPLETED!");
    } // End of the function
    function toFireState()
    {
        if (_wem.__get__currentShadowMode().getMode() == _wem.__get__nextShadowMode().getMode())
        {
            return;
        } // end if
        this.applyTinting(_wem.__get__nextShadowMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_FIRE);
        if (_wem.__get__currentShadowMode().getMode() == "A")
        {
            this.showClouds();
        } // end if
        if (_wem.__get__nextShadowMode().getMode() == "A")
        {
            this.removeClouds();
        } // end if
        if (_wem.__get__currentShadowMode().getMode() == "C")
        {
            this.stopShadowEffect();
        } // end if
        if (_wem.__get__nextShadowMode().getMode() == "C")
        {
            this.playShadowEffect();
        } // end if
        _wem.__set__currentShadowMode(_wem.nextShadowMode);
        trace ("[SHADOW] MODE CHANGED TO: " + _wem.__get__nextShadowMode().getMode());
        trace ("[SHADOW] from FIRE state to FIRE state");
    } // End of the function
    function toWaterState()
    {
        this.resetState();
        _wem.__set__currentShadowState(_wem.shadowWaterState);
        trace ("[SHADOW] from FIRE state to WATER state");
    } // End of the function
    function toSnowState()
    {
        this.resetState();
        _wem.__set__currentShadowState(_wem.shadowSnowState);
        trace ("[SHADOW] from FIRE state to SNOW state");
    } // End of the function
    function toTieState()
    {
        this.resetState();
        _wem.__set__currentShadowState(_wem.shadowTieState);
        trace ("[SHADOW] from FIRE state to TIE state");
    } // End of the function
    function toDefaultState()
    {
        this.resetState();
        _wem.__set__currentShadowState(_wem.shadowDefaultState);
        trace ("[SHADOW] from FIRE state to DEFAULT state");
    } // End of the function
    function toEmptyState()
    {
        this.resetState();
        _wem.__set__currentShadowState(_wem.shadowEmptyState);
        trace ("[SHADOW] from FIRE state to EMPTY state");
    } // End of the function
    function applyState()
    {
        this.applyTinting(_wem.__get__currentShadowMode().getMode(), com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_FIRE);
        if (_wem.__get__currentShadowMode().getMode() == "B" || _wem.__get__currentShadowMode().getMode() == "C")
        {
            this.showClouds();
        } // end if
        if (_wem.__get__currentShadowMode().getMode() == "C")
        {
            this.playShadowEffect();
        } // end if
        if (_wem.__get__currentShadowMode().getMode() == "A")
        {
            this.removeClouds();
        } // end if
        trace ("[SHADOW] APPLYING FIRE STATE IN MODE " + _wem.__get__currentShadowMode());
    } // End of the function
    function resetState()
    {
        if (_wem.__get__currentShadowMode().getMode() != "A" && _wem.__get__nextShadowMode().getMode() == "A")
        {
            this.removeClouds();
        } // end if
        if (_wem.__get__currentShadowMode().getMode() == "C" && _wem.__get__nextShadowMode().getMode() != "C")
        {
            this.stopShadowEffect();
        } // end if
    } // End of the function
} // End of Class
