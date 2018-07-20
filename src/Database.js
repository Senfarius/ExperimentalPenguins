"use strict"

const Config = require("../Config")

class Database {
	constructor(Logger) {
		this.Logger = Logger
		this.maxPenguins = Config.maxPenguins
		this.knex = require("knex")({
			client: "mysql2",
			connection: {
				"host": Config.hostname,
				"database": Config.database,
				"user": Config.username,
				"password": Config.password
			}
		})
	}
	/*
	* This is a MUST-HAVE.
	* The room in join.php is never reset by default...
	* This is all reset upon server exit.
	*/
	resetRooms() {
		return this.knex("penguins").update("room", 0).whereNot({ "room": 0 }).then(() => {
			this.Logger.log({ level: "info", msg: "Rooms have been reset" })
		}).catch((err) => {
			this.Logger.log({ level: "error", msg: err })
		})
	}
	resetPlayersOnline() {
		return this.knex("stats").update("online", 0).then(() => {
			this.Logger.log({ level: "info", msg: "Players online count have been reset" })
		}).catch((err) => {
			this.Logger.log({ level: "error", msg: err })
		})
	}
	/*
	* Single update functions, for re-use purposes.
	*/
	updateRoomById(id, room) {
		return this.knex("penguins").update({ "room": room }).where({ "id": id })
	}
	updateAttributesById(id, attributes) {
		return this.knex("penguins").update({ "attributes": attributes }).where({ "id": id })
	}
	updatePlayersOnline() {
		return this.knex("stats").increment("online", 1).then(() => {
			this.Logger.log({ level: "info", msg: "A new player has logged in" })
		}).catch((err) => {
			this.Logger.log({ level: "error", msg: err })
		})
	}
	/*
	* Penguin Chat doesn't always send the username sadly, so we also need getPlayerById.
	*/
	getPlayersOnline() { return this.knex("stats").select("online") }
	getPlayerByName(username) { return this.knex("penguins").first("*").where({ "username": username }) }
	getPlayerById(id) { return this.knex("penguins").first("*").where({ "id": id }) }
	getPlayersInRoom(username, room) { return this.knex("penguins").select("*").where({ "room": room }).whereNot({ "username": username }) }
	/*
	* Checks if the username/email exists.
	*/
	usernameExists(username) { return this.knex("penguins").where({ username }).count().first() }
	emailExists(email) { return this.knex("penguins").where({ email }).count().first() }
	/*
	* Inserts the player.
	* Our .sql has DEFAULT, allowing this to be as small as possible.
	*/
	registerPlayer(username, password, email) { return this.knex("penguins").insert({ username: username, password: password, email: email }) }
}

module.exports = Database