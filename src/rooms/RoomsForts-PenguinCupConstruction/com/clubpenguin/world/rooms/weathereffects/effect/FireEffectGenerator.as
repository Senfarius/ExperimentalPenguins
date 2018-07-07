class com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator
{
    var _wem, _elementHolder;
    static var _tweenObjects;
    function FireEffectGenerator(wem)
    {
        trace (com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator.CLASS_NAME + "Instatiated");
        _wem = wem;
        _maxHeight = _wem.fireAnimationHeight;
        _elementAmount = _wem.fireAmount;
        _delayTime = _wem.fireDelayTime;
        _tweenObjects = [];
        this.setMovieClips();
    } // End of the function
    function setMovieClips()
    {
        _elementHolder = _wem.getBackogrundMC().weatherEffects_mc.fireEffect;
    } // End of the function
    function startEffect()
    {
        if (_running)
        {
            return;
        } // end if
        trace (com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator.CLASS_NAME + ": startEffect()");
        _running = true;
        for (var _loc2 = 0; _loc2 < _elementAmount; ++_loc2)
        {
            this.setupElement(_loc2);
        } // end of for
    } // End of the function
    function stopEffect()
    {
        trace (com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator.CLASS_NAME + ": stopEffect()");
        _running = false;
        for (var _loc2 = 0; _loc2 < _elementAmount; ++_loc2)
        {
            com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator._tweenObjects[_loc2].repeat = 0;
        } // end of for
    } // End of the function
    function setupElement(index)
    {
        trace (com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator.CLASS_NAME + ": setupElement()");
        var _loc2 = _elementHolder.attachMovie(_elementArtMc, "f" + index, index + 100);
        _loc2.gotoAndStop(1);
        _loc2.index = index;
        var _loc6 = Math.random() * com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator._delayTime;
        var _loc4 = new Array();
        _loc4.push(_loc2);
        _loc4.push(this);
        com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator._tweenObjects[index] = new com.greensock.TweenMax(_loc2, 0, {delay: _loc6, onComplete: beginEffect, onCompleteParams: _loc4});
        com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator._tweenObjects[index].play();
    } // End of the function
    function beginEffect(me, effect)
    {
        if (!effect._running)
        {
            me.removeMovieClip();
            return;
        } // end if
        me.play();
    } // End of the function
    static function onAnimDone(mc)
    {
        mc.gotoAndStop(1);
        var _loc2 = Math.random() * com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator._delayTime;
        mc._y = int(Math.random() * com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator._maxHeight);
        mc._x = 0;
        com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator._tweenObjects[mc.index].delay = _loc2;
        com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator._tweenObjects[mc.index].restart(true, false);
    } // End of the function
    static var CLASS_NAME = "[FireEffectGenerator] ";
    var _elementArtMc = "WeatherFX_03_Fire_Sprite";
    var _maxWidth = Stage.width;
    static var _maxHeight = 55;
    var _running = false;
    var _elementAmount = 3;
    static var _delayTime = 2;
} // End of Class
