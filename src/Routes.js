"use strict"

const FileHandler = require("./FileHandler")

const schema = {
	schema: {
		body: {
			type: "object",
			properties: {
				action: { type: "string" },
				name: { type: "string" },
				room: { type: "number" }
			}
		}
	}
}

const newPlayer = (database, obj, res) => {
	database.handleNewPlayer(obj).then(result => {
		return handlePlayerData(database, obj.room, res)
	}).catch((err) => {
		console.error(err)
		return res.code(200).header("Content-Type", "text/plain").send("&response=denied")
	})
}
const updatePlayer = (database, obj, res) => {
	database.handleUpdatePlayer(obj).then(result => {
		return handlePlayerData(database, obj.room, res)
	}).catch((err) => {
		console.error(err)
		return res.code(200).header("Content-Type", "text/plain").send("&response=denied")
	})
}
const dropPlayer = (database, obj, res) => {
	database.handleDropPlayer(obj.username).then(result => {
		// Player is dropped
	}).catch((err) => {
		console.error(err)
		return res.code(200).header("Content-Type", "text/plain").send("&response=denied")
	})
}
const handlePlayerData = (database, room, res) => {
	let toPoll = "&players="
	database.getUsernamesInRoom(room).then(result => {
		for (const i in Object.keys(result)) toPoll += `${result[i].username}%7E`
		toPoll += "&"
		database.getAttributesInRoom(room).then(result => {
			for (const i in Object.keys(result)) toPoll += `${result[i].username}=${result[i].attributes}&`
			toPoll += `key=&room=${room}`
		    FileHandler.appendFileAsync(toPoll).then(() => {
		    	// Data is stored
		    }).catch((err) => {
		    	console.error(err)
		    })
			return res.code(200).header("Content-Type", "text/plain").send(toPoll)
		}).catch((err) => {
			console.error(err)
			return res.code(200).header("Content-Type", "text/plain").send("&response=denied")
		})
	}).catch((err) => {
		console.error(err)
		return res.code(200).header("Content-Type", "text/plain").send("&response=denied")
	})
}

module.exports = function (fastify, opts, next) {
	fastify.get("/", async (req, res) => { return res.sendFile("index.html") })
	fastify.post("/PChat.php", { schema }, async (req, res) => {
		const [action, username, room, data] = [req.body.action, require("underscore").escape(req.body.name), req.body.room, req.body[req.body.name]]
		if (require("underscore").isEmpty(username) || username.length > 14) return res.code(200).header("Content-Type", "text/plain").send("&response=denied")
		const obj = { username: username, room: room, data: data }
		if (action == "newplayer") {
			return newPlayer(opts.database, obj, res)
		} else if (action == "update") {
			return updatePlayer(opts.database, obj, res)
		} else if (action == "drop") {
			return dropPlayer(opts.database, obj, res)
		} else {
			opts.Logger.log({ level: "error", msg: `Unknown action: ${action}` })
		}
	})
	fastify.post("/PChat.ASP", async (req, res) => {
		opts.Logger.log({ level: "warning", msg: "This game isn't supported yet until Fastify will respond to my issue. I'm busy solving this." })
	})
	next()
}