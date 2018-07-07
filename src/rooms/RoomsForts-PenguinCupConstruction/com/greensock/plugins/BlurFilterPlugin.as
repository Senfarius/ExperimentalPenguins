class com.greensock.plugins.BlurFilterPlugin extends com.greensock.plugins.FilterPlugin
{
    var propName, overwriteProps, _target, _type, initFilter;
    function BlurFilterPlugin()
    {
        super();
        propName = "blurFilter";
        overwriteProps = ["blurFilter"];
    } // End of the function
    function onInitTween(target, value, tween)
    {
        _target = target;
        _type = flash.filters.BlurFilter;
        this.initFilter(value, new flash.filters.BlurFilter(0, 0, value.quality || 2), com.greensock.plugins.BlurFilterPlugin._propNames);
        return (true);
    } // End of the function
    static var API = 1;
    static var _propNames = ["blurX", "blurY", "quality"];
} // End of Class
