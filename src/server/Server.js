"use strict"

const Core       = require("./core/Core")
const Database   = require("./core/Database")
const Penguin    = require("./core/Penguin")
const Room       = require("./core/Room")
const Logger     = require("./Logger").Logger
const Constants  = require("./core/utils/Constants").CHECKER

class Server {
	constructor (port) {
		this.clients     = []
		this.port        = port
		this.maxPenguins = 100
		this.database    = new Database()
		this.room        = new Room()
		this.core        = new Core(this)
		this.createServer()
		process.on("SIGINT",  () => this.handleShutdown())
		process.on("SIGTERM", () => this.handleShutdown())
	}

	createServer () {
		require("net").createServer(socket => {
			socket.setEncoding("utf8")
			const client = new Penguin(socket, this)
			Logger.info(`${client.ipAddr} connected`)
			if (this.clients.length >= this.maxPenguins) return client.sendError("The game is full.")
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
				if (error.code == "ETIMEDOUT" || error.code == "ECONNRESET") return
				Logger.error(error)
			})
		}).listen(this.port, () => {
			Logger.info(`Server listening on port: ${this.port}`)
			Logger.info(`${Constants.SWEARS.length} swears loaded!`)
			Logger.info(`${this.room.countRooms()} rooms loaded!`)
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
		if (this.clients.length > 0) {
			Logger.info(`Server shutting down in 3 seconds...`)
			Logger.info(`Disconnecting ${this.clients.length} client(s)...`)
			setTimeout(() => {
				for (const client of this.clients) {
					client.sendError("The game is shutting down.")
					client.disconnect()
				}
				process.exit(0)
			}, 3000)
		} else {
			Logger.info(`Server shutting down in 1 second as there were no clients detected...`)
			process.exit(0)
		}
	}
}

module.exports = Server