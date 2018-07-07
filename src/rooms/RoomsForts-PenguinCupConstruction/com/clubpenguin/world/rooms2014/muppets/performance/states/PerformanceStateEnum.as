class com.clubpenguin.world.rooms2014.muppets.performance.states.PerformanceStateEnum
{
    var _id, _name, __get__id, __get__name;
    function PerformanceStateEnum(name)
    {
        NEXT_ID = ++com.clubpenguin.world.rooms2014.muppets.performance.states.PerformanceStateEnum.NEXT_ID;
        _id = com.clubpenguin.world.rooms2014.muppets.performance.states.PerformanceStateEnum.NEXT_ID;
        _name = name;
    } // End of the function
    function get id()
    {
        return (_id);
    } // End of the function
    function get name()
    {
        return (_name);
    } // End of the function
    function toString()
    {
        //return ("PerformanceStateEnum{ id=" + this.id() + ", name=" + this.__get__name() + "}");
    } // End of the function
    static var NEXT_ID = 0;
    static var PERFORMING = new com.clubpenguin.world.rooms2014.muppets.performance.states.PerformanceStateEnum("performing");
    static var BOARDING = new com.clubpenguin.world.rooms2014.muppets.performance.states.PerformanceStateEnum("boarding");
} // End of Class
