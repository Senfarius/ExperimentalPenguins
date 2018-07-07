class com.clubpenguin.world.rooms2014.muppets.MuppetsParty
{
    static var _shell, _airtower, _interface, _engine, _party, _serverCookieService, _serverCookie, _purchaseItemThrottler, __get__engineOverrides, _quests, __get__partyCookie, _engineOverrides, muppetDialogueIndex, __get__isActive, __get__itemOnIglooList, __get__partyIconVisible;
    function MuppetsParty()
    {
    } // End of the function
    static function init()
    {
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty.pebug("MUPPETS PARTY - INIT");
        com.clubpenguin.party.BaseParty.CLASS_NAME = com.clubpenguin.world.rooms2014.muppets.MuppetsParty._this.CLASS_NAME;
        com.clubpenguin.party.BaseParty.__set__CURRENT_PARTY(com.clubpenguin.world.rooms2014.muppets.MuppetsParty._this);
        _isActive = true;
        _shell = _global.getCurrentShell();
        _airtower = _global.getCurrentAirtower();
        _interface = _global.getCurrentInterface();
        _engine = _global.getCurrentEngine();
        _party = _global.getCurrentParty();
        _serverCookieService = com.clubpenguin.world.rooms2014.muppets.MuppetsParty._shell.getServerCookieService();
        _serverCookie = new com.clubpenguin.world.rooms2014.muppets.vo.MuppetsPartyCookieVO(com.clubpenguin.world.rooms2014.muppets.MuppetsParty.PARTY_COOKIE_ID);
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty._serverCookieService.registerCookieVO(com.clubpenguin.world.rooms2014.muppets.MuppetsParty._serverCookie.getID(), com.clubpenguin.world.rooms2014.muppets.MuppetsParty._serverCookie);
        _purchaseItemThrottler = new com.clubpenguin.util.EventThrottler();
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty._purchaseItemThrottler.__set__delayBetweenEvents(2000);
        com.clubpenguin.party.BaseParty.setConditionalPartyIconVisibility();
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty.__get__engineOverrides().init();
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty.activateEngineOverrides();
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty._airtower.addListener(com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.PARTY_SETTINGS_RESPONSE_NAME, com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.muppets.MuppetsParty._this, com.clubpenguin.world.rooms2014.muppets.MuppetsParty.handleUpdatePartySettings));
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty._shell.addListener(com.clubpenguin.world.rooms2014.muppets.MuppetsParty._shell.ROOM_INITIATED, com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.muppets.MuppetsParty._this, com.clubpenguin.world.rooms2014.muppets.MuppetsParty.onRoomInitialized));
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty._shell.addListener(com.clubpenguin.world.rooms2014.muppets.MuppetsParty._shell.SEND_EMOTE, com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.muppets.MuppetsParty._this, com.clubpenguin.world.rooms2014.muppets.MuppetsParty.onPlayerEmote));
        com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.init();
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty.initKermitAvatar();
    } // End of the function
    static function onRoomInitialized()
    {
    } // End of the function
    static function onPlayerEmote(event)
    {
        if (com.clubpenguin.world.rooms2014.muppets.MuppetsParty._shell.isMyPlayer(event.player_id))
        {
            if (event.emote_id == 32)
            {
                var _loc3 = random(2) + 1;
                var _loc1 = new Sound(com.clubpenguin.world.rooms2014.muppets.MuppetsParty._interface);
                _loc1.attachSound("sfx_emote_clapping_" + _loc3);
                _loc1.start();
            }
            else if (event.emote_id == 33)
            {
                _loc3 = random(2) + 1;
                _loc1 = new Sound(com.clubpenguin.world.rooms2014.muppets.MuppetsParty._interface);
                _loc1.attachSound("sfx_emote_pie_" + _loc3);
                _loc1.start();
            } // end if
        } // end else if
    } // End of the function
    static function get partyCookie()
    {
        return (com.clubpenguin.world.rooms2014.muppets.MuppetsParty._serverCookie);
    } // End of the function
    static function handleUpdatePartySettings(data)
    {
        var _loc5 = com.clubpenguin.util.JSONParser.parse(data[1]);
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty._airtower.removeListener(com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.PARTY_SETTINGS_RESPONSE_NAME, com.clubpenguin.world.rooms2014.muppets.MuppetsParty.handleUpdatePartySettings);
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.PARTY_DAY = _loc5.partySettings.unlockDayIndex;
        _quests = new Array();
        var _loc4 = _loc5.muppetList;
        for (var _loc3 = 0; _loc3 < _loc4.length; ++_loc3)
        {
            var _loc1 = new com.clubpenguin.world.rooms2014.muppets.vo.MuppetQuestInfoVO();
            var _loc2 = _loc4[_loc3];
            _loc1.id = _loc2.id;
            _loc1.name = _loc2.name;
            _loc1.roomId = _loc2.roomId;
            _loc1.interactiveItemId = _loc2.interactiveItemId;
            _loc1.hatId = _loc2.hatId;
            com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests.push(_loc1);
        } // end of for
    } // End of the function
    static function get isActive()
    {
        return (com.clubpenguin.world.rooms2014.muppets.MuppetsParty._isActive);
    } // End of the function
    static function pebug(msg, prefix)
    {
        com.clubpenguin.party.BaseParty.pebug(msg, prefix);
    } // End of the function
    static function playSound(ui, soundId)
    {
        com.clubpenguin.party.BaseParty.playSound(ui, soundId);
    } // End of the function
    static function checkForFirstTimeLogin(playerObj)
    {
        if (com.clubpenguin.world.rooms2014.muppets.MuppetsParty._shell.getMyPlayerId() != playerObj.player_id || com.clubpenguin.world.rooms2014.muppets.MuppetsParty._shell.getRoomObject().room_id == 112)
        {
            return;
        } // end if
        if (com.clubpenguin.world.rooms2014.muppets.MuppetsParty.__get__partyCookie().__get__login() == 0)
        {
            com.clubpenguin.world.rooms2014.muppets.MuppetsParty._interface.showContent(com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.LOGIN_PROMPT_PATH);
        } // end if
    } // End of the function
    static function showMemberContentOopsMessage()
    {
    } // End of the function
    static function showConstantineWantedPoster()
    {
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty._interface.showContent(com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.CONSTANTINE_WANTED_POSTER_PATH);
    } // End of the function
    static function get engineOverrides()
    {
        if (com.clubpenguin.world.rooms2014.muppets.MuppetsParty._engineOverrides == null)
        {
            _engineOverrides = new com.clubpenguin.world.rooms2014.muppets.MuppetsParty_EngineOverrides();
        } // end if
        return (com.clubpenguin.world.rooms2014.muppets.MuppetsParty._engineOverrides);
    } // End of the function
    static function get partyIconVisible()
    {
        if (com.clubpenguin.world.rooms2014.muppets.MuppetsParty.__get__partyCookie().__get__login() == 1)
        {
            return (true);
        } // end if
        return (false);
    } // End of the function
    static function getMuppetByName(muppetName)
    {
        for (var _loc1 = 0; _loc1 < com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests.length; ++_loc1)
        {
            if (com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests[_loc1].name == muppetName)
            {
                return (com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests[_loc1]);
            } // end if
        } // end of for
        return (null);
    } // End of the function
    static function getInteractiveItemByMuppet(muppetName)
    {
        for (var _loc1 = 0; _loc1 < com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests.length; ++_loc1)
        {
            if (com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests[_loc1].name == muppetName)
            {
                return (com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests[_loc1].interactiveItemId);
            } // end if
        } // end of for
        return (-1);
    } // End of the function
    static function getRewardByUnlockDay(day)
    {
        for (var _loc1 = 0; _loc1 < com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests.length; ++_loc1)
        {
            if (com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests[_loc1].id == day)
            {
                return (com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests[_loc1].hatId);
            } // end if
        } // end of for
        return;
    } // End of the function
    static function getRewardByInteractiveItem(itemID)
    {
        for (var _loc1 = 0; _loc1 < com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests.length; ++_loc1)
        {
            if (com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests[_loc1].interactiveItemId == itemID)
            {
                return (com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests[_loc1].hatId);
            } // end if
        } // end of for
        return;
    } // End of the function
    static function getMuppetByInteractiveItem(itemID)
    {
        for (var _loc1 = 0; _loc1 < com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests.length; ++_loc1)
        {
            if (com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests[_loc1].interactiveItemId == itemID)
            {
                return (com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests[_loc1].name);
            } // end if
        } // end of for
        return;
    } // End of the function
    static function getInteractiveItemByUnlockDay(day)
    {
        for (var _loc1 = 0; _loc1 < com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests.length; ++_loc1)
        {
            if (com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests[_loc1].id == day)
            {
                return (com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests[_loc1].interactiveItemId);
            } // end if
        } // end of for
        return (-1);
    } // End of the function
    static function getUnlockDayByInteractiveItem(itemID)
    {
        for (var _loc1 = 0; _loc1 < com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests.length; ++_loc1)
        {
            if (com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests[_loc1].interactiveItemId == itemID)
            {
                return (com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests[_loc1].id);
            } // end if
        } // end of for
        return (-1);
    } // End of the function
    static function get itemOnIglooList()
    {
        return (new com.clubpenguin.party.items.IglooPartyItem(com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.IGLOO_LIST_ITEM_ID));
    } // End of the function
    static function openQuestUI()
    {
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty._interface.showContent(com.clubpenguin.world.rooms2014.muppets.MuppetsPartyConstants.QUEST_UI_PATH);
    } // End of the function
    static function showMuppetsIglooList()
    {
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction("muppets_igloo_list", "view");
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty._interface.showContent(com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.IGLOO_LIST_PATH);
    } // End of the function
    static function showIglooPrompt()
    {
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty._interface.showContent(com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.IGLOO_PROMPT_PATH);
    } // End of the function
    static function checkAllQuestsCompleted()
    {
        if (com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.PARTY_DAY < com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.NUM_MUPPET_QUESTS - 1)
        {
            return (false);
        } // end if
        for (var _loc1 = 0; _loc1 < com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.NUM_MUPPET_QUESTS; ++_loc1)
        {
            if (!com.clubpenguin.world.rooms2014.muppets.MuppetsParty.__get__partyCookie().isMuppetMessageViewed(_loc1, 0) || !com.clubpenguin.world.rooms2014.muppets.MuppetsParty.__get__partyCookie().isMuppetMessageViewed(_loc1, 1))
            {
                return (false);
            } // end if
        } // end of for
        return (true);
    } // End of the function
    static function getQuestInfo(questIndex)
    {
        return (com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests[questIndex]);
    } // End of the function
    static function configureMuppet(muppetMC, muppetTriggerMC, muppetName)
    {
        var _loc1 = com.clubpenguin.world.rooms2014.muppets.MuppetsParty.getMuppetByName(muppetName);
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty.pebug("configureMuppet(" + muppetMC + "," + muppetName + ")");
        if (_loc1 != null)
        {
            if (com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.PARTY_DAY < _loc1.id || !com.clubpenguin.world.rooms2014.muppets.MuppetsParty.isMuppetViewable(_loc1))
            {
                muppetMC.gotoAndStop("empty");
            }
            else
            {
                muppetTriggerMC.triggerFunction = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.muppets.MuppetsParty, com.clubpenguin.world.rooms2014.muppets.MuppetsParty.handleMuppetClicked, muppetMC, _loc1);
            } // end if
        } // end else if
    } // End of the function
    static function isMuppetViewable(muppetQuestInfo)
    {
        if (com.clubpenguin.world.rooms2014.muppets.MuppetsParty._shell.isMyPlayerMember() && !com.clubpenguin.world.rooms2014.muppets.MuppetsParty._shell.isItemInMyInventory(muppetQuestInfo.interactiveItemId))
        {
            return (true);
        }
        else if (!com.clubpenguin.world.rooms2014.muppets.MuppetsParty._shell.isMyPlayerMember() && !com.clubpenguin.world.rooms2014.muppets.MuppetsParty.__get__partyCookie().isMuppetMessageViewed(muppetQuestInfo.id, 0))
        {
            return (true);
        } // end else if
        return (false);
    } // End of the function
    static function handleMuppetClicked(muppetMC, muppetQuestInfo)
    {
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty.logMuppetClick(muppetQuestInfo.name);
        muppetMC.gotoAndStop("inactive");
        muppetDialogueIndex = muppetQuestInfo.id;
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty._interface.showContent(com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.MUPPETS_INSTRUCTIONS_DIALOGUE_PATH);
    } // End of the function
    static function activateEngineOverrides()
    {
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty.pebug("Activate engine overrides");
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty._engine.sendPlayerFrame = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.muppets.MuppetsParty._engine, com.clubpenguin.world.rooms2014.muppets.MuppetsParty.__get__engineOverrides().sendPlayerFrame);
    } // End of the function
    static function setLoginPromptViewed()
    {
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty._airtower.send(com.clubpenguin.world.rooms2014.muppets.MuppetsParty._airtower.PLAY_EXT, com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.MUPPETS_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.LOGIN_VIEWED_COMMAND, [0], "str", _global.getCurrentShell().getCurrentServerRoomId());
    } // End of the function
    static function determineInteractiveItemIcon(player_id)
    {
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty.pebug("player_id " + player_id);
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty.pebug("_shell " + com.clubpenguin.world.rooms2014.muppets.MuppetsParty._shell);
        var _loc2 = com.clubpenguin.world.rooms2014.muppets.MuppetsParty._shell.getPlayerObjectById(player_id);
        var _loc1 = _loc2.hand;
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty.pebug("Hand item is " + _loc1);
        if (_loc1 == com.clubpenguin.world.rooms2014.muppets.MuppetsParty.getInteractiveItemByMuppet(com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.FOZZIE))
        {
            return (com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.MUPPETS_PIE_JOIN_ICON);
        } // end if
        if (_loc1 == com.clubpenguin.world.rooms2014.muppets.MuppetsParty.getInteractiveItemByMuppet(com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.MISS_PIGGY))
        {
            return (com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.MUPPETS_MIC_JOIN_ICON);
        } // end if
        if (_loc1 == com.clubpenguin.world.rooms2014.muppets.MuppetsParty.getInteractiveItemByMuppet(com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.GONZO))
        {
            return (com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.MUPPETS_CAPE_JOIN_ICON);
        } // end if
        if (_loc1 == com.clubpenguin.world.rooms2014.muppets.MuppetsParty.getInteractiveItemByMuppet(com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.SWEDISH_CHEF))
        {
            return (com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.MUPPETS_TONGS_JOIN_ICON);
        } // end if
        if (_loc1 == com.clubpenguin.world.rooms2014.muppets.MuppetsParty.getInteractiveItemByMuppet(com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.WALTER))
        {
            return (com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.MUPPETS_CANE_JOIN_ICON);
        } // end if
        if (_loc1 == com.clubpenguin.world.rooms2014.muppets.MuppetsParty.getInteractiveItemByMuppet(com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.BUNSEN_BEAKER))
        {
            return (com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.MUPPETS_BEAKERS_JOIN_ICON);
        } // end if
        if (_loc1 == com.clubpenguin.world.rooms2014.muppets.MuppetsParty.getInteractiveItemByMuppet(com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.ANIMAL))
        {
            return (com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.MUPPETS_DRUM_JOIN_ICON);
        } // end if
        if (_loc1 == com.clubpenguin.world.rooms2014.muppets.MuppetsParty.getInteractiveItemByMuppet(com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.PEPE))
        {
            return (com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.MUPPETS_MARACAS_JOIN_ICON);
        } // end if
        return;
    } // End of the function
    static function isWearingInteractiveItem(player_id)
    {
        if (player_id == null)
        {
            return (false);
        } // end if
        var _loc3 = com.clubpenguin.world.rooms2014.muppets.MuppetsParty._shell.getPlayerObjectById(player_id);
        var _loc2 = _loc3.hand;
        for (var _loc1 = 0; _loc1 < com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests.length; ++_loc1)
        {
            com.clubpenguin.world.rooms2014.muppets.MuppetsParty.pebug("_quests[i].interactiveItemId " + com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests[_loc1].interactiveItemId);
            if (Number(com.clubpenguin.world.rooms2014.muppets.MuppetsParty._quests[_loc1].interactiveItemId) == _loc2)
            {
                com.clubpenguin.world.rooms2014.muppets.MuppetsParty.pebug("It\'s a match");
                return (true);
            } // end if
        } // end of for
        return (false);
    } // End of the function
    static function checkForFirstTimePerformance(hostID)
    {
        var _loc3 = com.clubpenguin.world.rooms2014.muppets.MuppetsParty._shell.getPlayerObjectById(hostID);
        var _loc2 = _loc3.hand;
        var _loc1 = com.clubpenguin.world.rooms2014.muppets.MuppetsParty.getUnlockDayByInteractiveItem(_loc2);
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty.pebug("index " + _loc1);
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty.pebug("partyCookie.isMuppetMessageViewed(index, 1) " + com.clubpenguin.world.rooms2014.muppets.MuppetsParty.__get__partyCookie().isMuppetMessageViewed(_loc1, 1));
        if (!com.clubpenguin.world.rooms2014.muppets.MuppetsParty.__get__partyCookie().isMuppetMessageViewed(_loc1, 1))
        {
            muppetDialogueIndex = _loc1;
            com.clubpenguin.world.rooms2014.muppets.MuppetsParty.pebug("Player\'s first time performance with this item " + com.clubpenguin.world.rooms2014.muppets.MuppetsParty._shell.getMyPlayerId());
            com.clubpenguin.world.rooms2014.muppets.MuppetsParty._interface.showContent(com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.MUPPETS_REWARDS_DIALOGUE_PATH);
        } // end if
    } // End of the function
    static function logPerformanceMessage(msg)
    {
        com.clubpenguin.world.rooms2014.muppets.MuppetsParty._performanceLog.push(msg + "\n");
        if (com.clubpenguin.world.rooms2014.muppets.MuppetsParty._performanceLog.length > 300)
        {
            com.clubpenguin.world.rooms2014.muppets.MuppetsParty._performanceLog.shift();
        } // end if
    } // End of the function
    static function logMuppetClick(muppetName)
    {
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(muppetName, "muppet_click");
    } // End of the function
    static function logMuppetDanceEvent(hostId)
    {
        var _loc2 = com.clubpenguin.world.rooms2014.muppets.MuppetsParty._shell.getPlayerObjectById(hostId).hand;
        var _loc1 = com.clubpenguin.world.rooms2014.muppets.MuppetsParty.getInteractiveItemNameByItemID(_loc2);
        if (_loc1 != null)
        {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(_loc1, "muppet_dance_invite");
        } // end if
    } // End of the function
    static function logMuppetDanceJoinEvent(hostId)
    {
        var _loc2 = com.clubpenguin.world.rooms2014.muppets.MuppetsParty._shell.getPlayerObjectById(hostId).hand;
        var _loc1 = com.clubpenguin.world.rooms2014.muppets.MuppetsParty.getInteractiveItemNameByItemID(_loc2);
        if (_loc1 != null)
        {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(_loc1, "muppet_dance_join");
        } // end if
    } // End of the function
    static function getInteractiveItemNameByItemID(itemID)
    {
        if (itemID == 5429)
        {
            return ("cream_pie");
        } // end if
        if (itemID == 5428)
        {
            return ("pink_microphone");
        } // end if
        if (itemID == 5427)
        {
            return ("bull_cape");
        } // end if
        if (itemID == 5432)
        {
            return ("salad_tongs");
        } // end if
        if (itemID == 5434)
        {
            return ("gold_cane");
        } // end if
        if (itemID == 5431)
        {
            return ("beakers");
        } // end if
        if (itemID == 5430)
        {
            return ("drum_sticks");
        } // end if
        if (itemID == 5433)
        {
            return ("maracas");
        } // end if
        return (null);
    } // End of the function
    static function initKermitAvatar()
    {
        var _loc2 = com.clubpenguin.world.rooms2014.muppets.MuppetsParty._engine.avatarManager.model;
        var _loc1 = _loc2.createAvatarFromTemplate(com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID);
        _loc1.spritePath = "w.avatarsprite.mascot.kermit";
        _loc1.speechBubbleOffsetY = -30;
        _loc2.setAvatarTemplate(com.clubpenguin.world.rooms2014.muppets.MuppetsParty.CONSTANTS.KERMIT_AVATAR_ID, _loc1);
    } // End of the function
    static var CONSTANTS = com.clubpenguin.world.rooms2014.muppets.MuppetsPartyConstants;
    static var CLASS_NAME = "MuppetsParty";
    static var PARTY_COOKIE_ID = "20140301";
    static var _this = com.clubpenguin.world.rooms2014.muppets.MuppetsParty;
    static var _isActive = false;
    static var _performanceLog = new Array();
} // End of Class
