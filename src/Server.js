"use strict"

const fastify = require("fastify")()
const Logger = require("./Logger").Logger

const shutDown = () => {
	Logger.log({ level: "info", msg: "Server shutting down" })
	process.exit(0)
}

fastify
	.register(require("fastify-static"), { root: require("path").join(__dirname, "public"), prefix: "/" })
	.register(require("fastify-formbody"))
	.register(require("fastify-helmet"))
	.register(require("fastify-no-cache"))
	.register(require("./Routes"))
	.listen(80, (err, address) => {
		Logger.log({ level: "info", msg: `Server listening on ${address}` })
		process.on("SIGINT", () => shutDown())
		process.on("SIGTERM", () => shutDown())
		if (err) {
			Logger.log({ level: "error", msg: err })
			process.exit(1)
		}
	})