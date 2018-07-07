class com.clubpenguin.shell.PuffleStatsVO
{
    var _lowStats;
    function PuffleStatsVO(food, play, rest, clean)
    {
        trace ("com.clubpenguin.shell.PuffleStatsVO ---> Creating new PuffleStatsVO : " + food + " " + play + " " + rest + " " + clean);
        foodStat = food;
        playStat = play;
        restStat = rest;
        cleanStat = clean;
        this.populateLowStatsArray();
    } // End of the function
    function populateLowStatsArray()
    {
        _lowStats = new Array();
        trace ("populateLowStatsArray() Food is  " + foodStat);
        if (foodStat <= com.clubpenguin.shell.PuffleStatsVO.LOW_STAT_NUM)
        {
            trace ("food is less");
            if (foodStat == undefined)
            {
                return;
            } // end if
            _lowStats.push(com.clubpenguin.engine.PuffleEmoticonLocEnum.FOOD_EMOTICON);
        } // end if
        trace ("populateLowStatsArray() Play is  " + playStat);
        if (playStat <= com.clubpenguin.shell.PuffleStatsVO.LOW_STAT_NUM)
        {
            trace ("play is less");
            if (playStat == undefined)
            {
                return;
            } // end if
            _lowStats.push(com.clubpenguin.engine.PuffleEmoticonLocEnum.PLAY_EMOTICON);
        } // end if
        trace ("populateLowStatsArray() Rest is  " + restStat);
        if (restStat <= com.clubpenguin.shell.PuffleStatsVO.LOW_STAT_NUM)
        {
            trace ("rest is less");
            if (restStat == undefined)
            {
                return;
            } // end if
            _lowStats.push(com.clubpenguin.engine.PuffleEmoticonLocEnum.REST_EMOTICON);
        } // end if
        trace ("populateLowStatsArray() Clean is  " + cleanStat);
        if (cleanStat <= com.clubpenguin.shell.PuffleStatsVO.LOW_STAT_NUM)
        {
            trace ("clean is less");
            if (cleanStat == undefined)
            {
                return;
            } // end if
            _lowStats.push(com.clubpenguin.engine.PuffleEmoticonLocEnum.CLEAN_EMOTICON);
        } // end if
    } // End of the function
    function getLowestStat()
    {
        this.populateLowStatsArray();
        if (_lowStats.length > 1)
        {
            trace ("getLowestStat() LENGTH IS GREATER THAN 1");
            var _loc2;
            _loc2 = Math.floor(Math.random() * _lowStats.length);
            return (_lowStats[_loc2]);
        }
        else if (_lowStats.length == 1)
        {
            trace ("getLowestStat() LENGTH IS GREATER THAN 1");
            return (_lowStats[0]);
        }
        else if (_lowStats.length == 0)
        {
            trace ("LOW STATS LENGTH IS 0");
            return (com.clubpenguin.engine.PuffleEmoticonLocEnum.NO_EMOTE);
        } // end else if
    } // End of the function
    static var LOW_STAT_NUM = 20;
    static var NO_STATS_LOW = "none";
    var foodStat = -1;
    var playStat = -1;
    var restStat = -1;
    var cleanStat = -1;
} // End of Class
