"use strict"

const Constants = require("./Constants").CHECKS
const Logger    = require("./Logger").Logger

class Utils {
	static validateString(str) {
		if (Constants.SWEARS.includes(str) || Constants.SPECIAL.includes(str) || str == null || str == "" || str.length < 1 || str.length > 12) {
			return true
		}
		return false
	}
}

module.exports = Utils