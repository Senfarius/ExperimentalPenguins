"use strict"

const Config = require("../Config")

class Database {
	constructor() {
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

	getPlayersOnline() { return this.knex("stats").select("online") }
	updatePlayersOnline() { return this.knex("stats").increment("online", 1).then(() => { }).catch((err) => { console.error(err) }) }
	resetPlayersOnline() { return this.knex("stats").update("online", 0).then(() => { }).catch((err) => { console.error(err) }) }

	usernameExists(username) { return this.knex("penguins").where({ username }).count().first() }
	emailExists(email) { return this.knex("penguins").where({ email }).count().first() }
	isPlayerBanned(username) { return this.knex("penguins").select("banned").where({ username }) }

	registerPlayer(username, password, email) { return this.knex("penguins").insert({ username: username, password: this.hashPassword(password), email: email }) }
	getPlayerByName(username) { return this.knex("penguins").first("*").where("username", username) }

	hashPassword(pass) {
		const hash = require("blake2").createHash("blake2b", { digestLength: 64 })
		hash.update(Buffer.from(pass))
		return hash.digest("hex")
	}
}

module.exports = Database