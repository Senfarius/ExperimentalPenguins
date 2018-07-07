class com.clubpenguin.party.items.PartyItem
{
    var _id, _type, _member, __get__id, __get__member, __get__type;
    function PartyItem(id, type, member)
    {
        _id = id;
        _type = type;
        _member = member;
    } // End of the function
    function get id()
    {
        return (_id);
    } // End of the function
    function get type()
    {
        return (_type);
    } // End of the function
    function get member()
    {
        return (_member);
    } // End of the function
    function configureButton(itemMC, member, prompt)
    {
        return;
    } // End of the function
} // End of Class
