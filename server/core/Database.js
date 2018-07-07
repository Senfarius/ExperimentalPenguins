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
}

module.exports = Database