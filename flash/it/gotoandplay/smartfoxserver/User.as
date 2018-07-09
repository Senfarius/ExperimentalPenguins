class it.gotoandplay.smartfoxserver.User
{
    var id, name, variables, isSpec, isMod, pid;
    function User(id, name)
    {
        this.id = id;
        this.name = name;
        variables = new Object();
        isSpec = false;
    } // End of the function
    function getId()
    {
        return (id);
    } // End of the function
    function getName()
    {
        return (name);
    } // End of the function
    function getVariable(varName)
    {
        return (variables[varName]);
    } // End of the function
    function getVariables()
    {
        return (variables);
    } // End of the function
    function setIsSpectator(b)
    {
        isSpec = b;
    } // End of the function
    function isSpectator()
    {
        return (isSpec);
    } // End of the function
    function setModerator(b)
    {
        isMod = b;
    } // End of the function
    function isModerator()
    {
        return (isMod);
    } // End of the function
    function getPlayerId()
    {
        return (pid);
    } // End of the function
    function setPlayerId(pid)
    {
        this.pid = pid;
    } // End of the function
} // End of Class
