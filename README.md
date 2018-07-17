<h1 align="center">Penguin Chat JS</h1>
<p align="center">A blazing fast Penguin Chat 2 emulator written in Node.js .</p>
<p align="center"><img src="https://i.imgur.com/sfH04Fn.png"></p>

# Known issues

handleChat breaks a small part of the game, but I'm working on it.

# Features

* Async and await server
* Great performance thanks to Fastify
* Comes with all the game files
* Type checking on every used POST object
* Security headers to maintain security
* Every response has status codes to maintain stability
* Custom logger that pretty prints and saves logs
* Uses Knex to have a clean database class (also uses promises)
* Easy to understand, install and to modify

# Installation

1. (IF VPS) - In chat.swf & Config.json, change <b>localhost</b> to your VPS IP/domain
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