"use strict"

const database = new (require("./Database"))
const Logger = require("./Logger").Logger
const _ = require("lodash")

module.exports = function (fastify, opts, next) {
	fastify.get("/", (req, res) => {
		res.type("text/html").code(200).header("Content-Type", "text/html")
		return res.sendFile("index.html")
	})
	fastify.post("/register.php", (req, res) => {
		const [username, password, email] = [req.body.n, req.body.p, req.body.email]

		Logger.log({ level: "incoming", msg: req.body, extra: { url: "/register.php" } })

		if (_.isEmpty(username)) return res.status(200).send(`&e=2&em=Username is required`)
		if (_.isEmpty(password)) return res.status(200).send(`&e=26&em=Password is required`)
		if (_.isEmpty(email)) return res.status(200).send(`&e=27&em=Email is required`)

		database.usernameExists(username).then((penguin) => { if (penguin["count(*)"] > 0) return res.status(200).send(`&e=28&em=Username is already taken`) })
		database.emailExists(email).then((penguin) => { if (penguin["count(*)"] > 0) return res.status(200).send(`&e=29&em=Email is already taken`) })
		database.registerPlayer(username, password, email).then((penguin) => { if (penguin[0] > 1) return res.status(200).send(`&e=0`) })
	})
	fastify.post("/login.php", (req, res) => {
		const [username, password] = [req.body.n, req.body.p]

		Logger.log({ level: "incoming", msg: req.body, extra: { url: "/login.php" } })

		if (_.isEmpty(username)) return res.status(200).send(`&e=2&em=Username is required`)
		if (_.isEmpty(password)) return res.status(200).send(`&e=26&em=Password is required`)
	})
	next()
}