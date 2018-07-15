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
app.enable("trust proxy")
app.use(express.static(__dirname + "/public/"))
app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())
/*
* Routes
*/
app.get("/", (req, res) => { res.sendFile(__dirname + "/public/index.html") })
app.post("/new.php", (req, res) =>  { handleNew(req.body.n, req, res) })
app.post("/join.php", (req, res) => { handleJoin(req.body.d, req.body.n, req.body.id, res) })
app.post("/chat.php", (req, res) => { handleChat(req.body.d, req.body.id, res) })
app.post("/drop.php", (req, res) => { handleDrop(req.body.id) })
app.post("/wait.php", (req, res) => { handleWait(res) })
/*
* Server base
*/
app.get("*", (req, res) => { res.status(404).send("<h1>404 - NOT FOUND</h1>") })
app.listen(80, () => {
	Logger.info("Server listening on address http://localhost:80/")
	process.on("SIGINT", () => handleShutdown())
	process.on("SIGTERM", () => handleShutdown())
})
/*
* Server handlers
*/
function handleShutdown() {
	Logger.info(`Server shutting down in 3 seconds...`)
	database.dropAll()
	setTimeout(() => { process.exit(0) }, 3000)
}
function handleWrite(data, res) {
	res.setHeader("Content-Type", "text/html")
	Logger.polling(data)
    return res.status(200).send(data)
}
/*
* Game handlers
*/
function handleNew(username, req, res) {
	if (Utils.validateString(username)) { // Extensive username check => swears & special characters
		Logger.warning(`${username} is blocked`)
		return handleWrite(Errors.NAME_UNAVAILABLE, res)
	}
	let ip = req.ip
	if (ip.substr(0, 7) == "::ffff:") ip = ip.substr(7) // Catch ipv4 and ipv6 ips
	if (Utils.validateIP(ip)) { // Extensive IP check => subnets & masks
		Logger.warning(`${username} -| ${ip} is IP banned`)
		return handleWrite(Errors.CONNECTION_PROBLEM, res)
	}
	database.getPlayerExistsByName(username).then(penguin => {
		if (penguin.length != 1) { // The username does not exist
			Logger.info(`${username} -| ${ip} is joining`)
			database.insertPlayer(username).then(penguin => { // This is here because the insert is slower than getPlayerByName
				const id = penguin[0]
				database.updateIp(id, ip)
				database.getPlayerByName(username).then(penguin => { return handleWrite(`&id=${id}&m=${penguin.mod}${Errors.OK}`, res) })
			})
		} else {
			return handleWrite(Errors.NAME_UNAVAILABLE, res)
		}
	})
}
function handleJoin(data, username, id, res) {
	const room = data.substr(0, 1)
	const joinData = data.substr(1, 99)
	database.updateRoom(id, room)
	return handleWrite(`&p=${room}${joinData.substr(1, 4)}${username}${Errors.OK}`, res)
}
function handleChat(data, id, res) {
	const room = data.substr(0, 1)
	database.updateRoom(id, room)
	return handleWrite(`&c=${room}${data}`, res)
}
function handleDrop(id) { return database.drop(id) }
function handleWait(res) { return handleWrite(Errors.OK, res) }