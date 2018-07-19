"use strict"

class Crypto {
	static generateRandomKey () {
		return (require("crypto").randomBytes(2).toString("hex"))
	}
	static hashPassword(pass) {
		const hash = require("blake2").createHash("blake2b", { digestLength: 64 })
		hash.update(Buffer.from(pass))
		return hash.digest("hex")
	}
	static encryptZaseth (param1, param2) {
		let keyIndex = 0x00, res = ""
		for (let i = 0x00; i < param1.length; i++) {
			let charCode = param1.charCodeAt(i)
			charCode ^= param2.charCodeAt(keyIndex)
			let firstChar = charCode & 0x0F, secondChar = charCode >> 0x04
			res += String.fromCharCode(firstChar + 0x40), res += String.fromCharCode(secondChar + 0x40)
			keyIndex++
			if (keyIndex >= param2.length) keyIndex = 0x00
		}
		return res
	}
}

module.exports = Crypto