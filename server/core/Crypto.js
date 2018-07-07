"use strict"

const blake2 = require("blake2")

class Crypto {
	static encryptPassword (password) {
		const hash = blake2.createHash("blake2s")
		hash.update(Buffer.from(password))
		return hash.digest("hex")
	}
}

module.exports = Crypto