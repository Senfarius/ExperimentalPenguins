class com.greensock.plugins.FrameLabelPlugin extends com.greensock.plugins.FramePlugin
{
    var propName, _target, frame, addTween;
    function FrameLabelPlugin()
    {
        super();
        propName = "frameLabel";
    } // End of the function
    function onInitTween(target, value, tween)
    {
        if (typeof(tween.target) != "movieclip")
        {
            return (false);
        } // end if
        _target = (MovieClip)(target);
        frame = _target._currentframe;
        var _loc2 = _target.duplicateMovieClip("__frameLabelPluginTempMC", _target._parent.getNextHighestDepth());
        _loc2.gotoAndStop(value);
        var _loc3 = _loc2._currentframe;
        _loc2.removeMovieClip();
        if (frame != _loc3)
        {
            this.addTween(this, "frame", frame, _loc3, "frame");
        } // end if
        return (true);
    } // End of the function
    static var API = 1;
} // End of Class
