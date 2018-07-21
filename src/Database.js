"use strict"

const Config = require("../setup/Config")

class Database {
	constructor() {
		this.knex = require("knex")({
			client: "mysql2",
			connection: {
				"host"    : Config.hostname,
				"database": Config.database,
				"user"    : Config.username,
				"password": Config.password
			}
		})
	}

	handleNewPlayer(obj) {
		const date = new Date()
		return this.knex("penguins").insert({
			"username": obj.username,
			"created": date.getFullYear() * 10000 + (date.getMonth() + 1) * 100 + date.getDate(),
			"room": obj.room,
			"attributes": obj.data
		})
	}
	handleUpdatePlayer(obj) {
		return this.knex("penguins").where("username", obj.username).update({
			"room": obj.room,
			"attributes": obj.data
		})
	}
	handleDropPlayer(username) { return this.knex("penguins").where("username", username).del() }
	handleDropAll() { return this.knex("penguins").whereNot("id", 0).del() }

	getUsernamesInRoom(room) { return this.knex("penguins").select("username").where("room", room) }
	getAttributesInRoom(room) { return this.knex("penguins").select("username", "attributes").where("room", room) }
}

module.exports = Database