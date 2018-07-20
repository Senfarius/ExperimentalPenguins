"use strict"

const fs = require("fs")

class FileHandler {
	static dateToInt() { // Parser the date into YMD
		const date = new Date()
		return date.getFullYear() * 10000 + (date.getMonth() + 1) * 100 + date.getDate()
	}
	static writeLine(data) {
		const fileName = `${__dirname + "\\data\\"}Room${this.dateToInt()}.txt`
		return fs.appendFileSync(fileName, data, (err, result) => { if (err) throw err })
	}
	static getLine() {
		const fileName = `${__dirname + "\\data\\"}Room${this.dateToInt()}.txt`
		return fs.readFileSync(`${fileName}`).toString().split("\n").length - 1 // -1 because of \r\n
	}
}

module.exports = FileHandler