"use strict"

const Crypto = require("./Crypto")
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

		if (_.isEmpty(username) || username.length > 12 || _.isIn(username, charList)) return res.status(200).header("Content-Type", "text/plain").send(`&e=2&em=Username is invalid`)
		if (_.isEmpty(password) || password.length > 12 || _.isIn(password, charList)) return res.status(200).header("Content-Type", "text/plain").send(`&e=26&em=Password is invalid`)
		if (_.isEmpty(email) || !_.isEmail(email) || email.length > 50 || _.isIn(email, charList)) return res.status(200).header("Content-Type", "text/plain").send(`&e=27&em=Email is invalid`)

        opts.database.usernameExists(username).then((count) => {
        	if (count["count(*)"] == 0) {
        		opts.database.emailExists(email).then((count) => {
        			if (count["count(*)"] == 0) {
        				opts.database.registerPlayer(username, Crypto.hashPassword(password), email).then((penguin) => {
        					if (penguin[0] > 1) {
        						opts.Logger.log({ level: "info", msg: `${username} -| ${email} registered` })
        						return res.status(200).header("Content-Type", "text/plain").send(`&e=0`)
        					}
        				})
        			} else {
        				opts.Logger.log({ level: "info", msg: `${username} -| ${email} tried to register with an existing email` })
        				return res.status(200).header("Content-Type", "text/plain").send(`&e=29&em=Email is already taken`)
        			}
        		})
        	} else {
        		opts.Logger.log({ level: "info", msg: `${username} tried to register with an existing username` })
        		return res.status(200).header("Content-Type", "text/plain").send(`&e=28&em=Username is already taken`)
        	}
        })
	})
	fastify.post("/login.php", schema.LOGIN_SCHEMA, (req, res) => {
		const [username, password] = [req.body.n, req.body.p]

		if (_.isEmpty(username) || username.length > 12 || _.isIn(username, charList)) return res.status(200).header("Content-Type", "text/plain").send(`&e=2&em=Username is invalid`)
		if (_.isEmpty(password) || password.length > 12 || _.isIn(password, charList)) return res.status(200).header("Content-Type", "text/plain").send(`&e=26&em=Password is invalid`)

	    opts.database.getPlayersOnline().then((count) => {
	    	if (count[0].online < opts.database.maxPenguins) {
	    		opts.database.usernameExists(username).then((count) => {
	    			if (count["count(*)"] != 0) {
	    				opts.database.getPlayerByName(username).then((penguin) => {
	    					if (penguin.banned == 1) {
	    						opts.Logger.log({ level: "info", msg: `${username} tried to login but is banned` })
	    						return res.status(200).header("Content-Type", "text/plain").send(`&e=16&em=Server unavailable`)
	    					}
	    					const rndK = Crypto.generateRandomKey()
	    					const hash = Crypto.encryptZaseth(Crypto.hashPassword(password), rndK)
	    					if (hash == Crypto.encryptZaseth(penguin.password, rndK)) {
	    						opts.Logger.log({ level: "info", msg: `${username} logged in` })
	    						return res.status(200).header("Content-Type", "text/plain").send(`&id=${penguin.id}&m=${penguin.moderator}&e=0&k=${rndK}`)
	    					} else {
	    						opts.Logger.log({ level: "info", msg: `${username} failed to login` })
	    						return res.status(200).header("Content-Type", "text/plain").send(`&e=15&em=Incorrect password or password`)
	    					}
	    				})
	    			} else {
	    				opts.Logger.log({ level: "info", msg: `${username} tried to login but doesn't exist` })
	    				return res.status(200).header("Content-Type", "text/plain").send(`&e=14&em=Username does not exist`)
	    			}
	    		})
	    	} else {
	    		opts.Logger.log({ level: "info", msg: `${username} tried to login but the server is full` })
	    		return res.status(200).header("Content-Type", "text/plain").send(`&e=12&em=Server is full`)
	    	}
	    })
	})
	fastify.post("/join.php", schema.JOIN_SCHEMA, (req, res) => {
		const [id, attributes, room, key] = [req.body.id, req.body.s, req.body.r, req.body.k]
	})
	next()
}