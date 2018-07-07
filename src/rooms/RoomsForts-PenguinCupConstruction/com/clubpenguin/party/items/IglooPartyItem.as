class com.clubpenguin.party.items.IglooPartyItem extends com.clubpenguin.party.items.PartyItem
{
    var __get__id;
    function IglooPartyItem(id)
    {
        super(id, "igloo");
    } // End of the function
    function configureButton(itemMC, member, prompt)
    {
        member = member != undefined ? (member) : (true);
        var _loc3 = new com.clubpenguin.ui.itembuttons.BuyIglooItemButton(itemMC, this.__get__id(), member, prompt);
    } // End of the function
} // End of Class
