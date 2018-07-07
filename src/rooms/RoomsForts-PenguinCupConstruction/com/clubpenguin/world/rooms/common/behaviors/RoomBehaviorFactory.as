class com.clubpenguin.world.rooms.common.behaviors.RoomBehaviorFactory
{
    function RoomBehaviorFactory()
    {
    } // End of the function
    static function getInstance()
    {
        if (com.clubpenguin.world.rooms.common.behaviors.RoomBehaviorFactory._instance == null)
        {
            _instance = new com.clubpenguin.world.rooms.common.behaviors.RoomBehaviorFactory();
        } // end if
        return (com.clubpenguin.world.rooms.common.behaviors.RoomBehaviorFactory._instance);
    } // End of the function
    function getRoomBehavior(environmentType)
    {
        switch (environmentType.name)
        {
            case "water":
            {
                var _loc1 = new com.clubpenguin.world.rooms.common.behaviors.WaterRoomBehavior();
                return (_loc1);
            } 
        } // End of switch
        com.clubpenguin.util.Log.error("Environment name: " + environmentType.name + " does not exist in RoomBehaviorEnum");
        return (null);
    } // End of the function
    static var _instance = null;
} // End of Class
