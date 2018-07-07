class org.osflash.signals.Signal implements org.osflash.signals.IDispatcher, org.osflash.signals.ISignal
{
    var listenerBoxes, _valueClasses;
    function Signal()
    {
        listenerBoxes = [];
        this.setValueClasses(arguments);
    } // End of the function
    function getNumListeners()
    {
        return (listenerBoxes.length);
    } // End of the function
    function getValueClasses()
    {
        return (_valueClasses);
    } // End of the function
    function add(listener, scope)
    {
        this.registerListener(listener, scope, false);
    } // End of the function
    function addOnce(listener, scope)
    {
        this.registerListener(listener, scope, true);
    } // End of the function
    function remove(listener, scope)
    {
        if (listenersNeedCloning)
        {
            listenerBoxes = listenerBoxes.slice();
            listenersNeedCloning = false;
        } // end if
        var _loc2 = listenerBoxes.length;
        while (_loc2--)
        {
            if (listenerBoxes[_loc2].listener == listener && listenerBoxes[_loc2].scope == scope)
            {
                listenerBoxes.splice(_loc2, 1);
                return;
            } // end if
        } // end while
    } // End of the function
    function removeAll()
    {
        var _loc2 = listenerBoxes.length;
        while (_loc2--)
        {
            this.remove(listenerBoxes[_loc2].listener, listenerBoxes[_loc2].scope);
        } // end while
    } // End of the function
    function dispatch()
    {
        var _loc6;
        for (var _loc3 = 0; _loc3 < _valueClasses.length; ++_loc3)
        {
            if (this.primitiveMatchesValueClass(arguments[_loc3], _valueClasses[_loc3]))
            {
                continue;
            } // end if
            _loc6 = arguments[_loc3];
            if (arguments[_loc3] == null || _loc6 instanceof _valueClasses[_loc3])
            {
                continue;
            } // end if
            throw new Error("Value object <" + _loc6 + "> is not an instance of <" + _valueClasses[_loc3] + ">.");
        } // end of for
        var _loc7 = listenerBoxes;
        var _loc8 = _loc7.length;
        var _loc4;
        var _loc9;
        listenersNeedCloning = true;
        for (var _loc5 = 0; _loc5 < _loc8; ++_loc5)
        {
            _loc4 = _loc7[_loc5];
            if (_loc4.once)
            {
                this.remove(_loc4.listener, _loc4.scope);
            } // end if
            _loc4.listener.apply(_loc4.scope, arguments);
        } // end of for
        listenersNeedCloning = false;
    } // End of the function
    function primitiveMatchesValueClass(primitive, valueClass)
    {
        if (typeof(primitive) == "string" && valueClass == String || typeof(primitive) == "number" && valueClass == Number || typeof(primitive) == "boolean" && valueClass == Boolean)
        {
            return (true);
        } // end if
        return (false);
    } // End of the function
    function setValueClasses(valueClasses)
    {
        _valueClasses = valueClasses || [];
        var _loc2 = _valueClasses.length;
        while (_loc2--)
        {
            if (!(_valueClasses[_loc2] instanceof Function))
            {
                throw new Error("Invalid valueClasses argument: item at index " + _loc2 + " should be a Class but was:<" + _valueClasses[_loc2] + ">.");
            } // end if
        } // end while
    } // End of the function
    function registerListener(listener, scope, once)
    {
        for (var _loc2 = 0; _loc2 < listenerBoxes.length; ++_loc2)
        {
            if (listenerBoxes[_loc2].listener == listener && listenerBoxes[_loc2].scope == scope)
            {
                if (listenerBoxes[_loc2].once && !once)
                {
                    throw new Error("You cannot addOnce() then try to add() the same listener without removing the relationship first.");
                }
                else if (once && !listenerBoxes[_loc2].once)
                {
                    throw new Error("You cannot add() then addOnce() the same listener without removing the relationship first.");
                } // end else if
                return;
            } // end if
        } // end of for
        if (listenersNeedCloning)
        {
            listenerBoxes = listenerBoxes.slice();
        } // end if
        listenerBoxes.push({listener: listener, scope: scope, once: once});
    } // End of the function
    var listenersNeedCloning = false;
} // End of Class
