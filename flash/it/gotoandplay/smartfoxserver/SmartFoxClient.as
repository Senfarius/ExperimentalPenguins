import flash.external.ExternalInterface;

class it.gotoandplay.smartfoxserver.SmartFoxClient extends XMLSocket {
	var rand_key;
	function SmartFoxClient (objRef) {
		super();
		rand_key = "";
	}

	function handleSysMessages (xmlObj, scope) {
		var action = xmlObj.attributes.action;
		var fromRoom = xmlObj.attributes.r;
		if (action == "makeErr") {
			ExternalInterface.call("alertMsg", xmlObj.error.attributes.message);
		} else if (action == "makeAlert") {
			ExternalInterface.call("message", xmlObj.alert.attributes.message);
		} else if (action == "apiOK") {
			scope.isConnected = true;
			scope.onConnection(true);
			this.getRandomKey();
		} else if (action == "logOK") {
			scope.myUserId = xmlObj.login.attributes.id;
			scope.myUserName = xmlObj.login.attributes.n;
			scope.amIModerator = (xmlObj.login.attributes.mod == "0") ? false : true;
			scope.onLogin({success: true, name: scope.myUserName, error: ""});
			this.getRoomList();
		}
	}

	function login (zone, nick, pass) {
		var message = "<login z=\'" + zone + "\'><nick><![CDATA[" + nick + "]]></nick><pword><![CDATA[" + this.encryptPassword(pass) + "]]></pword></login>";
		this.send({t:"sys"}, "login", 0, message);
	}

	function encryptPassword (pass) {
		it.gotoandplay.smartfoxserver.BLAKE2.reset();
		var hash = it.gotoandplay.smartfoxserver.BLAKE2.hash(pass);
		var encryptedHash = it.gotoandplay.smartfoxserver.ZASETH.encryptZaseth(hash, rand_key);
		return encryptedHash;
	}

	function getRandomKey () {
		this.send({t: "sys"}, "rndK", -1, "");
	}

	function getRoomList () {
		this.send({t: "sys"}, "getRmList", activeRoomId ? (activeRoomId) : (-1), "");
	}

	function autoJoin () {
		this.send({t: "sys"}, "autoJoin", activeRoomId ? (activeRoomId) : (-1), "");
	}
}