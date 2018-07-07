class com.greensock.plugins.VisiblePlugin extends com.greensock.plugins.TweenPlugin
{
    var propName, overwriteProps, _target, _tween, _initVal, _visible, __get__changeFactor, __set__changeFactor;
    function VisiblePlugin()
    {
        super();
        propName = "_visible";
        overwriteProps = ["_visible"];
    } // End of the function
    function onInitTween(target, value, tween)
    {
        _target = target;
        _tween = tween;
        _initVal = Boolean(_target._visible);
        _visible = Boolean(value);
        return (true);
    } // End of the function
    function set changeFactor(n)
    {
        if (n == 1 && (_tween.cachedDuration == _tween.cachedTime || _tween.cachedTime == 0))
        {
            _target._visible = _visible;
        }
        else
        {
            _target._visible = _initVal;
        } // end else if
        //return (this.changeFactor());
        null;
    } // End of the function
    static var API = 1;
} // End of Class
