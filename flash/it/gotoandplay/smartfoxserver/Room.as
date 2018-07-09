class it.gotoandplay.smartfoxserver.Room
{
    var id, name, maxUsers, maxSpectators, temp, game, priv, limbo, updatable, description, userCount, specCount, userList, variables, myPlayerIndex;
    function Room(id, name, maxUsers, maxSpectators, isTemp, isGame, isPrivate)
    {
        this.id = id;
        this.name = name;
        this.maxUsers = maxUsers;
        this.maxSpectators = maxSpectators;
        temp = isTemp;
        game = isGame;
        priv = isPrivate;
        limbo = false;
        updatable = false;
        description = "";
        userCount = 0;
        specCount = 0;
        userList = new Object();
        variables = new Array();
    } // End of the function
    function getUserList()
    {
        return (userList);
    } // End of the function
    function getUser(userId)
    {
        if (typeof(userId) == "number")
        {
            return (userList[userId]);
        }
        else if (typeof(userId) == "string")
        {
            for (var _loc4 in userList)
            {
                var _loc2 = userList[_loc4];
                if (_loc2.getName() == userId)
                {
                    return (_loc2);
                } // end if
            } // end of for...in
        } // end else if
    } // End of the function
    function getVariable(varName)
    {
        return (variables[varName]);
    } // End of the function
    function getVariables()
    {
        return (variables);
    } // End of the function
    function getName()
    {
        return (name);
    } // End of the function
    function getId()
    {
        return (id);
    } // End of the function
    function isTemp()
    {
        return (temp);
    } // End of the function
    function isGame()
    {
        return (game);
    } // End of the function
    function isPrivate()
    {
        return (priv);
    } // End of the function
    function getUserCount()
    {
        return (userCount);
    } // End of the function
    function getSpectatorCount()
    {
        return (specCount);
    } // End of the function
    function getMaxUsers()
    {
        return (maxUsers);
    } // End of the function
    function getMaxSpectators()
    {
        return (maxSpectators);
    } // End of the function
    function setMyPlayerIndex(id)
    {
        myPlayerIndex = id;
    } // End of the function
    function getMyPlayerIndex()
    {
        return (myPlayerIndex);
    } // End of the function
    function setIsLimbo(b)
    {
        limbo = b;
    } // End of the function
    function isLimbo()
    {
        return (limbo);
    } // End of the function
} // End of Class
