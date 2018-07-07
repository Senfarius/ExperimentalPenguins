class com.clubpenguin.ui.itembuttons.BuyItemButtonBase
{
    var _itemMC, _itemID, _member, _prompt, _callback, ITEM_PURCHASE_EVENT, _purchaseSFX, _clickSFX;
    static var _shell, _airtower, _interface, _engine, _party, _buyItemDelegate;
    function BuyItemButtonBase(itemMC, itemID, member, prompt, callback, purchaseEventName, buttonName, oopsMsgPath, purchaseSound, clickSound)
    {
        _shell = _global.getCurrentShell();
        _airtower = _global.getCurrentAirtower();
        _interface = _global.getCurrentInterface();
        _engine = _global.getCurrentEngine();
        _party = _global.getCurrentParty();
        _itemMC = itemMC;
        _itemID = itemID;
        _member = member;
        _prompt = prompt != undefined ? (prompt) : (true);
        _callback = callback;
        ITEM_PURCHASE_EVENT = purchaseEventName;
        trace ("ITEM_PURCHASE_EVENT " + ITEM_PURCHASE_EVENT);
        if (buttonName != undefined)
        {
            CLAIM_BUTTON_INSTANCE_NAME = buttonName;
        } // end if
        if (oopsMsgPath != OOPS_MESSAGE_PATH)
        {
            OOPS_MESSAGE_PATH = oopsMsgPath;
        } // end if
        _purchaseSFX = purchaseSound;
        _clickSFX = clickSound;
        this.configurePurchaseableItem();
    } // End of the function
    function configurePurchaseableItem()
    {
    } // End of the function
    function checkPurchaseOfItem()
    {
        if (_member && !com.clubpenguin.ui.itembuttons.BuyItemButtonBase._shell.isMyPlayerMember())
        {
            com.clubpenguin.ui.itembuttons.BuyItemButtonBase._interface.showContent(OOPS_MESSAGE_PATH);
        }
        else
        {
            if (_purchaseSFX != undefined)
            {
                com.clubpenguin.ui.itembuttons.BuyItemButtonBase._party.BaseParty.playSound(_itemMC, _clickSFX);
            } // end if
            this.buyItem();
        } // end else if
    } // End of the function
    function buyItem()
    {
    } // End of the function
    function addItemPurchasedListener()
    {
        trace ("BuyItemButtonBase.addItemPurchasedListener");
        _buyItemDelegate = com.clubpenguin.util.Delegate.create(this, onInventoryBought);
        com.clubpenguin.ui.itembuttons.BuyItemButtonBase._shell.addListener(ITEM_PURCHASE_EVENT, com.clubpenguin.ui.itembuttons.BuyItemButtonBase._buyItemDelegate);
    } // End of the function
    function onInventoryBought(event)
    {
        trace ("BuyItemButtonBase.onInventoryBought");
        com.clubpenguin.ui.itembuttons.BuyItemButtonBase._shell.removeListener(ITEM_PURCHASE_EVENT, com.clubpenguin.ui.itembuttons.BuyItemButtonBase._buyItemDelegate);
        if (event.success)
        {
            _itemMC.nextFrame();
            if (_purchaseSFX != undefined)
            {
                com.clubpenguin.ui.itembuttons.BuyItemButtonBase._party.BaseParty.playSound(_itemMC, _purchaseSFX);
            } // end if
            if (_callback != undefined)
            {
                trace ("BuyItemButtonBase run callback function");
                setTimeout(_callback, 20);
            } // end if
        } // end if
    } // End of the function
    function destroy()
    {
        com.clubpenguin.ui.itembuttons.BuyItemButtonBase._shell.removeListener(ITEM_PURCHASE_EVENT, com.clubpenguin.ui.itembuttons.BuyItemButtonBase._buyItemDelegate);
        _itemMC[CLAIM_BUTTON_INSTANCE_NAME].onRelease = null;
    } // End of the function
    var CLAIM_BUTTON_INSTANCE_NAME = "claim_btn";
    var OOPS_MESSAGE_PATH = "oops_general";
} // End of Class
