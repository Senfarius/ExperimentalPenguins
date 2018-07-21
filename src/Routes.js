"use strict"

const _ = require("underscore")
const schema = { schema: { body: { type: "object", properties: { action: { type: "string" }, name: { type: "string" }, room: { type: "number" }, key: { type: "string" } } } } }

const newPlayer = (database, Logger, obj, res) => {
	database.handleNewPlayer(obj).then(result => {
		Logger.log({ level: "info", msg: `${obj.username} has been inserted` })
		return handlePlayerData(database, Logger, { room: obj.room, key: obj.key }, res)
	}).catch((err) => {
		Logger.log({ level: "error", msg: err })
		return res.code(200).header("Content-Type", "text/plain").send("&response=denied")
	})
}
const updatePlayer = (database, Logger, obj, res) => {
	database.handleUpdatePlayer(obj).then(result => {
		Logger.log({ level: "info", msg: `${obj.username} has been updated` })
		return handlePlayerData(database, Logger, { room: obj.room, key: obj.key }, res)
	}).catch((err) => {
		Logger.log({ level: "error", msg: err })
		return res.code(200).header("Content-Type", "text/plain").send("&response=denied")
	})
}
const dropPlayer = (database, Logger, obj, res) => {
	database.handleDropPlayer(obj.username).then(result => {
		Logger.log({ level: "info", msg: `${obj.username} has been dropped` })
		return handlePlayerData(database, Logger, { room: obj.room, key: obj.key }, res)
	}).catch((err) => {
		Logger.log({ level: "error", msg: err })
		return res.code(200).header("Content-Type", "text/plain").send("&response=denied")
	})
}

const handlePlayerData = (database, Logger, obj, res) => {
	let toPoll = "&players="
	database.getUsernamesInRoom(obj.room).then(result => {
		for (const i in Object.keys(result)) toPoll += `${result[i].username}%7E`
		toPoll += "&"
		database.getAttributesInRoom(obj.room).then(result => {
			for (const i in Object.keys(result)) toPoll += `${result[i].username}=${result[i].attributes}&`
			toPoll += `key=${obj.key}&room=${obj.room}`
			return res.code(200).header("Content-Type", "text/plain").send(toPoll)
		})
	})
}

module.exports = function (fastify, opts, next) {
	fastify.get("/", async (req, res) => { return res.sendFile("index.html") })
	fastify.get("/experimental.html", async (req, res) => { return res.sendFile("experimental.html") })
	fastify.get("/football.html", async (req, res) => { return res.sendFile("football.html") })
	fastify.get("/music.html", async (req, res) => { return res.sendFile("music.html") })
	fastify.post("/PChat.php", { schema }, async (req, res) => {
		const [action, username, room, key, data] = [req.body.action, _.escape(req.body.name), req.body.room, req.body.key, req.body[req.body.name]]
		if (_.isEmpty(username) || username.length > 14) return res.code(200).header("Content-Type", "text/plain").send("&response=denied")
		const obj = { username: username, room: room, key: key, data: data }
		if (action == "newplayer") {
			return newPlayer(opts.database, opts.Logger, obj, res)
		} else if (action == "update") {
			return updatePlayer(opts.database, opts.Logger, obj, res)
		} else if (action == "drop") {
			return dropPlayer(opts.database, opts.Logger, obj, res)
		} else {
			Logger.log({ level: "error", msg: `Unknown action: ${action}` })
		}
	})
	next()
}