"use strict"

const fs = require("fs-then")

class FileHandler {
	static dateToInt() {
		const date = new Date()
		return date.getFullYear() * 10000 + (date.getMonth() + 1) * 100 + date.getDate()
	}
	static writeLine(data) {
		const fileName = `${__dirname + "\\data\\"}Room${this.dateToInt()}.txt`
		return new Promise((resolve, reject) => {
			fs.appendFile(fileName, data, (err, result) => {
				if (err) {
					reject(err)
				} else {
					resolve(result)
				}
			})
		})
	}
	static getLine() {
		const fileName = `${__dirname + "\\data\\"}Room${this.dateToInt()}.txt`
		return fs.readFileSync(`${fileName}`).toString().split("\n").length - 1
	}
}

module.exports = FileHandler