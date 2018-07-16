<h1 align="center">Penguin Chat JS</h1>
<p align="center">A Penguin Chat 2 emulator, written in Node.js with the use of an extremely fast HTTP server called Fastify to imitate PHP's long polling technique.</p>
<p align="center"><img src="https://i.imgur.com/sfH04Fn.png"></p>

# Features

* Async and await server
* Great performance
* Comes with all the game files
* Type checking on every used POST object
* Security headers to maintain security
* Every response has status codes to maintain stability
* Easy to understand, install and to modify

# Installation

1. (IF VPS) - In chat.swf, change <b>localhost</b> to your VPS IP/domain
2. Download this repository
3. Download & install [Node.js](https://nodejs.org/en/)
4. Run the following command in CMD: <b>npm install fastify fastify-static fastify-formbody fastify-helmet knex mysql2</b>
5. Download & install MySQL for your OS (Windows, Linux etc)
6. Download & install [MySQL Workbench](https://www.mysql.com/products/workbench/) to <b>import</b>, browse and edit the database

# Run server

1. Make sure you did everything in <b>Installation</b> and <b>have MySQL running</b>
2. Open CMD
3. Use the [CD](https://ss64.com/nt/cd.html) command to CD to the folder where <b>Run.js</b> is located
4. Enter the command: <b>node Run.js</b>
5. Open a new webpage and browse to: <b>http://localhost/ (or your VPS IP/domain)</b>