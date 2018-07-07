class com.greensock.plugins.DropShadowFilterPlugin extends com.greensock.plugins.FilterPlugin
{
    var propName, overwriteProps, _target, _type, initFilter;
    function DropShadowFilterPlugin()
    {
        super();
        propName = "dropShadowFilter";
        overwriteProps = ["dropShadowFilter"];
    } // End of the function
    function onInitTween(target, value, tween)
    {
        _target = target;
        _type = flash.filters.DropShadowFilter;
        this.initFilter(value, new flash.filters.DropShadowFilter(0, 45, 0, 0, 0, 0, 1, value.quality || 2, value.inner, value.knockout, value.hideObject), com.greensock.plugins.DropShadowFilterPlugin._propNames);
        return (true);
    } // End of the function
    static var API = 1;
    static var _propNames = ["distance", "angle", "color", "alpha", "blurX", "blurY", "strength", "quality", "inner", "knockout", "hideObject"];
} // End of Class
