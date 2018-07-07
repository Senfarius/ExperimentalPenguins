"use strict"

const Logger = require("../Logger").Logger

class Penguin {
	constructor (socket, server) {
		this.socket  = socket
		this.server  = server
		this.ipAddr  = socket.remoteAddress.split(":").pop()
	}

	send (data) {
		if (!this.socket.writable) return
		if (this.socket) {
			Logger.outgoing(data)
			this.socket.write(data + `\0`)
		}
	}

	disconnect () {
		this.server.removePenguin(this)
	}
}

module.exports = Penguin