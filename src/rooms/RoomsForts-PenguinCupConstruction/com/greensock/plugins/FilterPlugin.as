class com.greensock.plugins.FilterPlugin extends com.greensock.plugins.TweenPlugin
{
    var _target, _index, _type, _filter, _remove, onComplete, _tweens, propName, addTween, __get__changeFactor, __set__changeFactor;
    function FilterPlugin()
    {
        super();
    } // End of the function
    function initFilter(props, defaultFilter, propNames)
    {
        var _loc6 = _target.filters;
        var _loc2;
        var _loc3;
        var _loc5;
        var _loc7 = props instanceof flash.filters.BitmapFilter ? ({}) : (props);
        _index = -1;
        if (_loc7.index != undefined)
        {
            _index = _loc7.index;
        }
        else
        {
            _loc3 = _loc6.length;
            while (_loc3--)
            {
                if (_loc6[_loc3] instanceof _type)
                {
                    _index = _loc3;
                    break;
                } // end if
            } // end while
        } // end else if
        if (_index == -1 || _loc6[_index] == undefined || _loc7.addFilter == true)
        {
            _index = _loc7.index != undefined ? (_loc7.index) : (_loc6.length);
            _loc6[_index] = defaultFilter;
            _target.filters = _loc6;
        } // end if
        _filter = _loc6[_index];
        if (_loc7.remove == true)
        {
            _remove = true;
            onComplete = onCompleteTween;
        } // end if
        _loc3 = propNames.length;
        while (_loc3--)
        {
            _loc2 = propNames[_loc3];
            if (props[_loc2] != undefined && _filter[_loc2] != props[_loc2])
            {
                if (_loc2 == "color" || _loc2 == "highlightColor" || _loc2 == "shadowColor")
                {
                    _loc5 = new com.greensock.plugins.HexColorsPlugin();
                    _loc5.initColor(_filter, _loc2, _filter[_loc2], props[_loc2]);
                    _tweens[_tweens.length] = new com.greensock.core.PropTween(_loc5, "changeFactor", 0, 1, propName);
                    continue;
                } // end if
                if (_loc2 == "quality" || _loc2 == "inner" || _loc2 == "knockout" || _loc2 == "hideObject")
                {
                    _filter[_loc2] = props[_loc2];
                    continue;
                } // end if
                this.addTween(_filter, _loc2, _filter[_loc2], props[_loc2], propName);
            } // end if
        } // end while
    } // End of the function
    function onCompleteTween()
    {
        if (_remove)
        {
            var _loc3 = _target.filters;
            if (!(_loc3[_index] instanceof _type))
            {
                var _loc2 = _loc3.length;
                while (_loc2--)
                {
                    if (_loc3[_loc2] instanceof _type)
                    {
                        _loc3.splice(_loc2, 1);
                        break;
                    } // end if
                } // end while
            }
            else
            {
                _loc3.splice(_index, 1);
            } // end else if
            _target.filters = _loc3;
        } // end if
    } // End of the function
    function set changeFactor(n)
    {
        var _loc2 = _tweens.length;
        var _loc3;
        var _loc4 = _target.filters;
        while (_loc2--)
        {
            _loc3 = _tweens[_loc2];
            _loc3.target[_loc3.property] = _loc3.start + _loc3.change * n;
        } // end while
        if (!(_loc4[_index] instanceof _type))
        {
            _loc2 = _index = _loc4.length;
            while (_loc2--)
            {
                if (_loc4[_loc2] instanceof _type)
                {
                    _index = _loc2;
                    break;
                } // end if
            } // end while
        } // end if
        _loc4[_index] = _filter;
        _target.filters = _loc4;
        //return (this.changeFactor());
        null;
    } // End of the function
    static var VERSION = 2.030000;
    static var API = 1;
} // End of Class
