class it.gotoandplay.smartfoxserver.SmartFoxClient extends XMLSocket
{
    var objRef, os, roomList, buddyList, buddyVars, activeRoomId, myUserId, myUserName, playerId, debug, isConnected, changingRoom, amIModerator, arrayTags, messageHandlers, onConnect, onData, onXML, onClose, onBuddyList, t1, ipAddress, onConnection, onConnectionLost, close;
    function SmartFoxClient(objRef)
    {
        super();
        this.objRef = objRef;
        os = it.gotoandplay.smartfoxserver.ObjectSerializer.getInstance();
        roomList = {};
        buddyList = [];
        buddyVars = [];
        activeRoomId = null;
        myUserId = null;
        myUserName = "";
        playerId = null;
        debug = false;
        isConnected = false;
        changingRoom = false;
        amIModerator = false;
        arrayTags = {uLs: true, rmList: true, vars: true, bList: true, vs: true};
        messageHandlers = new Object();
        onConnect = connectionEstablished;
        onData = gotData;
        onXML = xmlReceived;
        onClose = connectionClosed;
        this.setupMessageHandlers();
    } // End of the function
    function getVersion()
    {
        return (majVersion + "." + minVersion + "." + subVersion);
    } // End of the function
    function connected()
    {
        return (isConnected);
    } // End of the function
    function setupMessageHandlers()
    {
        this.addMessageHandler("sys", handleSysMessages);
        this.addMessageHandler("xt", handleExtensionMessages);
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
    function isModerator()
    {
        return (amIModerator);
    } // End of the function
    function handleSysMessages(xmlObj, scope)
    {
        var _loc22 = xmlObj.attributes.action;
        var _loc40 = xmlObj.attributes.r;
        if (_loc22 == "apiOK")
        {
            scope.isConnected = true;
            scope.onConnection(true);
        }
        else if (_loc22 == "apiKO")
        {
            scope.onConnection(false);
            trace ("--------------------------------------------------------");
            trace (" WARNING! The API you are using are not compatible with ");
            trace (" the SmartFoxServer instance you\'re trying to connect to");
            trace ("--------------------------------------------------------");
        }
        else if (_loc22 == "logOK")
        {
            scope.myUserId = xmlObj.login.attributes.id;
            scope.myUserName = xmlObj.login.attributes.n;
            scope.amIModerator = xmlObj.login.attributes.mod == "0" ? (false) : (true);
            scope.onLogin({success: true, name: scope.myUserName, error: ""});
            scope.getRoomList();
        }
        else if (_loc22 == "logKO")
        {
            var _loc48 = xmlObj.login.attributes.e;
            scope.onLogin({success: false, name: "", error: _loc48});
        }
        else if (_loc22 == "rmList")
        {
            var _loc20 = xmlObj.rmList.rmList;
            scope.roomList = new Array();
            for (var _loc46 in _loc20)
            {
                var _loc17 = _loc20[_loc46].attributes.id;
                var _loc12 = _loc20[_loc46].attributes;
                var _loc11 = _loc12.id;
                var _loc23 = _loc20[_loc46].n.value;
                var _loc36 = Number(_loc12.maxu);
                var _loc35 = Number(_loc12.maxs);
                var _loc29 = _loc12.temp ? (true) : (false);
                var _loc31 = _loc12.game ? (true) : (false);
                var _loc38 = _loc12.priv ? (true) : (false);
                var _loc37 = Number(_loc12.ucnt);
                var _loc34 = Number(_loc12.scnt);
                var _loc33 = _loc12.lmb ? (true) : (false);
                scope.roomList[_loc17] = new it.gotoandplay.smartfoxserver.Room(_loc11, _loc23, _loc36, _loc35, _loc29, _loc31, _loc38);
                scope.roomList[_loc17].userCount = _loc37;
                scope.roomList[_loc17].specCount = _loc34;
                scope.roomList[_loc17].setIsLimbo(_loc33);
                var _loc14 = _loc20[_loc46].vars.vars;
                for (var _loc43 = 0; _loc43 < _loc14.length; ++_loc43)
                {
                    var _loc3 = _loc14[_loc43].attributes.n;
                    var _loc1 = _loc14[_loc43].attributes.t;
                    var _loc5 = _loc14[_loc43].value;
                    var _loc2;
                    if (_loc1 == "b")
                    {
                        _loc2 = Boolean;
                    }
                    else if (_loc1 == "n")
                    {
                        _loc2 = Number;
                    }
                    else if (_loc1 == "s")
                    {
                        _loc2 = String;
                    }
                    else if (_loc1 == "x")
                    {
                        _loc2 = function (x)
                        {
                            return (null);
                        };
                    } // end else if
                    scope.roomList[_loc17].variables[_loc3] = _loc2(_loc5);
                } // end of for
            } // end of for...in
            scope.onRoomListUpdate(scope.roomList);
        }
        else if (_loc22 == "joinOK")
        {
            var _loc49 = xmlObj.uLs.attributes.r;
            var _loc18 = xmlObj.uLs.uLs;
            var _loc26 = xmlObj.vars.vars;
            scope.activeRoomId = Number(_loc49);
            var _loc10 = scope.roomList[_loc49];
            _loc10.userList = new Object();
            scope.playerId = xmlObj.pid.attributes.id;
            _loc10.setMyPlayerIndex(xmlObj.pid.attributes.id);
            _loc10.variables = new Object();
            for (var _loc43 = 0; _loc43 < _loc26.length; ++_loc43)
            {
                _loc3 = _loc26[_loc43].attributes.n;
                _loc1 = _loc26[_loc43].attributes.t;
                _loc5 = _loc26[_loc43].value;
                if (_loc1 == "b")
                {
                    _loc2 = Boolean;
                }
                else if (_loc1 == "n")
                {
                    _loc2 = Number;
                }
                else if (_loc1 == "s")
                {
                    _loc2 = String;
                }
                else if (_loc1 == "x")
                {
                    _loc2 = function (x)
                    {
                        return (null);
                    };
                } // end else if
                _loc10.variables[_loc3] = _loc2(_loc5);
            } // end of for
            for (var _loc46 = 0; _loc46 < _loc18.length; ++_loc46)
            {
                _loc23 = _loc18[_loc46].n.value;
                _loc11 = _loc18[_loc46].attributes.i;
                var _loc32 = _loc18[_loc46].attributes.m;
                var _loc30 = _loc18[_loc46].attributes.s;
                var _loc25 = _loc18[_loc46].attributes.p;
                _loc10.userList[_loc11] = new it.gotoandplay.smartfoxserver.User(_loc11, _loc23);
                _loc10.userList[_loc11].isMod = _loc32 == "1" ? (true) : (false);
                _loc10.userList[_loc11].isSpec = _loc30 == "1" ? (true) : (false);
                _loc10.userList[_loc11].pid = _loc25 == undefined ? (-1) : (_loc25);
                var _loc8 = _loc18[_loc46].vars.vars;
                _loc10.userList[_loc11].variables = {};
                var _loc21 = _loc10.userList[_loc11].variables;
                for (var _loc43 = 0; _loc43 < _loc8.length; ++_loc43)
                {
                    _loc3 = _loc8[_loc43].attributes.n;
                    _loc1 = _loc8[_loc43].attributes.t;
                    _loc5 = _loc8[_loc43].value;
                    if (_loc1 == "b")
                    {
                        _loc2 = Boolean;
                    }
                    else if (_loc1 == "n")
                    {
                        _loc2 = Number;
                    }
                    else if (_loc1 == "s")
                    {
                        _loc2 = String;
                    }
                    else if (_loc1 == "x")
                    {
                        _loc2 = function (x)
                        {
                            return (null);
                        };
                    } // end else if
                    _loc21[_loc3] = _loc2(_loc5);
                } // end of for
            } // end of for
            scope.changingRoom = false;
            scope.onJoinRoom(scope.roomList[_loc49]);
        }
        else if (_loc22 == "joinKO")
        {
            scope.changingRoom = false;
            var _loc59 = xmlObj.error.attributes.msg;
            scope.onJoinRoomError(_loc59);
        }
        else if (_loc22 == "uER")
        {
            var _loc27 = xmlObj.u.attributes.i;
            var _loc47 = xmlObj.u.n.value;
            _loc32 = xmlObj.u.attributes.m;
            _loc30 = xmlObj.u.attributes.s;
            _loc25 = xmlObj.u.attributes.p;
            _loc10 = scope.roomList[_loc40];
            _loc10.userList[_loc27] = new it.gotoandplay.smartfoxserver.User(_loc27, _loc47);
            _loc10.userList[_loc27].isMod = _loc32 == "1" ? (true) : (false);
            _loc10.userList[_loc27].isSpec = _loc30 == "1" ? (true) : (false);
            _loc10.userList[_loc27].pid = _loc25 == undefined ? (-1) : (_loc25);
            ++_loc10.userCount;
            _loc8 = xmlObj.u.vars.vars;
            _loc10.userList[_loc27].variables = {};
            _loc21 = _loc10.userList[_loc27].variables;
            for (var _loc43 = 0; _loc43 < _loc8.length; ++_loc43)
            {
                _loc3 = _loc8[_loc43].attributes.n;
                _loc1 = _loc8[_loc43].attributes.t;
                _loc5 = _loc8[_loc43].value;
                if (_loc1 == "b")
                {
                    _loc2 = Boolean;
                }
                else if (_loc1 == "n")
                {
                    _loc2 = Number;
                }
                else if (_loc1 == "s")
                {
                    _loc2 = String;
                }
                else if (_loc1 == "x")
                {
                    _loc2 = function (x)
                    {
                        return (null);
                    };
                } // end else if
                _loc21[_loc3] = _loc2(_loc5);
            } // end of for
            scope.onUserEnterRoom(_loc40, _loc10.userList[_loc27]);
        }
        else if (_loc22 == "userGone")
        {
            _loc27 = xmlObj.user.attributes.id;
            _loc10 = scope.roomList[_loc40];
            _loc47 = _loc10.userList[_loc27].name;
            delete _loc10.userList[_loc27];
            --_loc10.userCount;
            scope.onUserLeaveRoom(_loc40, _loc27, _loc47);
        }
        else if (_loc22 == "pubMsg")
        {
            _loc27 = xmlObj.user.attributes.id;
            var _loc39 = xmlObj.txt.value;
            _loc39 = scope.os.decodeEntities(_loc39.toString());
            scope.onPublicMessage(_loc39.toString(), scope.roomList[_loc40].userList[_loc27], _loc40);
        }
        else if (_loc22 == "prvMsg")
        {
            _loc27 = xmlObj.user.attributes.id;
            _loc39 = xmlObj.txt.value;
            _loc39 = scope.os.decodeEntities(_loc39);
            scope.onPrivateMessage(_loc39.toString(), scope.roomList[_loc40].userList[_loc27], _loc27, _loc40);
        }
        else if (_loc22 == "dmnMsg")
        {
            _loc27 = xmlObj.user.attributes.id;
            _loc39 = xmlObj.txt.value;
            _loc39 = scope.os.decodeEntities(_loc39);
            scope.onAdminMessage(_loc39.toString(), scope.roomList[_loc40].userList[_loc27]);
        }
        else if (_loc22 == "modMsg")
        {
            _loc27 = xmlObj.user.attributes.id;
            _loc39 = xmlObj.txt.value;
            _loc39 = scope.os.decodeEntities(_loc39);
            scope.onModeratorMessage(_loc39.toString(), scope.roomList[_loc40].userList[_loc27]);
        }
        else if (_loc22 == "dataObj")
        {
            var _loc63 = xmlObj.user.attributes.id;
            var _loc66 = xmlObj.dataObj.value;
            var _loc64 = scope.os.deserialize(_loc66);
            scope.onObjectReceived(_loc64, scope.roomList[_loc40].userList[_loc63]);
        }
        else if (_loc22 == "uVarsUpdate")
        {
            _loc27 = xmlObj.user.attributes.id;
            var _loc9 = xmlObj.vars.vars;
            var _loc41 = scope.roomList[_loc40].userList[_loc27];
            if (_loc41.variables == undefined)
            {
                _loc41.variables = {};
            } // end if
            var _loc24 = [];
            for (var _loc43 = 0; _loc43 < _loc9.length; ++_loc43)
            {
                _loc3 = _loc9[_loc43].attributes.n;
                _loc1 = _loc9[_loc43].attributes.t;
                _loc5 = _loc9[_loc43].value;
                _loc24.push(_loc3);
                _loc24[_loc3] = true;
                if (_loc1 == "x")
                {
                    delete _loc41.variables[_loc3];
                    continue;
                } // end if
                if (_loc1 == "b")
                {
                    _loc2 = Boolean;
                }
                else if (_loc1 == "n")
                {
                    _loc2 = Number;
                }
                else if (_loc1 == "s")
                {
                    _loc2 = String;
                } // end else if
                _loc41.variables[_loc3] = _loc2(_loc5);
            } // end of for
            scope.onUserVariablesUpdate(_loc41, _loc24);
        }
        else if (_loc22 == "rVarsUpdate")
        {
            _loc9 = xmlObj.vars.vars;
            _loc10 = scope.roomList[_loc40];
            _loc24 = [];
            if (_loc10.variables == undefined)
            {
                _loc10.variables = new Object();
            } // end if
            for (var _loc43 = 0; _loc43 < _loc9.length; ++_loc43)
            {
                _loc3 = _loc9[_loc43].attributes.n;
                _loc1 = _loc9[_loc43].attributes.t;
                _loc5 = _loc9[_loc43].value;
                _loc24.push(_loc3);
                _loc24[_loc3] = true;
                if (_loc1 == "x")
                {
                    delete _loc10.variables[_loc3];
                    continue;
                } // end if
                if (_loc1 == "b")
                {
                    _loc2 = Boolean;
                }
                else if (_loc1 == "n")
                {
                    _loc2 = Number;
                }
                else if (_loc1 == "s")
                {
                    _loc2 = String;
                } // end else if
                _loc10.variables[_loc3] = _loc2(_loc5);
            } // end of for
            scope.onRoomVariablesUpdate(_loc10, _loc24);
        }
        else if (_loc22 == "createRmKO")
        {
            _loc48 = xmlObj.room.attributes.e;
            scope.onCreateRoomError(_loc48);
        }
        else if (_loc22 == "uCount")
        {
            var _loc62 = xmlObj.attributes.u;
            var _loc53 = xmlObj.attributes.s;
            var _loc50 = scope.roomList[_loc40];
            _loc50.userCount = Number(_loc62);
            _loc50.specCount = Number(_loc53);
            scope.onUserCountChange(_loc50);
        }
        else if (_loc22 == "roomAdd")
        {
            var _loc45 = xmlObj.rm.attributes;
            var _loc52 = _loc45.id;
            var _loc55 = xmlObj.rm.name.value;
            var _loc60 = Number(_loc45.max);
            var _loc56 = Number(_loc45.spec);
            _loc29 = _loc45.temp ? (true) : (false);
            _loc31 = _loc45.game ? (true) : (false);
            var _loc54 = _loc45.priv ? (true) : (false);
            _loc33 = _loc45.limbo ? (true) : (false);
            var _loc44 = new it.gotoandplay.smartfoxserver.Room(_loc52, _loc55, _loc60, _loc56, _loc29, _loc31, _loc54);
            _loc44.setIsLimbo(_loc33);
            scope.roomList[_loc52] = _loc44;
            _loc9 = xmlObj.rm.vars.vars;
            _loc44.variables = new Object();
            for (var _loc43 = 0; _loc43 < _loc9.length; ++_loc43)
            {
                _loc3 = _loc9[_loc43].attributes.n;
                _loc1 = _loc9[_loc43].attributes.t;
                _loc5 = _loc9[_loc43].value;
                if (_loc1 == "b")
                {
                    _loc2 = Boolean;
                }
                else if (_loc1 == "n")
                {
                    _loc2 = Number;
                }
                else if (_loc1 == "s")
                {
                    _loc2 = String;
                } // end else if
                _loc44.variables[_loc3] = _loc2(_loc5);
            } // end of for
            scope.onRoomAdded(_loc44);
        }
        else if (_loc22 == "roomDel")
        {
            var _loc51 = xmlObj.rm.attributes.id;
            var _loc61 = scope.roomList[_loc51];
            delete scope.roomList[_loc51];
            scope.onRoomDeleted(_loc61);
        }
        else if (_loc22 == "leaveRoom")
        {
            var _loc57 = xmlObj.rm.attributes.id;
            scope.onRoomLeft(_loc57);
        }
        else if (_loc22 == "roundTripRes")
        {
            scope.t2 = getTimer();
            scope.onRoundTripResponse(scope.t2 - scope.t1);
        }
        else if (_loc22 == "swSpec")
        {
            scope.playerId = Number(xmlObj.pid.attributes.id);
            scope.onSpectatorSwitched(scope.playerId > 0, scope.playerId, scope.roomList[_loc40]);
        }
        else if (_loc22 == "bList")
        {
            var _loc19 = xmlObj.bList.bList;
            if (_loc19 == undefined)
            {
                scope.onBuddyListError(xmlObj.err.value);
                return;
            } // end if
            for (var _loc46 = 0; _loc46 < _loc19.length; ++_loc46)
            {
                var _loc6 = {};
                _loc6.isOnline = _loc19[_loc46].attributes.s == "1" ? (true) : (false);
                _loc6.name = _loc19[_loc46].n.value;
                _loc6.id = _loc19[_loc46].attributes.i;
                _loc6.variables = {};
                var _loc7 = _loc19[_loc46].vs.vs;
                for (var _loc43 in _loc7)
                {
                    var _loc15 = _loc7[_loc43].attributes.n;
                    var _loc13 = _loc7[_loc43].value;
                    _loc6.variables[_loc15] = _loc13;
                } // end of for...in
                scope.buddyList.push(_loc6);
            } // end of for
            scope.onBuddyList(scope.buddyList);
        }
        else if (_loc22 == "bUpd")
        {
            var _loc42 = xmlObj.b;
            if (_loc42 == undefined)
            {
                scope.onBuddyListError(xmlObj.err.value);
                return;
            } // end if
            _loc6 = {};
            _loc6.name = _loc42.n.value;
            _loc6.id = _loc42.attributes.i;
            _loc6.isOnline = _loc42.attributes.s == "1" ? (true) : (false);
            _loc6.variables = {};
            _loc7 = _loc42.vs.vs;
            for (var _loc46 in _loc7)
            {
                _loc15 = _loc7[_loc46].attributes.n;
                _loc13 = _loc7[_loc46].value;
                _loc6.variables[_loc15] = _loc13;
            } // end of for...in
            for (var _loc46 = 0; _loc46 < scope.buddyList.length; ++_loc46)
            {
                if (scope.buddyList[_loc46].name == _loc6.name)
                {
                    scope.buddyList[_loc46] = _loc6;
                    break;
                } // end if
            } // end of for
            scope.onBuddyListUpdate(_loc6);
        }
        else if (_loc22 == "bAdd")
        {
            _loc42 = xmlObj.b;
            _loc6 = {};
            _loc6.name = _loc42.n.value;
            _loc6.id = _loc42.attributes.i;
            _loc6.isOnline = _loc42.attributes.s == "1" ? (true) : (false);
            _loc6.variables = {};
            _loc7 = _loc42.vs.vs;
            for (var _loc46 in _loc7)
            {
                _loc15 = _loc7[_loc46].attributes.n;
                _loc13 = _loc7[_loc46].value;
                _loc6.variables[_loc15] = _loc13;
            } // end of for...in
            scope.buddyList.push(_loc6);
            scope.onBuddyList(scope.buddyList);
        }
        else if (_loc22 == "roomB")
        {
            var _loc65 = xmlObj.br.attributes.r;
            var _loc28 = _loc65.toString().split(",");
            for (var _loc46 in _loc28)
            {
                _loc28[_loc46] = Number(_loc28[_loc46]);
            } // end of for...in
            scope.onBuddyRoom(_loc28);
        }
        else if (_loc22 == "rndK")
        {
            var _loc58 = xmlObj.k.value;
            scope.onRandomKey(_loc58);
        } // end else if
    } // End of the function
    function handleExtensionMessages(dataObj, scope, type)
    {
        if (type == "xml")
        {
            var _loc4 = dataObj.attributes.action;
            var _loc7 = dataObj.attributes.r;
            if (_loc4 == "xtRes")
            {
                var _loc6 = dataObj.value;
                var _loc5 = scope.os.deserialize(_loc6);
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
    function sendXtMessage(xtName, cmdName, paramObj, type, roomId)
    {
        if (roomId == undefined)
        {
            roomId = activeRoomId;
        } // end if
        if (type == undefined)
        {
            type = "xml";
        } // end if
        if (type == "xml")
        {
            var _loc12;
            _loc12 = {t: "xt"};
            var _loc13 = {name: xtName, cmd: cmdName, param: paramObj};
            var _loc11 = "<![CDATA[" + os.serialize(_loc13) + "]]>";
            this.send(_loc12, "xtReq", roomId, _loc11);
        }
        else if (type == "str")
        {
            var _loc3;
            _loc3 = "%xt%" + xtName + "%" + cmdName + "%" + roomId + "%";
            for (var _loc2 = 0; _loc2 < paramObj.length; ++_loc2)
            {
                _loc3 = _loc3 + (paramObj[_loc2].toString() + "%");
            } // end of for
            this.sendString(_loc3);
        }
        else if (type == "json")
        {
            var _loc5 = {};
            _loc5.x = xtName;
            _loc5.c = cmdName;
            _loc5.r = roomId;
            _loc5.p = paramObj;
            var _loc6 = {};
            _loc6.t = "xt";
            _loc6.b = _loc5;
            try
            {
                var _loc10 = it.gotoandplay.smartfoxserver.JSON.stringify(_loc6);
                this.sendJson(_loc10);
            } // End of try
            catch (ex)
            {
                if (debug)
                {
                    trace ("Error in sending JSON message.");
                    trace (ex.name + " : " + ex.message + " : " + ex.at + " : " + ex.text);
                } // end else if
            } // End of catch
        } // end else if
    } // End of the function
    function dumpObj(obj, depth)
    {
        if (depth == undefined)
        {
            depth = 0;
        } // end if
        if (debug)
        {
            if (depth == 0)
            {
                trace ("+-----------------------------------------------+");
                trace ("+ Object Dump                                   +");
                trace ("+-----------------------------------------------+");
            } // end if
            for (var _loc8 in obj)
            {
                var _loc4 = obj[_loc8];
                var _loc5 = typeof(_loc4);
                if (_loc5 != "object")
                {
                    var _loc2 = "";
                    for (var _loc3 = 0; _loc3 < depth; ++_loc3)
                    {
                        _loc2 = _loc2 + "\t";
                    } // end of for
                    _loc2 = _loc2 + (_loc8 + " : " + _loc4 + " ( " + _loc5 + " )");
                    trace (_loc2);
                    continue;
                } // end if
                this.dumpObj(_loc4, depth + 1);
            } // end of for...in
        } // end if
    } // End of the function
    function login(zone, nick, pass)
    {
        var _loc2 = {t: "sys"};
        var _loc3 = "<login z=\'" + zone + "\'><nick><![CDATA[" + nick + "]]></nick><pword><![CDATA[" + pass + "]]></pword></login>";
        this.send(_loc2, "login", 0, _loc3);
    } // End of the function
    function getRoomList()
    {
        var _loc2 = {t: "sys"};
        this.send(_loc2, "getRmList", activeRoomId ? (activeRoomId) : (-1), "");
    } // End of the function
    function autoJoin()
    {
        var _loc2 = {t: "sys"};
        this.send(_loc2, "autoJoin", activeRoomId ? (activeRoomId) : (-1), "");
    } // End of the function
    function joinRoom(newRoom, pword, isSpectator, dontLeave, oldRoom)
    {
        var _loc2 = null;
        var _loc6;
        if (isSpectator)
        {
            _loc6 = 1;
        }
        else
        {
            _loc6 = 0;
        } // end else if
        if (!changingRoom)
        {
            if (typeof(newRoom) == "number")
            {
                _loc2 = newRoom;
            }
            else
            {
                for (var _loc4 in roomList)
                {
                    if (roomList[_loc4].name == newRoom)
                    {
                        _loc2 = roomList[_loc4].id;
                        break;
                    } // end if
                } // end of for...in
            } // end else if
            if (_loc2 != null)
            {
                var _loc8 = {t: "sys"};
                var _loc7 = dontLeave ? ("0") : ("1");
                var _loc5;
                if (oldRoom)
                {
                    _loc5 = oldRoom;
                }
                else
                {
                    _loc5 = activeRoomId;
                } // end else if
                if (activeRoomId == null)
                {
                    _loc7 = "0";
                    _loc5 = -1;
                } // end if
                var _loc9 = "<room id=\'" + _loc2 + "\' pwd=\'" + pword + "\' spec=\'" + _loc6 + "\' leave=\'" + _loc7 + "\' old=\'" + _loc5 + "\' />";
                this.send(_loc8, "joinRoom", activeRoomId ? (activeRoomId) : (-1), _loc9);
                changingRoom = true;
            }
            else
            {
                trace ("SmartFoxError: requested room to join does not exist!");
            } // end if
        } // end else if
    } // End of the function
    function sendPublicMessage(msg, roomId)
    {
        if (roomId == undefined)
        {
            roomId = activeRoomId;
        } // end if
        var _loc3 = {t: "sys"};
        var _loc2 = "<txt><![CDATA[" + os.encodeEntities(msg) + "]]></txt>";
        this.send(_loc3, "pubMsg", roomId, _loc2);
    } // End of the function
    function sendPrivateMessage(msg, userId, roomId)
    {
        if (roomId == undefined)
        {
            roomId = activeRoomId;
        } // end if
        var _loc3 = {t: "sys"};
        var _loc2 = "<txt rcp=\'" + userId + "\'><![CDATA[" + os.encodeEntities(msg) + "]]></txt>";
        this.send(_loc3, "prvMsg", roomId, _loc2);
    } // End of the function
    function sendModeratorMessage(msg, type, id)
    {
        var _loc3 = {t: "sys"};
        var _loc2 = "<txt t=\'" + type + "\' id=\'" + id + "\'><![CDATA[" + os.encodeEntities(msg) + "]]></txt>";
        this.send(_loc3, "modMsg", activeRoomId, _loc2);
    } // End of the function
    function sendObject(obj, roomId)
    {
        if (roomId == undefined)
        {
            roomId = activeRoomId;
        } // end if
        var _loc3 = "<![CDATA[" + os.serialize(obj) + "]]>";
        var _loc2 = {t: "sys"};
        this.send(_loc2, "asObj", roomId, _loc3);
    } // End of the function
    function sendObjectToGroup(obj, userList, roomId)
    {
        if (roomId == undefined)
        {
            roomId = activeRoomId;
        } // end if
        var _loc3 = "";
        for (var _loc4 in userList)
        {
            if (!isNaN(userList[_loc4]))
            {
                _loc3 = _loc3 + (userList[_loc4] + ",");
            } // end if
        } // end of for...in
        _loc3 = _loc3.substr(0, _loc3.length - 1);
        obj._$$_ = _loc3;
        var _loc6 = "<![CDATA[" + os.serialize(obj) + "]]>";
        var _loc5 = {t: "sys"};
        this.send(_loc5, "asObjG", roomId, _loc6);
    } // End of the function
    function setUserVariables(varObj, roomId)
    {
        if (roomId == undefined)
        {
            roomId = activeRoomId;
        } // end if
        var _loc9 = {t: "sys"};
        var _loc4 = "<vars>";
        var _loc5 = roomList[roomId].userList[myUserId];
        for (var _loc7 in varObj)
        {
            var _loc2 = varObj[_loc7];
            var _loc3 = null;
            if (typeof(_loc2) == "boolean")
            {
                _loc3 = "b";
                _loc2 = _loc2 ? (1) : (0);
            }
            else if (typeof(_loc2) == "number")
            {
                _loc3 = "n";
            }
            else if (typeof(_loc2) == "string")
            {
                _loc3 = "s";
            }
            else if (typeof(_loc2) == "null")
            {
                _loc3 = "x";
                delete _loc5.variables[_loc7];
            } // end else if
            if (_loc3 != null)
            {
                _loc5.variables[_loc7] = _loc2;
                _loc4 = _loc4 + ("<var n=\'" + _loc7 + "\' t=\'" + _loc3 + "\'><![CDATA[" + _loc2 + "]]></var>");
            } // end if
        } // end of for...in
        _loc4 = _loc4 + "</vars>";
        this.send(_loc9, "setUvars", roomId, _loc4);
    } // End of the function
    function setBuddyVariables(varObj)
    {
        var _loc6 = {t: "sys"};
        var _loc3 = "<vars>";
        for (var _loc5 in varObj)
        {
            var _loc2 = varObj[_loc5];
            if (buddyVars[_loc5] != _loc2)
            {
                buddyVars[_loc5] = _loc2;
                _loc3 = _loc3 + ("<var n=\'" + _loc5 + "\'><![CDATA[" + _loc2 + "]]></var>");
            } // end if
        } // end of for...in
        _loc3 = _loc3 + "</vars>";
        this.send(_loc6, "setBvars", -1, _loc3);
    } // End of the function
    function dumpRoomList()
    {
        for (var _loc5 in roomList)
        {
            var _loc2 = roomList[_loc5];
            trace ("\n");
            trace ("-------------------------------------");
            trace (" > Room: (" + _loc5 + ") - " + _loc2.getName());
            trace ("isTemp: " + _loc2.isTemp());
            trace ("isGame: " + _loc2.isGame());
            trace ("isPriv: " + _loc2.isPrivate());
            trace ("Users: " + _loc2.getUserCount() + " / " + _loc2.getMaxUsers());
            trace ("Variables: ");
            for (var _loc4 in _loc2.variables)
            {
                trace ("\t" + _loc4 + " = " + _loc2.getVariable(_loc4));
            } // end of for...in
            trace ("\rUserList: ");
            var _loc3 = _loc2.getUserList();
            for (var _loc4 in _loc3)
            {
                trace ("\t" + _loc3[_loc4].getId() + " > " + _loc3[_loc4].getName());
            } // end of for...in
        } // end of for...in
    } // End of the function
    function createRoom(roomObj, rId)
    {
        var _loc7 = rId == undefined ? (activeRoomId) : (rId);
        var _loc10 = {t: "sys"};
        var _loc8 = roomObj.updatable ? (1) : (0);
        var _loc6 = roomObj.isGame ? (1) : (0);
        var _loc5 = 1;
        var _loc9 = roomObj.maxSpectators;
        if (_loc6 && roomObj.exitCurrentRoom != undefined)
        {
            _loc5 = roomObj.exitCurrentRoom ? (1) : (0);
        } // end if
        var _loc2 = "<room upd=\'" + _loc8 + "\' tmp=\'1\' gam=\'" + _loc6 + "\' spec=\'" + _loc9 + "\' exit=\'" + _loc5 + "\'>";
        _loc2 = _loc2 + ("<name><![CDATA[" + roomObj.name + "]]></name>");
        _loc2 = _loc2 + ("<pwd><![CDATA[" + roomObj.password + "]]></pwd>");
        _loc2 = _loc2 + ("<max>" + roomObj.maxUsers + "</max>");
        if (roomObj.uCount != undefined)
        {
            _loc2 = _loc2 + ("<uCnt>" + (roomObj.uCount ? ("1") : ("0")) + "</uCnt>");
        } // end if
        if (roomObj.extension != undefined)
        {
            _loc2 = _loc2 + ("<xt n=\'" + roomObj.extension.name);
            _loc2 = _loc2 + ("\' s=\'" + roomObj.extension.script + "\' />");
        } // end if
        if (roomObj.vars == undefined)
        {
            _loc2 = _loc2 + "<vars></vars>";
        }
        else
        {
            _loc2 = _loc2 + "<vars>";
            for (var _loc4 in roomObj.vars)
            {
                _loc2 = _loc2 + this.getXmlRoomVariable(roomObj.vars[_loc4]);
            } // end of for...in
            _loc2 = _loc2 + "</vars>";
        } // end else if
        _loc2 = _loc2 + "</room>";
        this.send(_loc10, "createRoom", _loc7, _loc2);
    } // End of the function
    function leaveRoom(roomId)
    {
        var _loc2 = {t: "sys"};
        var _loc3 = "<rm id=\'" + roomId + "\' />";
        this.send(_loc2, "leaveRoom", roomId, _loc3);
    } // End of the function
    function getRoom(roomId)
    {
        if (typeof(roomId) == "number")
        {
            return (roomList[roomId]);
        }
        else if (typeof(roomId) == "string")
        {
            for (var _loc4 in roomList)
            {
                var _loc2 = roomList[_loc4];
                if (_loc2.getName() == roomId)
                {
                    return (_loc2);
                } // end if
            } // end of for...in
        } // end else if
    } // End of the function
    function getActiveRoom()
    {
        return (roomList[activeRoomId]);
    } // End of the function
    function setRoomVariables(varObj, roomId, setOwnership)
    {
        if (roomId == undefined)
        {
            roomId = activeRoomId;
        } // end if
        if (setOwnership == undefined)
        {
            setOwnership = true;
        } // end if
        var _loc5 = {t: "sys"};
        var _loc3;
        if (setOwnership)
        {
            _loc3 = "<vars>";
        }
        else
        {
            _loc3 = "<vars so=\'0\'>";
        } // end else if
        for (var _loc2 = 0; _loc2 < varObj.length; ++_loc2)
        {
            _loc3 = _loc3 + this.getXmlRoomVariable(varObj[_loc2]);
        } // end of for
        _loc3 = _loc3 + "</vars>";
        this.send(_loc5, "setRvars", roomId, _loc3);
    } // End of the function
    function getXmlRoomVariable(rVar)
    {
        var _loc5 = rVar.name;
        var _loc1 = rVar.val;
        var _loc4 = rVar.priv ? ("1") : ("0");
        var _loc6 = rVar.persistent ? ("1") : ("0");
        var _loc2 = null;
        if (typeof(_loc1) == "boolean")
        {
            _loc2 = "b";
            _loc1 = _loc1 ? (1) : (0);
        }
        else if (typeof(_loc1) == "number")
        {
            _loc2 = "n";
        }
        else if (typeof(_loc1) == "string")
        {
            _loc2 = "s";
        }
        else if (typeof(_loc1) == "null")
        {
            _loc2 = "x";
        } // end else if
        if (_loc2 != null)
        {
            return ("<var n=\'" + _loc5 + "\' t=\'" + _loc2 + "\' pr=\'" + _loc4 + "\' pe=\'" + _loc6 + "\'><![CDATA[" + _loc1 + "]]></var>");
        }
        else
        {
            return ("");
        } // end else if
    } // End of the function
    function loadBuddyList()
    {
        var _loc2 = {t: "sys"};
        this.send(_loc2, "loadB", -1, "");
    } // End of the function
    function addBuddy(buddyName)
    {
        if (buddyName != myUserName && !this.checkBuddy(buddyName))
        {
            var _loc6 = roomList[activeRoomId].getUserList().getUser(buddyName);
            var _loc3 = {t: "sys"};
            var _loc4 = "<n>" + buddyName + "</n>";
            this.send(_loc3, "addB", -1, _loc4);
        } // end if
    } // End of the function
    function removeBuddy(buddyName)
    {
        for (var _loc3 in buddyList)
        {
            if (buddyList[_loc3].name == buddyName)
            {
                delete buddyList[_loc3];
                break;
            } // end if
        } // end of for...in
        var _loc4 = {t: "sys"};
        var _loc5 = "<n>" + buddyName + "</n>";
        this.send(_loc4, "remB", -1, _loc5);
        this.onBuddyList(buddyList);
    } // End of the function
    function getBuddyRoom(buddy)
    {
        if (buddy.id != -1)
        {
            this.send({t: "sys", bid: buddy.id}, "roomB", -1, "<b id=\'" + buddy.id + "\' />");
        } // end if
    } // End of the function
    function checkBuddy(name)
    {
        var _loc2 = false;
        for (var _loc4 in buddyList)
        {
            if (buddyList[_loc4].name == name)
            {
                _loc2 = true;
                break;
            } // end if
        } // end of for...in
        return (_loc2);
    } // End of the function
    function clearBuddyList()
    {
        buddyList = [];
        this.send({t: "sys"}, "clearB", -1, "");
        this.onBuddyList(buddyList);
    } // End of the function
    function roundTripBench()
    {
        t1 = getTimer();
        var _loc2 = {t: "sys"};
        this.send(_loc2, "roundTrip", activeRoomId, "");
    } // End of the function
    function switchSpectator(roomId)
    {
        if (roomId == undefined)
        {
            roomId = activeRoomId;
        } // end if
        var _loc2 = {t: "sys"};
        this.send(_loc2, "swSpec", roomId, "");
    } // End of the function
    function getRandomKey()
    {
        this.send({t: "sys"}, "rndK", -1, "");
    } // End of the function
    function send(header, action, fromRoom, message)
    {
        var _loc3 = this.makeHeader(header);
        _loc3 = _loc3 + ("<body action=\'" + action + "\' r=\'" + fromRoom + "\'>" + message + "</body>" + this.closeHeader());
        if (debug)
        {
            trace ("[Sending]: " + _loc3 + "\n");
        } // end if
        super.send(_loc3);
    } // End of the function
    function uploadFile(fileRef, id, nick, port)
    {
        if (id == undefined)
        {
            id = myUserId;
        } // end if
        if (nick == undefined)
        {
            nick = myUserName;
        } // end if
        if (port == undefined)
        {
            port = httpPort;
        } // end if
        fileRef.upload("http://" + ipAddress + ":" + port + "/default/Upload.py?id=" + id + "&nick=" + nick);
        if (debug)
        {
            trace ("[UPLOAD]: http://" + ipAddress + ":" + port + "/default/Upload.py?id=" + id + "&nick=" + nick);
        } // end if
    } // End of the function
    function getUploadPath()
    {
        return ("http://" + ipAddress + ":" + httpPort + "/default/uploads/");
    } // End of the function
    function sendString(message)
    {
        if (debug)
        {
            trace ("[Sending]: " + message + "\n");
        } // end if
        super.send(message);
    } // End of the function
    function sendJson(message)
    {
        if (debug)
        {
            trace ("[Sending - json]: " + message + "\n");
        } // end if
        super.send(message);
    } // End of the function
    function gotData(message)
    {
        if (message.charAt(0) == "%")
        {
            this.strReceived(message);
        }
        else if (message.charAt(0) == "<")
        {
            this.onXML(new XML(message));
        }
        else if (message.charAt(0) == "{")
        {
            this.jsonReceived(message);
        } // end else if
    } // End of the function
    function connectionEstablished(ok)
    {
        if (ok)
        {
            var _loc2 = {t: "sys"};
            var _loc3 = "<ver v=\'" + majVersion.toString() + minVersion.toString() + subVersion.toString() + "\' />";
            this.send(_loc2, "verChk", 0, _loc3);
        }
        else
        {
            this.onConnection(false);
        } // end else if
    } // End of the function
    function connectionClosed()
    {
        isConnected = false;
        this.onConnectionLost();
    } // End of the function
    function connect(serverIp, serverPort)
    {
        if (!isConnected)
        {
            ipAddress = "127.0.0.1";
            super.connect("127.0.0.1", 9339);
        }
        else
        {
            trace ("WARNING! You\'re already connected to -> " + ipAddress);
        } // end else if
    } // End of the function
    function disconnect()
    {
        this.close();
        this.onConnectionLost();
    } // End of the function
    function xmlReceived(message)
    {
        var _loc2 = new Object();
        this.message2Object(message.childNodes, _loc2);
        if (debug)
        {
            trace ("[Received]: " + message);
        } // end if
        var _loc3 = _loc2.msg.attributes.t;
        messageHandlers[_loc3].handleMessage(_loc2.msg.body, this, "xml");
    } // End of the function
    function strReceived(message)
    {
        var _loc2 = message.substr(1, message.length - 2).split("%");
        if (debug)
        {
            trace ("[Received - Str]: " + message);
        } // end if
        var _loc4 = _loc2[0];
        messageHandlers[_loc4].handleMessage(_loc2.splice(1, _loc2.length - 1), this, "str");
    } // End of the function
    function jsonReceived(message)
    {
        var _loc2 = it.gotoandplay.smartfoxserver.JSON.parse(message);
        if (debug)
        {
            trace ("[Received - json]: " + message);
        } // end if
        var _loc3 = _loc2.t;
        messageHandlers[_loc3].handleMessage(_loc2.b, this, "json");
    } // End of the function
    function message2Object(xmlNodes, parentObj)
    {
        var _loc8 = 0;
        var _loc3 = null;
        while (_loc8 < xmlNodes.length)
        {
            var _loc4 = xmlNodes[_loc8];
            var _loc6 = _loc4.nodeName;
            var _loc5 = _loc4.nodeValue;
            if (parentObj instanceof Array)
            {
                _loc3 = {};
                parentObj.push(_loc3);
                _loc3 = parentObj[parentObj.length - 1];
            }
            else
            {
                parentObj[_loc6] = new Object();
                _loc3 = parentObj[_loc6];
            } // end else if
            for (var _loc10 in _loc4.attributes)
            {
                if (typeof(_loc3.attributes) == "undefined")
                {
                    _loc3.attributes = {};
                } // end if
                var _loc2 = _loc4.attributes[_loc10];
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
                _loc3.attributes[_loc10] = _loc2;
            } // end of for...in
            if (arrayTags[_loc6])
            {
                _loc3[_loc6] = [];
                _loc3 = _loc3[_loc6];
            } // end if
            if (_loc4.hasChildNodes() && _loc4.firstChild.nodeValue == undefined)
            {
                var _loc9 = _loc4.childNodes;
                this.message2Object(_loc9, _loc3);
            }
            else
            {
                _loc5 = _loc4.firstChild.nodeValue;
                if (!isNaN(_loc5) && _loc4.nodeName != "txt")
                {
                    _loc5 = Number(_loc5);
                } // end if
                _loc3.value = _loc5;
            } // end else if
            ++_loc8;
        } // end while
    } // End of the function
    function makeHeader(headerObj)
    {
        var _loc1 = "<msg";
        for (var _loc3 in headerObj)
        {
            _loc1 = _loc1 + (" " + _loc3 + "=\'" + headerObj[_loc3] + "\'");
        } // end of for...in
        _loc1 = _loc1 + ">";
        return (_loc1);
    } // End of the function
    function closeHeader()
    {
        return ("</msg>");
    } // End of the function
    static var MODMSG_TO_USER = "u";
    static var MODMSG_TO_ROOM = "r";
    static var MODMSG_TO_ZONE = "z";
    static var PROTOCOL_XML = "xml";
    static var PROTOCOL_STR = "str";
    static var PROTOCOL_JSON = "json";
    var httpPort = 8080;
    var majVersion = 1;
    var minVersion = 3;
    var subVersion = 5;
} // End of Class
