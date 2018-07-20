"use strict"

module.exports = {
	REGISTER_SCHEMA: { schema: { body: { type: "object", properties: { n: { type: "string" }, p: { type: "string" }, e: { type: "string" } } } } },
	LOGIN_SCHEMA: { schema: { body: { type: "object", properties: { n: { type: "string" }, p: { type: "string" } } } } },
	JOIN_SCHEMA: { schema: { body: { type: "object", properties: { id: { type: "number" }, s: { type: "string" }, r: { type: "number" }, k: { type: "string" } } } } },
	CHAT_SCHEMA: { schema: { body: { type: "object", properties: { l: { type: "number" }, id: { type: "number" }, k: { type: "string" }, r: { type: "number" }, s: { type: "string" }, d: { type: "string" } } } } }
}