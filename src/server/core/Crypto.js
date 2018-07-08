"use strict"

const crypto = require("crypto")
const blake2 = require("blake2")

class Crypto {
	static generateKey () {
		/*
		* A little note here!
		* We don't use Math.random() as it's not 'truly' random...
		* We use the randomBytes method as it's 'random enough', faster and easier
		* XML doesn't like special characters, this method only gives us a-z|0-9
		*/
		return crypto.randomBytes(12).toString("hex")
	}
	static swapHash (hash) {
		return hash.substr(32, 32) + hash.substr(0, 32) // Blake2 hash length is 64 => 64 / 2 = 32
	}
	static blake2s (password) {
		const hash = blake2.createHash("blake2s")
		hash.update(Buffer.from(password))
		return hash.digest("hex")
	}
	static encryptPassword (password, key) {
		let encryptedPass = this.swapHash(password) + key
		encryptedPass += 'Y(02.>\'H}t":E1'
		encryptedPass = this.blake2s(encryptedPass)
		return this.swapHash(encryptedPass)
	}
}

module.exports = Crypto