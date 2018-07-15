<h1 align="center">Penguin Chat JS</h1>
<p align="center">A Penguin Chat 2 emulator, written in Node.js with the use of Express to imitate PHP's long polling technique. Penguin Chat 2 originally used long polling, but we can use this in Node.js as well!</p>
<p align="center"><img src="https://i.imgur.com/sfH04Fn.png"></p>

## NOTE - FIGURING OUT THE SWF ISSUES, STAY TUNED.

# Installation

0. If you're running this on a VPS, install [NGINX](https://www.nginx.com/) and set this in the config of NGINX: <b>proxy_set_header X-Forwarded-For $remote_addr;</b>
1. Download this repository
2. Download & install [Node.js](https://nodejs.org/en/)
3. Run the following command in CMD: <b>npm install express knex mysql2</b>
4. Download & install MySQL for your OS (Windows, Linux etc)
5. Download & install [MySQL Workbench](https://www.mysql.com/products/workbench/) to <b>import</b>, browse and edit the database

# Run server

0. Make sure you did everything in <b>Installation</b> and <b>have MySQL running</b>
1. Open CMD
2. Use the [CD](https://ss64.com/nt/cd.html) command to CD to the folder where <b>Run.js</b> is located
3. Enter the command: <b>node Run.js</b>
4. Open a new webpage and browse to: <b>http://localhost/</b>

# TODO

Make the database class async and await?