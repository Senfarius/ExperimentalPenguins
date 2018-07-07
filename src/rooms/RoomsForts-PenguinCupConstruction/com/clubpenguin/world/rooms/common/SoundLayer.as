class com.clubpenguin.world.rooms.common.SoundLayer
{
    var id, name, maxConcurrent, numSoundsPlaying;
    function SoundLayer(id, name, maxConcurrent)
    {
        this.id = id;
        this.name = name;
        this.maxConcurrent = maxConcurrent;
        numSoundsPlaying = 0;
    } // End of the function
    function canPlaySound()
    {
        return (numSoundsPlaying < maxConcurrent || maxConcurrent == -1);
    } // End of the function
    function toString()
    {
        return ("SoundLayer{name:" + name + ", maxConcurrent:" + maxConcurrent + ", numSoundsPlaying:" + numSoundsPlaying + "}");
    } // End of the function
} // End of Class
