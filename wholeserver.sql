-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.6.36 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for test
DROP DATABASE IF EXISTS `test`;
CREATE DATABASE IF NOT EXISTS `test` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `test`;

-- Dumping structure for table test.coordinates
DROP TABLE IF EXISTS `coordinates`;
CREATE TABLE IF NOT EXISTS `coordinates` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- Dumping data for table test.coordinates: ~15 rows (approximately)
/*!40000 ALTER TABLE `coordinates` DISABLE KEYS */;
INSERT INTO `coordinates` (`id`, `x`, `y`, `z`) VALUES
	(1, 2222.84301757813, 5578.4443359375, 53.7291946411133),
	(2, 2352.2033691406, 3134.1745605469, 47.208702087402),
	(3, -1172.025878, -1575.5107421875, 3.38966178894),
	(4, 1685.48828125, -1442.7501220703, 112.20703125),
	(5, 2761.8466796875, 1467.1875, 24.501485824585),
	(6, 2565.5297851563, 396.72958374023, 107.46340179443),
	(7, 590.42272949219, 2744.7243652344, 41.048969268799),
	(8, 855.10955810547, -2113.8049316406, 30.575231552124),
	(9, 1389.425170898, 3604.7392578125, 37.941944122314),
	(10, 3266.9321289063, 5213.623046875, 18.617614746094),
	(11, 706.87115478516, -960.58551025391, 29.395351409912),
	(12, -110.0189743042, -1628.9012451172, 35.28896331787),
	(13, 2923.7082519531, 2798.2465820313, 40.145099639893),
	(14, 1114.2298583984, -2003.7059326172, 34.439407348633),
	(15, 2557.5266113281, 288.61724853516, 107.60833740234),
	(16, -1611.1496582031, 5260.99316406, 2.9741017),
	(17, 1453.3676757813, 3755.4489746094, 30.934200286865),
	(18, -1359.313476, -756.82067871, 21.30454826355),
	(19, 1114.2298583984, -2003.7059326172, 34.439407348633),
	(20, 2958.3999023438, 2776.0158691406, 39.00984954834),
	(21, -65.410736083984, -2229.8039550781, 6.8116698265076);
/*!40000 ALTER TABLE `coordinates` ENABLE KEYS */;

-- Dumping structure for procedure test.FixUsers
DROP PROCEDURE IF EXISTS `FixUsers`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `FixUsers`()
BEGIN
UPDATE users SET `enService` = 0 WHERE `enService` = 1;
END//
DELIMITER ;

-- Dumping structure for table test.garages
DROP TABLE IF EXISTS `garages`;
CREATE TABLE IF NOT EXISTS `garages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `x` decimal(10,2) NOT NULL,
  `y` decimal(10,2) NOT NULL,
  `z` decimal(10,2) NOT NULL,
  `price` int(11) NOT NULL,
  `blip_colour` int(255) NOT NULL,
  `blip_id` int(255) NOT NULL,
  `slot` int(255) NOT NULL,
  `available` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- Dumping data for table test.garages: ~1 rows (approximately)
/*!40000 ALTER TABLE `garages` DISABLE KEYS */;
INSERT INTO `garages` (`id`, `name`, `x`, `y`, `z`, `price`, `blip_colour`, `blip_id`, `slot`, `available`) VALUES
	(22, 'Public Garage', 214.12, -791.38, 29.65, 0, 3, 357, 99, 'on');
/*!40000 ALTER TABLE `garages` ENABLE KEYS */;

-- Dumping structure for table test.interiors
DROP TABLE IF EXISTS `interiors`;
CREATE TABLE IF NOT EXISTS `interiors` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'key id',
  `enter` text NOT NULL COMMENT 'enter coords',
  `exit` text NOT NULL COMMENT 'destination coords',
  `iname` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table test.interiors: ~2 rows (approximately)
/*!40000 ALTER TABLE `interiors` DISABLE KEYS */;
INSERT INTO `interiors` (`id`, `enter`, `exit`, `iname`) VALUES
	(1, '{-1045.888,-2751.017,21.3634,321.7075}', '{-1055.37,-2698.47,13.82,234.62}', 'first int'),
	(2, '{10.5031,-671.176094,32.4598, 0}', '{-0.4126,-706.239,15.1311, 14}', 'Vault');
/*!40000 ALTER TABLE `interiors` ENABLE KEYS */;

-- Dumping structure for table test.items
DROP TABLE IF EXISTS `items`;
CREATE TABLE IF NOT EXISTS `items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `isIllegal` tinyint(1) NOT NULL DEFAULT '0',
  `canUse` int(11) NOT NULL DEFAULT '0',
  `Amount` int(11) NOT NULL DEFAULT '0',
  `weight` int(11) NOT NULL DEFAULT '1',
  `sellPrice` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- Dumping data for table test.items: ~37 rows (approximately)
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` (`id`, `libelle`, `isIllegal`, `canUse`, `Amount`, `weight`, `sellPrice`) VALUES
	(1, 'Copper Bar', 0, 0, 0, 1, 0),
	(2, 'Copper Ore', 0, 0, 0, 1, 0),
	(3, 'Vodka', 0, 4, 0, 1, 0),
	(4, 'Cannabis', 1, 0, 0, 1, 0),
	(5, 'Corn Dog', 0, 2, 20, 1, 0),
	(6, 'Big Gulp', 0, 1, 20, 1, 0),
	(7, 'Coca', 0, 1, 0, 1, 0),
	(8, 'Weed', 1, 0, 0, 1, 0),
	(9, 'Casserole', 0, 0, 0, 1, 0),
	(10, 'Raisin', 0, 0, 0, 1, 0),
	(11, 'Piquette', 0, 0, 0, 1, 0),
	(12, 'Dirty Money', 1, 0, 0, 0, 0),
	(13, 'Ring', 0, 0, 0, 1, 2000),
	(14, 'Phone', 0, 0, 0, 1, 1000),
	(15, 'Rolex', 0, 0, 0, 1, 2000),
	(16, 'Laptop', 0, 0, 0, 1, 1500),
	(17, 'Camera', 0, 0, 0, 1, 800),
	(18, 'Glass eye', 0, 0, 0, 1, 1200),
	(19, 'Crude Oil', 0, 0, 0, 20, 0),
	(20, 'Gasoline', 0, 0, 0, 15, 0),
	(21, 'Cold medicine', 0, 0, 0, 10, 0),
	(22, 'Crystal Meth', 1, 0, 0, 5, 0),
	(23, 'Coca leaves', 1, 0, 0, 1, 0),
	(24, 'Cocaine', 1, 0, 0, 1, 0),
	(25, 'Trash', 0, 0, 0, 20, 0),
	(26, 'Plastic', 0, 0, 0, 25, 0),
	(27, 'Fuming Nitric Acid', 1, 0, 0, 20, 0),
	(28, 'Cheap Cell Phone', 0, 0, 0, 5, 0),
	(29, 'Coffee', 0, 1, 20, 1, 0),
	(30, 'Donuts', 0, 2, 20, 1, 0),
	(31, 'Repair Kit', 0, 3, 0, 10, 0),
	(32, 'Sulfur Ore', 0, 0, 0, 2, 0),
	(33, 'Sulfur Powder', 0, 0, 0, 1, 0),
	(34, 'Tree Stump Remover', 0, 0, 0, 1, 0),
	(35, 'Bag of Charcoal', 0, 0, 0, 15, 0),
	(36, 'Galvanized Steel Pipe', 0, 0, 0, 5, 0),
	(37, 'Gun Powder', 0, 0, 0, 1, 0),
	(38, 'Fishing Pole', 0, 0, 0, 5, 0),
	(39, 'Raw Fish', 0, 0, 0, 1, 0),
	(40, 'Filleted Fish', 0, 0, 0, 1, 0),
	(41, 'Iron Ore', 0, 0, 0, 1, 0),
	(42, 'Iron', 0, 0, 0, 1, 0);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;

-- Dumping structure for table test.jailedplayers
DROP TABLE IF EXISTS `jailedplayers`;
CREATE TABLE IF NOT EXISTS `jailedplayers` (
  `identifier` varchar(255) DEFAULT NULL,
  `timeleft` int(255) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table test.jailedplayers: ~0 rows (approximately)
/*!40000 ALTER TABLE `jailedplayers` DISABLE KEYS */;
/*!40000 ALTER TABLE `jailedplayers` ENABLE KEYS */;

-- Dumping structure for table test.jobs
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `job_id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(40) NOT NULL,
  `salary` int(11) NOT NULL DEFAULT '500',
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- Dumping data for table test.jobs: ~11 rows (approximately)
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs` (`job_id`, `job_name`, `salary`) VALUES
	(1, 'Unemployed', 500),
	(3, 'Lawer', 1200),
	(4, 'Sulfur Miner', 700),
	(5, 'Taxi driver', 1000),
	(6, 'Off duty cop', 900),
	(7, 'On duty cop', 1300),
	(10, 'Off Duty Medic', 900),
	(11, 'Medic', 1500),
	(12, 'Oil Manufacturer', 500),
	(13, 'Garbage Man', 600),
	(14, 'Trucker', 600),
	(15, 'Fisherman', 600),
	(16, 'Iron Miner', 500);
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;

-- Dumping structure for table test.modelmenu
DROP TABLE IF EXISTS `modelmenu`;
CREATE TABLE IF NOT EXISTS `modelmenu` (
  `identifier` varchar(50) DEFAULT NULL,
  `model` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT 'a_m_m_bevhills_02',
  `percing` int(11) NOT NULL DEFAULT '0',
  `percing_txt` int(11) NOT NULL DEFAULT '240',
  `glasses` int(11) NOT NULL DEFAULT '0',
  `glasses_txt` int(11) NOT NULL DEFAULT '240',
  `helmet` int(11) NOT NULL DEFAULT '0',
  `helmet_txt` int(11) NOT NULL DEFAULT '240',
  `mask` int(11) NOT NULL DEFAULT '0',
  `mask_txt` int(11) NOT NULL DEFAULT '240',
  `head` int(11) NOT NULL DEFAULT '0',
  `hair` int(11) NOT NULL DEFAULT '1',
  `hair_colour` int(11) NOT NULL DEFAULT '1',
  `shirt` int(11) NOT NULL DEFAULT '0',
  `shirt_txt` int(11) NOT NULL DEFAULT '0',
  `hand` int(11) NOT NULL DEFAULT '0',
  `shoe` int(11) NOT NULL DEFAULT '0',
  `shoe_txt` int(11) NOT NULL DEFAULT '0',
  `pants` int(11) NOT NULL DEFAULT '0',
  `pants_txt` int(11) NOT NULL DEFAULT '0',
  `undershirt` int(11) NOT NULL DEFAULT '0',
  `undershirt_txt` int(11) NOT NULL DEFAULT '240',
  `armour` int(11) NOT NULL DEFAULT '0',
  `armour_txt` int(11) NOT NULL DEFAULT '0',
  `mpmodel` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table test.modelmenu: ~26 rows (approximately)
/*!40000 ALTER TABLE `modelmenu` DISABLE KEYS */;
INSERT INTO `modelmenu` (`identifier`, `model`, `percing`, `percing_txt`, `glasses`, `glasses_txt`, `helmet`, `helmet_txt`, `mask`, `mask_txt`, `head`, `hair`, `hair_colour`, `shirt`, `shirt_txt`, `hand`, `shoe`, `shoe_txt`, `pants`, `pants_txt`, `undershirt`, `undershirt_txt`, `armour`, `armour_txt`, `mpmodel`) VALUES
	('steam:110000108ae15d4', 'mp_m_freemode_01', 0, 0, 0, 0, 9, 5, 0, 0, 3, 7, 5, 89, 0, 0, 6, 1, 5, 5, 2, 1, 1, 1, 1),
	('steam:110000105cc5fe0', 'mp_m_freemode_01', 10, 240, 13, 1, 9, 7, 0, 0, 14, 1, 1, 85, 0, 93, 12, 7, 9, 3, 0, 240, 0, 0, 1),
	('ip:50.36.163.98', 'a_m_m_bevhills_02', 0, 240, 0, 240, 0, 240, 0, 240, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0),
	('ip:88.236.135.16', 'a_m_m_bevhills_02', 0, 240, 0, 240, 0, 240, 0, 240, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0),
	('steam:110000101b35797', 'a_m_m_afriamer_01', 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 2, 0, 240, 0, 0, 0),
	('steam:11000010b79c26d', 'a_m_m_bevhills_02', 0, 240, 0, 240, 0, 240, 0, 240, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0),
	('steam:1100001069b1b80', 'a_m_m_bevhills_02', 0, 240, 0, 240, 0, 240, 0, 240, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0),
	('steam:110000106c709aa', 'a_m_m_bevhills_02', 0, 240, 0, 240, 0, 240, 0, 240, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0),
	('steam:1100001089d6023', 'a_f_y_juggalo_01', 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0),
	('steam:11000010ae2eea3', 'a_m_m_bevhills_02', 0, 240, 0, 240, 0, 240, 0, 240, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0),
	('steam:11000010b0cd32b', 'a_m_m_bevhills_02', 0, 240, 0, 240, 0, 240, 0, 240, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0),
	('steam:11000010cec6415', 'a_m_m_bevhills_02', 0, 240, 0, 240, 0, 240, 0, 240, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0),
	('steam:11000010d4dd063', 'mp_m_freemode_01', 0, 240, 5, 0, 0, 240, 0, 0, 44, 2, 4, 0, 2, 0, 32, 1, 4, 0, 0, 240, 0, 0, 1),
	('steam:11000010ac5591b', 'a_m_m_bevhills_02', 0, 240, 0, 240, 0, 240, 0, 240, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0),
	('steam:11000010741172d', 'a_m_m_bevhills_02', 0, 240, 0, 240, 0, 240, 0, 240, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0),
	('steam:110000115a0d026', 'a_m_m_bevhills_02', 0, 240, 0, 240, 0, 240, 0, 240, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0),
	('steam:1100001038ec4c4', 'a_m_m_bevhills_02', 0, 240, 0, 240, 0, 240, 0, 240, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0),
	('ip:66.94.195.161', 'a_m_m_bevhills_02', 0, 240, 0, 240, 0, 240, 0, 240, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0),
	('steam:110000119a1932e', 'a_m_m_bevhills_02', 0, 240, 0, 240, 0, 240, 0, 240, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0),
	('steam:110000107b948ff', 'a_m_m_bevhills_02', 0, 240, 0, 240, 0, 240, 0, 240, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0),
	('ip:23.28.21.20', 'a_m_m_bevhills_02', 0, 240, 0, 240, 0, 240, 0, 240, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0),
	('steam:110000117788d9b', 'a_m_m_bevhills_02', 0, 240, 0, 240, 0, 240, 0, 240, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0),
	('steam:11000010bd58ae2', 'a_m_m_bevhills_02', 0, 240, 0, 240, 0, 240, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0),
	('steam:11000010bd135a6', 'a_m_m_bevhills_02', 0, 240, 0, 240, 0, 240, 0, 240, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0),
	('steam:110000104ea6d5d', 'a_m_m_bevhills_02', 0, 240, 0, 240, 0, 240, 0, 240, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0),
	('ip:174.66.171.50', 'a_m_m_bevhills_02', 0, 240, 0, 240, 0, 240, 0, 240, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0),
	('steam:110000104e2e3d9', 'a_m_m_bevhills_02', 0, 240, 0, 240, 0, 240, 0, 240, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0);
/*!40000 ALTER TABLE `modelmenu` ENABLE KEYS */;

-- Dumping structure for table test.police
DROP TABLE IF EXISTS `police`;
CREATE TABLE IF NOT EXISTS `police` (
  `identifier` varchar(255) NOT NULL,
  `rank` varchar(255) NOT NULL DEFAULT 'Recruit',
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table test.police: ~8 rows (approximately)
/*!40000 ALTER TABLE `police` DISABLE KEYS */;
INSERT INTO `police` (`identifier`, `rank`) VALUES
	('steam:110000101b35797', 'Recruit'),
	('steam:110000105cc5fe0', 'Recruit'),
	('steam:1100001069b1b80', 'Recruit'),
	('steam:1100001089d6023', 'Recruit'),
	('steam:110000108ae15d4', 'Recruit'),
	('steam:11000010b79c26d', 'Recruit'),
	('steam:11000010cec6415', 'Recruit'),
	('steam:11000010d4dd063', 'Recruit'),
	('steam:110000119a1932e', 'Recruit');
/*!40000 ALTER TABLE `police` ENABLE KEYS */;

-- Dumping structure for table test.recolt
DROP TABLE IF EXISTS `recolt`;
CREATE TABLE IF NOT EXISTS `recolt` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `raw_id` int(11) unsigned DEFAULT NULL,
  `treated_id` int(11) unsigned DEFAULT NULL,
  `job_id` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `field_id` int(10) unsigned DEFAULT NULL,
  `treatment_id` int(10) unsigned DEFAULT NULL,
  `seller_id` int(10) unsigned DEFAULT NULL,
  `isLegal` int(11) NOT NULL DEFAULT '1',
  `minrand` int(11) NOT NULL DEFAULT '0',
  `maxrand` int(11) NOT NULL DEFAULT '0',
  `collectmarkername` varchar(50) NOT NULL DEFAULT '',
  `processmarkertag` varchar(50) NOT NULL DEFAULT '',
  `sellMarkerName` varchar(50) NOT NULL DEFAULT '',
  `HarvestTime` int(11) NOT NULL DEFAULT '4000',
  `ProcessTime` int(11) NOT NULL DEFAULT '4000',
  `harvestRadius` int(11) unsigned NOT NULL DEFAULT '5',
  `processRadius` int(11) unsigned NOT NULL DEFAULT '5',
  `sellRadius` int(11) unsigned NOT NULL DEFAULT '5',
  `ChangeOfExpolde1in1000` int(11) unsigned NOT NULL DEFAULT '0',
  `weaponToCollect` varchar(255) NOT NULL DEFAULT 'none',
  `harvestAnim` varchar(255) NOT NULL DEFAULT 'none',
  `harvestItemNeeded` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `raw_id` (`raw_id`),
  KEY `treated_id` (`treated_id`),
  KEY `job_id` (`job_id`),
  KEY `field_id` (`field_id`),
  KEY `treatment_id` (`treatment_id`),
  KEY `seller_id` (`seller_id`),
  CONSTRAINT `recolt_ibfk_1` FOREIGN KEY (`raw_id`) REFERENCES `items` (`id`),
  CONSTRAINT `recolt_ibfk_2` FOREIGN KEY (`treated_id`) REFERENCES `items` (`id`),
  CONSTRAINT `recolt_ibfk_4` FOREIGN KEY (`field_id`) REFERENCES `coordinates` (`id`),
  CONSTRAINT `recolt_ibfk_5` FOREIGN KEY (`treatment_id`) REFERENCES `coordinates` (`id`),
  CONSTRAINT `recolt_ibfk_6` FOREIGN KEY (`seller_id`) REFERENCES `coordinates` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Dumping data for table test.recolt: ~5 rows (approximately)
/*!40000 ALTER TABLE `recolt` DISABLE KEYS */;
INSERT INTO `recolt` (`ID`, `raw_id`, `treated_id`, `job_id`, `price`, `field_id`, `treatment_id`, `seller_id`, `isLegal`, `minrand`, `maxrand`, `collectmarkername`, `processmarkertag`, `sellMarkerName`, `HarvestTime`, `ProcessTime`, `harvestRadius`, `processRadius`, `sellRadius`, `ChangeOfExpolde1in1000`, `weaponToCollect`, `harvestAnim`, `harvestItemNeeded`) VALUES
	(1, 4, 8, 0, 0, 1, 2, 3, 0, 250, 450, '0', '0', '0', 4000, 4000, 10, 10, 10, 0, 'none', 'none', 0),
	(2, 19, 20, 12, 0, 4, 5, 6, 1, 3500, 4500, 'Oil Field', 'Oil Refinery', 'Oil Buyer', 120000, 70000, 5, 5, 5, 0, 'none', 'none', 0),
	(3, 21, 22, 0, 0, 7, 8, 9, 0, 2000, 3000, '0', '0', '0', 4000, 30000, 5, 5, 5, 40, 'none', 'none', 0),
	(4, 23, 24, 0, 0, 10, 11, 12, 0, 300, 550, '0', '0', '0', 4000, 4000, 5, 5, 5, 0, 'none', 'none', 0),
	(5, 32, 33, 4, 3000, 13, 14, 15, 1, 0, 0, 'Sulfur Mine', 'Sulfer Proccesing', 'Sulfer Buyer', 4000, 4000, 5, 2, 2, 0, 'WEAPON_POOLCUE', 'none', 0),
	(6, 39, 40, 15, 0, 16, 17, 18, 1, 400, 600, 'Fishing Docks', 'Fillet Station', 'Sushi Restaurant', 10000, 20000, 5, 5, 5, 0, 'none', 'world_human_stand_fishing', 38),
	(7, 41, 42, 16, 0, 19, 20, 21, 1, 150, 400, 'Iron Mine', 'Iron Processing', 'Iron Buyer', 4000, 4000, 5, 5, 5, 0, 'WEAPON_POOLCUE', 'none', 0);
/*!40000 ALTER TABLE `recolt` ENABLE KEYS */;

-- Dumping structure for table test.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `identifier` varchar(255) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `job` int(11) DEFAULT '1',
  `Weplicenselvl` int(11) NOT NULL DEFAULT '0',
  `enService` int(255) NOT NULL DEFAULT '0',
  `CanBeMedic` int(255) NOT NULL DEFAULT '0',
  `lastpos` varchar(255) DEFAULT '{-887.48388671875, -2311.68872070313,  -3.50776553153992, 142.503463745117}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table test.users: ~26 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`identifier`, `job`, `Weplicenselvl`, `enService`, `CanBeMedic`, `lastpos`) VALUES
	('steam:110000108ae15d4', 6, 3, 0, 1, '{-247.61911010742, -871.23638916016,  30.788675308228, 359.97048950195}'),
	('steam:110000105cc5fe0', 6, 3, 0, 1, '{-66.882316589355, -2231.3657226563,  7.8116698265076, 0}'),
	('ip:50.36.163.98', 1, 0, 0, 0, '{-887.48388671875, -2311.68872070313,  -3.50776553153992, 142.503463745117}'),
	('ip:88.236.135.16', 1, 0, 0, 0, '{-887.48388671875, -2311.68872070313,  -3.50776553153992, 142.503463745117}'),
	('steam:110000101b35797', 7, 3, 0, 0, '{251.92248535156, -1038.3986816406,  28.839653015137, 0}'),
	('steam:11000010b79c26d', 7, 3, 0, 0, '{239.17866516113, -858.82855224609,  29.640607833862, 8.0775890350342}'),
	('steam:1100001069b1b80', 7, 0, 0, 0, '{1634.9829101563, 2713.1560058594,  45.564937591553, 0}'),
	('steam:110000106c709aa', 1, 0, 0, 0, '{-887.48388671875, -2311.68872070313,  -3.50776553153992, 142.503463745117}'),
	('steam:1100001089d6023', 6, 0, 0, 0, '{-887.48388671875, -2311.68872070313,  -3.50776553153992, 142.503463745117}'),
	('steam:11000010ae2eea3', 1, 0, 0, 0, '{-887.48388671875, -2311.68872070313,  -3.50776553153992, 142.503463745117}'),
	('steam:11000010b0cd32b', 1, 0, 0, 0, '{-887.48388671875, -2311.68872070313,  -3.50776553153992, 142.503463745117}'),
	('steam:11000010cec6415', 6, 3, 0, 0, '{716.46801757813, -1088.8553466797,  21.939134597778, 0}'),
	('steam:11000010d4dd063', 13, 3, 0, 1, '{235.40058898926, -789.47625732422,  30.575523376465, 0}'),
	('steam:11000010ac5591b', 1, 0, 0, 0, '{-887.48388671875, -2311.68872070313,  -3.50776553153992, 142.503463745117}'),
	('steam:11000010741172d', 1, 0, 0, 0, '{458.94827270508, -993.0751953125,  25.317775726318, 0}'),
	('steam:110000115a0d026', 1, 0, 0, 0, '{447.75161743164, -992.52655029297,  29.56760597229, 0}'),
	('steam:1100001038ec4c4', 1, 0, 0, 0, '{-1050.2668457031, -2062.4519042969,  12.70555305481, 0}'),
	('ip:66.94.195.161', 1, 0, 0, 0, '{-887.48388671875, -2311.68872070313,  -3.50776553153992, 142.503463745117}'),
	('steam:110000119a1932e', 6, 3, 0, 0, '{444.72204589844, -985.89105224609,  30.689599990845, 0}'),
	('steam:110000107b948ff', 1, 0, 0, 0, '{-543.77508544922, -1186.1745605469,  18.429235458374, 0}'),
	('ip:23.28.21.20', 1, 0, 0, 0, '{-887.4892578125, -2311.6828613281,  -3.5124318599701, 0}'),
	('steam:110000117788d9b', 1, 0, 0, 0, '{212.56367492676, -817.73168945313,  29.884572982788, 0}'),
	('steam:11000010bd58ae2', 1, 0, 0, 0, '{223.32403564453, -798.50024414063,  30.671115875244, 0}'),
	('steam:11000010bd135a6', 1, 0, 0, 0, '{-506.77923583984, -2366.771484375,  -8.3546524047852, 0}'),
	('steam:110000104ea6d5d', 1, 0, 0, 0, '{818.70745849609, -1039.6337890625,  25.944780349731, 0}'),
	('ip:174.66.171.50', 1, 0, 0, 0, '{-927.27783203125, -2302.8740234375,  6.7090859413147, 0}'),
	('steam:110000104e2e3d9', 1, 0, 0, 0, '{-887.48956298828, -2311.6799316406,  -3.510068655014, 0}');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table test.user_garage
DROP TABLE IF EXISTS `user_garage`;
CREATE TABLE IF NOT EXISTS `user_garage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `garage_id` int(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table test.user_garage: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_garage` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_garage` ENABLE KEYS */;

-- Dumping structure for table test.user_inventory
DROP TABLE IF EXISTS `user_inventory`;
CREATE TABLE IF NOT EXISTS `user_inventory` (
  `user_id` varchar(255) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `item_id` int(11) unsigned NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  KEY `item_id` (`item_id`),
  CONSTRAINT `user_inventory_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table test.user_inventory: ~24 rows (approximately)
/*!40000 ALTER TABLE `user_inventory` DISABLE KEYS */;
INSERT INTO `user_inventory` (`user_id`, `item_id`, `quantity`) VALUES
	('steam:11000010b79c26d', 6, 14),
	('steam:11000010b79c26d', 5, 10),
	('steam:11000010b79c26d', 5, 10),
	('steam:110000101b35797', 6, 14),
	('steam:110000101b35797', 5, 10),
	('steam:1100001089d6023', 5, 6),
	('steam:1100001089d6023', 3, 2),
	('steam:1100001089d6023', 6, 7),
	('steam:11000010d4dd063', 6, 7),
	('steam:11000010d4dd063', 6, 7),
	('steam:11000010d4dd063', 5, 8),
	('steam:1100001069b1b80', 12, 20000),
	('steam:110000108ae15d4', 4, 9),
	('steam:110000105cc5fe0', 35, 1),
	('steam:110000105cc5fe0', 34, 29),
	('steam:110000105cc5fe0', 36, 1),
	('steam:110000105cc5fe0', 5, 3),
	('steam:110000105cc5fe0', 5, 3),
	('steam:110000108ae15d4', 6, 6),
	('steam:110000108ae15d4', 6, 6),
	('steam:110000108ae15d4', 6, 6),
	('steam:110000108ae15d4', 5, 7),
	('steam:110000108ae15d4', 5, 7),
	('steam:110000108ae15d4', 39, 36),
	('steam:110000108ae15d4', 38, 1),
	('steam:110000108ae15d4', 40, 1),
	('steam:110000105cc5fe0', 38, 2);
/*!40000 ALTER TABLE `user_inventory` ENABLE KEYS */;

-- Dumping structure for table test.user_vehicle
DROP TABLE IF EXISTS `user_vehicle`;
CREATE TABLE IF NOT EXISTS `user_vehicle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `vehicle_name` varchar(60) DEFAULT NULL,
  `vehicle_model` varchar(60) DEFAULT NULL,
  `vehicle_price` int(60) DEFAULT NULL,
  `vehicle_plate` varchar(60) DEFAULT NULL,
  `vehicle_state` varchar(60) DEFAULT NULL,
  `vehicle_colorprimary` varchar(60) DEFAULT NULL,
  `vehicle_colorsecondary` varchar(60) DEFAULT NULL,
  `vehicle_pearlescentcolor` varchar(60) DEFAULT NULL,
  `vehicle_wheelcolor` varchar(60) DEFAULT NULL,
  `vehicle_plateindex` varchar(255) DEFAULT NULL,
  `vehicle_neoncolor1` varchar(255) DEFAULT NULL,
  `vehicle_neoncolor2` varchar(255) DEFAULT NULL,
  `vehicle_neoncolor3` varchar(25) DEFAULT NULL,
  `vehicle_windowtint` varchar(255) DEFAULT NULL,
  `vehicle_wheeltype` varchar(255) DEFAULT NULL,
  `vehicle_mods0` varchar(255) DEFAULT NULL,
  `vehicle_mods1` varchar(255) DEFAULT NULL,
  `vehicle_mods2` varchar(255) DEFAULT NULL,
  `vehicle_mods3` varchar(255) DEFAULT NULL,
  `vehicle_mods4` varchar(255) DEFAULT NULL,
  `vehicle_mods5` varchar(255) DEFAULT NULL,
  `vehicle_mods6` varchar(255) DEFAULT NULL,
  `vehicle_mods7` varchar(255) DEFAULT NULL,
  `vehicle_mods8` varchar(255) DEFAULT NULL,
  `vehicle_mods9` varchar(255) DEFAULT NULL,
  `vehicle_mods10` varchar(255) DEFAULT NULL,
  `vehicle_mods11` varchar(255) DEFAULT NULL,
  `vehicle_mods12` varchar(255) DEFAULT NULL,
  `vehicle_mods13` varchar(255) DEFAULT NULL,
  `vehicle_mods14` varchar(255) DEFAULT NULL,
  `vehicle_mods15` varchar(255) DEFAULT NULL,
  `vehicle_mods16` varchar(255) DEFAULT NULL,
  `vehicle_turbo` varchar(255) NOT NULL DEFAULT 'off',
  `vehicle_tiresmoke` varchar(255) NOT NULL DEFAULT 'off',
  `vehicle_xenon` varchar(255) NOT NULL DEFAULT 'off',
  `vehicle_mods23` varchar(255) DEFAULT NULL,
  `vehicle_mods24` varchar(255) DEFAULT NULL,
  `vehicle_neon0` varchar(255) DEFAULT NULL,
  `vehicle_neon1` varchar(255) DEFAULT NULL,
  `vehicle_neon2` varchar(255) DEFAULT NULL,
  `vehicle_neon3` varchar(255) DEFAULT NULL,
  `vehicle_bulletproof` varchar(255) DEFAULT NULL,
  `vehicle_smokecolor1` varchar(255) DEFAULT NULL,
  `vehicle_smokecolor2` varchar(255) DEFAULT NULL,
  `vehicle_smokecolor3` varchar(255) DEFAULT NULL,
  `vehicle_modvariation` varchar(255) NOT NULL DEFAULT 'off',
  `instance` int(255) DEFAULT NULL,
  `playername` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- Dumping data for table test.user_vehicle: ~24 rows (approximately)
/*!40000 ALTER TABLE `user_vehicle` DISABLE KEYS */;
INSERT INTO `user_vehicle` (`id`, `identifier`, `vehicle_name`, `vehicle_model`, `vehicle_price`, `vehicle_plate`, `vehicle_state`, `vehicle_colorprimary`, `vehicle_colorsecondary`, `vehicle_pearlescentcolor`, `vehicle_wheelcolor`, `vehicle_plateindex`, `vehicle_neoncolor1`, `vehicle_neoncolor2`, `vehicle_neoncolor3`, `vehicle_windowtint`, `vehicle_wheeltype`, `vehicle_mods0`, `vehicle_mods1`, `vehicle_mods2`, `vehicle_mods3`, `vehicle_mods4`, `vehicle_mods5`, `vehicle_mods6`, `vehicle_mods7`, `vehicle_mods8`, `vehicle_mods9`, `vehicle_mods10`, `vehicle_mods11`, `vehicle_mods12`, `vehicle_mods13`, `vehicle_mods14`, `vehicle_mods15`, `vehicle_mods16`, `vehicle_turbo`, `vehicle_tiresmoke`, `vehicle_xenon`, `vehicle_mods23`, `vehicle_mods24`, `vehicle_neon0`, `vehicle_neon1`, `vehicle_neon2`, `vehicle_neon3`, `vehicle_bulletproof`, `vehicle_smokecolor1`, `vehicle_smokecolor2`, `vehicle_smokecolor3`, `vehicle_modvariation`, `instance`, `playername`) VALUES
	(12, 'steam:110000108ae15d4', 'Z-Type', 'ztype', 950000, '07ZVX461', 'In', '83', '131', '4', '156', '0', '255', '0', '255', '-1', '2', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '2', '-1', '-1', '-1', '-1', '4', 'off', 'off', 'off', '-1', '-1', 'off', 'off', 'off', 'off', 'off', '255', '255', '255', 'off', 0, 'Harold Haroldson'),
	(13, 'steam:110000105cc5fe0', 'Adder', 'adder', 1000000, '06VKM194', 'In', '1', '0', '7', '156', '0', '255', '0', '255', '-1', '7', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', 'off', 'off', 'off', '-1', '-1', 'off', 'off', 'off', 'off', 'off', '255', '255', '255', 'off', 0, 'Mort Yellow'),
	(14, 'steam:11000010b79c26d', 'Omnis', 'omnis', 701000, '64TXE567', 'In', '55', '92', '5', '111', '0', '255', '0', '255', '-1', '0', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', 'off', 'off', 'off', '-1', '-1', 'off', 'off', 'off', 'off', 'off', '255', '255', '255', 'off', 0, 'Eddie Madrazo'),
	(15, 'steam:110000108ae15d4', 'Buccaneer', 'buccaneer', 29000, '04QZP376', 'In', '36', '36', '0', '156', '0', '255', '0', '255', '-1', '1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', 'off', 'off', 'off', '-1', '-1', 'off', 'off', 'off', 'off', 'off', '255', '255', '255', 'off', 0, 'Harold Haroldson'),
	(17, 'steam:110000105cc5fe0', 'Bestia GTS', 'bestiagts', 610000, '25DKH862', 'In', '33', '40', '29', '156', '0', '255', '0', '255', '-1', '7', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', 'off', 'off', 'off', '-1', '-1', 'off', 'off', 'off', 'off', 'off', '255', '255', '255', 'off', 0, 'Mort Yellow'),
	(22, 'steam:11000010b79c26d', 'Trophy Truck', 'trophytruck', 550000, '47ONA170', 'In', '1', '38', '5', '156', '0', '255', '0', '255', '-1', '4', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', 'off', 'off', 'off', '-1', '-1', 'off', 'off', 'off', 'off', 'off', '255', '255', '255', 'off', 0, 'Eddie Madrazo'),
	(23, 'steam:11000010d4dd063', 'The Liberator', 'monster', 550000, '06AXK284', 'In', '111', '29', '111', '156', '0', '255', '0', '255', '-1', '3', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', 'off', 'off', 'off', '-1', '-1', 'off', 'off', 'off', 'off', 'on', '255', '255', '255', 'off', 0, 'Dess Green'),
	(24, 'steam:110000101b35797', 'X80 Proto', 'prototipo', 2700000, '82ETO388', 'In', '64', '75', '5', '0', '0', '255', '0', '255', '-1', '7', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', 'off', 'off', 'off', '-1', '-1', 'off', 'off', 'off', 'off', 'off', '255', '255', '255', 'off', 0, 'Mr. Tate'),
	(25, 'steam:110000101b35797', 'T20', 't20', 2200000, '63VMY134', 'In', '12', '83', '3', '147', '0', '0', '0', '255', '1', '0', '-1', '1', '1', '0', '1', '-1', '-1', '1', '-1', '-1', '0', '2', '2', '2', '1', '-1', '4', 'on', 'on', 'on', '20', '-1', 'on', 'on', 'on', 'on', 'on', '0', '150', '255', 'off', 0, 'Mr. Tate'),
	(26, 'steam:11000010cec6415', 'X80 Proto', 'prototipo', 2700000, '08SDI311', 'In', '5', '9', '5', '0', '0', '255', '0', '255', '-1', '7', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', 'off', 'off', 'off', '-1', '-1', 'off', 'off', 'off', 'off', 'off', '255', '255', '255', 'off', 0, 'Mr. Monkey'),
	(27, 'steam:11000010cec6415', 'Zentorno', 'zentorno', 725000, '25MTV739', 'In', '4', '41', '111', '156', '0', '255', '0', '255', '-1', '7', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', 'off', 'off', 'off', '-1', '-1', 'off', 'off', 'off', 'off', 'off', '255', '255', '255', 'off', 0, 'Mr. Monkey'),
	(28, 'steam:110000108ae15d4', 'Ferrari California', 'FCT', 650000, '28BRI838', 'In', '0', '2', '122', '156', '0', '255', '0', '255', '-1', '7', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', 'off', 'off', 'off', '-1', '-1', 'off', 'off', 'off', 'off', 'off', '255', '255', '255', 'off', 0, 'Harold Haroldson'),
	(29, 'steam:11000010d4dd063', 'X80 Proto', 'prototipo', 2700000, '87AFT116', 'In', '27', '1', '5', '0', '0', '255', '0', '255', '-1', '7', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', 'off', 'off', 'off', '-1', '-1', 'off', 'off', 'off', 'off', 'off', '255', '255', '255', 'off', 0, 'Dess Green'),
	(30, 'steam:110000101b35797', 'ETR1', 'sheava', 199500, '45GTE330', 'In', '64', '42', '5', '0', '1', '0', '0', '255', '1', '0', '3', '1', '0', '-1', '0', '-1', '-1', '0', '-1', '-1', '1', '2', '2', '2', '-1', '-1', '4', 'on', 'on', 'on', '20', '-1', 'on', 'on', 'on', 'on', 'on', '0', '150', '255', 'on', 0, 'Mr. Tate'),
	(31, 'steam:11000010bd58ae2', 'Fugitive', 'fugitive', 24000, '09CPW010', 'Out', '4', '0', '111', '156', '0', '255', '0', '255', '-1', '0', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', 'off', 'off', 'off', '-1', '-1', 'off', 'off', 'off', 'off', 'off', '255', '255', '255', 'off', 241922, 'Pitchit'),
	(32, 'steam:11000010bd58ae2', 'Rumpo', 'rumpo', 13000, '88VUE686', 'Out', '4', '0', '111', '156', '0', '255', '0', '255', '-1', '1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', 'off', 'off', 'off', '-1', '-1', 'off', 'off', 'off', 'off', 'off', '255', '255', '255', 'off', NULL, 'Pitchit'),
	(34, 'steam:110000108ae15d4', 'Yamaha YZF-R1', 'r1', 30000, '68RCG840', 'In', '145', '112', '112', '156', '3', '255', '0', '255', '-1', '6', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', 'off', 'off', 'off', '-1', '-1', 'off', 'off', 'off', 'off', 'off', '255', '255', '255', 'off', 0, 'Harold Haroldson'),
	(35, 'steam:110000108ae15d4', '2016 Range Rover Sport', 'RSVR16', 140000, '63DTA427', 'In', '0', '0', '6', '156', '2', '255', '0', '255', '-1', '3', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', 'off', 'off', 'off', '-1', '-1', 'off', 'off', 'off', 'off', 'off', '255', '255', '255', 'off', 0, 'Harold Haroldson'),
	(36, 'steam:110000105cc5fe0', 'BMW M4 F82', 'M4F82', 190000, '00FNT057', 'In', '8', '8', '134', '156', '0', '255', '0', '255', '-1', '0', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', 'off', 'off', 'off', '-1', '-1', 'off', 'off', 'off', 'off', 'off', '255', '255', '255', 'off', 0, 'Mort Yellow'),
	(37, 'steam:110000105cc5fe0', '9F Cabrio', 'ninef2', 130000, '47DNG559', 'In', '34', '12', '29', '156', '0', '255', '0', '255', '-1', '7', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', 'off', 'off', 'off', '-1', '-1', 'off', 'off', 'off', 'off', 'off', '255', '255', '255', 'off', 0, 'Mort Yellow'),
	(38, 'steam:110000105cc5fe0', 'BF400', 'bf400', 95000, '83BXI809', 'In', '0', '4', '5', '112', '0', '255', '0', '255', '-1', '6', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', 'off', 'off', 'off', '-1', '-1', 'off', 'off', 'off', 'off', 'off', '255', '255', '255', 'off', 0, 'Mort Yellow'),
	(39, 'steam:110000105cc5fe0', 'Cognoscenti Cabrio', 'cogcabrio', 32000, '05YEV254', 'In', '2', '1', '24', '156', '0', '255', '0', '255', '-1', '0', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', 'off', 'off', 'off', '-1', '-1', 'off', 'off', 'off', 'off', 'off', '255', '255', '255', 'off', 0, 'Mort Yellow'),
	(40, 'steam:110000108ae15d4', '1999 Dodge Ram', 'ram99', 19000, '48EPS644', 'In', '2', '2', '7', '156', '1', '255', '0', '255', '-1', '3', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', 'off', 'off', 'off', '-1', '-1', 'off', 'off', 'off', 'off', 'off', '255', '255', '255', 'off', 0, 'Harold Haroldson'),
	(41, 'steam:11000010d4dd063', 'Porche 911 Turbo', '911Turbos', 365000, '63LVT612', 'Out', '8', '8', '134', '156', '0', '255', '0', '255', '-1', '0', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', '-1', 'off', 'off', 'off', '-1', '-1', 'off', 'off', 'off', 'off', 'off', '255', '255', '255', 'off', 1026, 'Dess Green');
/*!40000 ALTER TABLE `user_vehicle` ENABLE KEYS */;

-- Dumping structure for table test.user_weapons
DROP TABLE IF EXISTS `user_weapons`;
CREATE TABLE IF NOT EXISTS `user_weapons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `weapon_model` varchar(255) NOT NULL,
  `withdraw_cost` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8;

-- Dumping data for table test.user_weapons: ~23 rows (approximately)
/*!40000 ALTER TABLE `user_weapons` DISABLE KEYS */;
INSERT INTO `user_weapons` (`id`, `identifier`, `weapon_model`, `withdraw_cost`) VALUES
	(8, 'steam:110000101b35797', 'WEAPON_Gusenberg', 0),
	(11, 'steam:110000101b35797', 'WEAPON_AssaultSMG', 0),
	(12, 'steam:110000101b35797', 'WEAPON_SMG', 0),
	(13, 'steam:110000101b35797', 'WEAPON_CombatPDW', 0),
	(14, 'steam:110000101b35797', 'WEAPON_MiniSMG', 0),
	(16, 'steam:110000101b35797', 'WEAPON_MachinePistol', 0),
	(17, 'steam:110000101b35797', 'WEAPON_MicroSMG', 0),
	(19, 'steam:110000101b35797', 'WEAPON_PISTOL50', 0),
	(20, 'steam:110000101b35797', 'WEAPON_HeavyPistol', 0),
	(21, 'steam:110000119a1932e', 'WEAPON_CombatPDW', 0),
	(22, 'steam:110000119a1932e', 'WEAPON_Pistol', 0),
	(23, 'steam:110000119a1932e', 'WEAPON_MicroSMG', 0),
	(28, 'steam:110000119a1932e', 'WEAPON_SMG', 0),
	(29, 'steam:110000119a1932e', 'WEAPON_AssaultSMG', 0),
	(30, 'steam:110000119a1932e', 'WEAPON_CombatPDW', 0),
	(34, 'steam:11000010cec6415', 'WEAPON_MachinePistol', 0),
	(54, 'steam:11000010cec6415', 'WEAPON_CombatPDW', 0),
	(55, 'steam:11000010cec6415', 'WEAPON_Gusenberg', 0),
	(70, 'steam:110000105cc5fe0', 'WEAPON_POOLCUE', 0),
	(74, 'steam:110000105cc5fe0', 'WEAPON_HAMMER', 0),
	(75, 'steam:110000105cc5fe0', 'WEAPON_CROWBAR', 0),
	(83, 'steam:110000108ae15d4', 'WEAPON_SawnoffShotgun', 0),
	(84, 'steam:110000108ae15d4', 'WEAPON_CROWBAR', 0),
	(85, 'steam:110000105cc5fe0', 'WEAPON_DBSHOTGUN', 0),
	(86, 'steam:110000105cc5fe0', 'WEAPON_DBSHOTGUN', 0),
	(87, 'steam:110000105cc5fe0', 'WEAPON_BullpupShotgun', 0),
	(88, 'steam:110000105cc5fe0', 'WEAPON_SniperRifle', 0),
	(89, 'steam:110000105cc5fe0', 'WEAPON_DBSHOTGUN', 0),
	(90, 'steam:110000105cc5fe0', 'WEAPON_BullpupShotgun', 0),
	(91, 'steam:110000105cc5fe0', 'WEAPON_SniperRifle', 0);
/*!40000 ALTER TABLE `user_weapons` ENABLE KEYS */;

-- Dumping structure for table test.vehicles
DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE IF NOT EXISTS `vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` int(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `catergory` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=190 DEFAULT CHARSET=utf8;

-- Dumping data for table test.vehicles: ~125 rows (approximately)
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
INSERT INTO `vehicles` (`id`, `name`, `price`, `model`, `catergory`) VALUES
	(1, 'Blista', 9500, 'blista', 'compacts'),
	(2, 'Brioso R/A', 11500, 'brioso', 'compacts'),
	(3, 'Dilettante', 13000, 'Dilettante', 'compacts'),
	(4, 'Issi', 8000, 'issi2', 'compacts'),
	(5, 'Panto', 7500, 'panto', 'compacts'),
	(6, 'Prairie', 15000, 'prairie', 'compacts'),
	(7, 'Rhapsody', 13500, 'rhapsody', 'compacts'),
	(8, 'Cognoscenti Cabrio', 32000, 'cogcabrio', 'coupes'),
	(9, 'Exemplar', 41000, 'exemplar', 'coupes'),
	(10, 'F620', 65000, 'f620', 'coupes'),
	(11, 'Felon', 46000, 'felon', 'coupes'),
	(12, 'Felon GT', 40000, 'felon2', 'coupes'),
	(13, 'Jackal', 36000, 'jackal', 'coupes'),
	(14, 'Oracle', 29000, 'oracle', 'coupes'),
	(15, 'Oracle XS', 33000, 'oracle2', 'coupes'),
	(16, 'Sentinel', 35000, 'sentinel', 'coupes'),
	(17, 'Sentinel XS', 40000, 'sentinel2', 'coupes'),
	(18, 'Windsor', 75000, 'windsor', 'coupes'),
	(19, 'Windsor Drop', 68000, 'windsor2', 'coupes'),
	(20, 'Zion', 41000, 'zion', 'coupes'),
	(21, 'Zion Cabrio', 41000, 'zion2', 'coupes'),
	(24, 'Alpha', 57000, 'alpha', 'sports'),
	(25, 'Banshee', 155000, 'banshee', 'sports'),
	(26, 'Bestia GTS', 85000, 'bestiagts', 'sports'),
	(34, 'Feltzer', 66000, 'feltzer2', 'sports'),
	(44, 'Penumbra', 24000, 'penumbra', 'sports'),
	(46, 'Rapid GT Convertible', 63000, 'rapidgt2', 'sports'),
	(47, 'Schafter V12', 160000, 'schafter3', 'sports'),
	(48, 'Sultan', 41000, 'sultan', 'sports'),
	(49, 'Surano', 61000, 'surano', 'sports'),
	(52, 'Casco 1', 48000, 'casco', 'sportsclassics'),
	(53, 'Coquette Classic', 56500, 'coquette2', 'sportsclassics'),
	(55, 'Pigalle', 29500, 'pigalle', 'sportsclassics'),
	(56, 'Stinger', 42500, 'stinger', 'sportsclassics'),
	(57, 'Stinger GT', 52500, 'stingergt', 'sportsclassics'),
	(58, 'Stirling GT', 54500, 'feltzer3', 'sportsclassics'),
	(79, 'Blade', 27500, 'blade', 'muscle'),
	(80, 'Buccaneer', 38500, 'buccaneer', 'muscle'),
	(81, 'Chino', 40500, 'chino', 'muscle'),
	(82, 'Coquette BlackFin', 52000, 'coquette3', 'muscle'),
	(84, 'Dukes', 41000, 'dukes', 'muscle'),
	(85, 'Gauntlet', 62000, 'gauntlet', 'muscle'),
	(87, 'Faction', 20000, 'faction', 'muscle'),
	(89, 'Picador', 18000, 'picador', 'muscle'),
	(90, 'Sabre Turbo', 36000, 'sabregt', 'muscle'),
	(91, 'Tampa', 57000, 'tampa', 'muscle'),
	(92, 'Virgo', 24000, 'virgo', 'muscle'),
	(93, 'Vigero', 34000, 'vigero', 'muscle'),
	(95, 'Blazer', 8000, 'blazer', 'offroad'),
	(98, 'Dune Buggy', 15000, 'dune', 'offroad'),
	(99, 'Rebel', 22000, 'rebel2', 'offroad'),
	(100, 'Sandking', 38000, 'sandking', 'offroad'),
	(102, 'Trophy Truck', 135000, 'trophytruck', 'offroad'),
	(103, 'Baller', 52000, 'baller', 'suvs'),
	(104, 'Cavalcade', 44000, 'cavalcade', 'suvs'),
	(105, 'Grabger', 36000, 'granger', 'suvs'),
	(106, 'Huntley S', 51000, 'huntley', 'suvs'),
	(107, 'Landstalker', 39000, 'landstalker', 'suvs'),
	(108, 'Radius', 32000, 'radi', 'suvs'),
	(109, 'Rocoto', 30000, 'rocoto', 'suvs'),
	(110, 'Seminole', 36000, 'seminole', 'suvs'),
	(111, 'XLS', 43000, 'xls', 'suvs'),
	(112, 'Bison', 30000, 'bison', 'vans'),
	(113, 'Bobcat XL', 23000, 'bobcatxl', 'vans'),
	(115, 'Journey', 15000, 'journey', 'vans'),
	(116, 'Minivan', 22000, 'minivan', 'vans'),
	(117, 'Paradise', 25000, 'paradise', 'vans'),
	(118, 'Rumpo', 13000, 'rumpo', 'vans'),
	(119, 'Surfer', 11000, 'surfer', 'vans'),
	(120, 'Youga', 16000, 'youga', 'vans'),
	(121, 'Asea', 10500, 'asea', 'sedans'),
	(122, 'Asterope', 17500, 'asterope', 'sedans'),
	(123, 'Fugitive', 22000, 'fugitive', 'sedans'),
	(124, 'Glendale', 9000, 'glendale', 'sedans'),
	(125, 'Ingot', 9000, 'ingot', 'sedans'),
	(126, 'Intruder', 16000, 'intruder', 'sedans'),
	(127, 'Premier', 10000, 'premier', 'sedans'),
	(128, 'Primo', 9000, 'primo', 'sedans'),
	(129, 'Primo Custom', 15000, 'primo2', 'sedans'),
	(130, 'Regina', 8000, 'regina', 'sedans'),
	(131, 'Schafter', 65000, 'schafter2', 'sedans'),
	(132, 'Stanier', 10000, 'stanier', 'sedans'),
	(133, 'Stratum', 10000, 'stratum', 'sedans'),
	(134, 'Stretch', 60000, 'stretch', 'sedans'),
	(135, 'Super Diamond', 95000, 'superd', 'sedans'),
	(136, 'Surge', 26000, 'surge', 'sedans'),
	(137, 'Tailgater', 37000, 'tailgater', 'sedans'),
	(138, 'Warrener', 12500, 'warrener', 'sedans'),
	(139, 'Washington', 15000, 'washington', 'sedans'),
	(140, 'Akuma', 12000, 'AKUMA', 'motorcycles'),
	(141, 'Bagger', 11000, 'bagger', 'motorcycles'),
	(144, 'BF400', 8000, 'bf400', 'motorcycles'),
	(145, 'Carbon RS', 23000, 'carbonrs', 'motorcycles'),
	(146, 'Cliffhanger', 21000, 'cliffhanger', 'motorcycles'),
	(147, 'Daemon', 16000, 'daemon', 'motorcycles'),
	(148, 'Double T', 19000, 'double', 'motorcycles'),
	(149, 'Enduro', 3000, 'enduro', 'motorcycles'),
	(150, 'Faggio', 2000, 'faggio2', 'motorcycles'),
	(152, 'Hakuchou', 46000, 'hakuchou', 'motorcycles'),
	(153, 'Hexer', 15000, 'hexer', 'motorcycles'),
	(154, 'Innovation', 18500, 'innovation', 'motorcycles'),
	(155, 'Lectro', 17000, 'lectro', 'motorcycles'),
	(156, 'Nemesis', 12000, 'nemesis', 'motorcycles'),
	(157, 'PCJ-600', 11000, 'pcj', 'motorcycles'),
	(158, 'Ruffian', 9000, 'ruffian', 'motorcycles'),
	(159, 'Sanchez', 7000, 'sanchez', 'motorcycles'),
	(160, 'Sovereign', 24000, 'sovereign', 'motorcycles'),
	(162, 'Vader', 9000, 'vader', 'motorcycles'),
	(164, 'Ferrari California', 320000, 'FCT', 'customCars'),
	(165, 'Yamaha YZF-R6', 45000, 'r6', 'customBikes'),
	(166, 'Porche 911 Turbo', 365000, '911Turbos', 'customCars'),
	(167, '2016 Range Rover Sport', 220000, 'RSVR16', 'customCars'),
	(168, 'BMW M4 F82', 340000, 'M4F82', 'customCars'),
	(169, 'Audi R8', 235000, 'ARV10', 'customCars'),
	(170, 'Mercedes-Benz S600 W220', 42000, 's600w220', 'customCars'),
	(171, 'Yamaha YZF-R1', 30000, 'r1', 'customBikes'),
	(172, 'GMC Yukon Denali', 55000, 'GMCYD', 'customCars'),
	(174, '2017 Bentley Bentayga', 195000, 'bentayga17', 'customCars'),
	(175, 'Dinka Flash', 37000, 'flash', 'customCars'),
	(176, '1999 Dodge Ram', 19000, 'ram99', 'customCars'),
	(177, '2016 Dodge Charger SRT', 61000, '16CHARGER', 'customCars'),
	(178, '2003 Audi RS6', 35000, 'C5RS6', 'customCars'),
	(179, '1982 Porche Turbo', 110000, 'TURBO33', 'customCars'),
	(180, '2008 F-350 Super Duty', 34000, 'TURBO33', 'customCars'),
	(181, 'Honda Civic', 13000, 'ek9', 'customCars'),
	(182, 'Mercedes-Benz W210', 25000, 'w210amg', 'customCars'),
	(183, 'Chevy Suburban', 72000, 'SUBN', 'customCars'),
	(184, 'Subaru BRZ', 147000, 'BRZBV3', 'customCars'),
	(185, 'BMW E30 325i', 34500, 'BLZE30', 'customCars'),
	(186, 'BMW E36 328i M-Sport', 40500, 'E36a', 'customCars'),
	(188, 'Mitsubishi Lancer Evolution X', 138000, 'LANEX400', 'customCars'),
	(189, 'Lexus RC350', 115000, 'RC350', 'customCars');
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;

-- Dumping structure for table test.vehicle_inventory
DROP TABLE IF EXISTS `vehicle_inventory`;
CREATE TABLE IF NOT EXISTS `vehicle_inventory` (
  `plate` varchar(50) NOT NULL,
  `item` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `IsGarb` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table test.vehicle_inventory: ~5 rows (approximately)
/*!40000 ALTER TABLE `vehicle_inventory` DISABLE KEYS */;
INSERT INTO `vehicle_inventory` (`plate`, `item`, `quantity`, `IsGarb`) VALUES
	('06VKM194', 6, 1, 0),
	('25DKH862', 6, 5, 0),
	('44NHW516', 8, 1, 0),
	('44NHW516', 6, 2, 0),
	('28BRI838', 19, 1, 0);
/*!40000 ALTER TABLE `vehicle_inventory` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
