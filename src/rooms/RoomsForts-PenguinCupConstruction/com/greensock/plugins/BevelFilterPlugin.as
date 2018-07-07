class com.greensock.plugins.BevelFilterPlugin extends com.greensock.plugins.FilterPlugin
{
    var propName, overwriteProps, _target, _type, initFilter;
    function BevelFilterPlugin()
    {
        super();
        propName = "bevelFilter";
        overwriteProps = ["bevelFilter"];
    } // End of the function
    function onInitTween(target, value, tween)
    {
        _target = target;
        _type = flash.filters.BevelFilter;
        this.initFilter(value, new flash.filters.BevelFilter(0, 0, 16777215, 0.500000, 0, 0.500000, 2, 2, 0, value.quality || 2), com.greensock.plugins.BevelFilterPlugin._propNames);
        return (true);
    } // End of the function
    static var API = 1;
    static var _propNames = ["distance", "angle", "highlightColor", "highlightAlpha", "shadowColor", "shadowAlpha", "blurX", "blurY", "strength", "quality"];
} // End of Class
