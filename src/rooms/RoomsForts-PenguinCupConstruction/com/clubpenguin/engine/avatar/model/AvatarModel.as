class com.clubpenguin.engine.avatar.model.AvatarModel
{
    var _SHELL, _avatarData, _snowballHitChecks;
    function AvatarModel()
    {
        _SHELL = _global.getCurrentShell();
        _avatarData = {};
        _snowballHitChecks = {};
    } // End of the function
    function setSnowballHitCheck(avatarEnum, snowballHitCheck)
    {
        _snowballHitChecks[avatarEnum.__get__symbolName()] = snowballHitCheck;
    } // End of the function
    function getSnowballHitCheck(avatarEnum)
    {
        //return (_snowballHitChecks[avatarEnum.symbolName()]);
    } // End of the function
    function setAvatarTemplate(avatarId, data)
    {
        data.avatar_id = avatarId;
        _avatarData[avatarId] = data;
    } // End of the function
    function getAvatarTemplate(avatarId)
    {
        return (_avatarData[avatarId]);
    } // End of the function
    function createAvatarFromTemplate(avatarId)
    {
        if (_avatarData[avatarId] != null)
        {
            return (_avatarData[avatarId].clone());
        }
        else
        {
            trace ("ERROR Invalid avatarId passed to createAvatarFromTemplate. No avatar template exists for avatarId " + avatarId);
            trace ("      Default avatar will be returned.");
            return (_avatarData[com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID].clone());
        } // end else if
    } // End of the function
} // End of Class
