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

	testConnection () {
		this.knex.raw("SELECT 1 + 1 AS RESULT").catch(err => {
			Logger.error(err)
			process.exit(1)
		})
	}
	
	drop (username) { return this.knex("penguins").where("username", username).del() }
	ban (username) { return this.updateColumn(username, "ban", 1) }
	unban (username) { return this.updateColumn(username, "ban", 0) }
	promote (username) { return this.updateColumn(username, "mod", 1) }
	demote (username) { return this.updateColumn(username, "mod", 0) }

	getPlayerByName (username) { return this.knex("penguins").first("*").where("username", username) }
	getPlayerExistsByName (username) { return this.knex("penguins").where("username", username).select("username") }

	updateColumn (id, column, value) {
		return this.knex("penguins").update(column, value).where("id", id).then(() => {
			Logger.info(`Updated ${column} with ${value} by ${id}`)
		}).catch((err) => {
			Logger.error(err)
		})
	}
	insertPlayer (username) {
		return this.knex("penguins").insert({username: username}).then(() => {
			Logger.info(`Inserted ${username}`)
		}).catch((err) => {
			Logger.error(err)
		})
	}
}

module.exports = Database