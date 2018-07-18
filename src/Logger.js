"use strict"

var Logger = exports.Logger = {}

Logger.log = function (obj) {
	const toLog = JSON.stringify({ level: obj.level, time: Date.now(), msg: obj.msg, extra: obj.extra || {} })
	const stream = require("fs").createWriteStream(`${__dirname}\\logs\\${obj.level}.log`, { flags: "a" })
	stream.write(`${toLog}\r\n`)
	return console.log(toLog)
}