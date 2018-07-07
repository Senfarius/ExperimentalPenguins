class com.greensock.plugins.VolumePlugin extends com.greensock.plugins.TweenPlugin
{
    var propName, overwriteProps, _sound, volume, addTween, updateTweens, __get__changeFactor, __set__changeFactor;
    function VolumePlugin()
    {
        super();
        propName = "volume";
        overwriteProps = ["volume"];
    } // End of the function
    function onInitTween(target, value, tween)
    {
        if (isNaN(value) || typeof(target) != "movieclip" && !(target instanceof Sound))
        {
            return (false);
        } // end if
        _sound = typeof(target) == "movieclip" ? (new Sound(target)) : ((Sound)(target));
        volume = _sound.getVolume();
        this.addTween(this, "volume", volume, value, "volume");
        return (true);
    } // End of the function
    function set changeFactor(n)
    {
        this.updateTweens(n);
        _sound.setVolume(volume);
        //return (this.changeFactor());
        null;
    } // End of the function
    static var API = 1;
} // End of Class
