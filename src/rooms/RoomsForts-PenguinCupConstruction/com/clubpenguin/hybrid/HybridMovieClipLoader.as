class com.clubpenguin.hybrid.HybridMovieClipLoader extends mx.events.EventDispatcher
{
    var _movieClipLoader, _movieClipLoaderListener, _container, dispatchEvent, _url, _startTime, _loadProgressCheckInterval, lastUpdate, _timeElapsed, _latencyDelegate, _latencyInterval, isNearlyLoadedShown;
    function HybridMovieClipLoader(completeParams)
    {
        super();
        _movieClipLoader = new MovieClipLoader();
        _movieClipLoaderListener = new Object();
        _movieClipLoaderListener.onLoadStart = com.clubpenguin.util.Delegate.create(this, onMovieClipLoadStart);
        _movieClipLoaderListener.onLoadComplete = com.clubpenguin.util.Delegate.create(this, onMovieClipLoadComplete);
        _movieClipLoaderListener.onLoadError = com.clubpenguin.util.Delegate.create(this, onMovieClipLoadError);
        _movieClipLoaderListener.onLoadProgress = com.clubpenguin.util.Delegate.create(this, onMovieClipLoadProgress);
        _movieClipLoaderListener.onLoadInit = com.clubpenguin.util.Delegate.create(this, onMovieClipLoadInit);
        var _loc3 = _movieClipLoader.addListener(_movieClipLoaderListener);
    } // End of the function
    function setCompleteParams(completeParams)
    {
        _completeParams = completeParams != undefined ? (completeParams) : ({});
    } // End of the function
    function loadClip(url, container, callerName)
    {
        trace ("HybridMovieClipLoader.loadClip(): " + url);
        var _loc4;
        if (url == undefined || url.indexOf("undefined") >= 0)
        {
            this.logParamError("LoadError", callerName);
            this.dispatchEvent({target: _container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, errorCode: "undefined url from " + callerName});
        }
        else
        {
            _loc4 = _global.getCacheVersion() == undefined || _global.getCacheVersion() == "" ? ("") : ("?cacheVersion=" + _global.getCacheVersion());
            _url = cacheVersion != null ? (url + "?cacheVersion=" + cacheVersion) : (url + _loc4);
            trace ("HybridMovieClipLoader _url: " + _url);
            _container = container;
            _startTime = getTimer();
            _movieClipLoader.loadClip(_url, _container);
            clearInterval(_loadProgressCheckInterval);
            _loadProgressCheckInterval = setInterval(this, "checkLoadProgress", com.clubpenguin.hybrid.HybridMovieClipLoader.INTERVAL_RATE);
            lastUpdate = getTimer();
        } // end else if
    } // End of the function
    function unloadClip(target)
    {
        return (_movieClipLoader.unloadClip(target));
    } // End of the function
    function checkLoadProgress()
    {
        _timeElapsed = getTimer() - _startTime;
        if (_container.getBytesLoaded() == undefined)
        {
            clearInterval(_loadProgressCheckInterval);
            return;
        } // end if
        if (_container.getBytesTotal() < 0 && _timeElapsed >= com.clubpenguin.hybrid.HybridMovieClipLoader.TIME_OUT_THRESHOLD)
        {
            clearInterval(_loadProgressCheckInterval);
            this.logLoadTimeout("HybridLoader TimedOut");
            this.dispatchEvent({target: _container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, errorCode: "ERROR: HybridMovieClipLoader timed out loading " + _url});
            return;
        } // end if
        if (_container.getBytesLoaded() == _container.getBytesTotal() && _container.getBytesTotal() > com.clubpenguin.hybrid.HybridMovieClipLoader.MIN_BYTES)
        {
            clearInterval(_loadProgressCheckInterval);
            this.dispatchEvent({target: _container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_COMPLETE});
            _latencyDelegate = com.clubpenguin.util.Delegate.create(this, onAS2MovieClipReady);
            _container.onEnterFrame = _latencyDelegate;
        }
        else
        {
            this.dispatchEvent({target: _container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS, bytesLoaded: _container.getBytesLoaded(), bytesTotal: _container.getBytesTotal()});
        } // end else if
    } // End of the function
    function onAS2MovieClipUnload()
    {
        clearInterval(_latencyInterval);
        clearInterval(_loadProgressCheckInterval);
        this.dispatchEvent({target: _container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_UNLOAD});
    } // End of the function
    function onAS2MovieClipReady()
    {
        clearInterval(_latencyInterval);
        clearInterval(_loadProgressCheckInterval);
        _timeElapsed = getTimer() - _startTime;
        delete _container.onEnterFrame;
        _latencyDelegate = null;
        this.dispatchEvent({target: _container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT});
    } // End of the function
    function onMovieClipLoadStart()
    {
        clearInterval(_latencyInterval);
        clearInterval(_loadProgressCheckInterval);
        this.dispatchEvent({target: _container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_START});
    } // End of the function
    function onMovieClipLoadComplete(target, httpStatus)
    {
        clearInterval(_latencyInterval);
        clearInterval(_loadProgressCheckInterval);
        this.dispatchEvent({target: target, loader: this, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_COMPLETE});
    } // End of the function
    function onMovieClipLoadInit(target)
    {
        clearInterval(_latencyInterval);
        clearInterval(_loadProgressCheckInterval);
        _movieClipLoader.removeListener(_movieClipLoaderListener);
        this.dispatchEvent({target: _container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, completeParams: _completeParams, url: _url});
    } // End of the function
    function onMovieClipLoadProgress(target, bytesLoaded, bytesTotal)
    {
        clearInterval(_latencyInterval);
        clearInterval(_loadProgressCheckInterval);
        if (bytesTotal > 0)
        {
            if (bytesLoaded / bytesTotal >= 0.950000 && !isNearlyLoadedShown)
            {
                isNearlyLoadedShown = true;
                this.dispatchEvent({target: _container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS, bytesLoaded: bytesLoaded, bytesTotal: bytesTotal});
                lastUpdate = getTimer();
            }
            else if (getTimer() - lastUpdate >= com.clubpenguin.hybrid.HybridMovieClipLoader.PROGRESS_THROTTLE_INTERVAL)
            {
                this.dispatchEvent({target: _container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS, bytesLoaded: bytesLoaded, bytesTotal: bytesTotal});
                lastUpdate = getTimer();
            } // end if
        } // end else if
    } // End of the function
    function onMovieClipLoadError(target, errorCode, httpStatus)
    {
        clearInterval(_latencyInterval);
        clearInterval(_loadProgressCheckInterval);
        this.logLoadError("LoadError", errorCode, httpStatus);
        this.dispatchEvent({target: _container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, errorCode: errorCode, httpStatus: httpStatus});
    } // End of the function
    function logLoadError(_context, _errorCode, _httpStatus)
    {
        if (_global.getCurrentShell())
        {
            com.clubpenguin.util.TrackerAS2.getInstance().sendToAS3LogMovieClipLoadError(_context, _trackerReason, _url, _errorCode, _httpStatus);
        } // end if
    } // End of the function
    function logLoadTimeout(_context)
    {
        if (_global.getCurrentShell())
        {
            com.clubpenguin.util.TrackerAS2.getInstance().sendToAS3LogMovieClipTimeout(_context, _trackerReason, _url);
        } // end if
    } // End of the function
    function logParamError(_context, _caller)
    {
        if (_global.getCurrentShell())
        {
            com.clubpenguin.util.TrackerAS2.getInstance().sendToAS3LogMovieClipParamError(_context, _trackerReason, _url, _caller);
        } // end if
    } // End of the function
    static var EVENT_ON_LOAD_START = "onLoadStart";
    static var EVENT_ON_LOAD_ERROR = "onLoadError";
    static var EVENT_ON_LOAD_COMPLETE = "onLoadComplete";
    static var EVENT_ON_LOAD_INIT = "onLoadInit";
    static var EVENT_ON_LOAD_PROGRESS = "onLoadProgress";
    static var EVENT_ON_UNLOAD = "onUnload";
    static var INTERVAL_RATE = 40;
    static var TIME_OUT_THRESHOLD = 180000;
    static var MIN_BYTES = 4;
    static var PROGRESS_THROTTLE_INTERVAL = 140;
    var _noByteDataTimeout = 0;
    var _trackerReason = "MovieClipLoading";
    var _completeParams = null;
    var cacheVersion = null;
} // End of Class
