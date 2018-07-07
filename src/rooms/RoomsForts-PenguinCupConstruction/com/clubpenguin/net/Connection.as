class com.clubpenguin.net.Connection extends XMLSocket implements com.clubpenguin.net.IConnection
{
    var _responded, onConnect, onData, onXML, onClose, messageHandlers, arrayTags, disabledCommands, ipAddress, port, socketConnectionTimeoutThread, onConnection, close, isBlocked, activeRoomId, roomList, buddyList, myBuddyVars, myUserId, myUserName, playerId, amIModerator, onConnectionLost;
    function Connection()
    {
        super();
        this.initialize();
        _responded = new org.osflash.signals.Signal(String, Array);
        onConnect = connectionEstablished;
        onData = gotData;
        onXML = xmlReceived;
        onClose = connectionClosed;
        messageHandlers = new Object();
        this.setupMessageHandlers();
        arrayTags = {uLs: true, rmList: true, vars: true, bList: true, vs: true, mv: true};
        disabledCommands = [];
    } // End of the function
    function getSentCommandsBuffer()
    {
        return (sentCommandsBuffer);
    } // End of the function
    function getResponded()
    {
        return (_responded);
    } // End of the function
    function login(zone, nick, pass, confirmationHash, loginDataRaw)
    {
        trace ("Connection.login()");
        var _loc3 = {t: "sys"};
        var _loc2;
        if (confirmationHash)
        {
            _loc2 = "<login z=\'" + zone + "\'><nick><![CDATA[" + loginDataRaw + "]]></nick><pword><![CDATA[" + pass + "#" + confirmationHash + "]]></pword></login>";
        }
        else
        {
            _loc2 = "<login z=\'" + zone + "\'><nick><![CDATA[" + nick + "]]></nick><pword><![CDATA[" + pass + "]]></pword></login>";
        } // end else if
        this.send(_loc3, "login", 0, _loc2);
    } // End of the function
    function connect(ipAdr, port)
    {
        trace ("Connection.connect(): " + ipAdr + ", " + port);
        if (!isConnected)
        {
            ipAddress = ipAdr;
            this.port = port;
            trace ("ipAddress: " + ipAddress);
            trace ("port: " + this.port);
            super.connect(ipAdr, port);
            socketConnectionTimeoutThread = setInterval(com.clubpenguin.util.Delegate.create(this, socketTimeoutHandler), socketConnectionTimeout);
        }
        else
        {
            trace ("WARNING! You\'re already connected to -> " + ipAddress + ":" + this.port);
        } // end else if
    } // End of the function
    function xmlReceived(message)
    {
        var _loc2 = new Object();
        this.message2Object(message.childNodes, _loc2);
        if (debug)
        {
            trace ("<-- [Received]," + getTimer() + "," + message + "\n");
        } // end if
        var _loc3 = _loc2.msg.attributes.t;
        messageHandlers[_loc3].handleMessage(_loc2.msg.body, this, "xml");
    } // End of the function
    function socketTimeoutHandler()
    {
        trace ("socketTimeoutHandler()");
        if (socketConnectionTimeoutThread != null)
        {
            clearInterval(socketConnectionTimeoutThread);
            delete this.socketConnectionTimeoutThread;
        } // end if
        preConnection = false;
        this.onConnection(false);
        this.close();
    } // End of the function
    function getRandomKey()
    {
        trace ("getRandomKey()");
        this.send({t: "sys"}, "rndK", -1, "");
    } // End of the function
    function disconnect()
    {
        this.close();
        isConnected = false;
        this.initialize();
    } // End of the function
    function connected()
    {
        return (isConnected);
    } // End of the function
    function message2Object(xmlNodes, parentObj)
    {
        var _loc8 = 0;
        var _loc3 = null;
        while (_loc8 < xmlNodes.length)
        {
            var _loc4 = xmlNodes[_loc8];
            var _loc5 = _loc4.nodeName;
            var _loc6 = _loc4.nodeValue;
            if (parentObj instanceof Array)
            {
                _loc3 = {};
                parentObj.push(_loc3);
                _loc3 = parentObj[parentObj.length - 1];
            }
            else
            {
                parentObj[_loc5] = new Object();
                _loc3 = parentObj[_loc5];
            } // end else if
            for (var _loc11 in _loc4.attributes)
            {
                if (typeof(_loc3.attributes) == "undefined")
                {
                    _loc3.attributes = {};
                } // end if
                var _loc2 = _loc4.attributes[_loc11];
                if (!isNaN(Number(_loc2)))
                {
                    _loc2 = Number(_loc2);
                } // end if
                if (_loc2.toLowerCase() == "true")
                {
                    _loc2 = true;
                }
                else if (_loc2.toLowerCase() == "false")
                {
                    _loc2 = false;
                } // end else if
                _loc3.attributes[_loc11] = _loc2;
            } // end of for...in
            if (arrayTags[_loc5])
            {
                _loc3[_loc5] = [];
                _loc3 = _loc3[_loc5];
            } // end if
            if (_loc4.hasChildNodes() && _loc4.firstChild.nodeValue == undefined)
            {
                var _loc9 = _loc4.childNodes;
                this.message2Object(_loc9, _loc3);
            }
            else
            {
                _loc6 = _loc4.firstChild.nodeValue;
                if (!isNaN(_loc6) && _loc4.nodeName != "txt" && _loc4.nodeName != "var")
                {
                    _loc6 = Number(_loc6);
                } // end if
                _loc3.value = _loc6;
            } // end else if
            ++_loc8;
        } // end while
    } // End of the function
    function makeHeader(headerObj)
    {
        var _loc2 = "<msg";
        for (var _loc3 in headerObj)
        {
            _loc2 = _loc2 + (" " + _loc3 + "=\'" + headerObj[_loc3] + "\'");
        } // end of for...in
        _loc2 = _loc2 + ">";
        return (_loc2);
    } // End of the function
    function closeHeader()
    {
        return ("</msg>");
    } // End of the function
    function send(header, action, fromRoom, message)
    {
        var _loc3 = this.makeHeader(header);
        _loc3 = _loc3 + ("<body action=\'" + action + "\' r=\'" + fromRoom + "\'>" + message + "</body>" + this.closeHeader());
        com.clubpenguin.util.Log.info("--> [Sending]:  " + _loc3 + "\n", com.clubpenguin.util.Log.SOCKET);
        super.send(_loc3);
    } // End of the function
    function sendXtMessage(xtName, cmdName, paramObj, type, roomId)
    {
        if (isBlocked)
        {
            return;
        } // end if
        var _loc3 = cmdName.split("#")[1];
        for (var _loc2 = 0; _loc2 < disabledCommands.length; ++_loc2)
        {
            if (disabledCommands[_loc2] == _loc3)
            {
                trace ("sendXTMessage command: " + _loc3 + " is disabled.");
                return;
            } // end if
        } // end of for
        if (roomId == undefined)
        {
            roomId = activeRoomId;
        } // end if
        if (type == undefined)
        {
            type = "str";
        } // end if
        if (type == "str")
        {
            var _loc5;
            _loc5 = serverMessageDelimiter + "xt" + serverMessageDelimiter + xtName + serverMessageDelimiter + cmdName + serverMessageDelimiter + roomId + serverMessageDelimiter;
            for (var _loc2 = 0; _loc2 < paramObj.length; ++_loc2)
            {
                _loc5 = _loc5 + (paramObj[_loc2].toString() + serverMessageDelimiter);
            } // end of for
            this.sendString(_loc5);
        } // end if
    } // End of the function
    function initialize(isLogout)
    {
        if (isLogout == undefined)
        {
            isLogout = false;
        } // end if
        roomList = {};
        buddyList = [];
        myBuddyVars = [];
        activeRoomId = null;
        myUserId = null;
        myUserName = "";
        playerId = null;
        changingRoom = false;
        amIModerator = false;
        if (!isLogout)
        {
            isConnected = false;
        } // end if
    } // End of the function
    function sendString(message)
    {
        com.clubpenguin.util.Log.info("--> [Sending]:  " + message, com.clubpenguin.util.Log.SOCKET);
        sentCommandsBuffer.push(message);
        if (sentCommandsBuffer.length > MAX_SENT_COMMANDS_BUFFER_LENGTH)
        {
            sentCommandsBuffer.splice(0, 1);
        } // end if
        super.send(message);
    } // End of the function
    function connectionEstablished(ok)
    {
        trace ("Connection.connectionEstablished(" + ok + ")");
        if (ok)
        {
            if (socketConnectionTimeoutThread != null)
            {
                clearInterval(socketConnectionTimeoutThread);
                delete this.socketConnectionTimeoutThread;
            } // end if
            preConnection = false;
            var _loc4 = {t: "sys"};
            var _loc3 = "<ver v=\'" + majVersion.toString() + minVersion.toString() + subVersion.toString() + "\' />";
            this.send(_loc4, "verChk", 0, _loc3);
        }
        else if (flash.external.ExternalInterface.available)
        {
            flash.external.ExternalInterface.call("console.log", "Connection.connectionEstablished ok:" + ok);
        } // end else if
    } // End of the function
    function connectionClosed()
    {
        isConnected = false;
        if (preConnection)
        {
            this.connectionEstablished(false);
        }
        else
        {
            this.initialize();
            this.onConnectionLost();
        } // end else if
    } // End of the function
    function gotData(message)
    {
        if (message.charAt(0) == serverMessageDelimiter)
        {
            this.strReceived(message);
        }
        else if (message.charAt(0) == "<")
        {
            this.onXML(new XML(message));
        } // end else if
    } // End of the function
    function strReceived(message)
    {
        var _loc4 = message.substr(1, message.length - 2).split(serverMessageDelimiter);
        var _loc3 = _loc4[1];
        var _loc7 = _loc4.slice(2);
        for (var _loc2 = 0; _loc2 < disabledCommands.length; ++_loc2)
        {
            if (_loc3 == disabledCommands[_loc2])
            {
                return;
            } // end if
        } // end of for
        com.clubpenguin.util.Log.info("<-- [Received]: " + message, com.clubpenguin.util.Log.SOCKET);
        var _loc6 = _loc4[0];
        _responded.dispatch(_loc3, _loc7);
        messageHandlers[_loc6].handleMessage(_loc4.splice(1, _loc4.length - 1), this, "str");
    } // End of the function
    function setupMessageHandlers()
    {
        this.addMessageHandler("sys", handleSysMessages);
        this.addMessageHandler("xt", com.clubpenguin.util.Delegate.create(this, handleExtensionMessages));
    } // End of the function
    function addMessageHandler(handlerId, handlerMethod)
    {
        if (messageHandlers[handlerId] == undefined)
        {
            messageHandlers[handlerId] = new Object();
            messageHandlers[handlerId].handleMessage = handlerMethod;
        }
        else
        {
            trace ("Warning: [" + handlerId + "] handler could not be created. A handler with this name already exist!");
        } // end else if
    } // End of the function
    function handleExtensionMessages(dataObj, scope, type)
    {
        if (type == undefined)
        {
            type = "xml";
        } // end if
        if (type == "xml")
        {
            var _loc6 = dataObj.attributes.action;
            var _loc7 = dataObj.attributes.r;
            if (_loc6 == "xtRes")
            {
                var _loc4 = dataObj.value;
                var _loc5 = scope.os.deserialize(_loc4);
                scope.onExtensionResponse(_loc5, type);
            } // end if
        }
        else if (type == "str")
        {
            scope.onExtensionResponse(dataObj, type);
        }
        else if (type == "json")
        {
            scope.onExtensionResponse(dataObj.o, type);
        } // end else if
    } // End of the function
    function handleSysMessages(xmlObj, scope)
    {
        var _loc1 = xmlObj.attributes.action;
        var _loc5 = xmlObj.attributes.r;
        if (_loc1 == "apiOK")
        {
            scope.isConnected = true;
            scope.onConnection(true);
        }
        else if (_loc1 == "rndK")
        {
            var _loc2 = xmlObj.k.value;
            scope.onRandomKey(_loc2);
        } // end else if
    } // End of the function
    function disableCommands(disabledCommands)
    {
        trace ("=========> DISABLING COMMANDS: " + disabledCommands);
        this.disabledCommands = disabledCommands;
    } // End of the function
    function enableCommands()
    {
        trace ("=========> ENABLING COMMANDS");
        disabledCommands = [];
    } // End of the function
    var isConnected = false;
    var changingRoom = false;
    var preConnection = true;
    var majVersion = 1;
    var minVersion = 5;
    var subVersion = 3;
    var MAX_SENT_COMMANDS_BUFFER_LENGTH = 10;
    var sentCommandsBuffer = [];
    var serverMessageDelimiter = "%";
    var socketConnectionTimeout = 30000;
    var debug = true;
} // End of Class
