"use strict"
/*
* Starts the server.
* Default port is 9339.
* node Run.js porthere.
*/
const Server  = require("./server/Server")
const Logger  = require("./server/Logger").Logger
const version = require("../package").version

console.log(`Penguin Chat 3 Emulator by Zaseth V${version}
:::::::::   ::::::::   ::::::::  ::::::::::: ::::::::  
:+:    :+: :+:    :+: :+:    :+:     :+:    :+:    :+: 
+:+    +:+ +:+               +:+     +:+    +:+        
+#++:++#+  +#+            +#++:      +#+    +#++:++#++ 
+#+        +#+               +#+     +#+           +#+ 
#+#        #+#    #+# #+#    #+# #+# #+#    #+#    #+# 
###         ########   ########   #####      ########  `)

new Server(process.argv[2] || 9339)