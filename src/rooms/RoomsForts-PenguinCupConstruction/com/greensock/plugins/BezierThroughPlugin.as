class com.greensock.plugins.BezierThroughPlugin extends com.greensock.plugins.BezierPlugin
{
    var propName, init;
    function BezierThroughPlugin()
    {
        super();
        propName = "bezierThrough";
    } // End of the function
    function onInitTween(target, value, tween)
    {
        if (!(value instanceof Array))
        {
            return (false);
        } // end if
        this.init(tween, [value][0], true);
        return (true);
    } // End of the function
    static var API = 1;
} // End of Class
