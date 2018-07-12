"use strict"
/*
* Used to validate time.
* Time is without minutes <- too many requests.
*/
const Logger   = require("../../Logger").Logger
const momentjs = require("moment")
const moment   = momentjs.utc()

class Validation {
	static MmValidate () {
		const Mm = `%${((moment.hours() + 1 ^ 954) * 65)}%${((moment.date() ^ 395) * 36)}%${(((moment.month() + 1) ^ 249) * 19)}%${((moment.year() ^ 509) * 53)}%`
		Logger.validation(`[CREATED] - ${Mm}`)
		return Mm
	}

	static MmParse (validation) {
		let validateObject = validation.split("%")

		const hour  = ((validateObject[1]) / 65) ^ 954
		const day   = ((validateObject[2]) / 36) ^ 395
		const month = ((validateObject[3]) / 19) ^ 249
		const year  = ((validateObject[4]) / 53) ^ 509

		const serverDate = momentjs(`${year} - ${month} - ${day}  ${hour}`, "YYYY-MM-DD HH")
		Logger.validation(`[PARSED] - ${serverDate}`)

		const date = serverDate.format("dddd, MMMM Do YYYY, h:mm:ss a")
		Logger.validation(`[FORMATTED] - ${date}`)

		return date
	}
}

module.exports = Validation