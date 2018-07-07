class com.clubpenguin.party.BaseParty
{
    static var _shell, _airtower, _interface, _engine, _party, _purchaseItemThrottler, __get__CURRENT_PARTY, _currentParty, _interfaceOverrides, __set__CURRENT_PARTY, __get__interfaceOverrides, __get__itemForSaleOnIglooList, __get__partyIglooListItems;
    function BaseParty()
    {
    } // End of the function
    static function init()
    {
        com.clubpenguin.party.BaseParty.pebug("BASE PARTY - INIT");
        _shell = _global.getCurrentShell();
        _airtower = _global.getCurrentAirtower();
        _interface = _global.getCurrentInterface();
        _engine = _global.getCurrentEngine();
        _party = _global.getCurrentParty();
        _purchaseItemThrottler = new com.clubpenguin.util.EventThrottler();
        com.clubpenguin.party.BaseParty._purchaseItemThrottler.__set__delayBetweenEvents(2000);
    } // End of the function
    static function pebug(msg, prefix)
    {
        if (prefix == undefined)
        {
            prefix = com.clubpenguin.party.BaseParty.CLASS_NAME;
        } // end if
        com.clubpenguin.util.Log.debug(prefix + "::" + msg, com.clubpenguin.util.Log.PARTY);
    } // End of the function
    static function playSound(ui, soundId)
    {
        var _loc1 = new Sound(ui);
        _loc1.attachSound(soundId);
        _loc1.start();
    } // End of the function
    static function setConditionalPartyIconVisibility()
    {
        if (com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().partyIconVisible != undefined)
        {
            com.clubpenguin.party.BaseParty.activatePartyIconOverrides();
        }
        else
        {
            com.clubpenguin.party.BaseParty.pebug("setConditionalPartyIconVisibility(): The current party does not have a getter called partyIconVisible(), please define.", com.clubpenguin.party.BaseParty.OBJECT_UNDEFINED);
        } // end else if
    } // End of the function
    static function checkForFirstTimeLogin(playerObj)
    {
        com.clubpenguin.party.BaseParty.pebug("Checking for first time login");
        com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().checkForFirstTimeLogin(playerObj);
    } // End of the function
    static function set CURRENT_PARTY(party)
    {
        _currentParty = party;
        //return (com.clubpenguin.party.BaseParty.CURRENT_PARTY());
        null;
    } // End of the function
    static function get CURRENT_PARTY()
    {
        if (com.clubpenguin.party.BaseParty._currentParty != undefined)
        {
            return (com.clubpenguin.party.BaseParty._currentParty);
        } // end if
        com.clubpenguin.party.BaseParty.pebug("CURRENT_PARTY is undefined - make sure your main party class sets this value in its init function. Returning BaseParty.", com.clubpenguin.party.BaseParty.OBJECT_UNDEFINED);
        return (com.clubpenguin.party.BaseParty._this);
    } // End of the function
    static function get interfaceOverrides()
    {
        if (com.clubpenguin.party.BaseParty._interfaceOverrides == null)
        {
            _interfaceOverrides = new com.clubpenguin.party.Party_InterfaceOverrides();
        } // end if
        return (com.clubpenguin.party.BaseParty._interfaceOverrides);
    } // End of the function
    static function get itemForSaleOnIglooList()
    {
        //return (com.clubpenguin.party.BaseParty.CURRENT_PARTY().itemOnIglooList);
    } // End of the function
    static function get partyIglooListItems()
    {
        //return (com.clubpenguin.party.BaseParty.CURRENT_PARTY().CONSTANTS.IGLOO_LIST_ITEMS);
    } // End of the function
    static function showPartyIcon()
    {
        com.clubpenguin.party.BaseParty._interface.PARTY_ICON._visible = true;
    } // End of the function
    static function hidePartyIcon()
    {
        com.clubpenguin.party.BaseParty._interface.PARTY_ICON._visible = false;
    } // End of the function
    static function partyIconState()
    {
        if (com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().partyIconVisible)
        {
            com.clubpenguin.party.BaseParty.showPartyIcon();
        }
        else
        {
            com.clubpenguin.party.BaseParty.hidePartyIcon();
        } // end else if
    } // End of the function
    static function showIglooList()
    {
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.BI_IGLOOLIST_ACTION, "view");
        com.clubpenguin.party.BaseParty._interface.showContent(com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.IGLOO_LIST_PATH);
    } // End of the function
    static function showIglooPrompt()
    {
        com.clubpenguin.party.BaseParty._interface.showContent(com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.IGLOO_PROMPT_PATH);
    } // End of the function
    static function activatePartyIconOverrides()
    {
        com.clubpenguin.party.BaseParty.pebug("Activate interface overrides");
        com.clubpenguin.party.BaseParty._interface.showPartyIcon = com.clubpenguin.util.Delegate.create(com.clubpenguin.party.BaseParty._interface, com.clubpenguin.party.BaseParty._party.BaseParty.interfaceOverrides.showPartyIcon);
        com.clubpenguin.party.BaseParty._interface.onPartyIconLoad = com.clubpenguin.util.Delegate.create(com.clubpenguin.party.BaseParty._interface, com.clubpenguin.party.BaseParty._party.BaseParty.interfaceOverrides.onPartyIconLoad);
    } // End of the function
    static function sendBIIglooVisit(isPartyIgloo)
    {
        com.clubpenguin.party.BaseParty.pebug("send bi tracking Igloo Visit");
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(isPartyIgloo ? ("party_item_present") : ("party_item_missing"), "igloo_visit");
    } // End of the function
    static var OBJECT_UNDEFINED = "****[ERROR:Object Undefined]**** ";
    static var CLASS_NAME = "BaseParty";
    static var _this = com.clubpenguin.party.BaseParty;
} // End of Class
