class com.clubpenguin.shell.puffle.PuffleHatEnum extends com.clubpenguin.util.Enumeration
{
    var _name, __get__name;
    function PuffleHatEnum(name)
    {
        super();
        _name = name;
    } // End of the function
    function get name()
    {
        return (_name);
    } // End of the function
    function toString()
    {
        return ("[PuffleHatEnum name=\"" + _name + "\"]");
    } // End of the function
    static var EMPTY_HAT = new com.clubpenguin.shell.puffle.PuffleHatEnum("empty hat");
    static var ACTUAL_HAT = new com.clubpenguin.shell.puffle.PuffleHatEnum("actual hat");
} // End of Class
