class com.clubpenguin.engine.avatar.model.AvatarAttributesVO
{
    var spriteAlpha, spriteScale, spriteSpeed, ignoresBlockLayer, isInvisible, isFloating;
    function AvatarAttributesVO()
    {
        spriteAlpha = 100;
        spriteScale = 100;
        spriteSpeed = 100;
        ignoresBlockLayer = false;
        isInvisible = false;
        isFloating = false;
    } // End of the function
    function equalsDefault()
    {
        return (this.equals(com.clubpenguin.engine.avatar.model.AvatarAttributesVO._defaultAttributes));
    } // End of the function
    function equals(other)
    {
        return (spriteAlpha == other.spriteAlpha && spriteScale == other.spriteScale && spriteSpeed == other.spriteSpeed && ignoresBlockLayer == other.ignoresBlockLayer && isInvisible == other.isInvisible && isFloating == other.isFloating);
    } // End of the function
    function clone()
    {
        var _loc2 = new com.clubpenguin.engine.avatar.model.AvatarAttributesVO();
        _loc2.spriteAlpha = spriteAlpha;
        _loc2.spriteScale = spriteScale;
        _loc2.spriteSpeed = spriteSpeed;
        _loc2.ignoresBlockLayer = ignoresBlockLayer;
        _loc2.isInvisible = isInvisible;
        _loc2.isFloating = isFloating;
        return (_loc2);
    } // End of the function
    function toString()
    {
        var _loc2 = "";
        _loc2 = _loc2 + "AvatarAttributesVO{";
        _loc2 = _loc2 + (" spriteAlpha: " + spriteAlpha);
        _loc2 = _loc2 + (", spriteScale: " + spriteScale);
        _loc2 = _loc2 + (", spriteSpeed: " + spriteSpeed);
        _loc2 = _loc2 + (", ignoresBlockLayer: " + ignoresBlockLayer);
        _loc2 = _loc2 + (", isInvisible: " + isInvisible);
        _loc2 = _loc2 + (", isFloating: " + isFloating);
        _loc2 = _loc2 + "}";
        return (_loc2);
    } // End of the function
    static var _defaultAttributes = new com.clubpenguin.engine.avatar.model.AvatarAttributesVO();
} // End of Class
