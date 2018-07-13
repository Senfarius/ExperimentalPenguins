"use strict"

const Constants = require("./Constants").CHECKS
const Logger    = require("./Logger").Logger

class Utils {
	static verifyName (username) {
		if (Constants.SWEARS.includes(username) || Constants.SPECIAL.includes(username) || username == null || username == "" || username.length < 1 || username.length > 20) {
			return true
		}
		return false
	}
}

module.exports = Utils