"use strict"

// Modules
const bodyParser = require("body-parser")
const database   = new (require("./Database"))
const express    = require("express")
const Logger     = require("./Logger").Logger
const Utils      = require("./Utils")

// Middleware
const app = express()
app.use(express.static(__dirname + "/public/"))
app.use(bodyParser.urlencoded({extended:true}))
app.use(bodyParser.json())

// GET routes
app.get("/", (req, res) => { res.sendFile(__dirname  + "/public/index.html") })

// POST routes (game)
app.post("/new.php", (req, res) => {
	newPlayer(req.body.n, res)
})

// Anything that isn't in /public/ routes to this status message
app.get("*", (req, res) => { res.status(404).send("<h1>404 - NOT FOUND</h1>") })

// Listens the server on port 80
app.listen(80, () => {
	Logger.info("Server listening on address http://localhost:80/")
})

function write (data, res) {
	Logger.info(`[POLLING] - ${data}`)
	return res.status(200).send(data)
}

// Handlers for the POST routes
function newPlayer (username, res) {
	if (Utils.verifyName(username)) {
		Logger.info(`${username} is invalid and has been blocked`)
		return write(`${error(2)}`, res)
	}
	database.getPlayerExistsByName(username).then(result => {
		if (result.length != 1) {
			database.insertPlayer(username) // The player is inserted
			database.getPlayerByName(username).then(penguin => {
				if (penguin.ban == 1) {
					Logger.info(`${username} tried to login but he is banned`)
					return write(error(4), res) // The player is banned
				}
				return write(`${error(0)}&id=${penguin.id}&m=${penguin.mod}`, res)
			})
		} else {
			return write(error(2), res) // The player is already used
		}
	})
}

/*
* 0 = Nothing (OK), 1 = Time Out, 2 = Name unavailable
* 3 = Server full, 4 = Server unavailable, 5 = Connection problem
*/
function error (code) {
	if (code >= 0 && code <= 6) {
		return `&e=${code}`
	} else {
		return Logger.error(`${code} is invalid...`)
	}
}