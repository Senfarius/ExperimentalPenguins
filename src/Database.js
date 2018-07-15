"use strict"

const Config = require("../Config")
const Logger = require("./Logger").Logger

class Database {
	constructor() {
		this.knex = require("knex")({
			client: "mysql2",
			connection: {
				"host"    : Config.host,
				"database": Config.database,
				"user"    : Config.username,
				"password": Config.password
			}
		})
	}

	promote(id) { return this.updateColumn(id, "mod", 1) }
	demote(id) { return this.updateColumn(id, "mod", 0) }

	updateRoom(id, room) { return this.updateColumn(id, "room", room) }
	updateIp(id, ip) { return this.updateColumn(id, "IP", ip)}

	getPlayerByName(username) { return this.knex("penguins").first("*").where("username", username) }
	getPlayerExistsByName(username) { return this.knex("penguins").where("username", username).select("username") }

	insertPlayer(username) { return this.knex("penguins").insert({ username: username }) }

	drop(id) {
		return this.knex("penguins").where("id", id).del().then(() => {
			Logger.info(`Dropped ${id}`)
		}).catch((err) => {
			Logger.error(err)
		})
	}
	dropAll() {
		return this.knex("penguins").where("id", ">", 100).del().then(() => {
			Logger.info(`Cleaned the database`)
		}).catch((err) => {
			Logger.error(err)
		})
	}
	updateColumn(id, column, value) {
		return this.knex("penguins").update(column, value).where("id", id).then(() => {
			Logger.info(`Updated ${column} with ${value} by ${id}`)
		}).catch((err) => {
			Logger.error(err)
		})
	}
}

module.exports = Database