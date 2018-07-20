SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
SET time_zone = "+00:00";

DROP TABLE IF EXISTS `penguins`;
CREATE TABLE `penguins` (
    `username` varchar(14) NOT NULL,
    `created` char(255) NOT NULL,
    `room` int(10) NOT NULL,
    `key` char(255) NOT NULL,
    `attributes` char(255) NOT NULL,
    UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;