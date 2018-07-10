"use strict"

const xmldoc     = require("xmldoc")
const Logger     = require("../Logger").Logger
const Crypto     = require("./utils/Crypto")

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
						client.sendError("Stop sending junk packets", true)
					}
				} else if (type == "rndK") {
					client.randomKey = Crypto.generateKey()
					client.send(`<msg t="sys"><body action="rndK" r="-1"><k>${client.randomKey}</k></body></msg>`)
				} else if (type == "login") {
					const username = xmlPacket.children[0].firstChild.firstChild.val
					const password = xmlPacket.children[0].lastChild.lastChild.val
					this.database.getPlayerExistsByName(username).then(result => {
						if (result.length != 1) {
							return client.sendError("Incorrect username/password.")
						} else {
							this.database.getPlayerByName(username).then(penguin => {
								const hash = Crypto.decryptZaseth(password, client.randomKey)
								if (hash == penguin.password) {
									Logger.info(`${penguin.username} -| ${client.ipAddr} has logged in`)
									client.buildPlayer(penguin)
									client.send(`<msg t="sys"><body action="logOK" r="0"><login n="${penguin.username}" id="${penguin.id}" mod="${penguin.moderator}"></login></body></msg>`)
									client.sendAlert(`Welcome back ${penguin.username}`)
								} else {
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
			client.sendError("Stop sending junk packets.", true)
		}
	}
}

module.exports = Core