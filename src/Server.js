"use strict"

const database = new (require("./Database"))
const Logger = require("./Logger").Logger
const fastify = require("fastify")()

fastify
	.register(require("fastify-static"), { root: require("path").join(__dirname, "public"), prefix: "/" })
	.register(require("fastify-formbody"))
	.register(require("fastify-helmet"))
	.register(require("fastify-no-cache"))
	.register(require("./Routes"), { database: database, Logger: Logger })
	.listen(80, (err, address) => {
		Logger.log({ level: "info", msg: `Server listening on ${address}` })
		if (err) {
			Logger.log({ level: "error", msg: err })
			process.exit(1)
		}
	})