SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
SET time_zone = "+00:00";

DROP TABLE IF EXISTS `penguins`;
CREATE TABLE `penguins` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
    `username` varchar(14) NOT NULL,
    `created` char(255) NOT NULL,
    `room` int(10) NOT NULL,
    `attributes` char(255) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=latin1;