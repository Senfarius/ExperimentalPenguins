"use strict"

const database = new (require("./Database"))
const fastify = require("fastify")()
const Logger = require("./Logger").Logger
const path = require("path")

const newOpts  = { schema: { body: { type: "object", properties: { n : { type: "string" }}}}}
const joinOpts = { schema: { body: { type: "object", properties: { n : { type: "string" }, id: { type: "number" }, d: { type: "string" }}}}}
const chatOpts = { schema: { body: { type: "object", properties: { id : { type: "number" }, d: { type: "string" }}}}}
const dropOpts = { schema: { body: { type: "object", properties: { id : { type: "number" }}}}}

fastify.register(require("fastify-static"), {
	root: path.join(__dirname, "public"),
	prefix: "/"
})
fastify.register(require("fastify-formbody"))
fastify.register(require("fastify-helmet"))

fastify.get("/", async (req, res) => {
	res.type("text/html").code(200)
	return res.sendFile("index.html")
})

fastify.post("/new.php", newOpts, async (req, res) => {
	const username = req.body.n
	database.getPlayerExistsByName(username).then(penguin => {
		if (penguin.length != 1 && username.length <= 12) {
			database.insertPlayer(username).then(penguin => {
				const id = penguin[0]
				database.getPlayerByName(username).then(penguin => {
					const poll = `&id=${id}&m=${penguin.mod}&e=0`
					Logger.polling(poll)
					return res.code(200).type("text/html").send(poll)
				})
			})
		} else {
			return res.code(200).type("text/html").send(`&e=2`)
		}
	})
})

fastify.post("/join.php", joinOpts, async (req, res) => {
	const id = req.body.id
	const username = req.body.n
	const data = req.body.d
	const room = data.substr(0, 1)
	const join = data.substr(1, 99)
	const poll = `&p=${room}${join.substr(1, 4)}${username}&e=0`

	database.updateRoom(id, room)
	Logger.polling(poll)
	return res.code(200).type("text/html").send(poll)
})

fastify.post("/chat.php", chatOpts, async (req, res) => {
	const id = req.body.id
	const data = req.body.d
	const room = data.substr(0, 1)
	const poll = `&c=${room}${data}`

	database.updateRoom(id, room)
	Logger.polling(poll)
	return res.code(200).type("text/html").send(poll)
})

fastify.post("/drop.php", dropOpts, async (req, res) => {
	const id = req.body.id
	return database.drop(id)
})

const shutDown = () => {
	Logger.info(`Server shutting down in 3 seconds...`)
	database.dropAll()
	setTimeout(() => { process.exit(0) }, 3000)
}

const start = async () => {
	try {
		await fastify.listen(80)
		Logger.info(`Server listening on http://localhost:80/`)
		process.on("SIGINT",  () => shutDown())
		process.on("SIGTERM", () => shutDown())
	} catch (err) {
		Logger.error(err)
		process.exit(1)
	}
}

start()