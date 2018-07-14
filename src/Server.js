"use strict"

const bodyParser = require("body-parser")
const database   = new (require("./Database"))
const express    = require("express")
const Logger     = require("./Logger").Logger
const Utils      = require("./Utils")

const Errors = {
	OK                : "&e=0",
	TIME_OUT          : "&e=1",
	NAME_UNAVAILABLE  : "&e=2",
	SERVER_FULL       : "&e=3",
	SERVER_UNAVAILABLE: "&e=4",
	CONNECTION_PROBLEM: "&e=5"
}

const app = express()
app.use(express.static(__dirname + "/public/"))
app.use(bodyParser.urlencoded({extended:true}))
app.use(bodyParser.json())

app.get("/", (req, res) => {
	res.sendFile(__dirname  + "/public/index.html")
})
app.post("/new.php", (req, res) => {
	handlePlayer(req.body.n, res)
})
app.post("/join.php", (req, res) => {
	handleJoin(req.body.d, req.body.id, res)
})
app.post("/chat.php", (req, res) => {
	handleChat(req.body.d, res)
})
app.post("/drop.php", (req, res) => {
	handleDrop(req.body.id)
})
app.get("*", (req, res) => {
	res.status(404).send("<h1>404 - NOT FOUND</h1>")
})
app.listen(80, () => {
	Logger.info("Server listening on address http://localhost:80/")
})

function write (data, res) {
	Logger.polling(data)
	return res.status(200).send(data)
}
function handlePlayer (username, res) {
	database.getPlayerExistsByName(username).then(result => {
		if (result.length != 1) {
			database.insertPlayer(username)
			database.getPlayerByName(username).then(penguin => { // Bug
				return write(`&id=${penguin.id}&m=${penguin.mod}${Errors.OK}`, res)
			})
		} else {
			return write(Errors.NAME_UNAVAILABLE, res)
		}
	})
}
function handleJoin (roomData, id, res) {
	let room = roomData.substr(0, 1)
	let chat = roomData.substr(1, 99)
	database.updateColumn(id, "data", chat)
	database.updateColumn(id, "room", room)
	database.getPlayerById(id).then(penguin => {
		return write(`&p=${penguin.room}${penguin.data.substr(1, 4)}${penguin.username}${Errors.OK}`, res)
	})
}
function handleChat (chatData, res) {
	let chat = chatData.substr(0, 99)
	let id = chat.substr(0, 3) // Bug
	if (chatData.length > 2) {
		database.updateColumn(id, "data", chatData)
		database.getPlayerById(id).then(penguin => {
			return write(`&c=${penguin.room}${penguin.data}`, res)
		})
	}
}
function handleDrop (id, res) {
	return database.drop(id)
}