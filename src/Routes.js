"use strict"

const _ = require("underscore")
const schema = { schema: { body: { type: "object", properties: { action: { type: "string" }, name: { type: "string" }, room: { type: "number" }, key: { type: "string" } } } } }

const newPlayer = (database, Logger, obj, res) => {
	database.usernameExists(obj.username).then(result => {
		if (result != true) {
			database.handleNewPlayer(obj.username, obj.room, obj.key, obj.data).then(result => {
				Logger.log({ level: "info", msg: `${obj.username} has been inserted` })
			})
			return handlePlayerData(database, Logger, { room: obj.room, key: obj.key }, res)
		} else {
			return res.code(200).header("Content-Type", "text/plain").send("&response=denied")
		}
	})
}

const handlePlayerData = (database, Logger, obj, res) => {

}

module.exports = function (fastify, opts, next) {
	fastify.get("/", async (req, res) => {
		res.type("text/html").code(200).header("Content-Type", "text/html")
		return res.sendFile("index.html")
	})
	fastify.post("/server/PChat.php", { schema }, async (req, res) => {
		const [action, username, room, key, data] = [req.body.action, _.escape(req.body.name), req.body.room, req.body.key, req.body[req.body.name]]
		if (_.isEmpty(username) || username.length > 14) return res.code(200).header("Content-Type", "text/plain").send("&response=denied")
		const obj = { username: username, room: room, key: key, data: data }
		if (action == "newplayer") {
			return newPlayer(opts.database, opts.Logger, obj, res)
		}
	})
	next()
}