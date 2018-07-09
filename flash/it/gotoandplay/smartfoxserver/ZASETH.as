class it.gotoandplay.smartfoxserver.ZASETH {
	function ZASETH () {}
	static function encryptZaseth (param1, param2) {
		var keyIndex = 0x00, res = "";
		for (var i = 0x00; i < param1.length; i++) {
			var charCode = param1.charCodeAt(i);
			charCode ^= param2.charCodeAt(keyIndex);
			var firstChar = charCode & 0x0F, secondChar = charCode >> 0x04;
			res += String.fromCharCode(firstChar + 0x40), res += String.fromCharCode(secondChar + 0x40);
			keyIndex++;
			if (keyIndex >= param2.length) keyIndex = 0x00;
		}
		return res;
	}
}