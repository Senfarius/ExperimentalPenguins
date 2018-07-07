class com.clubpenguin.net.Airtower
{
    var shell, _isBlocked, LOGIN_IP, LOGIN_PORT, on_login_response, autoLogin, on_world_response;
    function Airtower(shell)
    {
        this.shell = shell;
        _isBlocked = false;
    } // End of the function
    function toString()
    {
        return ("Airtower[" + debugName + "]");
    } // End of the function
    function init()
    {
        var _loc2 = shell.getLoginServer();
        LOGIN_IP = _loc2.ip;
        com.clubpenguin.util.Log.debug("LOGIN_IP: " + LOGIN_IP);
        LOGIN_PORT = _loc2.port;
        com.clubpenguin.util.Log.debug("LOGIN_PORT: " + LOGIN_PORT);
        sf_listener_container = new Object();
        server = new com.clubpenguin.net.Connection();
    } // End of the function
    function getServer()
    {
        return (server);
    } // End of the function
    function setIsJumpToNewServerInProgress(isJumping)
    {
        isJumpToNewServerInProgress = isJumping;
    } // End of the function
    function getSentCommandsBuffer()
    {
        var _loc4 = "";
        var _loc3 = this.getServer().getSentCommandsBuffer();
        for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
        {
            _loc4 = _loc4 + _loc3[_loc2];
            if (_loc2 != _loc3.length - 1)
            {
                _loc4 = _loc4 + "\n";
            } // end if
        } // end of for
        return (_loc4);
    } // End of the function
    function cloneListeners(cloneTo)
    {
        for (var _loc6 in sf_listener_container)
        {
            var _loc4 = sf_listener_container[_loc6];
            for (var _loc3 = 0; _loc3 < _loc4.length; ++_loc3)
            {
                var _loc2 = _loc4[_loc3];
                com.clubpenguin.util.Log.debug("clone listener -> type: " + _loc6 + " listener.func: " + _loc2.func + " listener.scope: " + _loc2.scope);
                cloneTo.addListener(_loc6, _loc2.func, _loc2.scope);
            } // end of for
        } // end of for...in
    } // End of the function
    function addListener(type, func, scope)
    {
        if (type == undefined || func == undefined)
        {
            shell.$e("addListner() -> You must pass a valid listener type and function! type: " + type + " func: " + func);
            return (false);
        } // end if
        var _loc3 = this.getListenersArray(type);
        var _loc4 = this.getListenerIndex(_loc3, func);
        if (_loc4 == -1)
        {
            shell.$d("[airtower] Successfully added listener to: \"" + type + "\"");
            _loc3.push({func: func, scope: scope});
            return (true);
        } // end if
        shell.$d("[airtower] Failed to add listener. Tried to add a duplicate listener to: \"" + type + "\"");
        return (false);
    } // End of the function
    function removeListener(type, func)
    {
        var _loc2 = this.getListenersArray(type);
        var _loc3 = this.getListenerIndex(_loc2, func);
        if (_loc3 != -1)
        {
            shell.$d("[airtower] Successfully removed listener from: \"" + type + "\"");
            _loc2.splice(_loc3, 1);
            return (true);
        } // end if
        shell.$d("[airtower] Failed to remove listener which did not exist from: \"" + type + "\"");
        return (false);
    } // End of the function
    function getListenerIndex(array, func)
    {
        var _loc2 = array.length;
        for (var _loc1 = 0; _loc1 < _loc2; ++_loc1)
        {
            if (array[_loc1].func == func)
            {
                return (_loc1);
            } // end if
        } // end of for
        return (-1);
    } // End of the function
    function updateListeners(type, obj)
    {
        var _loc3 = this.getListenersArray(type);
        var _loc5 = _loc3.length;
        if (_loc5 < 1)
        {
            shell.$d("[airtower] No listeners currently attached to: \"" + type + "\"");
            return (false);
        } // end if
        if (_loc5 == 1)
        {
            _loc3[0].scope ? (_loc3[0].func.call(_loc3[0].scope, obj)) : (_loc3[0].func(obj));
            return (true);
        } // end if
        for (var _loc2 = 0; _loc2 < _loc5; ++_loc2)
        {
            _loc3[_loc2].scope ? (_loc3[_loc2].func.call(_loc3[_loc2].scope, obj)) : (_loc3[_loc2].func(obj));
        } // end of for
        return (true);
    } // End of the function
    function getListenersArray(type)
    {
        if (sf_listener_container[type] == undefined)
        {
            sf_listener_container[type] = new Array();
        } // end if
        return (sf_listener_container[type]);
    } // End of the function
    function onAirtowerResponse(eventData, type, overrideBlock)
    {
        if (!_isBlocked || overrideBlock == true)
        {
            trace ("Airtower.onAirTowerResponse eventData " + eventData);
            var _loc2 = String(eventData[0]);
            if (com.clubpenguin.net.BridgeFilter.messageIsSentToAS3(this, _loc2))
            {
                shell.sendAirtowerEvent(eventData.join(SERVER_MESSAGE_DELIMITER) + SERVER_MESSAGE_DELIMITER);
            } // end if
            com.clubpenguin.util.Log.debug("onAirtowerResponse (eventType = " + _loc2 + ")", com.clubpenguin.net.Airtower.$_lc);
            com.clubpenguin.util.Log.debug("onAirtowerResponse after service test (eventType = " + _loc2 + ")", com.clubpenguin.net.Airtower.$_lc);
            eventData.shift();
            switch (_loc2)
            {
                case "gwcj":
                case "gw":
                case "jw":
                case "sw":
                case "cjms":
                case "jx":
                case "gz":
                case "jz":
                case "uz":
                case "sz":
                case "uw":
                {
                    this.sendAck(_loc2, eventData.slice());
                    break;
                } 
            } // End of switch
            this.updateListeners(_loc2, eventData);
        } // end if
    } // End of the function
    function sendAck(command, data)
    {
        data = data.slice();
        data.unshift(command);
        data.unshift("time=" + String(new Date().getTime()));
        this.send(PLAY_EXT, "bi#ack", data, "str", _global.getCurrentShell().getCurrentServerRoomId());
    } // End of the function
    function isBlocked()
    {
        return (_isBlocked);
    } // End of the function
    function block()
    {
        _isBlocked = true;
        server.isBlocked = true;
        server.onConnectionLost = null;
    } // End of the function
    function unblock()
    {
        _isBlocked = false;
        server.isBlocked = false;
        server.onConnectionLost = com.clubpenguin.util.Delegate.create(this, handleLostConnection);
    } // End of the function
    function setConnection(connection)
    {
        server = connection || server;
    } // End of the function
    function setUsername(in_username)
    {
        username = in_username;
    } // End of the function
    function setPlayerId(in_playerId)
    {
        playerId = in_playerId;
    } // End of the function
    function connectToLogin(in_username, in_pass, login_response, doAutoLogin)
    {
        com.clubpenguin.util.Log.debug("\n");
        com.clubpenguin.util.Log.debug("********************************************************************");
        com.clubpenguin.util.Log.debug("connectToLogin");
        com.clubpenguin.util.Log.debug("this = " + this);
        com.clubpenguin.util.Log.debug("in_username: " + in_username);
        com.clubpenguin.util.Log.debug("in_pass: " + in_pass);
        com.clubpenguin.util.Log.debug("login_response: " + login_response);
        com.clubpenguin.util.Log.debug("doAutoLogin: " + doAutoLogin);
        com.clubpenguin.util.Log.debug("server: " + server);
        com.clubpenguin.util.Log.debug("server.connected(); " + server.connected());
        com.clubpenguin.util.Log.debug("is_logged_in: " + is_logged_in);
        if (!is_logged_in)
        {
            if (server.connected())
            {
                server.disconnect();
            } // end if
            on_login_response = login_response;
            username = in_username;
            password = in_pass;
            autoLogin = doAutoLogin;
            server.onConnection = com.clubpenguin.util.Delegate.create(this, handleLoginConnection);
            server.onRandomKey = com.clubpenguin.util.Delegate.create(this, handleLoginRandomKey);
            server.onExtensionResponse = com.clubpenguin.util.Delegate.create(this, onAirtowerResponse);
            server.debug = true;
            this.addListener(HANDLE_LOGIN, handleOnLogin, this);
            this.addListener(HANDLE_LOGIN_EXPIRED, handleExpiredPreactivationLogin, this);
            server.connect(LOGIN_IP, LOGIN_PORT);
        }
        else
        {
            shell.$e("connectToLogin() -> Your already logged in! Cant login again");
        } // end else if
        com.clubpenguin.util.Log.debug("********************************************************************");
    } // End of the function
    function handleLostConnection()
    {
        com.clubpenguin.util.Log.debug("Airtower.handleLostConnection() this = " + this);
        if (!isJumpToNewServerInProgress)
        {
            shell.sendIdlePlayerTimeout();
        } // end if
        this.updateListeners(CONNECTION_LOST, null);
    } // End of the function
    function handleLoginConnection(success)
    {
        if (success)
        {
            server.getRandomKey();
        }
        else
        {
            server.disconnect();
            this.on_login_response(false);
        } // end else if
    } // End of the function
    function handleLoginRandomKey(key)
    {
        rand_key = key;
        this.login();
    } // End of the function
    function login()
    {
        if (!autoLogin)
        {
            server.login(com.clubpenguin.net.Airtower.LOGIN_ZONE, username, this.getLoginHash());
        }
        else
        {
            server.login(com.clubpenguin.net.Airtower.LOGIN_ZONE, username, password);
        } // end else if
    } // End of the function
    function handleOnLogin(serverResponse)
    {
        this.removeListener(HANDLE_LOGIN, handleOnLogin);
        this.removeListener(HANDLE_LOGIN_EXPIRED, handleExpiredPreactivationLogin, this);
        server.disconnect();
        com.clubpenguin.util.Log.debug("handleOnLogin: " + serverResponse);
        var _loc5 = serverResponse[1].split("|");
        loginObject = {};
        loginObject.loginDataRaw = serverResponse[1];
        loginObject.playerID = _loc5[0];
        loginObject.swid = _loc5[1];
        loginObject.username = _loc5[2];
        loginObject.loginKey = _loc5[3];
        loginObject.languageApproved = _loc5[5];
        loginObject.languageRejected = _loc5[6];
        loginObject.friendsLoginKey = serverResponse[3];
        loginObject.confirmationHash = serverResponse[2];
        loginObject.emailAddress = serverResponse[5];
        if (serverResponse[6] != null)
        {
            var _loc3 = serverResponse[6].split("|");
            loginObject.remaining_hours = _loc3[0];
            loginObject.trialMax = _loc3[1];
            loginObject.max_grace_hours = _loc3[2];
            var _loc6 = new Object();
            _loc6.modalBackgroundEnbaled = true;
            _loc6.blockPuffleNotifications = true;
            _loc6.hideLoadingDialog = true;
            var _loc4 = new Object();
            _loc4.state = FRAME_LABEL_WELCOME;
            _loc4.trialRemaining = _loc3[0];
            _loc4.trialMax = _loc3[1];
            _loc4.graceMax = _loc3[2];
            _loc4.confirmationHash = loginObject.confirmationHash;
            _loc4.loginDataRaw = loginObject.loginDataRaw;
            shell.sendOpenAS3Module("preactivation", _loc4, _loc6);
            flash.external.ExternalInterface.call("showActivationBanner", _loc3[0]);
        } // end if
        for (var _loc7 in serverResponse)
        {
            trace ("\t-serverResponse[" + _loc7 + "]: " + serverResponse[_loc7]);
        } // end of for...in
        for (var _loc8 in loginObject)
        {
            com.clubpenguin.util.Log.debug("loginObject." + _loc8 + ":" + loginObject[_loc8]);
        } // end of for...in
        shell.playerModel.initMyPlayer(loginObject);
        playerId = loginObject.playerID;
        shell.updateWorldPopulations(serverResponse[4]);
        this.on_login_response(true);
        is_logged_in = true;
        com.clubpenguin.login.LoginFloodManager.clearFloodControl();
        var _loc9 = shell.getLanguageBitmask();
        com.clubpenguin.util.Log.debug("\t-loginObject.languageRejected: " + loginObject.languageRejected);
        com.clubpenguin.util.Log.debug("\t-lang: " + _loc9);
        com.clubpenguin.util.Log.debug(" -loginObject.languageRejected & lang: " + loginObject.languageRejected + _loc9);
        if (loginObject.languageRejected & _loc9)
        {
            com.clubpenguin.util.Log.debug("calling out to nameResubmission");
            flash.external.ExternalInterface.call("nameResubmission", loginObject.playerID, loginObject.confirmationHash, loginObject.loginDataRaw);
        } // end if
    } // End of the function
    function handleExpiredPreactivationLogin(serverResponse)
    {
        this.removeListener(HANDLE_LOGIN, handleOnLogin);
        this.removeListener(HANDLE_LOGIN_EXPIRED, handleExpiredPreactivationLogin, this);
        trace ("\n\n            !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        trace ("            !!");
        trace ("            !!    USER MUST ACTIVATE SOON OR ACCOUNT WILL BE DELETED    !!");
        trace ("            !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        trace ("            !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n");
        var _loc3 = new Object();
        _loc3.modalBackgroundEnbaled = true;
        _loc3.blockPuffleNotifications = true;
        _loc3.hideLoadingDialog = true;
        var _loc2 = new Object();
        _loc2.state = FRAME_LABEL_EXPIRED;
        _loc2.graceRemaining = serverResponse[1];
        _loc2.confirmationHash = serverResponse[2];
        _loc2.loginDataRaw = serverResponse[3];
        _loc2.emailAddress = serverResponse[4];
        shell.sendOpenAS3Module("preactivation", _loc2, _loc3);
        var _loc4 = shell.getLanguageBitmask();
        trace ("\t-loginObject.languageRejected: " + loginObject.languageRejected);
        trace ("\t-lang: " + _loc4);
        trace (" -loginObject.languageRejected & lang: " + loginObject.languageRejected & _loc4);
        if (loginObject.languageRejected & _loc4)
        {
            trace ("calling out to nameResubmission");
            flash.external.ExternalInterface.call("nameResubmission", loginObject.playerID, loginObject.confirmationHash, loginObject.loginDataRaw);
        } // end if
    } // End of the function
    function connectToRedemption(server_ip, server_port, connect_to_world_response)
    {
        trace ("\tAIRTOWER.(server_ip: " + server_ip + ", server_port: " + server_port + ", connect_to_world_response: " + connect_to_world_response + ")");
        isRedemption = true;
        on_world_response = connect_to_world_response;
        server.onConnection = com.clubpenguin.util.Delegate.create(this, handleWorldConnection);
        server.onRandomKey = com.clubpenguin.util.Delegate.create(this, handleWorldRandomKey);
        this.addListener(HANDLE_LOGIN, joinWorld, this);
        server.connect(server_ip, server_port);
    } // End of the function
    function connectToWorld(server_ip, server_port, connect_to_world_response, loginKey)
    {
        isRedemption = false;
        on_world_response = connect_to_world_response;
        server.onConnection = com.clubpenguin.util.Delegate.create(this, handleWorldConnection);
        server.onRandomKey = com.clubpenguin.util.Delegate.create(this, handleWorldRandomKey);
        server.onExtensionResponse = com.clubpenguin.util.Delegate.create(this, onAirtowerResponse);
        server.debug = true;
        this.addListener(HANDLE_LOGIN, joinWorld, this);
        server.connect(server_ip, server_port);
    } // End of the function
    function handleWorldConnection(success)
    {
        if (success)
        {
            server.getRandomKey();
        }
        else
        {
            server.onConnection = null;
            server.onConnectionLost = null;
            server.onRandomKey = null;
            server.onExtensionResponse = null;
            this.on_world_response(false, false, false, false, false);
            on_world_response = null;
        } // end else if
    } // End of the function
    function handleWorldRandomKey(key)
    {
        rand_key = key;
        this.worldLogin();
    } // End of the function
    function worldLogin()
    {
        com.clubpenguin.util.Log.debug("worldLogin isJump = " + isJump + "   use encryption");
        var _loc2 = this.encryptPassword(loginObject.loginKey + rand_key) + loginObject.loginKey;
        trace ("Airtower - loginDataRaw " + shell.getMyPlayerObject().loginDataRaw);
        server.login(com.clubpenguin.net.Airtower.SERVER_ZONE, loginObject.Username, _loc2, shell.getMyPlayerObject().confirmationHash, shell.getMyPlayerObject().loginDataRaw);
    } // End of the function
    function joinWorld()
    {
        this.removeListener(HANDLE_LOGIN, joinWorld);
        server.onConnectionLost = com.clubpenguin.util.Delegate.create(this, handleLostConnection);
        var _loc2 = new Array();
        if (isRedemption)
        {
            _loc2.push(loginObject.loginDataRaw);
            _loc2.push(loginObject.confirmationHash);
        }
        else
        {
            _loc2.push(playerId);
            _loc2.push(loginObject.loginKey);
        } // end else if
        _loc2.push(shell.getLanguageAbbriviation());
        if (!isJump)
        {
            var _loc3 = com.clubpenguin.util.QueryParams.getQueryParams();
            if (Number(_loc3.rm))
            {
                _loc2.push(Number(_loc3.rm));
            } // end if
        }
        else
        {
            _loc2.push("jmp");
        } // end else if
        if (isRedemption)
        {
            this.addListener(REDEMPTION_JOIN_WORLD, handleJoinRedemption, this);
            this.send(REDEMPTION, REDEMPTION_JOIN_WORLD, _loc2, "str", -1);
            return;
        } // end if
        this.addListener(JOIN_WORLD, handleJoinWorld, this);
        this.addListener(GET_ACTIVE_FEATURES, handleGetActiveFeatures, this);
        this.send(PLAY_EXT, NAVIGATION + "#" + JOIN_WORLD, _loc2, "str", -1);
    } // End of the function
    function handleJoinRedemption(obj)
    {
        this.removeListener(REDEMPTION_JOIN_WORLD, handleJoinRedemption);
        var _loc4 = new Array();
        var _loc5 = new Array();
        var _loc6 = false;
        var _loc7 = obj.shift();
        if (obj[0] != "")
        {
            _loc4 = obj[0];
        } // end if
        if (obj[1] != "")
        {
            _loc5 = obj[1];
        } // end if
        if (obj[2] != "")
        {
            _loc6 = Boolean(Number(obj[2]));
        } // end if
        var _loc3 = new Array();
        _loc3[0] = _loc4;
        _loc3[1] = _loc5;
        _loc3[2] = _loc6;
        this.on_world_response(_loc3);
        on_world_response = undefined;
    } // End of the function
    function handleJoinWorld(obj)
    {
        com.clubpenguin.util.Log.debug("\n");
        com.clubpenguin.util.Log.debug("*********************************************");
        com.clubpenguin.util.Log.debug("handleJoinWorld");
        for (var _loc3 in obj)
        {
            com.clubpenguin.util.Log.debug("prop: " + _loc3 + "  " + obj[_loc3]);
        } // end of for...in
        com.clubpenguin.util.Log.debug("*********************************************");
        this.removeListener(JOIN_WORLD, handleJoinWorld);
        var _loc6 = Boolean(Number(obj[1]));
        var _loc4 = Boolean(Number(obj[2]));
        var _loc5 = Boolean(Number(obj[4]));
        shell.playerModel.setUpModeratorPenguin(Number(obj[3]));
        this.on_world_response(true, _loc6, _loc4, _loc5);
        on_world_response = undefined;
        isJump = false;
        shell.sendGetABTestData();
        this.send(PLAY_EXT, NEW_USER_EXPERIENCE_HANDLER + "#" + GET_ACTION_STATUS, null, "str", -1);
        this.addListener(GET_ACTION_STATUS, handleGetActionStatus, this);
    } // End of the function
    function handleGetActionStatus(serverResponse)
    {
        com.clubpenguin.util.Log.debug("handleGetActionStatus: " + serverResponse);
        this.removeListener(GET_ACTION_STATUS, handleGetActionStatus);
        var _loc4 = new Array(serverResponse[1], serverResponse[2], serverResponse[3]);
        shell.playerModel.initActionStatus(_loc4);
        _global.getCurrentEngine().localPlayerSpecialActionIndicators();
    } // End of the function
    function handleGetActiveFeatures(obj)
    {
        this.removeListener(GET_ACTIVE_FEATURES, handleGetActiveFeatures);
        shell.activeFeaturesArray = obj.slice(1);
        shell.updateListeners(shell.UPDATE_ACTIVE_FEATURES);
    } // End of the function
    function send(extension, command, arr, type, room_id)
    {
        com.clubpenguin.util.Log.debug("@@@@@ Airtower.send()  this=" + this);
        server.sendXtMessage(extension, command, arr, type, room_id);
    } // End of the function
    function disconnect(disconnectFriends)
    {
        com.clubpenguin.util.Log.debug("[airtower] disconnect() this = " + this + "  disconnectFriends=" + disconnectFriends);
        if (disconnectFriends == undefined)
        {
            disconnectFriends = true;
        } // end if
        if (server.connected())
        {
            if (!isJumpToNewServerInProgress)
            {
                if (disconnectFriends)
                {
                    shell.disconnectFromFriends();
                } // end if
            } // end if
            server.disconnect();
        }
        else
        {
            shell.$d("[airtower] disconnect() -> Trying to disconnect the server when its not connected");
        } // end else if
    } // End of the function
    function getLoginHash()
    {
        var _loc2 = this.encryptPassword(password).toUpperCase();
        _loc2 = _loc2 + password;
        _loc2 = this.encryptPassword(_loc2 + rand_key + this.encryptPassword(_loc2 + this.encryptPassword(password = password + _loc2)));
        return (_loc2);
    } // End of the function
    function hex_md5(s)
    {
        return (com.clubpenguin.crypto.MD5.hash(s));
    } // End of the function
    function encryptPassword(pass)
    {
        var _loc1 = com.clubpenguin.crypto.MD5.hash(pass);
        _loc1 = _loc1.substr(16, 16) + "" + _loc1.substr(0, 16);
        return (_loc1);
    } // End of the function
    static var linkageId = "__Packages.com.clubpenguin.net.Airtower";
    static var serializable = Object.registerClass(com.clubpenguin.net.Airtower.linkageId, com.clubpenguin.net.Airtower);
    static var $_lc = new com.clubpenguin.util.LogChannel("Airtower");
    var SERVER_MESSAGE_DELIMITER = "%";
    var STRING_TYPE = "str";
    var XML_TYPE = "xml";
    var PLAY_EXT = "s";
    var GAME_EXT = "z";
    var NAVIGATION = "j";
    var PLAYER_HANDLER = "u";
    var ITEM_HANDLER = "i";
    var IGNORE_HANDLER = "n";
    var BUDDY_HANDLER = "b";
    var TOY_HANDLER = "t";
    var TABLE_HANDLER = "a";
    var IGLOO_HANDLER = "g";
    var PET_HANDLER = "p";
    var MESSAGE_HANDLER = "m";
    var MAIL_HANDLER = "l";
    var SURVEY_HANDLER = "e";
    var WADDLE = "w";
    var SETTING_HANDLER = "s";
    var MODERATION_HANDLER = "o";
    var NINJA_HANDLER = "ni";
    var CARD_HANDLER = "cd";
    var ROOM_HANDLER = "r";
    var NEW_USER_EXPERIENCE_HANDLER = "nx";
    var PLAYER_TRANSFORMATION_HANDLER = "pt";
    var GHOST_BUSTER_HANDLER = "gb";
    var PLAYER_TICKET_HANDLER = "tic";
    var COOKIE_BAKERY_HANDLER = "ba";
    var BATTLE_ROOM_COUNTDOWN_UPDATE = "brcu";
    var BATTLE_ROOM_STATUS_UPDATE = "brsu";
    var BATTLE_ROOM_HIT_SNOWBALL = "bhs";
    var BATTLE_ROOM_THROW_SNOWBALL = "brts";
    var REDEMPTION = "red";
    var REDEMPTION_JOIN_WORLD = "rjs";
    var HANDLE_LOGIN = "l";
    var HANDLE_LOGIN_EXPIRED = "loginMustActivate";
    var HANDLE_ALERT = "a";
    var HANDLE_ERROR = "e";
    var GET_BUDDY_LIST = "gb";
    var GET_IGNORE_LIST = "gn";
    var GET_PLAYER = "gp";
    var GET_ROOM_LIST = "gr";
    var GET_TABLE = "gt";
    var JOIN_WORLD = "js";
    var JOIN_ROOM = "jr";
    var CLIENT_ROOM_LOADED = "crl";
    var REFRESH_ROOM = "grs";
    var LOAD_PLAYER = "lp";
    var ADD_PLAYER = "ap";
    var REMOVE_PLAYER = "rp";
    var UPDATE_PLAYER = "up";
    var PLAYER_MOVE = "sp";
    var PLAYER_TELEPORT = "tp";
    var REFRESH_PLAYER_FRIEND_INFORMATION = "rpfi";
    var PLAYER_FRAME = "sf";
    var PLAYER_ACTION = "sa";
    var OPEN_BOOK = "at";
    var CLOSE_BOOK = "rt";
    var THROW_BALL = "sb";
    var JOIN_GAME = "jg";
    var JOIN_NON_BLACK_HOLE_GAME = "jnbhg";
    var LEAVE_NON_BLACK_HOLE_GAME = "lnbhg";
    var SEND_MESSAGE = "sm";
    var SEND_PHRASECHAT_MESSAGE = "sc";
    var SEND_BLOCKED_MESSAGE = "mm";
    var SEND_EMOTE = "se";
    var SEND_JOKE = "sj";
    var SEND_SAFE_MESSAGE = "ss";
    var SEND_LINE_MESSAGE = "sl";
    var SEND_QUICK_MESSAGE = "sq";
    var SEND_TOUR_GUIDE_MESSAGE = "sg";
    var COIN_DIG_UPDATE = "cdu";
    var GET_INVENTORY_LIST = "gi";
    var GET_CURRENT_TOTAL_COIN = "gtc";
    var NINJA_GET_INVENTORY_LIST = "ngi";
    var GET_CURRENCIES = "currencies";
    var MAIL_START_ENGINE = "mst";
    var GET_MAIL = "mg";
    var SEND_MAIL = "ms";
    var RECEIVE_MAIL = "mr";
    var DELETE_MAIL = "md";
    var DELETE_MAIL_FROM_PLAYER = "mdp";
    var GET_MAIL_DETAILS = "mgd";
    var MAIL_CHECKED = "mc";
    var GAME_OVER = "zo";
    var BUY_INVENTORY = "ai";
    var CHECK_INVENTORY = "qi";
    var ADD_IGNORE = "an";
    var REMOVE_IGNORE = "rn";
    var REMOVE_BUDDY = "rb";
    var REQUEST_BUDDY = "br";
    var ACCEPT_BUDDY = "ba";
    var BUDDY_ONLINE = "bon";
    var BUDDY_OFFLINE = "bof";
    var FIND_BUDDY = "bf";
    var GET_PLAYER_OBJECT = "gp";
    var GET_MASCOT_OBJECT = "gmo";
    var REPORT_PLAYER = "r";
    var GET_ACTION_STATUS = "gas";
    var UPDATE_PLAYER_COLOUR = "upc";
    var UPDATE_PLAYER_HEAD = "uph";
    var UPDATE_PLAYER_FACE = "upf";
    var UPDATE_PLAYER_NECK = "upn";
    var UPDATE_PLAYER_BODY = "upb";
    var UPDATE_PLAYER_HAND = "upa";
    var UPDATE_PLAYER_FEET = "upe";
    var UPDATE_PLAYER_FLAG = "upl";
    var UPDATE_PLAYER_PHOTO = "upp";
    var UPDATE_PLAYER_REMOVE = "upr";
    var SEND_ACTION_DANCE = "sdance";
    var SEND_ACTION_WAVE = "swave";
    var SEND_ACTION_SNOWBALL = "ssnowball";
    var GET_FURNITURE_LIST = "gii";
    var UPDATE_ROOM = "up";
    var UPDATE_FLOOR = "ag";
    var UPDATE_IGLOO_TYPE = "au";
    var BUY_IGLOO_LOCATION = "aloc";
    var UNLOCK_IGLOO = "or";
    var LOCK_IGLOO = "cr";
    var UPDATE_IGLOO_MUSIC = "um";
    var GET_IGLOO_DETAILS = "gm";
    var JOIN_PLAYER_ROOM = "jp";
    var SAVE_IGLOO_FURNITURE = "ur";
    var JUMP_TO_IGLOO = "ji";
    var GET_IGLOO_LIST = "gr";
    var GET_IGLOO_LIST_ITEM = "gri";
    var PLAYER_IGLOO_OPEN = "pio";
    var BUY_FURNITURE = "af";
    var BUY_MULTIPLE_FURNITURE = "buy_multiple_furniture";
    var SEND_IGLOO = "sig";
    var GET_OWNED_IGLOOS = "go";
    var ACTIVATE_IGLOO = "ao";
    var GET_MY_PLAYER_PUFFLES = "pgu";
    var RETURN_PUFFLE = "prp";
    var GET_PLAYER_PUFFLES = "pg";
    var PUFFLE_FRAME = "ps";
    var PUFFLE_MOVE = "pm";
    var PUFFLE_VISITOR_HAT_UPDATE = "puphi";
    var ADD_A_PUFFLE = "addpuffle";
    var REST_PUFFLE = "pr";
    var BATH_PUFFLE = "pb";
    var PLAY_PUFFLE = "pp";
    var BUBBLE_GUM_PUFFLE = "pbg";
    var FEED_PUFFLE = "pf";
    var WALK_PUFFLE = "pw";
    var TREAT_PUFFLE = "pt";
    var SWAP_PUFFLE = "puffleswap";
    var WALK_SWAP_PUFFLE = "pufflewalkswap";
    var INTERACTION_PLAY = "ip";
    var INTERACTION_REST = "ir";
    var INTERACTION_FEED = "if";
    var PUFFLE_INIT_INTERACTION_PLAY = "pip";
    var PUFFLE_INIT_INTERACTION_REST = "pir";
    var ADOPT_PUFFLE = "pn";
    var PUFFLE_QUIZ_STATUS = "pgas";
    var ADD_PUFFLE_CARE_ITEM = "papi";
    var UPDATE_TABLE = "ut";
    var GET_TABLE_POPULATION = "gt";
    var JOIN_TABLE = "jt";
    var LEAVE_TABLE = "lt";
    var UPDATE_WADDLE = "uw";
    var GET_WADDLE_POPULATION = "gw";
    var GET_WADDLE_CJ = "gwcj";
    var JOIN_WADDLE = "jw";
    var LEAVE_WADDLE = "lw";
    var START_WADDLE = "sw";
    var SEND_WADDLE = "jx";
    var CARD_JITSU_MATCH_SUCCESSFUL = "cjms";
    var SPY_PHONE_REQUEST = "spy";
    var HEARTBEAT = "h";
    var TIMEOUT = "t";
    var MODERATOR_ACTION = "ma";
    var KICK = "k";
    var MUTE = "m";
    var BAN = "b";
    var INT_BAN = "initban";
    var SEND_MASCOT_MESSAGE = "sma";
    var DONATE = "dc";
    var POLL = "spl";
    var CONNECTION_LOST = "con";
    var GET_CARDS = "gcd";
    var GET_NINJA_LEVEL = "gnl";
    var GET_FIRE_LEVEL = "gfl";
    var GET_WATER_LEVEL = "gwl";
    var GET_SNOW_LEVEL = "gsl";
    var GET_NINJA_RANKS = "gnr";
    var BUY_POWER_CARDS = "bpc";
    var SET_SAVED_MAP_CATEGORY = "mcs";
    var SET_PLAYER_CARD_OPENED = "pcos";
    var SET_VISITED_CONTENT_FLAGS = "vcfs";
    var GET_VISITED_CONTENT_FLAGS = "vcf";
    var PLAYER_TRANSFORMATION = "spts";
    var GET_LAST_REVISION = "glr";
    var MOBILE_ACCOUNT_ACTIVATION_REQUIRED = "maar";
    var GET_PLAYER_ID_AND_NAME_BY_SWID = "pbs";
    var GET_PLAYER_INFO_BY_NAME = "pbn";
    var GET_PLAYER_INFO_BY_ID = "pbi";
    var GET_PLAYER_IDS_BY_SWIDS = "pbsm";
    var PBSM_START = "pbsms";
    var PBSM_FINISHED = "pbsmf";
    static var LOGIN_ZONE = "w1";
    static var SERVER_ZONE = "w1";
    var SCAVENGER_HUNT_NOTIFICATION = "shn";
    var GET_SCAVENGER_HUNT_TICKETS = "gptc";
    var INC_SCAVENGER_HUNT_TICKETS = "iptc";
    var DEC_SCAVENGER_HUNT_TICKETS = "dptc";
    var COINS_AWARDED = "$";
    var PLAYER_DIRECTOR_POINTS = "pdp";
    var GET_COINS_FOR_CHANGE_TOTALS = "gcfct";
    var CAN_PURCHASE_COOKIE = "cac";
    var PURCHASE_COOKIE = "ac";
    var COOKIES_READY = "cr";
    var GET_BAKERY_ROOM_STATE = "barsu";
    var SEND_SNOWBALL_ENTER_HOPPER = "seh";
    var GET_COOKIE_STOCK = "ctc";
    var CANCEL_COOKIE_RESERVATION = "cc";
    var GET_PARTY_COOKIE = "qpc";
    var SET_PARTY_COOKIE = "spd";
    var SET_PLAYER_TEST_GROUP_ID = "pigt";
    var UPDATE_EGG_TIMER = "uet";
    var SNOWBALL_HIT = "sh";
    var GET_AB_TEST_DATA = "gabcms";
    var GET_ACTIVE_FEATURES = "activefeatures";
    var server_ip = "";
    var server_port = 0;
    var loginObject = {};
    var username = "";
    var password = "";
    var playerId = -1;
    var rand_key = "";
    var is_logged_in = false;
    var server = null;
    var sf_listener_container = new Object();
    var isRedemption = false;
    var isJump = false;
    var isJumpToNewServerInProgress = false;
    var FRAME_LABEL_WELCOME = "welcome";
    var FRAME_LABEL_EXPIRED = "expired";
    var debugName = "";
} // End of Class
