class com.clubpenguin.world.rooms.weathereffects.effect.RainEffectGenerator
{
    var _wem, _elementHolder;
    function RainEffectGenerator(wem)
    {
        trace (com.clubpenguin.world.rooms.weathereffects.effect.RainEffectGenerator.CLASS_NAME + "Instatiated");
        _wem = wem;
        _maxHeight = wem.rainAnimationHeight;
        _elementSpeed = wem.rainAnimationSpeed;
        _elementAmount = wem.rainAmount;
        _elementShrinkSize = wem.rainShrinkSize;
        _elementDelayTime = wem.rainDelayTime;
        _elementRotation = wem.rainRotation;
        this.setMovieClips();
    } // End of the function
    function setMovieClips()
    {
        _elementHolder = _wem.getBackogrundMC().weatherEffects_mc.waterEffect;
    } // End of the function
    function startEffect()
    {
        if (_running)
        {
            return;
        } // end if
        trace (com.clubpenguin.world.rooms.weathereffects.effect.RainEffectGenerator.CLASS_NAME + ": startEffect()");
        _running = true;
        for (var _loc2 = 0; _loc2 < _elementAmount; ++_loc2)
        {
            this.setupElement(_loc2);
        } // end of for
    } // End of the function
    function stopEffect()
    {
        trace (com.clubpenguin.world.rooms.weathereffects.effect.RainEffectGenerator.CLASS_NAME + ": stopEffect()");
        _running = false;
    } // End of the function
    function setupElement(index)
    {
        var _loc2 = _elementHolder.attachMovie(_elementArtMc, "r" + index, index + 200);
        _loc2.index = index;
        this.beginEffect(_loc2, this);
    } // End of the function
    function beginEffect(me, effect)
    {
        if (!effect._running)
        {
            me.removeMovieClip();
            return;
        } // end if
        var _loc4 = effect._elementSpeed;
        var _loc5 = Math.random() * effect._elementDelayTime;
        me._y = 0;
        me._x = int(Math.random() * effect._maxWidth);
        me._rotation = effect._elementRotation;
        me._alpha = 100;
        me._yscale = 100;
        me._xscale = 100;
        var _loc3 = new Array();
        _loc3.push(me);
        _loc3.push(effect);
        com.greensock.TweenMax.to(me, _loc4, {_y: effect._maxHeight, _x: me._x + effect._maxHeight / 2, _yscale: effect._elementShrinkSize, _xscale: effect._elementShrinkSize, delay: _loc5, ease: com.greensock.easing.Linear.easeOut, onComplete: effect.beginEffect, onCompleteParams: _loc3});
    } // End of the function
    static var CLASS_NAME = "[RainEffectGenerator] ";
    var _elementArtMc = "WeatherFX_01_Water_Sprite";
    var _maxWidth = Stage.width;
    var _maxHeight = 85;
    var _running = false;
    var _elementSpeed = 0.500000;
    var _elementAmount = 25;
    var _elementShrinkSize = 25;
    var _elementDelayTime = 2;
    var _elementRotation = -26;
} // End of Class
