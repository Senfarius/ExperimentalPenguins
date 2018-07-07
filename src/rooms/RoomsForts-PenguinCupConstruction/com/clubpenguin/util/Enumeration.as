class com.clubpenguin.util.Enumeration
{
    var __constructor__, _value, __get__name, __get__value;
    function Enumeration(value_p)
    {
        var _loc2 = __constructor__;
        if (value_p == null)
        {
            _value = _loc2.__enumCount == null ? (_loc2.__enumCount = 0) : (++_loc2.__enumCount);
        }
        else
        {
            _value = value_p;
            if (_loc2.__enumCount == null || value_p > _loc2.__enumCount)
            {
                _loc2.__enumCount = value_p;
            } // end if
        } // end else if
    } // End of the function
    function get name()
    {
        for (var _loc2 in __constructor__)
        {
            if (this == __constructor__[_loc2])
            {
                return (_loc2);
            } // end if
        } // end of for...in
        return (null);
    } // End of the function
    function get value()
    {
        return (_value);
    } // End of the function
} // End of Class
