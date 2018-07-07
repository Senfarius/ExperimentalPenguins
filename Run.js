"use strict"

const Server     = require("./src/server/Server")
const Logger     = require("./src/server/Logger").Logger

console.log(`Penguin Chat 3 Emulator by Zaseth
:::::::::   ::::::::   ::::::::  ::::::::::: ::::::::  
:+:    :+: :+:    :+: :+:    :+:     :+:    :+:    :+: 
+:+    +:+ +:+               +:+     +:+    +:+        
+#++:++#+  +#+            +#++:      +#+    +#++:++#++ 
+#+        +#+               +#+     +#+           +#+ 
#+#        #+#    #+# #+#    #+# #+# #+#    #+#    #+# 
###         ########   ########   #####      ########  `)

new Server(process.argv[2] || 9339)