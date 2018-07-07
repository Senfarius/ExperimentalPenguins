class com.greensock.plugins.RoundPropsPlugin extends com.greensock.plugins.TweenPlugin
{
    var propName, overwriteProps, round, priority, onInitAllProps, _tween, addTween;
    function RoundPropsPlugin()
    {
        super();
        propName = "roundProps";
        overwriteProps = ["roundProps"];
        round = true;
        priority = -1;
        onInitAllProps = _initAllProps;
    } // End of the function
    function onInitTween(target, value, tween)
    {
        _tween = tween;
        var _loc2 = value;
        overwriteProps = overwriteProps.concat(_loc2);
        return (true);
    } // End of the function
    function _initAllProps()
    {
        var _loc3;
        var _loc4;
        var _loc6 = _tween.vars.roundProps;
        var _loc2;
        var _loc5 = _loc6.length;
        while (--_loc5 > -1)
        {
            _loc3 = _loc6[_loc5];
            for (var _loc2 = _tween.cachedPT1; _loc2; _loc2 = _loc2.nextNode)
            {
                if (_loc2.name == _loc3)
                {
                    if (_loc2.isPlugin)
                    {
                        _loc2.target.round = true;
                    }
                    else
                    {
                        this.add(_loc2.target, _loc3, _loc2.start, _loc2.change);
                        this._removePropTween(_loc2);
                        _tween.propTweenLookup[_loc3] = _tween.propTweenLookup.roundProps;
                    } // end else if
                    continue;
                } // end if
                if (_loc2.isPlugin && _loc2.name == "_MULTIPLE_" && !_loc2.target.round)
                {
                    _loc4 = " " + _loc2.target.overwriteProps.join(" ") + " ";
                    if (_loc4.indexOf(" " + _loc3 + " ") != -1)
                    {
                        _loc2.target.round = true;
                    } // end if
                } // end if
            } // end of for
        } // end while
    } // End of the function
    function _removePropTween(propTween)
    {
        if (propTween.nextNode)
        {
            propTween.nextNode.prevNode = propTween.prevNode;
        } // end if
        if (propTween.prevNode)
        {
            propTween.prevNode.nextNode = propTween.nextNode;
        }
        else if (_tween.cachedPT1 == propTween)
        {
            _tween.cachedPT1 = propTween.nextNode;
        } // end else if
        if (propTween.isPlugin && propTween.target.onDisable)
        {
            propTween.target.onDisable();
        } // end if
    } // End of the function
    function add(object, propName, start, change)
    {
        this.addTween(object, propName, start, start + change, propName);
        overwriteProps[overwriteProps.length] = propName;
    } // End of the function
    static var API = 1;
} // End of Class
