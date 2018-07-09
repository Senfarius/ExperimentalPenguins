"use strict"

const xmldoc     = require("xmldoc")
const Logger     = require("../Logger").Logger
const Crypto     = require("./utils/Crypto")
const Constants  = require("./utils/Constants").CHECKER

class Core {
	constructor (server) {
		this.server   = server
		this.room     = server.room
		this.database = server.database
	}

	handleData (data, client) {
		if (data.charAt(0) == "<" && data.charAt(data.length - 1) == ">") {
			Logger.incoming(data)
			if (data == "<policy-file-request/>") {
				client.send(`<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE cross-domain-policy SYSTEM "http://www.adobe.com/xml/dtds/cross-domain-policy.dtd"><cross-domain-policy><site-control permitted-cross-domain-policies="master-only"/><allow-access-from domain="*" to-ports="${this.server.port}"/></cross-domain-policy>`)
			} else {
				const xmlPacket = new xmldoc.XmlDocument(data)
				const type = xmlPacket.children[0].attr.action
				if (type == "verChk") {
					if (xmlPacket.children[0].firstChild.attr.v == 135) {
						client.send(`<msg t="sys"><body action="apiOK" r="0"></body></msg>`)
					} else {
						Logger.warning(`Invalid verChk packet: ${data} -| ${client.ipAddr}`)
						client.disconnect()
					}
				} else if (type == "rndK") {
					client.randomKey = Crypto.generateKey()
					client.send(`<msg t="sys"><body action="rndK" r="-1"><k>${client.randomKey}</k></body></msg>`)
				} else if (type == "login") {
					const username = xmlPacket.children[0].firstChild.firstChild.val
					const password = xmlPacket.children[0].lastChild.lastChild.val
					this.database.penguinExistsByName(username).then(result => {
						if (result.length != 1) {
							return client.sendError("Username is invalid.")
						} else if (username.length <= 0 || password.length <= 0) {
							return client.sendError("Username/password is empty.")
						} else if (Constants.SWEARS.includes(username)) {
							return client.sendError("Username contains a swear word.")
						} else {
							this.database.getPenguinByName(username).then(penguin => {
								const hash = Crypto.decryptZaseth(password, client.randomKey)
								if (hash == penguin.password) {
									Logger.info(`${penguin.username} -| ${client.ipAddr} is logging in`)
									client.id = penguin.id
									client.username = penguin.username
									client.password = penguin.password
									client.moderator = penguin.moderator
									client.send(`<msg t="sys"><body action="logOK" r="0"><login n="${penguin.username}" id="${penguin.id}" mod="${penguin.moderator}"></login></body></msg>`)
								} else {
									Logger.warning(`Invalid login: ${penguin.username} -| ${client.ipAddr}`)
									return client.sendError("Invalid username/password.")
								}
							})
						}
					})
				} else if (type == "getRmList") {
					client.send(this.room.makeRoomList())
				}
			}
		} else {
			Logger.warning(`Junk packet: ${data} -| ${client.ipAddr}`)
			client.disconnect()
		}
	}
}

module.exports = Core