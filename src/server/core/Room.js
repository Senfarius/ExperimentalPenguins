"use strict"
/*
* Used to create rooms to send to SmartFoxServer.
*/
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
		const roomObj = { // Default room object
			priv: 0, // Private room
			temp: 0, // Temporary room
			game: 0, // Game room
			ucnt: 0, // User count
			scnt: 0, // Spectator count
			lmb: 0, // Limbo room
			maxs: 0 // Max spectators
		}
		let packet = `<msg t="sys"><body action="rmList" r="0"><rmList><`
		for (let room of Object.keys(Rooms)) {
			packet += `rm id="${Rooms[room].ID}" priv="${roomObj.priv}" temp="${roomObj.temp}" game="${roomObj.game}" ucnt="${roomObj.ucnt}" scnt="${roomObj.scnt}" lmb="${roomObj.lmb}" maxu="${Rooms[room].maxUsers}" maxs="${roomObj.maxs}"><n><![CDAT[${Rooms[room].Name}]]></n></rm></rmList></body></msg>`
		}
		return packet
	}
}

module.exports = Room