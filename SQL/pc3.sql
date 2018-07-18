SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
SET time_zone = "+00:00";

DROP TABLE IF EXISTS `penguins`;
CREATE TABLE `penguins` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Penguin ID',
	`username` varchar(12) NOT NULL COMMENT 'Penguin username',
	`password` char(255) NOT NULL COMMENT 'Penguin password',
	`email` char(255) NOT NULL COMMENT 'Penguin email',
	`created` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'Penguin creation date',
	PRIMARY KEY (`id`),
	UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=latin1 COMMENT='Penguins';

LOCK TABLE `penguins` WRITE;
INSERT INTO `penguins` VALUES (100, 'Daan', '82a1424e827c594ec1a9392c4d0a2e455131a0897f5bbb44e5563260ab8f9151', 'YourMom@xd.com', '2018-07-14 13:24:31');
UNLOCK TABLES;