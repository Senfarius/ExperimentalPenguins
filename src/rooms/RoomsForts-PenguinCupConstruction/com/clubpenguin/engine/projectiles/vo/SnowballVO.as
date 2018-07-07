class com.clubpenguin.engine.projectiles.vo.SnowballVO
{
    var _type, _maxHeightOffset, _wait, _duration, _showAnimation, _alpha, _scale, __get__type, __get__alpha, __get__duration, __get__maxHeightOffset, __get__scale, __get__showAnimation, __set__type, __get__wait;
    function SnowballVO(type, maxHeightOffset, wait, duration, showAnimation, alpha, scale)
    {
        _type = type;
        _maxHeightOffset = maxHeightOffset;
        _wait = wait;
        _duration = duration != undefined ? (duration) : (-1);
        _showAnimation = showAnimation != undefined ? (showAnimation) : (true);
        _alpha = alpha != undefined ? (alpha) : (100);
        _scale = scale != undefined ? (scale) : (100);
    } // End of the function
    function set type(snowballType)
    {
        _type = snowballType;
        //return (this.type());
        null;
    } // End of the function
    function get type()
    {
        return (_type);
    } // End of the function
    function get maxHeightOffset()
    {
        return (_maxHeightOffset);
    } // End of the function
    function get wait()
    {
        return (_wait);
    } // End of the function
    function get duration()
    {
        return (_duration);
    } // End of the function
    function get showAnimation()
    {
        return (_showAnimation);
    } // End of the function
    function get alpha()
    {
        return (_alpha);
    } // End of the function
    function get scale()
    {
        return (_scale);
    } // End of the function
    function clone()
    {
        return (new com.clubpenguin.engine.projectiles.vo.SnowballVO(_type, _maxHeightOffset, _wait, _duration, _showAnimation, _alpha, _scale));
    } // End of the function
    function toString()
    {
        return ("[" + _type + "|" + _maxHeightOffset + "|" + _wait + "|" + _duration + "|" + _showAnimation + "|" + _alpha + "|" + _scale + "]");
    } // End of the function
} // End of Class
