class com.clubpenguin.party.Party_InterfaceOverrides
{
    function Party_InterfaceOverrides()
    {
    } // End of the function
    function Party_thisOverrides()
    {
    } // End of the function
    function showPartyIcon(partyIcon)
    {
        var _loc2 = this;
        trace ("JC: Party version of showPartyIcon");
        var _loc3 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        if (_loc2.PARTY_ICON)
        {
            _loc2.PARTY.BaseParty.partyIconState();
            _loc2.setPartyIconPositionForLikeWindow();
            return;
        } // end if
        var _loc4 = _loc2.SHELL.getPath(partyIcon);
        var _loc5 = com.clubpenguin.util.URLUtils.getCacheResetURL(_loc4);
        _loc2.PARTY_ICON = _loc2.ICONS.createEmptyMovieClip(_loc2.PARTY_ICON_INSTANCE_NAME, 1);
        _loc3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_COMPLETE, com.clubpenguin.util.Delegate.create(this, _loc2.onPartyIconLoad));
        _loc3.loadClip(_loc5, _loc2.PARTY_ICON, "icons.as loadPartyIcon()");
    } // End of the function
    function onPartyIconLoad(event)
    {
        trace ("JC: Party version of onPartyIconLoad");
        var _loc2 = this;
        if (_loc2.EGG_TIMER_ICON._visible)
        {
            _loc2.PARTY_ICON._x = _loc2.PARTY_ICON._x - 58;
        } // end if
        _loc2.defaultPartyIconPos = _loc2.PARTY_ICON._x;
        _loc2.setPartyIconPositionForLikeWindow();
        trace ("JC: _this.PARTY.BaseParty " + _loc2.PARTY.BaseParty);
        trace ("JC: _this.PARTY.BaseParty.partyIconState " + _loc2.PARTY.BaseParty.partyIconState);
        _loc2.PARTY.BaseParty.partyIconState();
    } // End of the function
} // End of Class
