class com.greensock.plugins.TintPlugin extends com.greensock.plugins.TweenPlugin
{
    var propName, overwriteProps, _color, _tweens, __get__changeFactor, __set__changeFactor;
    function TintPlugin()
    {
        super();
        propName = "tint";
        overwriteProps = ["tint"];
    } // End of the function
    function onInitTween(target, value, tween)
    {
        if (typeof(target) != "movieclip" && !(target instanceof TextField))
        {
            return (false);
        } // end if
        var _loc2 = tween.vars._alpha != undefined ? (tween.vars._alpha) : (tween.vars.autoAlpha != undefined ? (tween.vars.autoAlpha) : (target._alpha));
        var _loc4 = Number(value);
        var _loc6 = value == null || tween.vars.removeTint == true ? ({rb: 0, gb: 0, bb: 0, ab: 0, ra: _loc2, ga: _loc2, ba: _loc2, aa: _loc2}) : ({rb: _loc4 >> 16, gb: _loc4 >> 8 & 255, bb: _loc4 & 255, ra: 0, ga: 0, ba: 0, aa: _loc2});
        this.init(target, _loc6);
        return (true);
    } // End of the function
    function init(target, end)
    {
        _color = new Color(target);
        var _loc3 = _color.getTransform();
        var _loc6;
        var _loc2;
        for (var _loc2 in end)
        {
            if (_loc3[_loc2] != end[_loc2])
            {
                _tweens[_tweens.length] = new com.greensock.core.PropTween(_loc3, _loc2, _loc3[_loc2], end[_loc2] - _loc3[_loc2], "tint", false);
            } // end if
        } // end of for...in
    } // End of the function
    function set changeFactor(n)
    {
        var _loc4 = _color.getTransform();
        var _loc3 = _tweens.length;
        var _loc2;
        while (_loc3--)
        {
            _loc2 = _tweens[_loc3];
            _loc4[_loc2.property] = _loc2.start + _loc2.change * n;
        } // end while
        _color.setTransform(_loc4);
        //return (this.changeFactor());
        null;
    } // End of the function
    static var API = 1;
} // End of Class
