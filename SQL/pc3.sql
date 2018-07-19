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
    `moderator` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Is penguin moderator',
    `banned` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Is penguin banned',
    PRIMARY KEY (`id`),
    UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=latin1 COMMENT='Penguins';

LOCK TABLE `penguins` WRITE;
INSERT INTO `penguins` VALUES (100, 'Daan', 'c91a3d3c2f7a413f804580d331ac9a5ae79a302070755ab478f4036bf9e1b8212faccd640de9e497908d9d33f57c68180a878a4db736d885912bb2df4c0cf490', 'YourMom@xd.com', '2018-07-14 13:24:31', 1, 0);
UNLOCK TABLES;

DROP TABLE IF EXISTS `stats`;
CREATE TABLE `stats` (
    `online` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Penguins online'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stats';

LOCK TABLE `stats` WRITE;
INSERT INTO `stats` VALUES (0);
UNLOCK TABLES;