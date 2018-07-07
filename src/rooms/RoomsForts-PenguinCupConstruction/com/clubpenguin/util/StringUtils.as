class com.clubpenguin.util.StringUtils
{
    function StringUtils()
    {
    } // End of the function
    static function capitalizeFirstLetter(source)
    {
        return (source.substr(0, 1).toUpperCase() + source.substr(1, source.length));
    } // End of the function
    static function toTitleCase(source)
    {
        var _loc2 = source.split(" ");
        var _loc3 = _loc2.length;
        for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
        {
            _loc2[_loc1] = com.clubpenguin.util.StringUtils.capitalizeFirstLetter(_loc2[_loc1]);
        } // end of for
        return (_loc2.join(" "));
    } // End of the function
    static function lastChar(string)
    {
        if (typeof(string) != "string")
        {
            return ("");
        } // end if
        return (string.substr(-1, 1));
    } // End of the function
    static function removeLastChar(string)
    {
        if (typeof(string) != "string")
        {
            return ("");
        } // end if
        return (string.substring(0, string.length - 1));
    } // End of the function
    static function ensureTrailingSlash(string)
    {
        if (typeof(string) != "string")
        {
            return ("");
        } // end if
        if (com.clubpenguin.util.StringUtils.lastChar(string) != "/")
        {
            string = string + "/";
        } // end if
        return (string);
    } // End of the function
    static function removeTrailingSlash(string)
    {
        if (typeof(string) != "string")
        {
            return ("");
        } // end if
        if (com.clubpenguin.util.StringUtils.lastChar(string) == "/")
        {
            return (com.clubpenguin.util.StringUtils.removeLastChar(string));
        } // end if
        return (string);
    } // End of the function
    static function replaceString(target, word, message)
    {
        return (message.split(target).join(word));
    } // End of the function
    static function ResizeTextToFit(txt)
    {
        if (txt.textWidth > txt._width)
        {
            var _loc4 = txt.text;
            txt.text = "A";
            var _loc3 = txt.textHeight;
            txt.text = _loc4;
            while (txt.textWidth > txt._width)
            {
                var _loc2 = txt.getTextFormat();
                --_loc2.size;
                txt.setTextFormat(_loc2);
            } // end while
            txt._y = txt._y + (_loc3 - txt.textHeight);
        } // end if
    } // End of the function
} // End of Class
