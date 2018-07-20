"use strict"

const Config = require("../setup/Config")

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

	usernameExists(username) {
		return new Promise((resolve, reject) => {
			this.knex("penguins")
				.count("*")
				.where("username", username)
				.then(result => {
					resolve(result[0]["count(*)"] > 0)
			})
		})
	}

	handleNewPlayer(username, room, key, data) {
		const date = new Date()
		const toInsert = {
			username: username,
			created: date.getFullYear() * 10000 + (date.getMonth() + 1) * 100 + date.getDate(), // YMD
			room: room,
			key: key,
			attributes: data
		}
		return new Promise((resolve, reject) => {
			this.knex("penguins")
				.insert(toInsert)
				.then(result => {
					resolve(result == 0)
			})
		})
	}
}

module.exports = Database