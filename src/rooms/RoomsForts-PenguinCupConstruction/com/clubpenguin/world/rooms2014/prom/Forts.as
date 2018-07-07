class com.clubpenguin.world.rooms2014.prom.Forts extends com.clubpenguin.world.rooms.BaseRoom
{
    var _stage, _SHELL, localize, setupNavigationButtons, IS_24_HOUR_CLOCK, _now, _secondCheckIntervalID, _destroyDelegate, _checkClockTagetDelegate, showContent, wem, _ct_minutes, _ct_hours, _pm_trigger, _ct_day, _today;
    function Forts(stageReference)
    {
        super(stageReference);
        trace (com.clubpenguin.world.rooms2014.prom.Forts.CLASS_NAME + "()");
        _stage.start_x = 380;
        _stage.start_y = 285;
    } // End of the function
    function exit(name, x, y)
    {
        trace (com.clubpenguin.world.rooms2014.prom.Forts.CLASS_NAME + ": exit()");
        _SHELL.sendJoinRoom(name, x, y);
    } // End of the function
    function init()
    {
        this.localize([_stage.clocktower.clocktext]);
        this.setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.town_btn, 75, 245), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.rink_btn, 331, 150), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.plaza_btn, 695, 205)]);
        IS_24_HOUR_CLOCK = _SHELL.getLanguageAbbreviation() == "de";
        if (IS_24_HOUR_CLOCK)
        {
            _stage.clocktower.clock_txt._x = _stage.clocktower.clock_txt._x + 15;
        } // end if
        trace (com.clubpenguin.world.rooms2014.prom.Forts.CLASS_NAME + ": init()");
        if (_SHELL.getPenguinStandardTime != undefined)
        {
            _now = _SHELL.getPenguinStandardTime();
        }
        else
        {
            _now = new Date();
        } // end else if
        clearInterval(_secondCheckIntervalID);
        _secondCheckIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, clockTimer), com.clubpenguin.world.rooms2014.prom.Forts.ONE_SECOND);
        this.clockTimer();
        _stage.background_mc.town_btn.useHandCursor = false;
        _stage.background_mc.rink_btn.useHandCursor = false;
        _stage.background_mc.plaza_btn.useHandCursor = false;
        _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 660, 325);
        _stage.triggers_mc.rink_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "rink", 380, 135);
        _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 85, 330);
        _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
        _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        _checkClockTagetDelegate = com.clubpenguin.util.Delegate.create(this, onSnowballLand);
        _SHELL.addListener(_SHELL.BALL_LAND, _checkClockTagetDelegate);
        this.showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.clock_btn, true, "clock_help", "")]);
        wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(_SHELL, _stage.background_mc);
        wem.setupFireAnimationHeight(25);
        wem.setupRainAnimationHeight(35);
        wem.setupSnowAnimationHeight(35);
        wem.setupRainAnimationSpeed(0.300000);
        wem.setupSnowAnimationSpeed(0.600000);
        wem.setupRainDelayTime(2);
        wem.setupSnowDelayTime(2);
        wem.startWeatherEffectCheck();
    } // End of the function
    function clockTimer()
    {
        var _loc6 = 0;
        var _loc5 = 11;
        var _loc2 = 12;
        _now.setTime(_now.getTime() + com.clubpenguin.world.rooms2014.prom.Forts.ONE_SECOND);
        if (_ct_minutes != _now.getMinutes())
        {
            _ct_minutes = _now.getMinutes();
            if (_ct_hours != _now.getMinutes())
            {
                _ct_hours = _now.getHours();
                if (_ct_hours > _loc5)
                {
                    _pm_trigger = true;
                    if (_ct_hours > _loc2 && !IS_24_HOUR_CLOCK)
                    {
                        _ct_hours = _ct_hours - _loc2;
                    } // end if
                }
                else
                {
                    _pm_trigger = false;
                    if (_ct_hours == _loc6 && !IS_24_HOUR_CLOCK)
                    {
                        _ct_hours = _loc2;
                    } // end if
                } // end else if
                if (!IS_24_HOUR_CLOCK)
                {
                    if (_pm_trigger)
                    {
                        _stage.clocktower.am_pm.text = "PM";
                    }
                    else
                    {
                        _stage.clocktower.am_pm.text = "AM";
                    } // end else if
                }
                else
                {
                    _stage.clocktower.am_pm.text = "";
                } // end else if
                if (_ct_day != _now.getDay())
                {
                    var _loc4;
                    _ct_day = _now.getDay();
                    _loc4 = _daysOfTheWeek[_ct_day];
                    _today = _SHELL.getLocalizedString(_loc4);
                } // end if
            } // end if
            _stage.clocktower.day_mc.label_txt.text = _today.toUpperCase();
            if (IS_24_HOUR_CLOCK)
            {
                var _loc3 = new TextFormat();
                _loc3.size = 10;
                _stage.clocktower.day_txt.setTextFormat(_loc3);
            } // end if
            if (_ct_minutes < 10)
            {
                _stage.clocktower.clock_txt.text = _ct_hours + ":0" + _ct_minutes;
            }
            else
            {
                _stage.clocktower.clock_txt.text = _ct_hours + ":" + _ct_minutes;
            } // end if
        } // end else if
    } // End of the function
    function onSnowballLand(snowballInfo)
    {
        trace (com.clubpenguin.world.rooms2014.prom.Forts.CLASS_NAME + ": handleThrow()");
        if (_stage.clocktower.tower.target.target.hitTest(snowballInfo.x, snowballInfo.y, true))
        {
            _stage.clocktower.tower.play();
            _stage.clocktower.tower.target.play();
            _stage.clocktower.tower.play();
            snowballInfo.snowballMC._visible = false;
            ++_clockTargetHits;
            if (_clockTargetHits >= com.clubpenguin.world.rooms2014.prom.Forts.TARGET_STAMP_THRESHOLD)
            {
                _clockTargetHits = 0;
                _SHELL.stampEarned(com.clubpenguin.world.rooms2014.prom.Forts.TARGET_STAMP_ID);
            } // end if
        } // end if
    } // End of the function
    function destroy()
    {
        clearInterval(_secondCheckIntervalID);
        trace (com.clubpenguin.world.rooms2014.prom.Forts.CLASS_NAME + ": destroy()");
        _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        _SHELL.removeListener(_SHELL.BALL_LAND, _checkClockTagetDelegate);
        wem.destroy();
    } // End of the function
    static var CLASS_NAME = "Forts";
    static var ONE_SECOND = 1000;
    static var TARGET_STAMP_ID = 13;
    static var TARGET_STAMP_THRESHOLD = 10;
    var _daysOfTheWeek = ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"];
    var _clockTargetHits = 0;
} // End of Class
