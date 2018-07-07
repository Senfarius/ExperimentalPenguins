class com.greensock.plugins.AutoAlphaPlugin extends com.greensock.plugins.VisiblePlugin
{
    var propName, overwriteProps, _target, addTween, _ignoreVisible, updateTweens, __get__changeFactor, __set__changeFactor;
    function AutoAlphaPlugin()
    {
        super();
        propName = "autoAlpha";
        overwriteProps = ["_alpha", "_visible"];
    } // End of the function
    function onInitTween(target, value, tween)
    {
        _target = target;
        this.addTween(target, "_alpha", target._alpha, value, "_alpha");
        return (true);
    } // End of the function
    function killProps(lookup)
    {
        super.killProps(lookup);
        _ignoreVisible = Boolean(lookup._visible != undefined);
    } // End of the function
    function set changeFactor(n)
    {
        this.updateTweens(n);
        if (!_ignoreVisible)
        {
            _target._visible = Boolean(_target._alpha != 0);
        } // end if
        //return (this.changeFactor());
        null;
    } // End of the function
    static var API = 1;
} // End of Class
