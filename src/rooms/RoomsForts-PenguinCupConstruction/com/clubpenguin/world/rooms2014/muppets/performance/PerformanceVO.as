class com.clubpenguin.world.rooms2014.muppets.performance.PerformanceVO
{
    var _id, hostId, participant, state, __get__id;
    function PerformanceVO()
    {
        NEXT_ID = ++com.clubpenguin.world.rooms2014.muppets.performance.PerformanceVO.NEXT_ID;
        _id = com.clubpenguin.world.rooms2014.muppets.performance.PerformanceVO.NEXT_ID;
    } // End of the function
    static function fromObject(obj)
    {
        var _loc1 = new com.clubpenguin.world.rooms2014.muppets.performance.PerformanceVO();
        _loc1.hostId = obj.hostId;
        _loc1.participant = obj.participant;
        _loc1.state = obj.open ? (com.clubpenguin.world.rooms2014.muppets.performance.states.PerformanceStateEnum.BOARDING) : (com.clubpenguin.world.rooms2014.muppets.performance.states.PerformanceStateEnum.PERFORMING);
        return (_loc1);
    } // End of the function
    function get id()
    {
        return (_id);
    } // End of the function
    function clone()
    {
        var _loc2 = new com.clubpenguin.world.rooms2014.muppets.performance.PerformanceVO();
        _loc2.hostId = hostId;
        _loc2.participant = participant;
        _loc2.state = state;
        return (_loc2);
    } // End of the function
    function containsParticipant(playerId)
    {
        if (playerId == participant)
        {
            return (true);
        } // end if
        return (false);
    } // End of the function
    function containsPlayer(playerId)
    {
        return (hostId == playerId || this.containsParticipant(playerId) ? (true) : (false));
    } // End of the function
    function participantEqual(other)
    {
        if (other.participant == participant)
        {
            return (true);
        } // end if
        return (false);
    } // End of the function
    function equals(other)
    {
        return (hostId == other.hostId && state == other.state && this.participantEqual(other));
    } // End of the function
    function toString()
    {
        return ("PerformanceVO{ hostId=" + hostId + ", participant=" + participant + ", state=" + state + " }");
    } // End of the function
    static var NEXT_ID = 0;
} // End of Class
