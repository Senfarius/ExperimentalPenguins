-- phpMyAdmin SQL Dump
-- version 4.8.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Gegenereerd op: 14 jul 2018 om 13:26
-- Serverversie: 10.1.33-MariaDB
-- PHP-versie: 7.2.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pc2`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `penguins`
--

DROP TABLE IF EXISTS `penguins`;
CREATE TABLE `penguins` (
    `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Penguin ID',
    `username` varchar(12) NOT NULL COMMENT 'Penguin username',
    `created` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'Penguin creation date',
    `ip` char(255) NOT NULL DEFAULT '' COMMENT 'Penguin IP',
    `room` int(11) NOT NULL DEFAULT 1 COMMENT 'Penguin room',
    `mod` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Penguin moderator',
    PRIMARY KEY (`id`),
    UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=latin1 COMMENT='Penguins';

--
-- Gegevens worden geëxporteerd voor tabel `penguins`
--

LOCK TABLE `penguins` WRITE;
INSERT INTO `penguins` VALUES (100, 'Daan', '2018-07-14 13:24:31', '127.0.0.1', 1, 1);
UNLOCK TABLES;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;