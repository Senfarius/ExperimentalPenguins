class com.clubpenguin.world.rooms.weathereffects.effect.SnowEffectGenerator
{
    var _wem, _elementHolder;
    function SnowEffectGenerator(wem)
    {
        trace (com.clubpenguin.world.rooms.weathereffects.effect.SnowEffectGenerator.CLASS_NAME + "Instatiated");
        _wem = wem;
        _maxHeight = wem.snowAnimationHeight;
        _elementSpeed = wem.snowAnimationSpeed;
        _elementAmount = wem.snowAmount;
        _elementShrinkSize = wem.snowShrinkSize;
        _delayTime = wem.snowDelayTime;
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
        trace (com.clubpenguin.world.rooms.weathereffects.effect.SnowEffectGenerator.CLASS_NAME + ": startEffect()");
        _running = true;
        for (var _loc2 = 0; _loc2 < _elementAmount; ++_loc2)
        {
            this.setupElement(_loc2);
        } // end of for
    } // End of the function
    function stopEffect()
    {
        trace (com.clubpenguin.world.rooms.weathereffects.effect.SnowEffectGenerator.CLASS_NAME + ": stopEffect()");
        _running = false;
    } // End of the function
    function setupElement(index)
    {
        var _loc2 = _elementHolder.attachMovie(_elementArtMc, "s" + index, index + 300);
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
        effect._running = true;
        var _loc5 = effect._elementSpeed;
        var _loc4 = Math.random() * effect._delayTime;
        me._y = -5;
        me._x = int(Math.random() * effect._maxWidth);
        me._alpha = 100;
        me._yscale = 100;
        me._xscale = 100;
        var _loc3 = new Array();
        _loc3.push(me);
        _loc3.push(effect);
        com.greensock.TweenMax.to(me, _loc5, {_y: effect._maxHeight, _x: me._x + effect._maxHeight / 2, _yscale: effect._elementShrinkSize, _xscale: effect._elementShrinkSize, delay: _loc4, ease: com.greensock.easing.Linear.easeOut, onComplete: effect.beginEffect, onCompleteParams: _loc3});
    } // End of the function
    static var CLASS_NAME = "[SnowEffectGenerator] ";
    var _elementArtMc = "WeatherFX_02_Snow_Sprite";
    var _maxWidth = Stage.width;
    var _maxHeight = 85;
    var _running = false;
    var _elementSpeed = 1;
    var _elementAmount = 25;
    var _elementShrinkSize = 50;
    var _delayTime = 2;
} // End of Class
