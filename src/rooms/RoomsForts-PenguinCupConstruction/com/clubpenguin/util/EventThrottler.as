class com.clubpenguin.util.EventThrottler
{
    var _eventQueue, __set__delayBetweenEvents, _delayBetweenEvents, __get__delayBetweenEvents, __get__maxQueueSize, __set__maxQueueSize;
    function EventThrottler()
    {
        _eventQueue = [];
        this.__set__delayBetweenEvents(0);
    } // End of the function
    function set delayBetweenEvents(delay)
    {
        _delayBetweenEvents = delay;
        if (_delayBetweenEvents < 0)
        {
            _delayBetweenEvents = 0;
        } // end if
        if (_intervalId != -1)
        {
            this.disableInterval();
            if (_delayBetweenEvents > 0)
            {
                this.enableInterval();
            } // end if
        } // end if
        if (_delayBetweenEvents == 0 && _eventQueue.length > 0)
        {
            this.processNextEvent();
        } // end if
        //return (this.delayBetweenEvents());
        null;
    } // End of the function
    function set maxQueueSize(size)
    {
        _maxQueueSize = size != undefined ? (size) : (0);
        //return (this.maxQueueSize());
        null;
    } // End of the function
    function queueFunction(callback)
    {
        if (_maxQueueSize > 0 && _eventQueue.length >= _maxQueueSize)
        {
            return;
        } // end if
        _eventQueue.push({type: com.clubpenguin.util.EventThrottler.EVENT_TYPE_FUNCTION, callback: callback});
        if (_delayBetweenEvents <= 0)
        {
            this.processNextEvent();
        }
        else if (_intervalId == -1)
        {
            this.enableInterval();
            if (_eventQueue.length == 1)
            {
                this.processNextEvent();
            } // end if
        } // end else if
    } // End of the function
    function clearQueue()
    {
        _eventQueue.length = 0;
        this.disableInterval();
    } // End of the function
    function processNextEvent()
    {
        if (_eventQueue.length > 0)
        {
            var _loc2 = _eventQueue.shift();
            this.invokeEvent(_loc2);
            if (_delayBetweenEvents <= 0)
            {
                this.processNextEvent();
            } // end if
        }
        else
        {
            this.disableInterval();
        } // end else if
    } // End of the function
    function invokeEvent(event)
    {
        if (event.type == com.clubpenguin.util.EventThrottler.EVENT_TYPE_FUNCTION)
        {
            event.callback();
        } // end if
    } // End of the function
    function enableInterval()
    {
        clearInterval(_intervalId);
        _intervalId = setInterval(this, "processNextEvent", _delayBetweenEvents);
    } // End of the function
    function disableInterval()
    {
        clearInterval(_intervalId);
        _intervalId = -1;
    } // End of the function
    static var EVENT_TYPE_FUNCTION = 0;
    var _maxQueueSize = 0;
    var _intervalId = -1;
} // End of Class
