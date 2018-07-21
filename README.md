<h1 align="center">Experimental Penguins</h1>
<p align="center"><b>A blazing fast Experimental Penguins emulator, written in Node.js.</b></p>
<p align="center"><img src="https://vignette.wikia.nocookie.net/clubpenguin/images/0/00/Experimental_Penguins.png/revision/latest?cb=20160206070548"></p>
<p align="center"><img src="https://i.imgur.com/sDc8wdJ.png"></p> 

# Bugs

* Can't redirect POST request => [Issue](https://github.com/fastify/fastify/issues/1049)
* Missing 2 swfs for Experimental Penguins.

# Features

* Written to be simple, secure and fast.
* Extensive response validation using JSON.
* Uses no-cache to avoid SWFS getting cached.
* Supports <b>Experimental Penguins, Football Club Penguin Chat and Contact Music Penguin Chat.</b>
* So easy to setup that it feels instant.

# Installation - Windows

1. Download this repository.
2. Download & install the latest version of [Node.js](https://nodejs.org/en/)
3. Open CMD and enter this command: ```npm i fastify fastify-static fastify-formbody fastify-helmet fastify-no-cache underscore knex mysql2```
4. Download & install [XAMPP](https://www.apachefriends.org/index.html)
5. Open XAMPP and run MySQL (Do not run Apache as the Node.js server runs on port 80)
6. Import the database that you can find in <b>/setup/experimental.sql</b> by using a tool like [MySQL Workbench](https://dev.mysql.com/downloads/workbench/?utm_source=tuicool)
7. Change the options in <b>/setup/Config.json</b> to comfort your MySQL settings
8. Open CMD and CD to the folder where <b>Run.js</b> is located
9. Enter the following command to start the server: ```node Run.js```
10. Browse to http://127.0.0.1/ or your VPS domain/ip if you're running this behind a webserver

# Installation - Linux

1. Download this repository.
2. Download & install the latest version of [Node.js](https://nodejs.org/en/)
3. Execute the following command: ```npm i fastify fastify-static fastify-formbody fastify-helmet fastify-no-cache underscore knex mysql2```
4. Download & install [MySQL](https://www.mysql.com/)
5. Run MySQL and execute the command: <b>mysql -u username -p database_name < experimental.sql</b>
6. Change the options in <b>/setup/Config.json</b> to comfort your MySQL settings
7. CD to the folder where <b>Run.js</b> is located
8. Enter the following command to start the server: ```node Run.js```
9. Browse to http://127.0.0.1/ or your VPS domain/ip if you're running this behind a webserver