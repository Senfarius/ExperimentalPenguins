class com.clubpenguin.util.state.BaseState implements com.clubpenguin.util.state.IState
{
    var _manager, _transitionMap;
    function BaseState(manager)
    {
        _manager = manager;
        _transitionMap = {};
    } // End of the function
    function onEnterState()
    {
    } // End of the function
    function onExitState()
    {
    } // End of the function
    function getManager()
    {
        return (_manager);
    } // End of the function
    function addTransition(transition)
    {
        _transitionMap[transition.eventName] = transition;
    } // End of the function
    function removeTransition(transition)
    {
        _transitionMap[transition.eventName] = null;
    } // End of the function
    function clearTransitions()
    {
        _transitionMap = {};
    } // End of the function
    function hasTransitionForEvent(eventName)
    {
        return (_transitionMap[eventName] != null);
    } // End of the function
    function getTransitionForEvent(eventName)
    {
        return (_transitionMap[eventName]);
    } // End of the function
} // End of Class
