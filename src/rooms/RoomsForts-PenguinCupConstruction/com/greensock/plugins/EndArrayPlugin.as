class com.greensock.plugins.EndArrayPlugin extends com.greensock.plugins.TweenPlugin
{
    var propName, overwriteProps, _info, _a, round, __get__changeFactor, __set__changeFactor;
    function EndArrayPlugin()
    {
        super();
        propName = "endArray";
        overwriteProps = ["endArray"];
        _info = [];
    } // End of the function
    function onInitTween(target, value, tween)
    {
        if (!(target instanceof Array) || !(value instanceof Array))
        {
            return (false);
        } // end if
        this.init([target][0], [value][0]);
        return (true);
    } // End of the function
    function init(start, end)
    {
        _a = start;
        var _loc2 = end.length;
        while (_loc2--)
        {
            if (start[_loc2] != end[_loc2] && start[_loc2] != undefined)
            {
                _info[_info.length] = new com.greensock.plugins.helpers.ArrayTweenInfo(_loc2, _a[_loc2], end[_loc2] - _a[_loc2]);
            } // end if
        } // end while
    } // End of the function
    function set changeFactor(n)
    {
        var _loc3 = _info.length;
        var _loc2;
        if (round)
        {
            while (_loc3--)
            {
                _loc2 = _info[_loc3];
                _a[_loc2.index] = Math.round(_loc2.start + _loc2.change * n);
            } // end while
        }
        else
        {
            while (_loc3--)
            {
                _loc2 = _info[_loc3];
                _a[_loc2.index] = _loc2.start + _loc2.change * n;
            } // end while
        } // end else if
        //return (this.changeFactor());
        null;
    } // End of the function
    static var API = 1;
} // End of Class
