class com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager
{
    var background_mc, __get__checkInterval, _currentColorState, _colorFireState, _colorWaterState, _colorSnowState, _colorTieState, _colorDefaultState, _currentColorMode, __get__currentColorMode, _nextColorMode, _colorModeA, _colorModeB, _colorModeC, _currentShadowState, _shadowFireState, _shadowWaterState, _shadowSnowState, _shadowTieState, _shadowDefaultState, _shadowEmptyState, _currentShadowMode, __get__currentShadowMode, _nextShadowMode, _shadowModeA, _shadowModeB, _shadowModeC, __get__currentColorState, __get__currentShadowState, __set__checkInterval, __get__colorDefaultState, __get__colorFireState, __get__colorModeA, __get__colorModeB, __get__colorModeC, __get__colorSnowState, __get__colorTieState, __get__colorWaterState, __set__currentColorMode, __set__currentColorState, __set__currentShadowMode, __set__currentShadowState, __get__fireAmount, __get__fireAnimationHeight, __get__fireAnimationSpeed, __get__fireDelayTime, __get__fireShrinkSize, __get__nextColorMode, __get__nextShadowMode, __get__rainAmount, __get__rainAnimationHeight, __get__rainAnimationSpeed, __get__rainDelayTime, __get__rainFadeAmount, __get__rainRotation, __get__rainShrinkSize, __get__shadowDefaultState, __get__shadowEmptyState, __get__shadowFireState, __get__shadowModeA, __get__shadowModeB, __get__shadowModeC, __get__shadowSnowState, __get__shadowTieState, __get__shadowWaterState, __get__snowAmount, __get__snowAnimationHeight, __get__snowAnimationSpeed, __get__snowDelayTime, __get__snowFadeAmount, __get__snowShrinkSize;
    function WeatherEffectsManager(shell, background)
    {
        trace ("WeatherEffectsManager()");
        SHELL = shell;
        background_mc = background;
        com.greensock.plugins.TweenPlugin.activate([com.greensock.plugins.ColorTransformPlugin]);
        this.setDefaultTintValues(2, com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_DEFAULT);
    } // End of the function
    function getDancingFirePlayers()
    {
        return (_dancingFirePlayers);
    } // End of the function
    function getDancingWaterPlayers()
    {
        return (_dancingWaterPlayers);
    } // End of the function
    function getDancingSnowPlayers()
    {
        return (_dancingSnowPlayers);
    } // End of the function
    function getDancingShadowPlayers()
    {
        return (_dancingShadowPlayers);
    } // End of the function
    function set checkInterval(interval)
    {
        _checkInterval = interval;
        //return (this.checkInterval());
        null;
    } // End of the function
    function get fireAnimationHeight()
    {
        return (_fireAnimationHeight);
    } // End of the function
    function get fireAnimationSpeed()
    {
        return (_fireAnimationSpeed);
    } // End of the function
    function get fireAmount()
    {
        return (_fireAmount);
    } // End of the function
    function get fireShrinkSize()
    {
        return (_fireShrinkSize);
    } // End of the function
    function get fireDelayTime()
    {
        return (_fireDelayTime);
    } // End of the function
    function get rainAnimationHeight()
    {
        return (_rainAnimationHeight);
    } // End of the function
    function get rainAnimationSpeed()
    {
        return (_rainAnimationSpeed);
    } // End of the function
    function get rainAmount()
    {
        return (_rainAmount);
    } // End of the function
    function get rainShrinkSize()
    {
        return (_rainShrinkSize);
    } // End of the function
    function get rainFadeAmount()
    {
        return (_rainFadeAmount);
    } // End of the function
    function get rainDelayTime()
    {
        return (_rainDelayTime);
    } // End of the function
    function get rainRotation()
    {
        return (_rainRotation);
    } // End of the function
    function get snowAnimationHeight()
    {
        return (_snowAnimationHeight);
    } // End of the function
    function get snowAnimationSpeed()
    {
        return (_snowAnimationSpeed);
    } // End of the function
    function get snowAmount()
    {
        return (_snowAmount);
    } // End of the function
    function get snowShrinkSize()
    {
        return (_snowShrinkSize);
    } // End of the function
    function get snowFadeAmount()
    {
        return (_snowFadeAmount);
    } // End of the function
    function get snowDelayTime()
    {
        return (_snowDelayTime);
    } // End of the function
    function get currentColorState()
    {
        return (_currentColorState);
    } // End of the function
    function get colorFireState()
    {
        return (_colorFireState);
    } // End of the function
    function get colorWaterState()
    {
        return (_colorWaterState);
    } // End of the function
    function get colorSnowState()
    {
        return (_colorSnowState);
    } // End of the function
    function get colorTieState()
    {
        return (_colorTieState);
    } // End of the function
    function get colorDefaultState()
    {
        return (_colorDefaultState);
    } // End of the function
    function get currentColorMode()
    {
        return (_currentColorMode);
    } // End of the function
    function set currentColorMode(mode)
    {
        _currentColorMode = mode;
        //return (this.currentColorMode());
        null;
    } // End of the function
    function get nextColorMode()
    {
        return (_nextColorMode);
    } // End of the function
    function get colorModeA()
    {
        return (_colorModeA);
    } // End of the function
    function get colorModeB()
    {
        return (_colorModeB);
    } // End of the function
    function get colorModeC()
    {
        return (_colorModeC);
    } // End of the function
    function get currentShadowState()
    {
        return (_currentShadowState);
    } // End of the function
    function get shadowFireState()
    {
        return (_shadowFireState);
    } // End of the function
    function get shadowWaterState()
    {
        return (_shadowWaterState);
    } // End of the function
    function get shadowSnowState()
    {
        return (_shadowSnowState);
    } // End of the function
    function get shadowTieState()
    {
        return (_shadowTieState);
    } // End of the function
    function get shadowDefaultState()
    {
        return (_shadowDefaultState);
    } // End of the function
    function get shadowEmptyState()
    {
        return (_shadowEmptyState);
    } // End of the function
    function get currentShadowMode()
    {
        return (_currentShadowMode);
    } // End of the function
    function set currentShadowMode(mode)
    {
        _currentShadowMode = mode;
        //return (this.currentShadowMode());
        null;
    } // End of the function
    function get nextShadowMode()
    {
        return (_nextShadowMode);
    } // End of the function
    function get shadowModeA()
    {
        return (_shadowModeA);
    } // End of the function
    function get shadowModeB()
    {
        return (_shadowModeB);
    } // End of the function
    function get shadowModeC()
    {
        return (_shadowModeC);
    } // End of the function
    function startWeatherEffectCheck()
    {
        trace ("WeatherEffectsManager: startWeatherEffectCheck()");
        this.initStates();
        _intervalId = setInterval(com.clubpenguin.util.Delegate.create(this, checkOutfitandSpecialDance), _checkInterval);
    } // End of the function
    function stopWeatherEffectCheck()
    {
        clearInterval(_intervalId);
        _intervalId = -1;
    } // End of the function
    function initialize(fireAnimationHeight, fireAnimationSpeed, fireAmount, fireDelayTime, rainAnimationHeight, rainAmount, rainShrinkSize, rainFadeAmount, rainDelayTime, rainRotation, snowAnimationHeight, snowAmount, snowShrinkSize, snowFadeAmount, snowDelayTime)
    {
        this.setupFireAnimationHeight(fireAnimationHeight);
        this.setupFireAnimationSpeed(fireAnimationSpeed);
        this.setupFireAmount(fireAmount);
        this.setupFireDelayTime(fireDelayTime);
        this.setupRainAnimationHeight(rainAnimationHeight);
        this.setupRainAmount(rainAmount);
        this.setupRainShrinkSize(rainShrinkSize);
        this.setupRainFadeAmount(rainFadeAmount);
        this.setupRainDelayTime(rainDelayTime);
        this.setupRainRotation(rainRotation);
        this.setupSnowAnimationHeight(snowAnimationHeight);
        this.setupSnowAmount(snowAmount);
        this.setupSnowShrinkSize(snowShrinkSize);
        this.setupSnowFadeAmount(snowFadeAmount);
        this.setupSnowDelayTime(snowDelayTime);
    } // End of the function
    function setupIntervalCheck(interval)
    {
        _checkInterval = interval;
    } // End of the function
    function setupFireAnimationHeight(height)
    {
        _fireAnimationHeight = height;
    } // End of the function
    function setupFireAnimationSpeed(speed)
    {
        _fireAnimationSpeed = speed;
    } // End of the function
    function setupFireAmount(amount)
    {
        _fireAmount = amount;
    } // End of the function
    function setupFireDelayTime(delay)
    {
        _fireDelayTime = delay;
    } // End of the function
    function setupRainAnimationHeight(height)
    {
        _rainAnimationHeight = height;
    } // End of the function
    function setupRainAnimationSpeed(speed)
    {
        _rainAnimationSpeed = speed;
    } // End of the function
    function setupRainAmount(amount)
    {
        _rainAmount = amount;
    } // End of the function
    function setupRainShrinkSize(shrinkSize)
    {
        _rainShrinkSize = shrinkSize;
    } // End of the function
    function setupRainFadeAmount(rainFadeAmount)
    {
        _rainFadeAmount = rainFadeAmount;
    } // End of the function
    function setupRainDelayTime(delay)
    {
        _rainDelayTime = delay;
    } // End of the function
    function setupRainRotation(rotation)
    {
        _rainRotation = rotation;
    } // End of the function
    function setupSnowAnimationHeight(height)
    {
        _snowAnimationHeight = height;
    } // End of the function
    function setupSnowAnimationSpeed(speed)
    {
        _snowAnimationSpeed = speed;
    } // End of the function
    function setupSnowAmount(amount)
    {
        _snowAmount = amount;
    } // End of the function
    function setupSnowShrinkSize(shrinkSize)
    {
        _snowShrinkSize = shrinkSize;
    } // End of the function
    function getBackogrundMC()
    {
        return (background_mc);
    } // End of the function
    function setupSnowFadeAmount(snowFadeAmount)
    {
        _snowFadeAmount = snowFadeAmount;
    } // End of the function
    function setupSnowDelayTime(snowDelayTime)
    {
        _snowDelayTime = snowDelayTime;
    } // End of the function
    function playWeatherEffect(effectType)
    {
        _currentColorState.playWeatherEffect(effectType);
    } // End of the function
    function set currentColorState(state)
    {
        _currentColorState = state;
        _currentColorMode = _nextColorMode;
        _currentColorState.applyState();
        //return (this.currentColorState());
        null;
    } // End of the function
    function initStates()
    {
        _colorFireState = new com.clubpenguin.world.rooms.weathereffects.state.color.ColorFireState(this);
        _colorWaterState = new com.clubpenguin.world.rooms.weathereffects.state.color.ColorWaterState(this);
        _colorSnowState = new com.clubpenguin.world.rooms.weathereffects.state.color.ColorSnowState(this);
        _colorTieState = new com.clubpenguin.world.rooms.weathereffects.state.color.ColorTieState(this);
        _colorDefaultState = new com.clubpenguin.world.rooms.weathereffects.state.color.ColorDefaultState(this);
        _colorModeA = new com.clubpenguin.world.rooms.weathereffects.state.mode.ModeA();
        _colorModeB = new com.clubpenguin.world.rooms.weathereffects.state.mode.ModeB();
        _colorModeC = new com.clubpenguin.world.rooms.weathereffects.state.mode.ModeC();
        _currentColorMode = _nextColorMode = _colorModeA;
        _currentColorState = _colorDefaultState;
        _shadowFireState = new com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowFireState(this);
        _shadowWaterState = new com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowWaterState(this);
        _shadowSnowState = new com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowSnowState(this);
        _shadowTieState = new com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowTieState(this);
        _shadowDefaultState = new com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowDefaultState(this);
        _shadowEmptyState = new com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowEmptyState(this);
        _shadowModeA = new com.clubpenguin.world.rooms.weathereffects.state.mode.ModeA();
        _shadowModeB = new com.clubpenguin.world.rooms.weathereffects.state.mode.ModeB();
        _shadowModeC = new com.clubpenguin.world.rooms.weathereffects.state.mode.ModeC();
        _currentShadowMode = _nextShadowMode = _shadowModeA;
        _currentShadowState = _shadowEmptyState;
    } // End of the function
    function determineColorMode(numberOfUsers)
    {
        if (numberOfUsers <= 2)
        {
            return (_colorModeA);
        } // end if
        if (numberOfUsers == 3)
        {
            return (_colorModeB);
        } // end if
        if (numberOfUsers >= 4)
        {
            return (_colorModeC);
        } // end if
        return (_colorModeA);
    } // End of the function
    function set currentShadowState(state)
    {
        _currentShadowState = state;
        _currentShadowMode = _nextShadowMode;
        _currentShadowState.applyState();
        //return (this.currentShadowState());
        null;
    } // End of the function
    function determineShadowMode(numberOfUsers)
    {
        if (numberOfUsers <= 2)
        {
            return (_shadowModeA);
        } // end if
        if (numberOfUsers == 3)
        {
            return (_shadowModeB);
        } // end if
        if (numberOfUsers >= 4)
        {
            return (_shadowModeC);
        } // end if
        return (_shadowModeA);
    } // End of the function
    function determineShadowState()
    {
        switch (_currentColorState)
        {
            case _colorFireState:
            {
                _currentShadowState.toFireState();
                break;
            } 
            case _colorWaterState:
            {
                _currentShadowState.toWaterState();
                break;
            } 
            case _colorSnowState:
            {
                _currentShadowState.toSnowState();
                break;
            } 
            case _colorTieState:
            {
                _currentShadowState.toTieState();
                break;
            } 
            case _colorDefaultState:
            {
                _currentShadowState.toDefaultState();
                break;
            } 
        } // End of switch
    } // End of the function
    function checkOutfitandSpecialDance()
    {
        _dancingFirePlayers = 0;
        _dancingWaterPlayers = 0;
        _dancingSnowPlayers = 0;
        _dancingShadowPlayers = 0;
        for (var _loc3 = 0; _loc3 < SHELL.getPlayerList().length; ++_loc3)
        {
            var _loc2 = SHELL.getPlayerList()[_loc3];
            if (this.isWearingFireOutfit(_loc2) && this.isDoingSpecialDance(_loc2))
            {
                ++_dancingFirePlayers;
            } // end if
            if (this.isWearingWaterOutfit(_loc2) && this.isDoingSpecialDance(_loc2))
            {
                ++_dancingWaterPlayers;
            } // end if
            if (this.isWearingSnowOutfit(_loc2) && this.isDoingSpecialDance(_loc2))
            {
                ++_dancingSnowPlayers;
            } // end if
            if (this.isWearingShadowOutfit(_loc2) && this.isDoingSpecialDance(_loc2))
            {
                ++_dancingShadowPlayers;
            } // end if
        } // end of for
        if (SHELL.getPlayerList().length < 2)
        {
            this.resetToDefaultValues();
            _nextShadowMode = this.determineShadowMode(_dancingShadowPlayers);
            _currentShadowState.toEmptyState();
            return;
        } // end if
        this.determinePlayableWeatherEffects();
    } // End of the function
    function determinePlayableWeatherEffects()
    {
        _playFireEffect = false;
        _playWaterEffect = false;
        _playSnowEffect = false;
        _playShadowEffect = false;
        if (_dancingFirePlayers >= 2)
        {
            _playFireEffect = true;
        } // end if
        if (_dancingWaterPlayers >= 2)
        {
            _playWaterEffect = true;
        } // end if
        if (_dancingSnowPlayers >= 2)
        {
            _playSnowEffect = true;
        } // end if
        if (_dancingShadowPlayers >= 2)
        {
            _playShadowEffect = true;
        } // end if
        if (_dancingWaterPlayers >= _dancingFirePlayers)
        {
            _playFireEffect = false;
        } // end if
        if (_dancingFirePlayers >= _dancingSnowPlayers)
        {
            _playSnowEffect = false;
        } // end if
        if (_dancingSnowPlayers >= _dancingWaterPlayers)
        {
            _playWaterEffect = false;
        } // end if
        if (_dancingWaterPlayers < _dancingFirePlayers)
        {
            _playWaterEffect = false;
        } // end if
        if (_dancingSnowPlayers < _dancingWaterPlayers)
        {
            _playSnowEffect = false;
        } // end if
        if (_dancingFirePlayers < _dancingSnowPlayers)
        {
            _playFireEffect = false;
        } // end if
        if (_dancingFirePlayers >= 2 && _dancingFirePlayers == _dancingWaterPlayers && _dancingFirePlayers == _dancingSnowPlayers)
        {
            _playFireEffect = true;
            _playWaterEffect = true;
            _playSnowEffect = true;
        } // end if
        if (_playFireEffect || _playWaterEffect || _playSnowEffect)
        {
            this.determineWhichStateShouldBePlayed();
        }
        else
        {
            this.resetToDefaultValues();
        } // end else if
        if (_playShadowEffect)
        {
            this.determineWhichShadowStateShouldBePlayed();
        } // end if
        if (!_playShadowEffect)
        {
            _nextShadowMode = this.determineShadowMode(_dancingShadowPlayers);
            if (_nextShadowMode != _currentShadowMode || _currentShadowState != _shadowEmptyState)
            {
                trace ("RESET SHADOW");
                _currentShadowState.toEmptyState();
            } // end if
        } // end if
    } // End of the function
    function determineWhichStateShouldBePlayed()
    {
        if (!_playShadowEffect)
        {
            _nextShadowMode = this.determineShadowMode(_dancingShadowPlayers);
            if (_nextShadowMode != _currentShadowMode || _currentShadowState != _shadowEmptyState)
            {
                trace ("RESET SHADOW");
                _currentShadowState.toEmptyState();
            } // end if
        } // end if
        if (_playFireEffect && _playWaterEffect && _playSnowEffect)
        {
            _nextColorMode = this.determineColorMode(_dancingFirePlayers);
            _currentColorState.toTieState();
            if (_playShadowEffect)
            {
                this.determineWhichShadowStateShouldBePlayed();
            } // end if
            return;
        } // end if
        if (_playFireEffect)
        {
            _nextColorMode = this.determineColorMode(_dancingFirePlayers);
            _currentColorState.toFireState();
            if (_playShadowEffect)
            {
                this.determineWhichShadowStateShouldBePlayed();
            } // end if
            return;
        } // end if
        if (_playWaterEffect)
        {
            _nextColorMode = this.determineColorMode(_dancingWaterPlayers);
            _currentColorState.toWaterState();
            if (_playShadowEffect)
            {
                this.determineWhichShadowStateShouldBePlayed();
            } // end if
            return;
        } // end if
        if (_playSnowEffect)
        {
            _nextColorMode = this.determineColorMode(_dancingSnowPlayers);
            _currentColorState.toSnowState();
            if (_playShadowEffect)
            {
                this.determineWhichShadowStateShouldBePlayed();
            } // end if
            return;
        } // end if
        if (!_playFireEffect && !_playWaterEffect && !_playSnowEffect)
        {
            this.resetToDefaultValues();
        } // end if
    } // End of the function
    function determineWhichShadowStateShouldBePlayed()
    {
        trace ("DETERMINING WHICH SHADOW STATE SHOULD BE PLAYED");
        _nextShadowMode = this.determineShadowMode(_dancingShadowPlayers);
        if (_playShadowEffect)
        {
            this.determineShadowState();
            return;
        } // end if
        _currentShadowState.toEmptyState();
    } // End of the function
    function setDefaultTintValues(numOfPlayers, effectType)
    {
        var _loc2 = new Object();
        _loc2.tintType = _playShadowEffect ? ("shadow") : ("color");
        _loc2.state = "Mode" + (numOfPlayers - 1 > 2 ? ("C") : (numOfPlayers - 1 == 2 ? ("B") : ("A")));
        _loc2.effectType = effectType;
        _loc2.stateForSettings = "Mode" + (numOfPlayers > 2 ? ("B") : ("A"));
        if (effectType == com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.EFFECT_TYPE_DEFAULT && !_playShadowEffect)
        {
            _loc2.state = "ModeA";
        } // end if
        _loc2.sky = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[_loc2.tintType + effectType + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_SKY + _loc2.stateForSettings];
        _loc2.clouds = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[_loc2.tintType + effectType + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_CLOUDS + _loc2.stateForSettings];
        _loc2.distantObjects = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[_loc2.tintType + effectType + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_DISTANT_OBJ + _loc2.stateForSettings];
        _loc2.topCoulds = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[_loc2.tintType + effectType + com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager.OBJECT_TYPE_TOP_CLOUDS + _loc2.stateForSettings];
        com.greensock.TweenMax.to(background_mc.weatherEffects_mc.bgSky.bgSkyShadow.bgSkyColor, 0, {colorTransform: _loc2.sky});
    } // End of the function
    function resetToDefaultValues()
    {
        if (_currentColorState == _colorDefaultState)
        {
            return;
        } // end if
        _nextColorMode = this.determineColorMode(0);
        _currentColorState.toDefaultState();
    } // End of the function
    function isWearingFireOutfit(player)
    {
        if (player.head != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._FIRE_NINJA_HEAD_ITEM_ID)
        {
            return (false);
        } // end if
        if (player.face != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._FIRE_NINJA_FACE_ITEM_ID)
        {
            return (false);
        } // end if
        if (player.body != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._FIRE_NINJA_BODY_ITEM_ID)
        {
            return (false);
        } // end if
        if (player.feet != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._FIRE_NINJA_FEET_ITEM_ID)
        {
            return (false);
        } // end if
        return (true);
    } // End of the function
    function isWearingWaterOutfit(player)
    {
        if (player.head != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._WATER_NINJA_HEAD_ITEM_ID)
        {
            return (false);
        } // end if
        if (player.face != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._WATER_NINJA_FACE_ITEM_ID)
        {
            return (false);
        } // end if
        if (player.body != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._WATER_NINJA_BODY_ITEM_ID)
        {
            return (false);
        } // end if
        if (player.feet != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._WATER_NINJA_FEET_ITEM_ID)
        {
            return (false);
        } // end if
        return (true);
    } // End of the function
    function isWearingSnowOutfit(player)
    {
        if (player.head != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._SNOW_NINJA_HEAD_ITEM_ID)
        {
            return (false);
        } // end if
        if (player.face != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._SNOW_NINJA_FACE_ITEM_ID)
        {
            return (false);
        } // end if
        if (player.body != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._SNOW_NINJA_BODY_ITEM_ID)
        {
            return (false);
        } // end if
        if (player.feet != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._SNOW_NINJA_FEET_ITEM_ID)
        {
            return (false);
        } // end if
        return (true);
    } // End of the function
    function isWearingShadowOutfit(player)
    {
        if (player.head != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._SHADOW_NINJA_HEAD_ITEM_ID)
        {
            return (false);
        } // end if
        if (player.face != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._SHADOW_NINJA_FACE_ITEM_ID)
        {
            return (false);
        } // end if
        if (player.body != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._SHADOW_NINJA_BODY_ITEM_ID)
        {
            return (false);
        } // end if
        if (player.feet != com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._SHADOW_NINJA_FEET_ITEM_ID)
        {
            return (false);
        } // end if
        return (true);
    } // End of the function
    function isDoingSpecialDance(player)
    {
        var _loc3 = SHELL.getSecretFrame(player.player_id, player.frame);
        if (player.frame == com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager._SPECIAL_DANCE_FRAME && player.frame != _loc3)
        {
            return (true);
        } // end if
        return (false);
    } // End of the function
    function traceCurrentRoomStatus()
    {
        trace ("=====================================");
        trace ("FIRE DANCERS   " + _dancingFirePlayers);
        trace ("WATER DANCERS  " + _dancingWaterPlayers);
        trace ("SNOW DANCERS   " + _dancingSnowPlayers);
        trace ("SHADOW DANCERS " + _dancingShadowPlayers);
        trace ("PLAY FIRE EFFECT:   " + _playFireEffect);
        trace ("PLAY WATER EFFECT:  " + _playWaterEffect);
        trace ("PLAY SNOW EFFECT:   " + _playSnowEffect);
        trace ("PLAY SHADOW EFFECT: " + _playShadowEffect);
        trace ("===========================");
    } // End of the function
    function destroy()
    {
        trace ("WeatherEffectsManager -> destroy()");
        this.stopWeatherEffectCheck();
    } // End of the function
    var SHELL = undefined;
    static var _NECK_AMULET_ID = 3032;
    static var _SPECIAL_DANCE_FRAME = 26;
    static var _FIRE_NINJA_HEAD_ITEM_ID = 1086;
    static var _FIRE_NINJA_FACE_ITEM_ID = 2013;
    static var _FIRE_NINJA_BODY_ITEM_ID = 4120;
    static var _FIRE_NINJA_FEET_ITEM_ID = 6025;
    static var _WATER_NINJA_HEAD_ITEM_ID = 1087;
    static var _WATER_NINJA_FACE_ITEM_ID = 2025;
    static var _WATER_NINJA_BODY_ITEM_ID = 4121;
    static var _WATER_NINJA_FEET_ITEM_ID = 6026;
    static var _SNOW_NINJA_HEAD_ITEM_ID = 1581;
    static var _SNOW_NINJA_FACE_ITEM_ID = 2119;
    static var _SNOW_NINJA_BODY_ITEM_ID = 4834;
    static var _SNOW_NINJA_FEET_ITEM_ID = 6163;
    static var _SHADOW_NINJA_HEAD_ITEM_ID = 1271;
    static var _SHADOW_NINJA_FACE_ITEM_ID = 2033;
    static var _SHADOW_NINJA_BODY_ITEM_ID = 4380;
    static var _SHADOW_NINJA_FEET_ITEM_ID = 6077;
    var _intervalId = -1;
    var _dancingFirePlayers = 0;
    var _dancingWaterPlayers = 0;
    var _dancingSnowPlayers = 0;
    var _dancingShadowPlayers = 0;
    var _playFireEffect = false;
    var _playWaterEffect = false;
    var _playSnowEffect = false;
    var _playShadowEffect = false;
    var _checkInterval = 4000;
    var _fireAnimationHeight = 55;
    var _fireAnimationSpeed = 1;
    var _fireAmount = 3;
    var _fireShrinkSize = 100;
    var _fireDelayTime = 2;
    var _rainAnimationHeight = 85;
    var _rainAnimationSpeed = 0.500000;
    var _rainAmount = 25;
    var _rainShrinkSize = 25;
    var _rainFadeAmount = 50;
    var _rainDelayTime = 2;
    var _rainRotation = -26;
    var _snowAnimationHeight = 85;
    var _snowAnimationSpeed = 1;
    var _snowAmount = 25;
    var _snowShrinkSize = 50;
    var _snowFadeAmount = 50;
    var _snowDelayTime = 2;
    static var EFFECT_TYPE_FIRE = "Fire";
    static var EFFECT_TYPE_WATER = "Water";
    static var EFFECT_TYPE_SNOW = "Snow";
    static var EFFECT_TYPE_TIE = "Tie";
    static var EFFECT_TYPE_DEFAULT = "Default";
    static var EFFECT_TYPE_EMPTY = "Empty";
    static var OBJECT_TYPE_SKY = "Sky";
    static var OBJECT_TYPE_CLOUDS = "Clouds";
    static var OBJECT_TYPE_DISTANT_OBJ = "DistantObjects";
    static var OBJECT_TYPE_TOP_CLOUDS = "TopClouds";
    static var OBJECT_TYPE_SHELL = "TintShell";
} // End of Class
