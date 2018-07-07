class com.clubpenguin.util.state.StateManager
{
    var _defaultTransitionMap, _currentState, __get__currentState;
    function StateManager()
    {
        _defaultTransitionMap = {};
    } // End of the function
    function addDefaultTransition(transition)
    {
        _defaultTransitionMap[transition.eventName] = transition;
    } // End of the function
    function removeDefaultTransition(transition)
    {
        _defaultTransitionMap[transition.eventName] = null;
    } // End of the function
    function changeState(state)
    {
        this.debugTrace("changeState to " + state);
        this.debugTrace("oldState = " + _currentState);
        var _loc2 = _currentState;
        _currentState = state;
        if (_loc2 != null)
        {
            _loc2.onExitState();
        } // end if
        _currentState.onEnterState();
    } // End of the function
    function get currentState()
    {
        return (_currentState);
    } // End of the function
    function onEvent(eventName)
    {
        this.debugTrace("onEvent " + eventName);
        if (_currentState.hasTransitionForEvent(eventName))
        {
            this.debugTrace("Use _currentState transition for event \'" + eventName + "\'");
            this.changeState(_currentState.getTransitionForEvent(eventName).state);
        }
        else if (_defaultTransitionMap[eventName] != null)
        {
            this.debugTrace("Use default transition for event \'" + eventName + "\'");
            this.changeState(_defaultTransitionMap[eventName].state);
        } // end else if
    } // End of the function
    function debugTrace(msg)
    {
        com.clubpenguin.util.Log.debug("StateManager > " + msg, com.clubpenguin.util.Log.DEFAULT);
    } // End of the function
} // End of Class
