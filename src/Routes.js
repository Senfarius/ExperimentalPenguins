"use strict"

const Crypto = require("./Crypto")
const FileHandler = require("./FileHandler")
const schema = require("./Schemas")

module.exports = function (fastify, opts, next) {
	fastify.get("/", (req, res) => {
		res.type("text/html").code(200).header("Content-Type", "text/html")
		return res.sendFile("index.html")
	})
	fastify.post("/register.php", schema.REGISTER_SCHEMA, (req, res) => {
		const [username, password, email] = [req.body.n, req.body.p, req.body.email]
		/* Simple checks */
		if (username.length == 0 || username.length > 12) return res.status(200).header("Content-Type", "text/plain").send(`&e=2&em=Username is invalid`)
		if (password.length == 0 || password.length > 12) return res.status(200).header("Content-Type", "text/plain").send(`&e=26&em=Password is invalid`)
		if (email.length == 0 || email.length > 50) return res.status(200).header("Content-Type", "text/plain").send(`&e=27&em=Email is invalid`)
		/* Start the SQL progress. */
		opts.database.usernameExists(username).then((count) => {
			if (count["count(*)"] == 0) { // Username doesn't exist
				opts.database.emailExists(email).then((count) => {
					if (count["count(*)"] == 0) { // Email doesn't exist
						opts.database.registerPlayer(username, Crypto.hashPassword(password), email).then((penguin) => {
							if (penguin[0] > 1) { // The ID is greater than 1
								opts.Logger.log({ level: "info", msg: `${username} -| ${email} registered` })
								return res.status(200).header("Content-Type", "text/plain").send(`&e=0`)
							}
						})
					} else { // The email exists
						opts.Logger.log({ level: "info", msg: `${username} -| ${email} tried to register with an existing email` })
						return res.status(200).header("Content-Type", "text/plain").send(`&e=29&em=Email is already taken`)
					}
				})
			} else { // The username exists
				opts.Logger.log({ level: "info", msg: `${username} tried to register with an existing username` })
				return res.status(200).header("Content-Type", "text/plain").send(`&e=28&em=Username is already taken`)
			}
		})
	})
	fastify.post("/login.php", schema.LOGIN_SCHEMA, (req, res) => {
		const [username, password] = [req.body.n, req.body.p]
		/* Simple checks */
		if (username.length == 0 || username.length > 12) return res.status(200).header("Content-Type", "text/plain").send(`&e=2&em=Username is invalid`)
		if (password.length == 0 || password.length > 12) return res.status(200).header("Content-Type", "text/plain").send(`&e=26&em=Password is invalid`)
		/* Start the SQL progress */
		opts.database.getPlayersOnline().then((count) => {
			if (count[0].online < opts.database.maxPenguins) { // The server is full
				opts.database.usernameExists(username).then((count) => {
					if (count["count(*)"] != 0) { // The username exists
						opts.database.getPlayerByName(username).then((penguin) => {
							if (penguin.banned == 1) { // The player is banned
								opts.Logger.log({ level: "info", msg: `${username} tried to login but is banned` })
								return res.status(200).header("Content-Type", "text/plain").send(`&e=16&em=Server unavailable`)
							}
							const rndK = Crypto.generateRandomKey() // Generates a random 4-length key
							const hash = Crypto.encryptZasethv2(Crypto.hashPassword(password), rndK) // Every password will be different
							if (hash == Crypto.encryptZasethv2(penguin.password, rndK)) { // The password is the same
								opts.database.updatePlayersOnline() // A player has logged in, +1
								return res.status(200).header("Content-Type", "text/plain").send(`&id=${penguin.id}&m=${penguin.moderator}&e=0&k=${rndK}`)
							} else { // The password is not the same
								opts.Logger.log({ level: "info", msg: `${username} failed to login` })
								return res.status(200).header("Content-Type", "text/plain").send(`&e=15&em=Incorrect password or password`)
							}
						})
					} else { // The username doesn't exist
						opts.Logger.log({ level: "info", msg: `${username} tried to login but doesn't exist` })
						return res.status(200).header("Content-Type", "text/plain").send(`&e=14&em=Username does not exist`)
					}
				})
			} else { // The server is full
				opts.Logger.log({ level: "info", msg: `${username} tried to login but the server is full` })
				return res.status(200).header("Content-Type", "text/plain").send(`&e=12&em=Server is full`)
			}
		})
	})
	fastify.post("/join.php", schema.JOIN_SCHEMA, (req, res) => {
		const [id, attributes, room] = [req.body.id, req.body.s, req.body.r] // Key is also posted, but we don't store it as it'll leak private stuff
		let [line, count, data, username] = [0, 1, "", ""] // Count is 1, because the bot is 0
		/* Start the SQL progress */
		opts.database.getPlayerById(id).then((penguin) => {
			username = penguin.username
			FileHandler.writeLine(`${id}|${attributes}|${username}\r\n`) // Write the player's details into a file
			line = FileHandler.getLine() // Get the last line number of the file's pointer
			data += `&e=0&l=${line}&p=0|1|1|J|K|Zippy\r\n` // Add the bot player string
			opts.database.updateRoomById(id, room).then((penguin) => {
				if (penguin == 1) { // Executed
					opts.database.updateAttributesById(id, attributes).then((penguin) => {
						if (penguin == 1) { // Executed
							opts.database.getPlayersInRoom(username, room).then((penguin) => {
								for (const id of Object.keys(penguin)) { // Loop through every player in the room EXCEPT the player written in the file
									data += `${count++}|${penguin[id].attributes}|${penguin[id].username}\r\n`
								}
								return res.status(200).header("Content-Type", "text/plain").send(data)
							})
						}
					})
				}
			})
		})
	})
	fastify.post("/chat.php", schema.CHAT_SCHEMA, (req, res) => {
		const [line, id, key, room, attributes, dialogue] = [req.body.l, req.body.id, req.body.k, req.body.r, req.body.s, req.body.d]
	})
	next()
}