"use strict"

const xmldoc = require("xmldoc")
const Logger = require("../Logger").Logger

class Core {
	constructor (server) {
		this.server   = server
		this.database = server.database
	}

	handleData (data, client) {
		if (data.charAt(0) == "<" && data.charAt(data.length - 1) == ">") { // XML always starts with `<` and ends with `>`
			Logger.incoming(data) // Logger here to save resources if packet is invalid
			if (data == "<policy-file-request/>") {
				client.send(`<?xml version="1.0"?><cross-domain-policy><allow-access-from domain="*" to-ports="*" /></cross-domain-policy>`)
			} else {
				const xmlPacket = new xmldoc.XmlDocument(data)
				const type = xmlPacket.children[0].attr.action
				if (type == "verChk") {
					if (xmlPacket.children[0].firstChild.attr.v == 135) { // Hardcode check version
						client.send(`<msg t="sys"><body action="apiOK" r="0"></body></msg>`)
					} else {
						Logger.warning(`Invalid verChk packet: ${data} received from ${client.ipAddr}`)
						client.disconnect()
					}
				} else if (type == "login") {
					const username = xmlPacket.children[0].firstChild.firstChild.val
					if (username.length > 12 || username.length <= 0) {
						Logger.warning(`Junk client: ${client.ipAddr}`)
						client.disconnect()
					} else {
						Logger.info(`${username} - ${client.ipAddr} is logging on`)
					}
				}
			}
		} else {
			Logger.warning(`Junk packet: ${data} received from ${client.ipAddr}`)
			client.disconnect()
		}
	}
}

module.exports = Core