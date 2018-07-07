class com.clubpenguin.util.LogChannel
{
    var __get__bitMask, __get__name;
    function LogChannel(name)
    {
        _name = name;
        _bitMask = 1 << com.clubpenguin.util.LogChannel._numMasks;
        _numMasks = ++com.clubpenguin.util.LogChannel._numMasks;
        com.clubpenguin.util.Log.ALL._bitMask = com.clubpenguin.util.Log.ALL._bitMask + bitMask;
    } // End of the function
    function get name()
    {
        return (_name);
    } // End of the function
    function get bitMask()
    {
        return (_bitMask);
    } // End of the function
    static var _numMasks = 0;
    var _name = "";
    var _bitMask = 0;
} // End of Class
