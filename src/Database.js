"use strict"

const Config = require("../Config")

class Database {
	constructor() {
		this.knex = require("knex")({
			client: "mysql2",
			connection: {
				"host": Config.host,
				"database": Config.database,
				"user": Config.username,
				"password": Config.password
			}
		})
	}

	updateData(id, data) { return this.updateColumn(id, "data", data) }
	getData() { return this.knex("penguins").first("*") }
	updateRoom(id, room) { return this.updateColumn(id, "room", room) }
	getPlayerByName(username) { return this.knex("penguins").first("*").where("username", username) }
	getPlayerExistsByName(username) { return this.knex("penguins").where("username", username).select("username") }
	insertPlayer(username) { return this.knex("penguins").insert({ username: username }) }
	drop(id) { return this.knex("penguins").where("id", id).del() }
	dropAll() { return this.knex("penguins").where("id", ">", 100).del() }
	updateColumn(id, column, value) { return this.knex("penguins").update(column, value).where("id", id).then(() => { }).catch((err) => { if (err) throw err }) }
}

module.exports = Database