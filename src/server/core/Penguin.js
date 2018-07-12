"use strict"
/*
* The player class.
*/
const Logger = require("../Logger").Logger

class Penguin {
	constructor (socket, server) {
		this.socket  = socket
		this.server  = server
		this.ipAddr  = socket.remoteAddress.split(":").pop()

		this.id         = 0
		this.username   = ""
		this.password   = ""
		this.moderator  = 0
		this.validation = ""
	}

	send (data) {
		if (!this.socket.writable) return
		if (this.socket) {
			Logger.outgoing(data)
			this.socket.write(data + `\0`)
		}
	}

	sendError (message, disconnect) {
		this.send(`<msg t="sys"><body action="makeErr" r="0"><error message="${message}"></error></body></msg>`)
		if (disconnect) this.disconnect()
	}

    sendAlert (message) {
    	this.send(`<msg t="sys"><body action="makeAlert" r="0"><alert message="${message}"></error></body></msg>`)
    }

	disconnect () {
		this.server.removePenguin(this)
	}

	buildPlayer (penguin) {
		this.id = penguin.id
		this.username = penguin.username
		this.password = penguin.password
		this.moderator = penguin.moderator
		this.server.database.addValidation(this)
	}

	isOnline (id) {return this.server.isOnline(id)}
	isModerator (id) {return this.server.isModerator(id)}
}

module.exports = Penguin