CREATE DATABASE IF NOT EXISTS `PenguinChatJS`;

DROP TABLE IF EXISTS `penguins`;
CREATE TABLE `penguins` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Penguin ID',
	`username` varchar(12) NOT NULL COMMENT 'Penguin username',
	`password` char(255) NOT NULL COMMENT 'Penguin password in blake2s',
	`moderator` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Penguin moderator',
	PRIMARY KEY (`id`),
	UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=latin1 COMMENT='Penguins';

LOCK TABLE `penguins` WRITE;
INSERT INTO `penguins` VALUES (100, 'Daan', '82a1424e827c594ec1a9392c4d0a2e455131a0897f5bbb44e5563260ab8f9151', 1);
UNLOCK TABLES;