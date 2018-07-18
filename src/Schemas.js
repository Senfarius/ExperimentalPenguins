"use strict"

module.exports = {
	REGISTER_SCHEMA: { schema: { body: { type: "object", properties: { n: { type: "string" }, p: { type: "string" }, e: { type: "string" } } } } },
	LOGIN_SCHEMA: { schema: { body: { type: "object", properties: { n: { type: "string" }, p: { type: "string" } } } } }
}