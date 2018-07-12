"use strict"
/*
* Used to validate time.
* Time is without minutes <- too many requests.
*/
const Logger   = require("../../Logger").Logger
const momentjs = require("moment")
const moment   = momentjs.utc()

class Validation {
	static MmValidate (client) {
		const Mm = `[ ${((moment.hours() + 1 ^ 954) * 65)} , ${((moment.date() ^ 395) * 36)} , ${(((moment.month() + 1) ^ 249) * 19)} , ${((moment.year() ^ 509) * 53)} , "${client.ipAddr}" ]`
		Logger.validation(`[CREATED] - ${Mm}`)
		return Mm
	}

	static MmParse (validation) {
		let validateObject = JSON.parse(validation)

		const hour  = ((validateObject[0]) / 65) ^ 954
		const day   = ((validateObject[1]) / 36) ^ 395
		const month = ((validateObject[2]) / 19) ^ 249
		const year  = ((validateObject[3]) / 53) ^ 509

		const serverDate = momentjs(`${year} - ${month} - ${day}  ${hour}`, "YYYY-MM-DD HH")
		Logger.validation(`[PARSED] - ${serverDate}`)

		const date = serverDate.format("dddd, MMMM Do YYYY, h:mm:ss a")
		Logger.validation(`[FORMATTED] - ${date}`)

		return date
	}
}

module.exports = Validation