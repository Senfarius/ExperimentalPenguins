"use strict"

const database = new (require("./Database"))
const fastify  = require("fastify")({})
const Logger   = require("./Logger").Logger
const Utils    = require("./Utils")
const path     = require("path")

// Handle server exit
const shutDown = () => {
	Logger.info(`Server shutting down in 3 seconds...`)
	database.dropAll() // Drop every player in the database
	setTimeout(() => { process.exit(0) }, 3000)
}

// Middleware
fastify.register(require("fastify-static"), { // Serve files
	root: path.join(__dirname, "public"),
	prefix: "/"
})
fastify.register(require("fastify-formbody")) // POST usage
fastify.register(require("fastify-helmet")) // Security headers

// Routes
fastify.get("/", (req, res) => {
	res.type("text/html").code(200)
	res.sendFile("index.html")
})
fastify.post("/new.php", (req, res) => {
	const username = req.body.n
	if (Utils.validateString(username)) { // Extensive username check => swears & special characters
		Logger.warning(`${username} is blocked`)
		return res.status(200).send(`&e=2`)
	}
	database.getPlayerExistsByName(username).then(penguin => {
		if (penguin.length != 1) { // The username doesn't exist
			database.insertPlayer(username).then(penguin => {
				const id = penguin[0]
				database.getPlayerByName(username).then(penguin => {
					const poll = `&id=${id}&m=${penguin.mod}&e=0`
					Logger.polling(poll)
					return res.status(200).send(poll)
				})
			})
		} else {
			return res.status(200).send(`&e=2`)
		}
	})
})
fastify.post("/join.php", (req, res) => {
	const id = req.body.id
	const username = req.body.n
	const data = req.body.d
	const room = data.substr(0, 1)
	const join = data.substr(1, 99)
	const poll = `&p=${room}${join.substr(1, 4)}${username}&e=0`

	database.updateRoom(id, room)
	Logger.polling(poll)
	return res.status(200).send(poll)
})
fastify.post("/chat.php", (req, res) => {
	const id = req.body.id
	const data = req.body.d
	const room = data.substr(0, 1)
	const poll = `&c=${room}${data}`

	database.updateRoom(id, room)
	Logger.polling(poll)
	return res.status(200).send(poll)
})
fastify.post("/drop.php", (req, res) => {
	const id = req.body.id
	return database.drop(id)
})

// Run the server
fastify.listen(80).then(() => { // Use promise
	Logger.info(`Server listening on http://localhost:80/`)
	process.on("SIGINT",  () => shutDown())
	process.on("SIGTERM", () => shutDown())
}).catch((err) => {
	Logger.error(err)
	process.exit(1)
})