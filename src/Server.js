"use strict"
/*
* Modules
*/
const bodyParser = require("body-parser")
const database   = new (require("./Database"))
const express    = require("express")
const Logger     = require("./Logger").Logger
const Utils      = require("./Utils")
/*
* Error types
*/
const Errors = {
	OK                : "&e=0",
	TIME_OUT          : "&e=1",
	NAME_UNAVAILABLE  : "&e=2",
	SERVER_FULL       : "&e=3",
	SERVER_UNAVAILABLE: "&e=4",
	CONNECTION_PROBLEM: "&e=5"
}
/*
* Security headers
*/
const headers = (req, res, next) => {
	res.setHeader("Surrogate-Control", "no-store")
	res.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, proxy-revalidate")
	res.setHeader("Pragma", "no-cache")
	res.setHeader("Expires", "0")
	res.setHeader("X-XSS-Protection", "1; mode=block")
	res.setHeader("X-Powered-By", "Your mom")
	res.setHeader("X-Download-Options", "noopen")
	res.setHeader("X-Frame-Options", "SAMEORIGIN")
	res.setHeader("X-Content-Type-Options", "nosniff")
	next()
}
/*
* Middleware
*/
const app = express()
app.use(express.static(__dirname + "/public/"))
app.use(bodyParser.urlencoded({extended:true}))
app.use(bodyParser.json())
/*
* Routes
*/
app.get("/", (req, res) => { res.sendFile(__dirname  + "/public/index.html") })
app.post("/new.php", (req, res) =>  { handleNew(req.body.n, res) })
app.post("/join.php", (req, res) => { handleJoin(req.body.d, req.body.id, res) })
app.post("/chat.php", (req, res) => { handleChat(req.body.d, req.body.id, res) })
app.post("/drop.php", (req, res) => { handleDrop(req.body.id) })
app.post("/ban.php", (req, res) =>  { handleBan(req.body.id) })
/*
* Server base
*/
app.get("*", (req, res) => { res.status(404).send("<h1>404 - NOT FOUND</h1>") })
app.listen(80, () => {
	Logger.info("Server listening on address http://localhost:80/")
	process.on("SIGINT",  () => handleShutdown())
    process.on("SIGTERM", () => handleShutdown())
})
/*
* Handlers
*/
function handleShutdown () {
	Logger.info(`Server shutting down in 3 seconds...`)
	database.dropAll()
	setTimeout(() => {
		process.exit(0)
	}, 3000)
}
function handleWrite (data, res) {
	Logger.polling(data)
	return res.status(200).send(data)
}
function handleNew (username, res) {
	if (Utils.validateString(username)) {
		Logger.warning(`${username} is blocked`)
		return handleWrite(Errors.NAME_UNAVAILABLE, res)
	}
	database.getPlayerExistsByName(username).then(penguin => {
		if (penguin.length != 1) {
			database.insertPlayer(username).then(penguin => {
				const id = penguin[0]
				database.getPlayerByName(username).then(penguin => {
					return handleWrite(`&id=${id}&m=${penguin.mod}${Errors.OK}`, res)
				})
			})
		} else {
			return handleWrite(Errors.NAME_UNAVAILABLE, res)
		}
	})
}
function handleJoin (roomData, id, res) {
	let room = roomData.substr(0, 1)
	let chat = roomData.substr(1, 99)
	database.updateColumn(id, "data", chat)
	database.updateColumn(id, "room", room)
	database.getPlayerById(id).then(penguin => {
		return handleWrite(`&p=${penguin.room}${penguin.data.substr(1, 4)}${penguin.username}${Errors.OK}`, res)
	})
}
function handleChat (chatData, id, res) {
	let chat = chatData.substr(0, 99)
	if (chatData.length > 2) {
		database.updateColumn(id, "data", chatData)
		database.getPlayerById(id).then(penguin => {
			return handleWrite(`&c=${penguin.room}${penguin.data}`, res)
		})
	}
}
function handleDrop (id) { return database.drop(id) }
function handleBan (id)  { return database.ban(id) }