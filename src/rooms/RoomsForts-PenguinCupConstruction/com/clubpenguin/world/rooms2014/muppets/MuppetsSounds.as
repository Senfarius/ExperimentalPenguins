class com.clubpenguin.world.rooms2014.muppets.MuppetsSounds
{
    static var _shell, _interface, _engine, __get__soundManager, _sfxLayer_animations, _sfxLayer_poofs, _sfx_poofin, _sfx_poofout, _sfx_fozzie, _sfx_miss_piggy, _sfx_gonzo, _sfx_swedish_chef_1, _sfx_swedish_chef_2, _sfx_walter, _sfx_bunsen_beaker, _sfx_animal, _sfx_pepe_1, _sfx_pepe_2, _sfx_transformpoof, _sfx_transform;
    function MuppetsSounds()
    {
    } // End of the function
    static function init()
    {
        _shell = _global.getCurrentShell();
        _interface = _global.getCurrentInterface();
        _engine = _global.getCurrentEngine();
        com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._shell.addListener(com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._shell.ROOM_INITIATED, com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.muppets.MuppetsSounds, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.onRoomInitialized));
    } // End of the function
    static function get soundManager()
    {
        //return (com.clubpenguin.world.rooms.BaseRoom.current().__get__soundManager());
    } // End of the function
    static function onRoomInitialized()
    {
        com.clubpenguin.world.rooms.BaseRoom.__get__current().soundManagerReady.addOnce(com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.onSoundManagerReady, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds);
    } // End of the function
    static function onSoundManagerReady()
    {
        _sfxLayer_animations = com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.__get__soundManager().addLayer("animations", 2);
        _sfxLayer_poofs = com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.__get__soundManager().addLayer("poofs", 2);
        var _loc1 = function (symbolName)
        {
            //return (com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.soundManager().registerSymbolName(symbolName));
        };
        _sfx_poofin = _loc1("sfx_poofin");
        _sfx_poofout = _loc1("sfx_poofout");
        _sfx_fozzie = _loc1("sfx_fozzie");
        _sfx_miss_piggy = _loc1("sfx_miss_piggy");
        _sfx_gonzo = _loc1("sfx_gonzo");
        _sfx_swedish_chef_1 = _loc1("sfx_swedish_chef_1");
        _sfx_swedish_chef_2 = _loc1("sfx_swedish_chef_2");
        _sfx_walter = _loc1("sfx_walter");
        _sfx_bunsen_beaker = _loc1("sfx_bunsen_beaker");
        _sfx_animal = _loc1("sfx_animal");
        _sfx_pepe_1 = _loc1("sfx_pepe_1");
        _sfx_pepe_2 = _loc1("sfx_pepe_2");
        _sfx_transformpoof = _loc1("sfx_transformpoof");
        _sfx_transform = _loc1("sfx_transform");
    } // End of the function
    static function playPoofIn()
    {
        com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.__get__soundManager().playSound(com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfx_poofin, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfxLayer_poofs, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.LOCAL_PLAYER_SFX_VOLUME);
    } // End of the function
    static function playPoofOut()
    {
        com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.__get__soundManager().playSound(com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfx_poofout, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfxLayer_poofs, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.LOCAL_PLAYER_SFX_VOLUME);
    } // End of the function
    static function playMuppetAnimationSoundByItem(itemID)
    {
        var _loc1 = com.clubpenguin.world.rooms2014.muppets.MuppetsParty.getMuppetByInteractiveItem(itemID);
        trace ("MuppetsSounds muppetName " + _loc1);
        com.clubpenguin.world.rooms2014.muppets.MuppetsSounds[_loc1]();
    } // End of the function
    static function fozzie()
    {
        com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.__get__soundManager().playSoundAfterDelay(com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfx_fozzie, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfxLayer_animations, 33, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.LOCAL_PLAYER_SFX_VOLUME);
    } // End of the function
    static function miss_piggy()
    {
        com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.__get__soundManager().playSound(com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfx_miss_piggy, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfxLayer_animations, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.LOCAL_PLAYER_SFX_VOLUME);
    } // End of the function
    static function gonzo()
    {
        com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.__get__soundManager().playSound(com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfx_gonzo, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfxLayer_animations, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.LOCAL_PLAYER_SFX_VOLUME);
    } // End of the function
    static function animal()
    {
        com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.__get__soundManager().playSoundAfterDelay(com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfx_animal, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfxLayer_animations, 5, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.LOCAL_PLAYER_SFX_VOLUME);
    } // End of the function
    static function swedish_chef()
    {
        com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.__get__soundManager().playSoundAfterDelay(com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfx_swedish_chef_1, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfxLayer_animations, 33, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.LOCAL_PLAYER_SFX_VOLUME);
        com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.__get__soundManager().playSoundAfterDelay(com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfx_swedish_chef_2, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfxLayer_animations, 75, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.LOCAL_PLAYER_SFX_VOLUME);
    } // End of the function
    static function walter()
    {
        com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.__get__soundManager().playSound(com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfx_walter, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfxLayer_animations, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.LOCAL_PLAYER_SFX_VOLUME);
    } // End of the function
    static function pepe()
    {
        com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.__get__soundManager().playSoundAfterDelay(com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfx_pepe_1, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfxLayer_animations, 9, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.LOCAL_PLAYER_SFX_VOLUME);
        com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.__get__soundManager().playSoundAfterDelay(com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfx_pepe_2, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfxLayer_animations, 40, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.LOCAL_PLAYER_SFX_VOLUME);
        com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.__get__soundManager().playSoundAfterDelay(com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfx_pepe_1, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfxLayer_animations, 69, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.LOCAL_PLAYER_SFX_VOLUME);
        com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.__get__soundManager().playSoundAfterDelay(com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfx_pepe_2, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfxLayer_animations, 99, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.LOCAL_PLAYER_SFX_VOLUME);
    } // End of the function
    static function bunsen_beaker()
    {
        com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.__get__soundManager().playSound(com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfx_bunsen_beaker, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfxLayer_animations, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.LOCAL_PLAYER_SFX_VOLUME);
        com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.__get__soundManager().playSoundAfterDelay(com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfx_transformpoof, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfxLayer_animations, 63, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.LOCAL_PLAYER_SFX_VOLUME);
        com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.__get__soundManager().playSoundAfterDelay(com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfx_transform, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfxLayer_animations, 63, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.LOCAL_PLAYER_SFX_VOLUME);
        com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.__get__soundManager().playSoundAfterDelay(com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfx_transformpoof, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds._sfxLayer_animations, 111, com.clubpenguin.world.rooms2014.muppets.MuppetsSounds.LOCAL_PLAYER_SFX_VOLUME);
    } // End of the function
    static var REMOTE_PLAYER_SFX_VOLUME = 25;
    static var LOCAL_PLAYER_SFX_VOLUME = 100;
} // End of Class
