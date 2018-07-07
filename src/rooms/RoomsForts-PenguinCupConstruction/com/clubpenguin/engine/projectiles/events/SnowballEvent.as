class com.clubpenguin.engine.projectiles.events.SnowballEvent
{
    var type, id, snowballMC, player_id, snowballType, hit_player_id, __get__x, __get__y;
    function SnowballEvent(_type, _id, _snowballMC, _player_id, _snowballType, _hit_player_id)
    {
        type = _type;
        id = _id;
        snowballMC = _snowballMC;
        player_id = _player_id;
        snowballType = _snowballType;
        hit_player_id = _hit_player_id;
    } // End of the function
    function get x()
    {
        return (snowballMC._x);
    } // End of the function
    function get y()
    {
        return (snowballMC._y);
    } // End of the function
    function clone()
    {
        return (new com.clubpenguin.engine.projectiles.events.SnowballEvent(type, id, snowballMC, player_id, snowballType, hit_player_id));
    } // End of the function
    function toString()
    {
        return ("[" + type + " | " + id + " | " + snowballMC + " | " + player_id + " | " + snowballType + " | " + hit_player_id + " ]");
    } // End of the function
    static var SNOWBALL_HIT = "snowballHit";
    static var SNOWBALL_MISS = "snowballMiss";
    static var SNOWBALL_BOUNCE = "snowballBounce";
} // End of Class
