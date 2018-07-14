"use strict"

const Config = require("../Config")
const Logger = require("./Logger").Logger

class Database {
	constructor () {
		this.knex = require("knex")({
			client: "mariadb",
			connection: {
				"host"    : Config.host,
				"db"      : Config.database,
				"user"    : Config.username,
				"password": Config.password
			}
		})
	}

	ban (id) { return this.updateColumn(id, "ban", 1) }
	unban (id) { return this.updateColumn(id, "ban", 0) }
	promote (id) { return this.updateColumn(id, "mod", 1) }
	demote (id) { return this.updateColumn(id, "mod", 0) }
	getPlayerByName (username) { return this.knex("penguins").first("*").where("username", username) }
	getPlayerById (id) { return this.knex("penguins").first("*").where("id", id) }
	getPlayerExistsByName (username) { return this.knex("penguins").where("username", username).select("username") }
	getIdByName (username) { return this.knex("penguins").where("username", username).select("id") }
	insertPlayer (username) { return this.knex("penguins").insert({username: username}) }

	drop (id) {
		return this.knex("penguins").where("id", id).del().then(() => {
			Logger.info(`Dropped ${id}`)
		}).catch((err) => {
			Logger.error(err)
		})
	}
	dropAll () {
		return this.knex.raw("DELETE FROM `penguins` WHERE `id` > 100").then(() => {
			Logger.info("Cleaned the database")
		}).catch((err) => {
			Logger.error(err)
		})
	}
	updateColumn (id, column, value) {
		return this.knex("penguins").update(column, value).where("id", id).then(() => {
			Logger.info(`Updated ${column} with ${value} by ${id}`)
		}).catch((err) => {
			Logger.error(err)
		})
	}
}

module.exports = Database