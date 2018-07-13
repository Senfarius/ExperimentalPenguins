"use strict"
/*
* Used to handle the database.
*/
const Logger     = require("../Logger").Logger
const Config     = require("../Config").Database
const Validation = require("./utils/Validation")

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

	drop (id) {
		return this.knex("penguins").where("id", id).del()
	}

	ban (id) {
		return this.updateColumn(id, "ban", 1)
	}

	addValidation (client) {
		let Mm = Validation.MmValidate()
		client.validation = Mm
		return this.updateColumn(client.id, "validation", Mm)
	}

	updateColumn (id, column, value) {
		return this.knex("penguins").update(column, value).where("id", id).then(() => {
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