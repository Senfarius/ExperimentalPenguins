class com.clubpenguin.engine.avatar.effect.AvatarEffectEnum
{
    var _flags, _swfName, _symbolName, _tweenDuration, _tweenOptions, __get__attachToPlayer, __get__loopAnimation, __get__playUnderPlayer, __get__stopOnLastFrame, __get__swfName, __get__symbolName, __get__tweenDuration, __get__tweenOptions;
    function AvatarEffectEnum(swfName, symbolName, flags, tweenDuration, tweenOptions)
    {
        super();
        if (flags != undefined)
        {
            _flags = flags;
        }
        else
        {
            _flags = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE;
        } // end else if
        _swfName = swfName;
        _symbolName = symbolName;
        _tweenDuration = tweenDuration;
        _tweenOptions = tweenOptions;
    } // End of the function
    function get tweenDuration()
    {
        return (_tweenDuration);
    } // End of the function
    function get tweenOptions()
    {
        return (_tweenOptions);
    } // End of the function
    function get swfName()
    {
        return (_swfName);
    } // End of the function
    function get symbolName()
    {
        return (_symbolName);
    } // End of the function
    function isFlagSet(flag)
    {
        return ((flag & _flags) != com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    } // End of the function
    function get attachToPlayer()
    {
        return (this.isFlagSet(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER));
    } // End of the function
    function get loopAnimation()
    {
        return (this.isFlagSet(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_LOOP_ANIMATION));
    } // End of the function
    function get stopOnLastFrame()
    {
        return (this.isFlagSet(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_STOP_ON_LAST_FRAME));
    } // End of the function
    function get playUnderPlayer()
    {
        return (this.isFlagSet(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_PLAY_UNDER_PLAYER_DEPTH));
    } // End of the function
    static function fromString(id)
    {
        switch (id)
        {
            case "QuestFoundItem":
            {
                return (com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.QUEST_FOUND_ICON);
            } 
        } // End of switch
        trace ("Unknown of unhandled AvatarEffectEnum id " + id);
        return (com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.NO_EFFECT);
    } // End of the function
    function toString()
    {
        return ("[" + _swfName + "|" + _symbolName + "|" + _flags + "|" + _tweenDuration + "|" + _tweenOptions + "]");
    } // End of the function
    static var LIB_AVATAR_NAME = "avatar";
    static var LIB_AVATAR_DEPTH = 800001;
    static var LIB_SNOW_BALL_NAME = "snowball";
    static var LIB_SNOW_BALL_DEPTH = 1000200;
    static var FLAG_NONE = 0;
    static var FLAG_ATTACH_TO_PLAYER = 1;
    static var FLAG_LOOP_ANIMATION = 2;
    static var FLAG_STOP_ON_LAST_FRAME = 4;
    static var FLAG_PLAY_UNDER_PLAYER_DEPTH = 8;
    static var NO_EFFECT = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum("NO_EFFECT", "NO_EFFECT", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var SMOKE_POOF_BLUE = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "smokePoofBlue", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER);
    static var SMOKE_POOF_BROWN_LARGE = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "smokePoofBrownLarge", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER);
    static var SMOKE_POOF_BROWN_SMALL = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "smokePoofBrownSmall", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER);
    static var COIN_TWIRL = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "coin_twirl", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER);
    static var PUFFLE_BATH_POINT = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "bathPoint", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_PLAY_POINT = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "playPoint", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_SLEEP_POINT = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "sleepPoint", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_EAT_POINT = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "eatPoint", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_BOUNCE_BLUE = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pufflebounce_blue", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_BOUNCE_RED = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pufflebounce_red", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_BOUNCE_BLACK = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pufflebounce_black", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_BOUNCE_BROWN = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pufflebounce_brown", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_BOUNCE_GREEN = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pufflebounce_green", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_BOUNCE_PINK = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pufflebounce_pink", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_BOUNCE_WHITE = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pufflebounce_white", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_BOUNCE_YELLOW = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pufflebounce_yellow", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_BOUNCE_PURPLE = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pufflebounce_purple", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_BOUNCE_ORANGE = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pufflebounce_orange", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_FOUND_COINS = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "treasureHuntFoundCoins", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var QUEST_FOUND_ICON = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "QuestFoundItem", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE, 1, {_x: 50, _y: 490});
    static var MUPPETS_PIE_JOIN_ICON = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pieJoinIcon", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_STOP_ON_LAST_FRAME);
    static var MUPPETS_MIC_JOIN_ICON = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "micJoinIcon", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_STOP_ON_LAST_FRAME);
    static var MUPPETS_CAPE_JOIN_ICON = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "capeJoinIcon", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_STOP_ON_LAST_FRAME);
    static var MUPPETS_TONGS_JOIN_ICON = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "tongsJoinIcon", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_STOP_ON_LAST_FRAME);
    static var MUPPETS_CANE_JOIN_ICON = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "caneJoinIcon", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_STOP_ON_LAST_FRAME);
    static var MUPPETS_BEAKERS_JOIN_ICON = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "beakersJoinIcon", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_STOP_ON_LAST_FRAME);
    static var MUPPETS_DRUM_JOIN_ICON = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "drumJoinIcon", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_STOP_ON_LAST_FRAME);
    static var MUPPETS_MARACAS_JOIN_ICON = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "maracasJoinIcon", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_STOP_ON_LAST_FRAME);
    static var EFFECT_LIBS = [{swfName: com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, depth: com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_DEPTH}];
} // End of Class
