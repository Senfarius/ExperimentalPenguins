"use strict"

/*
* My RND seed generator => https://github.com/Zaseth/RND
*/
let rndSeed = 327680
class RND {
	static Random(val) {
		rndSeed = (rndSeed * 1140671485 + 1280163) % 16777216
		return Math.ceil((rndSeed / 16777216) * val)
	}
	static setSeed(seed) { rndSeed = Math.abs(seed) }
	static getSeed() { return rndSeed }
}

class Crypto {
	static generateRandomKey() {
		return (require("crypto").randomBytes(2).toString("hex")) // Truly random and fast
	}
	static hashPassword(pass) {
		const hash = require("blake2").createHash("blake2b", { digestLength: 64 }) // 64 for blake2b-512
		hash.update(Buffer.from(pass))
		return hash.digest("hex")
	}
	/*
	* This is the old version of my custom encryption/decryption.
	* This is two-way (encryption & decryption)
	*/
	static encryptZaseth(str, key) {
		let keyIndex = 0x00, res = ""
		for (let i = 0x00; i < str.length; i++) {
			let charCode = str.charCodeAt(i)
			charCode ^= key.charCodeAt(keyIndex)
			let firstChar = charCode & 0x0F, secondChar = charCode >> 0x04
			res += String.fromCharCode(firstChar + 0x40), res += String.fromCharCode(secondChar + 0x40)
			keyIndex++
			if (keyIndex >= key.length) keyIndex = 0x00
		}
		return res
	}
	static decryptZaseth(str, key) {
		let keyIndex = 0x00, res = ""
		for (let i = 0x00; i < str.length; i++) {
			let charCode = str.charCodeAt(i), firstChar = str.charCodeAt(i + 0x01), secondChar = key.charCodeAt(keyIndex)
			charCode &= 0x1F, firstChar &= 0x1F, firstChar *= 0x10
			res += String.fromCharCode((firstChar | charCode) ^ secondChar)
			keyIndex++
			if (keyIndex >= key.length) keyIndex = 0x00
			i++
		}
		return res
	}
	/*
	* This is the latest version of my custom encryption.
	* For now, it's one-way encryption.
	* Is it possible to decrypt? Probably, but that's OK.
	*/
	static encryptZasethv2(str, key) {
		let keyIndex = 0x00, keyResult = "", res = ""
		for (let i = 0; i < str.length; i++) {
			let charCode = key.charCodeAt(keyIndex)
			RND.setSeed(charCode * 1000)
			keyResult += String.fromCharCode(charCode ^ RND.Random(127))
			keyIndex++
			if (keyIndex >= key.length) keyIndex = 0x00
		}
		for (let i = 0; i < str.length; i++) {
			let firstChar = str.charCodeAt(i), charCode = keyResult.charCodeAt(i)
			let secondChar = firstChar ^ charCode, thirdChar = (firstChar ^ charCode) & 15, fourthChar = secondChar & 240
			fourthChar = parseInt((secondChar & 240) / 16)
			thirdChar |= 64, fourthChar |= 64
			res += String.fromCharCode(thirdChar), res += String.fromCharCode(fourthChar)
		}
		return res
	}
}

module.exports = Crypto