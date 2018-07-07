class com.greensock.plugins.ColorTransformPlugin extends com.greensock.plugins.TintPlugin
{
    var propName, init;
    function ColorTransformPlugin()
    {
        super();
        propName = "colorTransform";
    } // End of the function
    function onInitTween(target, value, tween)
    {
        if (typeof(target) != "movieclip" && !(target instanceof TextField))
        {
            return (false);
        } // end if
        var _loc7 = new Color(target);
        var _loc2 = _loc7.getTransform();
        if (value.redMultiplier != undefined)
        {
            _loc2.ra = value.redMultiplier * 100;
        } // end if
        if (value.greenMultiplier != undefined)
        {
            _loc2.ga = value.greenMultiplier * 100;
        } // end if
        if (value.blueMultiplier != undefined)
        {
            _loc2.ba = value.blueMultiplier * 100;
        } // end if
        if (value.alphaMultiplier != undefined)
        {
            _loc2.aa = value.alphaMultiplier * 100;
        } // end if
        if (value.redOffset != undefined)
        {
            _loc2.rb = value.redOffset;
        } // end if
        if (value.greenOffset != undefined)
        {
            _loc2.gb = value.greenOffset;
        } // end if
        if (value.blueOffset != undefined)
        {
            _loc2.bb = value.blueOffset;
        } // end if
        if (value.alphaOffset != undefined)
        {
            _loc2.ab = value.alphaOffset;
        } // end if
        if (!isNaN(value.tint) || !isNaN(value.color))
        {
            var _loc4 = !isNaN(value.tint) ? (value.tint) : (value.color);
            if (_loc4 != null)
            {
                _loc2.rb = Number(_loc4) >> 16;
                _loc2.gb = Number(_loc4) >> 8 & 255;
                _loc2.bb = Number(_loc4) & 255;
                _loc2.ra = 0;
                _loc2.ga = 0;
                _loc2.ba = 0;
            } // end if
        } // end if
        if (!isNaN(value.tintAmount))
        {
            var _loc5 = value.tintAmount / (1 - (_loc2.ra + _loc2.ga + _loc2.ba) / 300);
            _loc2.rb = _loc2.rb * _loc5;
            _loc2.gb = _loc2.gb * _loc5;
            _loc2.bb = _loc2.bb * _loc5;
            _loc2.ra = _loc2.ga = _loc2.ba = (1 - value.tintAmount) * 100;
        }
        else if (!isNaN(value.exposure))
        {
            _loc2.rb = _loc2.gb = _loc2.bb = 255 * (value.exposure - 1);
            _loc2.ra = _loc2.ga = _loc2.ba = 100;
        }
        else if (!isNaN(value.brightness))
        {
            _loc2.rb = _loc2.gb = _loc2.bb = Math.max(0, (value.brightness - 1) * 255);
            _loc2.ra = _loc2.ga = _loc2.ba = (1 - Math.abs(value.brightness - 1)) * 100;
        } // end else if
        if (tween.vars._alpha != undefined && value.alphaMultiplier == undefined)
        {
            _loc2.aa = tween.vars._alpha;
            tween.killVars({_alpha: 1});
        } // end if
        this.init(target, _loc2);
        return (true);
    } // End of the function
    static var API = 1;
} // End of Class
