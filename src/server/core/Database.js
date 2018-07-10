"use strict"

const Logger = require("../Logger").Logger
const Config = require("../Config").Database

class Database {
	constructor () {
		this.knex = require("knex")({
			client: "mariadb",
			connection: {
				"host": Config.host,
				"db": Config.database,
				"user": Config.username,
				"password": Config.password
			}
		})
	}

	updateColumn (id, column, value) {
		return this.knex("penguins").update(column, value).where("id", id).then(() => {
			Logger.info(`"${column}" updated with "${value}" by "${id}"`)
		}).catch((error) => {
			Logger.error(error)
		})
	}

	getPlayerByName (username) {
		return this.knex("penguins").first("*").where("username", username)
	}

	getPlayerById (id) {
		return this.knex("penguins").first("*").where("id", id)
	}

	getPlayerExistsByName (username) {
		return this.knex("penguins").where("username", username).select("username")
	}
}

module.exports = Database