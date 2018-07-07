class com.greensock.plugins.TweenPlugin
{
    var _tweens, _changeFactor, propName, round, __get__changeFactor, overwriteProps, __set__changeFactor;
    function TweenPlugin()
    {
        _tweens = [];
        _changeFactor = 0;
    } // End of the function
    function onInitTween(target, value, tween)
    {
        this.addTween(target, propName, target[propName], value, propName);
        return (true);
    } // End of the function
    function addTween(object, propName, start, end, overwriteProp)
    {
        if (end != undefined)
        {
            var _loc3 = typeof(end) == "number" ? (Number(end) - start) : (Number(end));
            if (_loc3 != 0)
            {
                _tweens[_tweens.length] = new com.greensock.core.PropTween(object, propName, start, _loc3, overwriteProp || propName);
            } // end if
        } // end if
    } // End of the function
    function updateTweens(changeFactor)
    {
        var _loc3 = _tweens.length;
        var _loc2;
        if (round)
        {
            var _loc4;
            while (--_loc3 > -1)
            {
                _loc2 = _tweens[_loc3];
                _loc4 = _loc2.start + _loc2.change * changeFactor;
                if (_loc4 > 0)
                {
                    _loc2.target[_loc2.property] = _loc4 + 0.500000 >> 0;
                    continue;
                } // end if
                _loc2.target[_loc2.property] = _loc4 - 0.500000 >> 0;
            } // end while
        }
        else
        {
            while (--_loc3 > -1)
            {
                _loc2 = _tweens[_loc3];
                _loc2.target[_loc2.property] = _loc2.start + _loc2.change * changeFactor;
            } // end while
        } // end else if
    } // End of the function
    function get changeFactor()
    {
        return (_changeFactor);
    } // End of the function
    function set changeFactor(n)
    {
        this.updateTweens(n);
        _changeFactor = n;
        //return (this.changeFactor());
        null;
    } // End of the function
    function killProps(lookup)
    {
        var _loc2 = overwriteProps.length;
        while (--_loc2 > -1)
        {
            if (lookup[overwriteProps[_loc2]])
            {
                overwriteProps.splice(_loc2, 1);
            } // end if
        } // end while
        _loc2 = _tweens.length;
        while (--_loc2 > -1)
        {
            if (lookup[_tweens[_loc2].name])
            {
                _tweens.splice(_loc2, 1);
            } // end if
        } // end while
    } // End of the function
    static function onTweenEvent(type, tween)
    {
        var _loc1 = tween.cachedPT1;
        var _loc5;
        if (type == "onInitAllProps")
        {
            var _loc3 = [];
            var _loc2 = 0;
            while (_loc1)
            {
                _loc3[_loc2++] = _loc1;
                _loc1 = _loc1.nextNode;
            } // end while
            _loc3.sortOn("priority", Array.NUMERIC | Array.DESCENDING);
            while (--_loc2 > -1)
            {
                _loc3[_loc2].nextNode = _loc3[_loc2 + 1];
                _loc3[_loc2].prevNode = _loc3[_loc2 - 1];
            } // end while
        } // end if
        for (var _loc1 = tween.cachedPT1 = _loc3[0]; _loc1; _loc1 = _loc1.nextNode)
        {
            if (_loc1.isPlugin && _loc1.target[type])
            {
                if (_loc1.target.activeDisable)
                {
                    _loc5 = true;
                } // end if
                _loc1.target[type]();
            } // end if
        } // end of for
        return (_loc5);
    } // End of the function
    static function activate(plugins)
    {
        com.greensock.TweenLite.onPluginEvent = com.greensock.plugins.TweenPlugin.onTweenEvent;
        var _loc1 = plugins.length;
        var _loc3;
        while (_loc1--)
        {
            if (plugins[_loc1].API == 1)
            {
                _loc3 = new plugins[_loc1]();
                com.greensock.TweenLite.plugins[_loc3.propName] = plugins[_loc1];
            } // end if
        } // end while
        return (true);
    } // End of the function
    static var VERSION = 1.400000;
    static var API = 1;
    var priority = 0;
} // End of Class
