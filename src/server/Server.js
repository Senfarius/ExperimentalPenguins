"use strict"

const Core       = require("./core/Core")
const Database   = require("./core/Database")
const Penguin    = require("./core/Penguin")
const Logger     = require("./Logger").Logger
const Constants  = require("./core/Constants").CHECKER

class Server {
	constructor (port) {
		this.clients     = []
		this.port        = port
		this.maxPenguins = 50
		this.database    = new Database()
		this.core        = new Core(this)
		this.createServer() // This at last so this.core doesn't take this with it
		process.on("SIGINT",  () => this.handleShutdown())
		process.on("SIGTERM", () => this.handleShutdown())
	}

	createServer () {
		require("net").createServer(socket => {
			socket.setEncoding("utf8")
			const client = new Penguin(socket, this)
			Logger.info(`${client.ipAddr} connected`)
			if (this.clients.length >= this.maxPenguins) client.disconnect() // Do this before adding the client, obviously
			this.clients.push(client)
			socket.on("data", data => {
				data = data.toString().split(`\0`)[0]
				this.core.handleData(data, client)
			})
			socket.on("close", () => {
				client.disconnect()
				Logger.info(`${client.ipAddr} disconnected`)
			})
			socket.on("error", error => {
				client.disconnect()
				if (error.code == "ETIMEDOUT" || error.code == "ECONNRESET") return // Stupid errors that we don't log
				Logger.error(error)
			})
		}).listen(this.port, () => {
			if (this.port != 9339) Logger.info(`Server listening on custom port: ${this.port}`)
			else Logger.info(`Server listening on default port: ${this.port}`)
			this.calculateConstants()
		})
	}

	removePenguin (client) {
		let index = this.clients.indexOf(client)
		if (index > -1) {
			Logger.info("Removing penguin...")
			this.clients.splice(index, 1)
			client.socket.end()
			client.socket.destroy()
		}
	}

	handleShutdown () {
		if (this.clients.length > 0) { // First check if there's even clients connected, smart move...
			Logger.info(`Server shutting down in 3 seconds...`)
			Logger.info(`Disconnecting ${this.clients.length} client(s)...`)
			setTimeout(() => {
				for (const client of this.clients) client.disconnect()
				process.exit(0)
			}, 3000)
		} else { // Don't loop through an empty array and just exit the process immediately
			Logger.info(`Server shutting down in 1 second as there were no clients detected...`)
			process.exit(0)
		}
	}

	calculateConstants () {
		Logger.info(`${Constants.SWEARS.length} swears loaded!`)
	}
}

module.exports = Server