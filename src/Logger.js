"use strict"

const fs    = require("fs")
const chalk = require("chalk")
const path  = __dirname + "\\logs\\"
var Logger  = exports.Logger = {}

Logger.dateToInt = function () {
    const date = new Date()
    return date.getFullYear() * 10000 + (date.getMonth() + 1) * 100 + date.getDate() + "||" + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds()
}
Logger.clear = function () {
    fs.truncate(`${path}info.log`, 0, (err) => { if (err) throw err })
    fs.truncate(`${path}debug.log`, 0, (err) => { if (err) throw err })
}
Logger.polling = function (message) {
    if (message.length == 0 || message.length == 1) return
    console.log(chalk.hex("#F1E").bgWhite(`[POLLING] - ${message}\r`))
    fs.appendFile(`${path}polling.log`, this.dateToInt() + ": [POLLING] - " + message + "\r\n", (err) => { if (err) throw err })
}
Logger.error = function (message) {
    console.log(chalk.red.bgBlack.bold(`[ERROR] - ${message}\r`))
    fs.appendFile(`${path}error.log`, this.dateToInt() + ": " + message + "\r\n", (err) => { if (err) throw err })
}
Logger.warning = function (message) {
    console.log(chalk.yellow.bgBlack.bold(`[WARNING] - ${message}\r`))
    fs.appendFile(`${path}warning.log`, this.dateToInt() + ": " + message + "\r\n", (err) => { if (err) throw err })
}
Logger.info = function (message) {
    console.log(chalk.green.bgBlack.bold(`[INFO] - ${message}\r`))
    fs.appendFile(`${path}info.log`, this.dateToInt() + ": " + message + "\r\n", (err) => { if (err) throw err })
}
Logger.debug = function (message) {
    console.log(chalk.cyan(`[DEBUG] - ${message}\r`))
    fs.appendFile(`${path}debug.log`, this.dateToInt() + ": " + message + "\r\n", (err) => { if (err) throw err })
}