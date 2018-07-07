class com.clubpenguin.ui.itembuttons.BuyIglooItemButton extends com.clubpenguin.ui.itembuttons.BuyItemButtonBase
{
    var _customPurchase, _itemID, _itemMC, CLAIM_BUTTON_INSTANCE_NAME, checkPurchaseOfItem, _prompt, ITEM_PURCHASE_EVENT, addItemPurchasedListener;
    function BuyIglooItemButton(itemMC, itemID, member, prompt, customPurchase, callback, buttonName, oopsMsgPath, purchaseSound, clickSound)
    {
        super(itemMC, itemID, member, prompt, callback, _global.getCurrentShell().BUY_IGLOO_TYPE, buttonName, oopsMsgPath != undefined ? (oopsMsgPath) : (com.clubpenguin.ui.itembuttons.BuyIglooItemButton.DEFAULT_OOPS_MESSAGE), purchaseSound, clickSound);
        _customPurchase = customPurchase;
    } // End of the function
    function configurePurchaseableItem()
    {
        if (com.clubpenguin.ui.itembuttons.BuyItemButtonBase._shell.isIglooBuildingInMyInventory(_itemID))
        {
            _itemMC.nextFrame();
            return;
        } // end if
        _itemMC[CLAIM_BUTTON_INSTANCE_NAME].onRelease = com.clubpenguin.util.Delegate.create(this, checkPurchaseOfItem);
    } // End of the function
    function buyItem()
    {
        com.clubpenguin.ui.itembuttons.BuyItemButtonBase._buyItemDelegate = null;
        if (_customPurchase != undefined)
        {
            this._customPurchase(_itemID, _itemMC, com.clubpenguin.ui.itembuttons.BuyIglooItemButton.ITEM_TYPE);
            return;
        } // end if
        if (_prompt)
        {
            com.clubpenguin.ui.itembuttons.BuyItemButtonBase._interface.buyIglooType(_itemID);
        }
        else
        {
            com.clubpenguin.ui.itembuttons.BuyItemButtonBase._shell.sendBuyIglooType(_itemID);
        } // end else if
        if (ITEM_PURCHASE_EVENT != undefined)
        {
            this.addItemPurchasedListener();
        } // end if
    } // End of the function
    static var DEFAULT_OOPS_MESSAGE = "oops_catalog_igloofurniture";
    static var ITEM_TYPE = "igloo";
} // End of Class
