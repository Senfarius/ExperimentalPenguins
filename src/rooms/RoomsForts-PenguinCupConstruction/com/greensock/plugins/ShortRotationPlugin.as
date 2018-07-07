class com.greensock.plugins.ShortRotationPlugin extends com.greensock.plugins.TweenPlugin
{
    var propName, overwriteProps, addTween;
    function ShortRotationPlugin()
    {
        super();
        propName = "shortRotation";
        overwriteProps = [];
    } // End of the function
    function onInitTween(target, value, tween)
    {
        if (typeof(value) == "number")
        {
            return (false);
        } // end if
        var _loc4 = Boolean(value.useRadians == true);
        for (var _loc5 in value)
        {
            if (_loc5 != "useRadians")
            {
                this.initRotation(target, _loc5, target[_loc5], typeof(value[_loc5]) == "number" ? (Number(value[_loc5])) : (target[_loc5] + Number(value[_loc5])), _loc4);
            } // end if
        } // end of for...in
        return (true);
    } // End of the function
    function initRotation(target, propName, start, end, useRadians)
    {
        var _loc3 = useRadians ? (6.283185) : (360);
        var _loc2 = (end - start) % _loc3;
        if (_loc2 != _loc2 % (_loc3 / 2))
        {
            _loc2 = _loc2 < 0 ? (_loc2 + _loc3) : (_loc2 - _loc3);
        } // end if
        this.addTween(target, propName, start, start + _loc2, propName);
        overwriteProps[overwriteProps.length] = propName;
    } // End of the function
    static var API = 1;
} // End of Class
