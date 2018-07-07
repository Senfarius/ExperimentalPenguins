class com.clubpenguin.world.rooms2013.common.CallbackAnimation extends MovieClip
{
    var _mc, _callback, _targetFrame;
    function CallbackAnimation(mc, callback, startFrame, targetFrame)
    {
        super();
        _mc = mc;
        _callback = callback;
        _targetFrame = targetFrame == undefined ? (_mc._totalframes) : (targetFrame);
        var _loc3 = startFrame == undefined ? (2) : (startFrame);
        _mc.gotoAndPlay(_loc3);
        _mc.onEnterFrame = com.clubpenguin.util.Delegate.create(this, tweenComplete);
    } // End of the function
    function tweenComplete()
    {
        if (_mc._currentframe == _targetFrame)
        {
            this._callback();
            delete _mc.onEnterFrame;
        } // end if
    } // End of the function
} // End of Class
