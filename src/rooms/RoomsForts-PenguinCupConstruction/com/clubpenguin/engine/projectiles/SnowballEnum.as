class com.clubpenguin.engine.projectiles.SnowballEnum
{
    var _flags, _symbolName, __get__delayAnimStart, __get__hasTail, __get__hasTrail, __get__intelligentSort, __get__isConstructive, __get__isDestructive, __get__isFixed, __get__originAtCenter, __get__originAtHead, __get__playAbovePlayer, __get__playUnderPlayer, __get__playerInvisible, __get__returnsToPlayer, __get__symbolName;
    function SnowballEnum(symbolName, flags)
    {
        super();
        if (flags != undefined)
        {
            _flags = flags;
        }
        else
        {
            _flags = com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE;
        } // end else if
        _symbolName = symbolName;
    } // End of the function
    function get symbolName()
    {
        return (_symbolName);
    } // End of the function
    function isFlagSet(flag)
    {
        return ((flag & _flags) != com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    } // End of the function
    function get hasTail()
    {
        return (this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_HAS_TAIL));
    } // End of the function
    function get isFixed()
    {
        return (this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_IS_FIXED));
    } // End of the function
    function get delayAnimStart()
    {
        return (this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_DELAY_ANIM_START));
    } // End of the function
    function get originAtHead()
    {
        return (this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_ORIGIN_AT_HEAD));
    } // End of the function
    function get originAtCenter()
    {
        return (this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_ORIGIN_AT_CENTER));
    } // End of the function
    function get returnsToPlayer()
    {
        return (this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_RETURNS_TO_PLAYER));
    } // End of the function
    function get playerInvisible()
    {
        return (this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_PLAYER_INVISIBLE));
    } // End of the function
    function get hasTrail()
    {
        return (this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_HAS_TRAIL));
    } // End of the function
    function get isConstructive()
    {
        return (this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_CONSTRUCTIVE));
    } // End of the function
    function get isDestructive()
    {
        return (this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_DESTRUCTIVE));
    } // End of the function
    function get playUnderPlayer()
    {
        return (this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_PLAY_UNDER_PLAYER_DEPTH));
    } // End of the function
    function get playAbovePlayer()
    {
        return (this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_PLAY_ABOVE_PLAYER_DEPTH));
    } // End of the function
    function get intelligentSort()
    {
        return (this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_INTELLIGENT_DEPTH_SORT));
    } // End of the function
    function toString()
    {
        return ("[" + _symbolName + "|" + _flags + "]");
    } // End of the function
    static var FLAG_NONE = 0;
    static var FLAG_HAS_TAIL = 2;
    static var FLAG_IS_FIXED = 4;
    static var FLAG_ORIGIN_AT_HEAD = 8;
    static var FLAG_ORIGIN_AT_CENTER = 16;
    static var FLAG_PLAY_ABOVE_PLAYER_DEPTH = 32;
    static var FLAG_DELAY_ANIM_START = 64;
    static var FLAG_RETURNS_TO_PLAYER = 128;
    static var FLAG_PLAYER_INVISIBLE = 256;
    static var FLAG_HAS_TRAIL = 512;
    static var FLAG_CONSTRUCTIVE = 1024;
    static var FLAG_DESTRUCTIVE = 2048;
    static var FLAG_PLAY_UNDER_PLAYER_DEPTH = 4096;
    static var FLAG_INTELLIGENT_DEPTH_SORT = 8192;
    static var SNOW_BALL_NORMAL = new com.clubpenguin.engine.projectiles.SnowballEnum("ballnormal", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_CANDY = new com.clubpenguin.engine.projectiles.SnowballEnum("ballCandy", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_EGG = new com.clubpenguin.engine.projectiles.SnowballEnum("ballEgg", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_FLOUR = new com.clubpenguin.engine.projectiles.SnowballEnum("ballFlour", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_HAY = new com.clubpenguin.engine.projectiles.SnowballEnum("ballHay", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_MILK = new com.clubpenguin.engine.projectiles.SnowballEnum("ballMilk", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_TIRE = new com.clubpenguin.engine.projectiles.SnowballEnum("ballTire", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_LARGE = new com.clubpenguin.engine.projectiles.SnowballEnum("ballLarge", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_DESTRUCTIVE);
    static var SNOW_BALL_ICE = new com.clubpenguin.engine.projectiles.SnowballEnum("ballIce", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_BARF = new com.clubpenguin.engine.projectiles.SnowballEnum("ballBarf", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_FOOD = new com.clubpenguin.engine.projectiles.SnowballEnum("ballFood", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_INVISIBLE = new com.clubpenguin.engine.projectiles.SnowballEnum("ballInvisible", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_PIZZA = new com.clubpenguin.engine.projectiles.SnowballEnum("ballPizza", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_MAGIC = new com.clubpenguin.engine.projectiles.SnowballEnum("ballMagic", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_FIRE = new com.clubpenguin.engine.projectiles.SnowballEnum("ballFire", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_HAS_TAIL | com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_DELAY_ANIM_START | com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_PLAY_UNDER_PLAYER_DEPTH);
} // End of Class
