class com.clubpenguin.engine.avatar.model.AvatarVO
{
    var effectTransitionsMap, defaultTransitionEffect, attributes, avatar_id, duration, speechBubbleOffsetY, speechBubbleOffsetX, nicknameOffsetY, hasTransformEffect, defaultRevertEffect, hasCustomPlayerCard, customPlayerCardBackgroundID, dynamicPlayerCardBackgroundFunc, dynamicPlayerCardLabelFunc, hasColorVersions, isSpriteTransformed, spritePath, dynamicSpritePathFunc, isMemberOnly, attachItems, canRevertToDefault, revertSoundEffectSymbol, shadowScaleX, shadowScaleY, snowball;
    function AvatarVO()
    {
        effectTransitionsMap = {};
    } // End of the function
    function setEffectTransition(avatarId, effect)
    {
        effectTransitionsMap[avatarId] = effect != null ? (effect) : (com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.NO_EFFECT);
    } // End of the function
    function getEffectTransition(avatarId)
    {
        var _loc2 = effectTransitionsMap[avatarId];
        if (_loc2 != null)
        {
            return (_loc2);
        }
        else
        {
            return (defaultTransitionEffect);
        } // end else if
    } // End of the function
    function clearEffectTransitions()
    {
        effectTransitionsMap = {};
    } // End of the function
    function initializeAttributesFromString(features)
    {
        trace ("AvatarVO::initializeAttributesFromString(" + features + ")");
        if (features != undefined)
        {
            try
            {
                var _loc2 = com.clubpenguin.util.JSONParser.parse(features);
                attributes.spriteScale = Number(_loc2.spriteScale);
                attributes.spriteSpeed = Number(_loc2.spriteSpeed);
                attributes.ignoresBlockLayer = Boolean(_loc2.ignoresBlockLayer);
                attributes.isInvisible = Boolean(_loc2.invisible);
                attributes.isFloating = Boolean(_loc2.floating);
                
            } // End of try
        } // end if
    } // End of the function
    function clone()
    {
        var _loc2 = new com.clubpenguin.engine.avatar.model.AvatarVO();
        _loc2.avatar_id = avatar_id;
        _loc2.duration = duration;
        _loc2.speechBubbleOffsetY = speechBubbleOffsetY;
        _loc2.speechBubbleOffsetX = speechBubbleOffsetX;
        _loc2.nicknameOffsetY = nicknameOffsetY;
        _loc2.hasTransformEffect = hasTransformEffect;
        _loc2.defaultTransitionEffect = defaultTransitionEffect;
        _loc2.defaultRevertEffect = defaultRevertEffect;
        _loc2.hasCustomPlayerCard = hasCustomPlayerCard;
        _loc2.customPlayerCardBackgroundID = customPlayerCardBackgroundID;
        _loc2.dynamicPlayerCardBackgroundFunc = dynamicPlayerCardBackgroundFunc;
        _loc2.dynamicPlayerCardLabelFunc = dynamicPlayerCardLabelFunc;
        _loc2.hasColorVersions = hasColorVersions;
        _loc2.isSpriteTransformed = isSpriteTransformed;
        _loc2.spritePath = spritePath;
        _loc2.dynamicSpritePathFunc = dynamicSpritePathFunc;
        _loc2.isMemberOnly = isMemberOnly;
        _loc2.attachItems = attachItems;
        _loc2.canRevertToDefault = canRevertToDefault;
        _loc2.revertSoundEffectSymbol = revertSoundEffectSymbol;
        _loc2.shadowScaleX = shadowScaleX;
        _loc2.shadowScaleY = shadowScaleY;
        _loc2.effectTransitionsMap = {};
        for (var _loc3 in effectTransitionsMap)
        {
            _loc2.effectTransitionsMap[_loc3] = effectTransitionsMap[_loc3];
        } // end of for...in
        _loc2.snowball = snowball.clone();
        _loc2.attributes = attributes.clone();
        return (_loc2);
    } // End of the function
    function toString()
    {
        var _loc2 = "";
        _loc2 = _loc2 + "AvatarVO{";
        _loc2 = _loc2 + (" avatar_id: " + avatar_id);
        _loc2 = _loc2 + (", duration: " + duration);
        _loc2 = _loc2 + (", speechBubbleOffsetY: " + speechBubbleOffsetY);
        _loc2 = _loc2 + (", speechBubbleOffsetX: " + speechBubbleOffsetX);
        _loc2 = _loc2 + (", nicknameOffsetY: " + nicknameOffsetY);
        _loc2 = _loc2 + (", snowball: " + snowball.toString());
        _loc2 = _loc2 + (", hasTransformEffect: " + hasTransformEffect);
        _loc2 = _loc2 + (", defaultTransitionEffect: " + defaultTransitionEffect);
        _loc2 = _loc2 + (", defaultRevertEffect: " + defaultRevertEffect);
        _loc2 = _loc2 + (", effectTransitionsMap: " + this.effectTransitionsMapToString());
        _loc2 = _loc2 + (", hasCustomPlayerCard: " + hasCustomPlayerCard);
        _loc2 = _loc2 + (", customPlayerCardBackgroundID: " + customPlayerCardBackgroundID);
        _loc2 = _loc2 + (", dynamicPlayerCardBackgroundFunc: " + dynamicPlayerCardBackgroundFunc);
        _loc2 = _loc2 + (", hasColorVersions: " + hasColorVersions);
        _loc2 = _loc2 + (", isSpriteTransformed: " + isSpriteTransformed);
        _loc2 = _loc2 + (", spritePath: " + spritePath);
        _loc2 = _loc2 + (", isMemberOnly: " + isMemberOnly);
        _loc2 = _loc2 + (", attachItems: " + attachItems);
        _loc2 = _loc2 + (", canRevertToDefault: " + canRevertToDefault);
        _loc2 = _loc2 + (", revertSoundEffectSymbol: " + revertSoundEffectSymbol);
        _loc2 = _loc2 + (", shadowScaleX: " + shadowScaleX);
        _loc2 = _loc2 + (", shadowScaleY: " + shadowScaleY);
        _loc2 = _loc2 + (", attributes: " + attributes);
        _loc2 = _loc2 + "}";
        return (_loc2);
    } // End of the function
    function effectTransitionsMapToString()
    {
        var _loc2 = "";
        _loc2 = _loc2 + "{";
        for (var _loc3 in effectTransitionsMap)
        {
            _loc2 = _loc2 + (_loc3 + ":" + effectTransitionsMap[_loc3] + " ");
        } // end of for...in
        _loc2 = _loc2 + "}";
        return (_loc2);
    } // End of the function
} // End of Class
