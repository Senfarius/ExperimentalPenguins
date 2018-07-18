"use strict"

const Config = require("../Config")

class Database {
	constructor() {
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

	getPlayerByName(username) { return this.knex("penguins").first("*").where("username", username) }

	usernameExists(username) { return this.knex("penguins").where({ username }).count().first() }
	emailExists(email) { return this.knex("penguins").where({ email }).count().first() }

	registerPlayer(username, password, email) {
		return this.knex("penguins").insert({ username: username, password: this.hashPassword(password), email: email })
	}

	hashPassword(pass) {
		const hash = require("blake2").createHash("blake2s")
		hash.update(Buffer.from(pass))
		return hash.digest("hex")
	}
}

module.exports = Database