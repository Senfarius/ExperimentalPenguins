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
	static validateIP(ip) {
		if (Constants.IPS.includes(ip) || this.checkIPforBan(ip)) {
			return true
		}
		return false
	}
	static checkIPforBan(ip) {
		const singleips = Constants.IPMASKS
		let p1 = false
		for (let i = 0; i < singleips.length; i++) {
			if (ip.substr(0, singleips[i].length) == singleips[i]) {
				p1 = true
			}
		}
		const iprange = Constants.IPRANGE
		for (let i = 0; i < iprange.length; i++) {
			if (this.IPinRange(ip, iprange[i])) {
				p1 = true
			}
		}
		return p1
	}
	static IPinRange(ip, iprange) {
		let subnet = iprange.split("-")
		let secondIP = subnet[0].split(".")
		let firstIP = subnet[1].split(".")
		let mainIP = ip.split(".")
		if (mainIP[0] < secondIP[0]) {
			return false
		} else if (mainIP[0] > firstIP[0]) {
			return false
		} else if (mainIP[1] < secondIP[1]) {
			return false
		} else if (mainIP[1] > firstIP[1]) {
			return false
		} else if (mainIP[2] < secondIP[2]) {
			return false
		} else if (mainIP[2] > firstIP[2]) {
			return false
		} else if (mainIP[3] < secondIP[3]) {
			return false
		} else if (mainIP[3] > firstIP[3]) {
			return false
		}
		return true
	}
}

module.exports = Utils