class com.greensock.plugins.FramePlugin extends com.greensock.plugins.TweenPlugin
{
    var propName, overwriteProps, round, _target, frame, addTween, updateTweens, __get__changeFactor, __set__changeFactor;
    function FramePlugin()
    {
        super();
        propName = "frame";
        overwriteProps = ["frame"];
        round = true;
    } // End of the function
    function onInitTween(target, value, tween)
    {
        if (typeof(target) != "movieclip" || isNaN(value))
        {
            return (false);
        } // end if
        _target = (MovieClip)(target);
        frame = _target._currentframe;
        this.addTween(this, "frame", frame, value, "frame");
        return (true);
    } // End of the function
    function set changeFactor(n)
    {
        this.updateTweens(n);
        _target.gotoAndStop(frame);
        //return (this.changeFactor());
        null;
    } // End of the function
    static var API = 1;
} // End of Class
