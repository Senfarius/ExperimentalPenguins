"use strict"

const database = new (require("./Database"))
const fastify = require("fastify")()
const path = require("path")

const newOpts = { schema: { body: { type: "object", properties: { n: { type: "string" } } } } }
const joinOpts = { schema: { body: { type: "object", properties: { n: { type: "string" }, id: { type: "number" }, d: { type: "string" } } } } }
const chatOpts = { schema: { body: { type: "object", properties: { id: { type: "number" }, d: { type: "string" } } } } }
const dropOpts = { schema: { body: { type: "object", properties: { id: { type: "number" } } } } }

fastify.register(require("fastify-static"), { root: path.join(__dirname, "public"), prefix: "/" })
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
					Logger({ level: "outgoing", msg: "Outgoing data", extra: { data: poll, url: "/new.php" } })
					return res.code(200).type("text/html").send(poll)
				})
			})
		} else {
			return res.code(200).type("text/html").send(`&e=2`)
		}
	})
})

fastify.post("/join.php", joinOpts, async (req, res) => {
	const data = req.body.d
	const room = data.substr(0, 1)
	const chat = data.substr(1, 99)
	const id = req.body.id
	Logger({ level: "incoming", msg: "Incoming data", extra: { data: `${id}${data}`, url: "/join.php" } })
	database.updateData(id, chat)
	database.updateRoom(id, room)
	database.getData().then(penguin => {
		const poll = `&p=${penguin.room}${penguin.data.substr(1, 4)}${penguin.username}`
		Logger({ level: "outgoing", msg: "Outgoing data", extra: { data: poll, url: "/join.php" } })
		return res.code(200).type("text/html").send(poll + "\r\n")
	})
})

fastify.post("/chat.php", chatOpts, async (req, res) => {
	const data = req.body.d
	const chat = data.substr(0, 99)
	const id = req.body.id
	Logger({ level: "incoming", msg: "Incoming data", extra: { data: `${id}${data}`, url: "/chat.php" } })
	if (data.length > 2) {
		database.updateData(id, data)
		database.getData().then(penguin => {
			const poll = `&c=${penguin.room}${penguin.data}`
			Logger({ level: "outgoing", msg: "Outgoing data", extra: { data: poll, url: "/chat.php" } })
			return res.code(200).type("text/html").send(poll + "\r\n")
		})
	} else {
		database.getData().then(penguin => {
			const poll = `&c=${penguin.room}${penguin.data}`
			Logger({ level: "outgoing", msg: "Outgoing data", extra: { data: poll, url: "/chat.php" } })
			return res.code(200).type("text/html").send(poll + "\r\n")
		})
	}
})

fastify.post("/drop.php", dropOpts, async (req, res) => {
	const id = req.body.id
	database.drop(id).then(() => {
		Logger({ level: "info", msg: `Dropped ${id}` })
	}).catch((err) => {
		Logger({ level: "error", msg: err })
	})
})

const Logger = (obj) => {
	const toLog = JSON.stringify({ level: obj.level, time: Date.now(), msg: obj.msg, extra: obj.extra || {} })
	const stream = require("fs").createWriteStream(`${__dirname}\\logs\\${obj.level}.log`, { flags: "a" })
	stream.write(`${toLog}\r\n`)
	return console.log(toLog)
}

const shutDown = () => {
	Logger({ level: "info", msg: "Server shutting down in 3 seconds..." })
	database.dropAll().then(() => {
		Logger({ level: "info", msg: `Cleaned the database` })
	}).catch((err) => {
		Logger({ level: "error", msg: err })
	})
	setTimeout(() => { process.exit(0) }, 3000)
}

const start = async () => {
	try {
		await fastify.listen(80)
		Logger({ level: "info", msg: "Server listening on http://localhost:80/" })
		process.on("SIGINT", () => shutDown())
		process.on("SIGTERM", () => shutDown())
	} catch (err) {
		Logger({ level: "error", msg: err })
		process.exit(1)
	}
}

start()