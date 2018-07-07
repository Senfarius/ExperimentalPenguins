"use strict"

const Server = require("./server/Server")
const Logger = require("./server/Logger").Logger
const figlet = require("figlet") // ASCII art, because why not?

figlet("PenguinChatJS", (error, data) => {
	if (error) return Logger.error(error)
	console.log(data) // Obviously don't log this for reasons...
})

new Server(process.argv[2] || 9339)