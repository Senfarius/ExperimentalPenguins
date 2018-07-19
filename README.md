<h1 align="center">Penguin Chat JS</h1>
<p align="center"><b>A blazing fast Penguin Chat 3 emulator, written in Node.js.</b></p>
<p align="center"><img src="https://vignette.wikia.nocookie.net/clubpenguin/images/b/bc/Penguin_Chat_Logo.png/revision/latest?cb=20130114043324"></p>

# Still in development

# Features

* Great performance
* Simple to setup
* Well written and clean
* Comes with all of the files
* Uses no-cache to avoid SWFS getting cached
* Extensive response validating
* Uses security headers to maintain stability and security
* Uses [Blake2b-512](https://blake2.net/) for hashing passwords and my custom algorithm for comparing hashes with a random key

# Installation

1. Download this repository
2. (IF VPS) - In chat.swf, change <b>127.0.0.1</b> to your VPS IP/domain
3. Download & install [Node.js](https://nodejs.org/en/)
4. Run the following command in CMD: <b>npm install fastify fastify-static fastify-formbody fastify-helmet fastify-no-cache validator knex mysql2</b>
5. Download & install MySQL for your OS (Windows, Linux etc)
6. Change the details in Config.json
7. Download & install [MySQL Workbench](https://www.mysql.com/products/workbench/) to <b>import</b>, browse and edit the database

# Run server

1. Make sure you did everything in <b>Installation</b> and <b>have MySQL running</b>
2. Open CMD
3. Use the [CD](https://ss64.com/nt/cd.html) command to CD to the folder where <b>Run.js</b> is located
4. Enter the command: <b>node Run.js</b>
5. Open a new webpage and browse to: <b>http://127.0.0.1/ (or your VPS IP/domain)</b>