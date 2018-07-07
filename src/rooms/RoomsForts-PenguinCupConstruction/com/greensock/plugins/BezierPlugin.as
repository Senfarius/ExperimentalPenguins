class com.greensock.plugins.BezierPlugin extends com.greensock.plugins.TweenPlugin
{
    var propName, overwriteProps, _future, _target, _orientData, _orient, _beziers, round, __set__changeFactor, __get__changeFactor;
    function BezierPlugin()
    {
        super();
        propName = "bezier";
        overwriteProps = [];
        _future = {};
    } // End of the function
    function onInitTween(target, value, tween)
    {
        if (!(value instanceof Array))
        {
            return (false);
        } // end if
        this.init(tween, [value][0], false);
        return (true);
    } // End of the function
    function init(tween, beziers, through)
    {
        _target = tween.target;
        var _loc7 = tween.vars;
        if (_loc7.orientToBezier == true)
        {
            _orientData = [["_x", "_y", "_rotation", 0, 0.010000]];
            _orient = true;
        }
        else if (_loc7.orientToBezier instanceof Array)
        {
            _orientData = _loc7.orientToBezier;
            _orient = true;
        } // end else if
        var _loc3 = {};
        var _loc4;
        var _loc2;
        var _loc8;
        for (var _loc4 = 0; _loc4 < beziers.length; ++_loc4)
        {
            for (var _loc2 in beziers[_loc4])
            {
                if (_loc3[_loc2] == undefined)
                {
                    _loc3[_loc2] = [tween.target[_loc2]];
                } // end if
                if (typeof(beziers[_loc4][_loc2]) == "number")
                {
                    _loc3[_loc2].push(beziers[_loc4][_loc2]);
                    continue;
                } // end if
                _loc3[_loc2].push(tween.target[_loc2] + Number(beziers[_loc4][_loc2]));
            } // end of for...in
        } // end of for
        for (var _loc2 in _loc3)
        {
            overwriteProps[overwriteProps.length] = _loc2;
            if (_loc7[_loc2] != undefined)
            {
                if (typeof(_loc7[_loc2]) == "number")
                {
                    _loc3[_loc2].push(_loc7[_loc2]);
                }
                else
                {
                    _loc3[_loc2].push(tween.target[_loc2] + Number(_loc7[_loc2]));
                } // end else if
                _loc8 = {};
                _loc8[_loc2] = true;
                tween.killVars(_loc8, false);
                delete _loc7[_loc2];
            } // end if
        } // end of for...in
        _beziers = com.greensock.plugins.BezierPlugin.parseBeziers(_loc3, through);
    } // End of the function
    static function parseBeziers(props, through)
    {
        var _loc2;
        var _loc1;
        var _loc3;
        var _loc4;
        var _loc6 = {};
        if (through == true)
        {
            for (var _loc4 in props)
            {
                _loc1 = props[_loc4];
                _loc3 = [];
                _loc6[_loc4] = [];
                if (_loc1.length > 2)
                {
                    _loc3[_loc3.length] = [_loc1[0], _loc1[1] - (_loc1[2] - _loc1[0]) / 4, _loc1[1]];
                    for (var _loc2 = 1; _loc2 < _loc1.length - 1; ++_loc2)
                    {
                        _loc3[_loc3.length] = [_loc1[_loc2], _loc1[_loc2] + (_loc1[_loc2] - _loc3[_loc2 - 1][1]), _loc1[_loc2 + 1]];
                    } // end of for
                    continue;
                } // end if
                _loc3[_loc3.length] = [_loc1[0], (_loc1[0] + _loc1[1]) / 2, _loc1[1]];
            } // end of for...in
        }
        else
        {
            for (var _loc4 in props)
            {
                _loc1 = props[_loc4];
                _loc3 = [];
                _loc6[_loc4] = [];
                if (_loc1.length > 3)
                {
                    _loc3[_loc3.length] = [_loc1[0], _loc1[1], (_loc1[1] + _loc1[2]) / 2];
                    for (var _loc2 = 2; _loc2 < _loc1.length - 2; ++_loc2)
                    {
                        _loc3[_loc3.length] = [_loc3[_loc2 - 2][2], _loc1[_loc2], (_loc1[_loc2] + _loc1[_loc2 + 1]) / 2];
                    } // end of for
                    _loc3[_loc3.length] = [_loc3[_loc3.length - 1][2], _loc1[_loc1.length - 2], _loc1[_loc1.length - 1]];
                    continue;
                } // end if
                if (_loc1.length == 3)
                {
                    _loc3[_loc3.length] = [_loc1[0], _loc1[1], _loc1[2]];
                    continue;
                } // end if
                if (_loc1.length == 2)
                {
                    _loc3[_loc3.length] = [_loc1[0], (_loc1[0] + _loc1[1]) / 2, _loc1[1]];
                } // end if
            } // end of for...in
        } // end else if
        return (_loc6);
    } // End of the function
    function killProps(lookup)
    {
        for (var _loc4 in _beziers)
        {
            if (lookup[_loc4] != undefined)
            {
                delete _beziers[_loc4];
            } // end if
        } // end of for...in
        super.killProps(lookup);
    } // End of the function
    function set changeFactor(n)
    {
        var _loc3;
        var _loc5;
        var _loc4;
        var _loc6;
        var _loc7;
        var _loc15;
        var _loc16;
        if (n == 1)
        {
            for (var _loc5 in _beziers)
            {
                _loc3 = _beziers[_loc5].length - 1;
                _target[_loc5] = _beziers[_loc5][_loc3][2];
            } // end of for...in
        }
        else
        {
            for (var _loc5 in _beziers)
            {
                _loc7 = _beziers[_loc5].length;
                if (n < 0)
                {
                    _loc3 = 0;
                }
                else if (n >= 1)
                {
                    _loc3 = _loc7 - 1;
                }
                else
                {
                    _loc3 = _loc7 * n >> 0;
                } // end else if
                _loc6 = (n - _loc3 * (1 / _loc7)) * _loc7;
                _loc4 = _beziers[_loc5][_loc3];
                if (round)
                {
                    _target[_loc5] = Math.round(_loc4[0] + _loc6 * (2 * (1 - _loc6) * (_loc4[1] - _loc4[0]) + _loc6 * (_loc4[2] - _loc4[0])));
                    continue;
                } // end if
                _target[_loc5] = _loc4[0] + _loc6 * (2 * (1 - _loc6) * (_loc4[1] - _loc4[0]) + _loc6 * (_loc4[2] - _loc4[0]));
            } // end of for...in
        } // end else if
        if (_orient == true)
        {
            _loc3 = _orientData.length;
            var _loc9 = {};
            var _loc11;
            var _loc10;
            var _loc2;
            var _loc12;
            while (_loc3-- > 0)
            {
                _loc2 = _orientData[_loc3];
                _loc9[_loc2[0]] = _target[_loc2[0]];
                _loc9[_loc2[1]] = _target[_loc2[1]];
            } // end while
            var _loc13 = _target;
            var _loc14 = round;
            _target = _future;
            round = false;
            _orient = false;
            _loc3 = _orientData.length;
            while (_loc3-- > 0)
            {
                _loc2 = _orientData[_loc3];
                this.__set__changeFactor(n + (_loc2[4] || 0.010000));
                _loc12 = _loc2[3] || 0;
                _loc11 = _future[_loc2[0]] - _loc9[_loc2[0]];
                _loc10 = _future[_loc2[1]] - _loc9[_loc2[1]];
                _loc13[_loc2[2]] = Math.atan2(_loc10, _loc11) * com.greensock.plugins.BezierPlugin._RAD2DEG + _loc12;
            } // end while
            _target = _loc13;
            round = _loc14;
            _orient = true;
        } // end if
        //return (this.changeFactor());
        null;
    } // End of the function
    static var API = 1;
    static var _RAD2DEG = 57.295780;
} // End of Class
