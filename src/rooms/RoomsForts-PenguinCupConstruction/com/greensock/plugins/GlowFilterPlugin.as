class com.greensock.plugins.GlowFilterPlugin extends com.greensock.plugins.FilterPlugin
{
    var propName, overwriteProps, _target, _type, initFilter;
    function GlowFilterPlugin()
    {
        super();
        propName = "glowFilter";
        overwriteProps = ["glowFilter"];
    } // End of the function
    function onInitTween(target, value, tween)
    {
        _target = target;
        _type = flash.filters.GlowFilter;
        this.initFilter(value, new flash.filters.GlowFilter(16777215, 0, 0, 0, value.strength || 1, value.quality || 2, value.inner, value.knockout), com.greensock.plugins.GlowFilterPlugin._propNames);
        return (true);
    } // End of the function
    static var API = 1;
    static var _propNames = ["color", "alpha", "blurX", "blurY", "strength", "quality", "inner", "knockout"];
} // End of Class
