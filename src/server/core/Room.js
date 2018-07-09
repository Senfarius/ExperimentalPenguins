"use strict"

const Logger = require("../Logger").Logger
const Rooms  = require("./data/Rooms")

class Room {
	constructor () {
		this.roomCount = 0
	}

	countRooms () {
		for (const room of Object.keys(Rooms)) {
			this.roomCount++
		}
		return this.roomCount
	}

	makeRoomList () {
		let packet = `<msg t="sys"><body action="rmList" r="0"><rmList><`
		for (let room of Object.keys(Rooms)) {
			packet += `rm id="${Rooms[room].ID}" priv="0" temp="0" game="0" ucnt="0" scnt="0" lmb="0" maxu="${Rooms[room].maxUsers}" maxs="0"><n><![CDAT[${Rooms[room].Name}]]></n></rm></rmList></body></msg>`
		}
		return packet
	}
}

module.exports = Room