"use strict"

const Logger = require("./Logger").Logger
const database = new (require("./Database"))(Logger) // Allows us to share the Logger
const fastify = require("fastify")()

const shutDown = () => {
	Logger.log({ level: "info", msg: "Server shutting down in 3 seconds..." })
	/* Reset some stuff before shutting down the process */
	database.resetPlayersOnline()
	database.resetRooms()
	/* In order for everything to go OK, use a timeout */
	setTimeout(() => { process.exit(0) }, 3000)
}

fastify
	.register(require("fastify-static"), { root: require("path").join(__dirname, "public"), prefix: "/" })
	.register(require("fastify-formbody")) // Allows us to grab POST stuff
	.register(require("fastify-helmet")) // Allows us to play with important headers
	.register(require("fastify-no-cache")) // Allows us to use no-cache, good for SWFS
	.register(require("./Routes"), { database: database, Logger: Logger }) // Register our routes
	.listen(80, (err, address) => {
		Logger.log({ level: "info", msg: `Server listening on ${address}` })
		/* If the process is being shutdown */
		process.on("SIGINT", () => shutDown())
		process.on("SIGTERM", () => shutDown())
		if (err) {
			Logger.log({ level: "error", msg: err })
			process.exit(1)
		}
	})