class com.clubpenguin.net.BridgeFilter
{
    var airtower;
    function BridgeFilter()
    {
        airtower = new com.clubpenguin.net.Airtower();
    } // End of the function
    static function messageIsSentToAS3(airtower, eventType)
    {
        switch (eventType)
        {
            case airtower.ADD_PUFFLE_CARE_ITEM:
            case airtower.GET_MY_PLAYER_PUFFLES:
            case airtower.GET_PLAYER_PUFFLES:
            case airtower.WALK_PUFFLE:
            case airtower.REST_PUFFLE:
            case airtower.INTERACTION_REST:
            case airtower.PLAY_PUFFLE:
            case airtower.JOIN_WORLD:
            case airtower.JOIN_ROOM:
            case airtower.PLAYER_HANDLER:
            case airtower.ADOPT_PUFFLE:
            case airtower.PUFFLE_VISITOR_HAT_UPDATE:
            case com.clubpenguin.net.BridgeFilter.GET_PUFFLE_CARE_INVENTORY:
            case com.clubpenguin.net.BridgeFilter.GET_MY_PUFFLES_STATS:
            case com.clubpenguin.net.BridgeFilter.PUFFLE_CARE_ITEM_DELIVERED:
            case com.clubpenguin.net.BridgeFilter.RETURN_PUFFLE:
            case com.clubpenguin.net.BridgeFilter.PUFFLE_PLAYED_GAME:
            case com.clubpenguin.net.BridgeFilter.CAN_LIKE_IGLOO:
            case com.clubpenguin.net.BridgeFilter.LIKE_IGLOO:
            case com.clubpenguin.net.BridgeFilter.GET_IGLOO_LIKE_BY:
            case com.clubpenguin.net.BridgeFilter.PLAYER_BY_SWID_USERNAME:
            case com.clubpenguin.net.BridgeFilter.LIKE_UPDATE_EVENT:
            case com.clubpenguin.net.BridgeFilter.GET_SNOWBALL_PLAYER_DETAILS:
            case com.clubpenguin.net.BridgeFilter.GET_PUFFLE_QUIZ:
            case com.clubpenguin.net.BridgeFilter.UPDATE_PUFFLE_QUIZ:
            case com.clubpenguin.net.BridgeFilter.CHECK_PUFFLE_NAME:
            case com.clubpenguin.net.BridgeFilter.OK:
            case com.clubpenguin.net.BridgeFilter.INVALID_NAME:
            case com.clubpenguin.net.BridgeFilter.NOT_ENOUGH_COINS:
            case com.clubpenguin.net.BridgeFilter.PUFFLE_ADOPTION_BI:
            case com.clubpenguin.net.BridgeFilter.SEND_CARE_BI:
            case com.clubpenguin.net.BridgeFilter.GET_PUFFLE_HANDLER:
            case com.clubpenguin.net.BridgeFilter.GAME_OVER:
            case airtower.HANDLE_ERROR:
            case com.clubpenguin.net.BridgeFilter.GET_CARD_DATA:
            case airtower.GET_NINJA_LEVEL:
            case airtower.GET_FIRE_LEVEL:
            case airtower.GET_WATER_LEVEL:
            case airtower.GET_SNOW_LEVEL:
            case com.clubpenguin.net.BridgeFilter.TRIAL_OFFER:
            case com.clubpenguin.net.BridgeFilter.TRIAL_ACCEPT:
            case com.clubpenguin.net.BridgeFilter.TRIAL_DAYS_LEFT:
            case com.clubpenguin.net.BridgeFilter.TRIAL_EXPIRED:
            case com.clubpenguin.net.BridgeFilter.TRIAL_ACTIVE:
            case com.clubpenguin.net.BridgeFilter.GET_SNOWBALL_PLAYER_DETAILS:
            case com.clubpenguin.net.BridgeFilter.PUFFLE_FOUND_TREASURE:
            case com.clubpenguin.net.BridgeFilter.MODERATOR_MESSAGE_TYPE:
            case com.clubpenguin.net.BridgeFilter.BANNING_MESSAGE_TYPE:
            case com.clubpenguin.net.BridgeFilter.INIT_BAN_MESSAGE_TYPE:
            case com.clubpenguin.net.BridgeFilter.CARE_STATION_MENU_MESSAGE_TYPE:
            case airtower.GET_AB_TEST_DATA:
            {
                return (true);
                break;
            } 
        } // End of switch
        return (false);
    } // End of the function
    static var GET_PUFFLE_CARE_INVENTORY = "pgpi";
    static var GET_MY_PUFFLES_STATS = "pgmps";
    static var PUFFLE_CARE_ITEM_DELIVERED = "pcid";
    static var RETURN_PUFFLE = "prp";
    static var PUFFLE_PLAYED_GAME = "ppg";
    static var CAN_LIKE_IGLOO = "cli";
    static var LIKE_IGLOO = "li";
    static var GET_IGLOO_LIKE_BY = "gili";
    static var PLAYER_BY_SWID_USERNAME = "pbsu";
    static var LIKE_UPDATE_EVENT = "lue";
    static var GET_SNOWBALL_PLAYER_DETAILS = "gpsd";
    static var GET_PUFFLE_QUIZ = "pgpq";
    static var UPDATE_PUFFLE_QUIZ = "pupq";
    static var CHECK_PUFFLE_NAME = "pcn";
    static var INVALID_NAME = "441";
    static var NOT_ENOUGH_COINS = "401";
    static var PUFFLE_ADOPTION_BI = "bipa";
    static var SEND_CARE_BI = "bipc";
    static var GET_PUFFLE_HANDLER = "phg";
    static var OK = "200";
    static var TRIAL_OFFER = "sdto";
    static var TRIAL_ACCEPT = "sdta";
    static var TRIAL_DAYS_LEFT = "sdtd";
    static var TRIAL_EXPIRED = "sdtx";
    static var TRIAL_ACTIVE = "sdtac";
    static var PUFFLE_FOUND_TREASURE = "puffledig";
    static var GET_CARD_DATA = "gcd";
    static var MODERATOR_MESSAGE_TYPE = "moderatormessage";
    static var BANNING_MESSAGE_TYPE = "ban";
    static var INIT_BAN_MESSAGE_TYPE = "initban";
    static var CARE_STATION_MENU_MESSAGE_TYPE = "carestationmenu";
    static var GAME_OVER = "zo";
} // End of Class
