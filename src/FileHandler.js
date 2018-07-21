"use strict"

module.exports = {
	appendFileAsync: function (data) {
		const date = new Date()
		const YMD = date.getFullYear() * 10000 + (date.getMonth() + 1) * 100 + date.getDate()
		const filename = `${__dirname + "\\data\\"}Data${YMD}.txt`
		return require("bluebird").promisify(require("fs").appendFile)(filename, data + "\r\n")
	},
	readFileAsync: function () {
		const date = new Date()
		const YMD = date.getFullYear() * 10000 + (date.getMonth() + 1) * 100 + date.getDate()
		const filename = `${__dirname + "\\data\\"}Data${YMD}.txt`
		return require("bluebird").promisify(require("fs").readFile)(filename)
	}
}