"use strict"

const schema = require("./Schemas")
const _ = require("validator")
const charList = ["<", ">", ";", "'", `"`, "(", ")"]

module.exports = function (fastify, opts, next) {
	fastify.get("/", (req, res) => {
		res.type("text/html").code(200).header("Content-Type", "text/html")
		return res.sendFile("index.html")
	})
	fastify.post("/register.php", schema.REGISTER_SCHEMA, (req, res) => {
		const [username, password, email] = [req.body.n, req.body.p, req.body.email]

		// Empty || Username & password longer than 12 characters || Email longer than 50 characters || Contains special characters || Is email really an email
		if (_.isEmpty(username) || username.length > 12 || _.isIn(username, charList)) return res.status(200).send(`&e=2&em=Username is invalid`)
		if (_.isEmpty(password) || password.length > 12 || _.isIn(password, charList)) return res.status(200).send(`&e=26&em=Password is invalid`)
		if (_.isEmpty(email) || !_.isEmail(email) || email.length > 50 || _.isIn(email, charList)) return res.status(200).send(`&e=27&em=Email is invalid`)

		// Username exists || Email exists
		opts.database.usernameExists(username).then((count) => { if (count["count(*)"] > 0) return res.status(200).send(`&e=28&em=Username is already taken`) })
		opts.database.emailExists(email).then((count) => { if (count["count(*)"] > 0) return res.status(200).send(`&e=29&em=Email is already taken`) })

		// Register the player
		opts.database.registerPlayer(username, password, email).then((penguin) => { if (penguin[0] > 1) return res.status(200).send(`&e=0`) })
	})
	fastify.post("/login.php", schema.LOGIN_SCHEMA, (req, res) => {
		const [username, password] = [req.body.n, req.body.p]

		// Empty || Username & password longer than 12 characters || Contains special characters
		if (_.isEmpty(username) || username.length > 12 || _.isIn(username, charList)) return res.status(200).send(`&e=2&em=Username is invalid`)
		if (_.isEmpty(password) || password.length > 12 || _.isIn(password, charList)) return res.status(200).send(`&e=26&em=Password is invalid`)

		// Full server || Username exists || Is player banned
		opts.database.getPlayersOnline().then((count) => { if (count[0].online >= opts.database.maxPenguins) return res.status(200).send(`&e=12&em=Server is full`) })
		opts.database.usernameExists(username).then((count) => { if (count["count(*)"] == 0) return res.status(200).send(`&e=14&em=Username does not exist`) })
		opts.database.isPlayerBanned(username).then((penguin) => { if (penguin[0].banned == 1) return res.status(200).send(`&e=16&em=Server unavailable`) })

		// Get the player's data
		opts.database.getPlayerByName(username).then((penguin) => {
			const hash = opts.database.hashPassword(password)
			if (hash == penguin.password) {
				opts.Logger.log({ level: "info", msg: `${username} logged in` })
				return res.status(200).send(`&id=${penguin.id}&m=${penguin.moderator}&e=0&k=${require("crypto").randomBytes(2)}`)
			} else {
				opts.Logger.log({ level: "info", msg: `${username} failed to login` })
				return res.status(200).send(`&e=15&em=Incorrect password or password`)
			}
		})
	})
	next()
}