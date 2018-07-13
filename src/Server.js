"use strict"

const bodyParser = require("body-parser")
const database   = new (require("./Database"))
const express    = require("express")
const Logger     = require("./Logger").Logger
const morgan     = require("morgan")

const app = express()
app.use(express.static(__dirname + "/public/"))
app.use(bodyParser.urlencoded({extended:true}))
app.use(bodyParser.json())
app.use(morgan("common"))

app.get("/", (req, res) => {
	res.sendFile(__dirname  + "/public/index.html")
})

app.post("/new.php", (req, res) => {
	newPlayer(req.body.n, res)
})

app.get("*", (req, res) => {
	res.status(404).send("<h1>404 - NOT FOUND</h1>")
})

app.listen(80, () => {
	Logger.info("Server listening on address http://localhost:80/")
})

function newPlayer (username, res) {
	database.getPlayerExistsByName(username).then(result => {
		if (result.length != 1) {
			database.insertPlayer(username) // The player is inserted
			database.getPlayerByName(username).then(penguin => {
				if (penguin.ban == 1) {
					Logger.info(`${username} tried to login but he is banned`)
					return res.status(200).send(error(4)) // The player is banned
				}
				res.status(200).send(`${error(0)}&id=${penguin.id}`)
			})
		} else {
			return res.status(200).send(error(2)) // The player is in use
		}
	})
}

function error (code) {
	if (code == 0) return "&e=0" // Nothing
	else if (code == 1) return "&e=1" // Time out
	else if (code == 2) return "&e=2" // Name unavailable
	else if (code == 3) return "&e=3" // Server full
	else if (code == 4) return "&e=4" // Server unavailable
	else if (code == 5) return "&e=5" // Connection problem
}