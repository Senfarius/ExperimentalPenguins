"use strict"

const crypto = require("crypto")
const blake2 = require("blake2")

class Crypto {
	static generateKey () {
		return crypto.randomBytes(6).toString("hex")
	}
	static blake2s (password) {
		const hash = blake2.createHash("blake2s")
		hash.update(Buffer.from(password))
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
	static decryptZaseth (param1, param2) {
		let keyIndex = 0x00, res = ""
		for (let i = 0x00; i < param1.length; i++) {
			let charCode = param1.charCodeAt(i), firstChar = param1.charCodeAt(i + 0x01), secondChar = param2.charCodeAt(keyIndex)
			charCode &= 0x1F, firstChar &= 0x1F, firstChar *= 0x10
			res += String.fromCharCode((firstChar | charCode) ^ secondChar)
			keyIndex++
			if (keyIndex >= param2.length) keyIndex = 0x00
			i++
		}
		return res
	}
}

module.exports = Crypto