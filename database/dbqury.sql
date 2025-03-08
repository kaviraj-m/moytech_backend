-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: test
-- ------------------------------------------------------
-- Server version	5.7.44-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `location` varchar(255) NOT NULL,
  `event_type` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_events_date` (`date`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,'Kumar Wedding','2024-02-15 04:30:00','Sri Mahal, Madurai','Wedding','2025-02-26 10:40:01','2025-02-26 10:40:01'),(2,'Rajan Housewarming','2024-03-01 03:30:00','123 New Street, Coimbatore','Housewarming','2025-02-26 10:40:01','2025-02-26 10:40:01'),(4,'Rajan Housewarming','2024-03-01 03:30:00','123 New Street, Coimbatore','Housewarming','2025-02-26 10:40:01','2025-02-26 10:40:01'),(5,'Priya Wedding Reception','2024-03-20 13:00:00','Green Gardens, Chennai','Wedding','2025-02-26 10:40:01','2025-02-26 10:40:01'),(6,'Muthu Priya Marriage','2025-03-07 07:13:24','Hotel Royal, Salem','Birthday','2025-02-26 10:40:01','2025-03-07 07:13:24');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `financeentries`
--

DROP TABLE IF EXISTS `financeentries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `financeentries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `type` enum('INCOME','EXPENSE') NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `description` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `category` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_financeentries_event_id` (`event_id`),
  KEY `idx_financeentries_type` (`type`),
  CONSTRAINT `financeentries_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `financeentries`
--

LOCK TABLES `financeentries` WRITE;
/*!40000 ALTER TABLE `financeentries` DISABLE KEYS */;
INSERT INTO `financeentries` VALUES (23,6,'INCOME',555.00,'food','2025-03-07 07:05:15','Catering','2025-03-07 07:05:55','2025-03-07 07:05:55'),(24,6,'EXPENSE',455.00,'flowers','2025-03-07 07:05:54','Decoration','2025-03-07 07:06:16','2025-03-07 07:06:16'),(26,5,'INCOME',6777.00,'food etc..','2025-03-07 07:07:36','Catering','2025-03-07 07:09:32','2025-03-07 07:09:32'),(27,5,'EXPENSE',5677.00,'food leaf','2025-03-07 07:09:32','Catering','2025-03-07 07:10:00','2025-03-07 07:10:00'),(28,6,'INCOME',66.00,'summa','2025-03-07 07:41:25','Sales','2025-03-07 07:41:40','2025-03-07 07:41:40'),(29,6,'INCOME',55.00,'55','2025-03-07 07:42:21','Sales','2025-03-07 07:44:09','2025-03-07 07:44:09'),(30,6,'INCOME',55.00,'meow','2025-03-07 07:44:09','Sales','2025-03-07 07:46:57','2025-03-07 07:46:57'),(31,6,'EXPENSE',55.00,'veg','2025-03-07 08:45:05','Catering','2025-03-07 08:46:00','2025-03-07 08:46:00');
/*!40000 ALTER TABLE `financeentries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materialentries`
--

DROP TABLE IF EXISTS `materialentries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materialentries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `contributor_name` varchar(255) NOT NULL,
  `material_type` varchar(50) NOT NULL,
  `weight` decimal(10,3) NOT NULL,
  `description` text,
  `place` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_materialentries_event_id` (`event_id`),
  CONSTRAINT `materialentries_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materialentries`
--

LOCK TABLES `materialentries` WRITE;
/*!40000 ALTER TABLE `materialentries` DISABLE KEYS */;
INSERT INTO `materialentries` VALUES (5,4,'Kannan Family','Silver',250.000,'Silver gift items','Salem','2025-02-26 10:40:01','2025-02-26 10:40:01'),(16,6,'kaviraj','Gold',55.000,'gold','tiruchengode','2025-03-07 07:04:30','2025-03-07 07:04:30'),(17,5,'kaviraj','Gold',555.000,' ','konganapuram','2025-03-07 07:20:28','2025-03-07 07:20:28'),(19,6,'Ramesh Kumar','Gold',50.000,'gold ring gift hi','salem','2025-03-07 08:44:11','2025-03-07 08:44:46');
/*!40000 ALTER TABLE `materialentries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moyentries`
--

DROP TABLE IF EXISTS `moyentries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `moyentries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `contributor_name` varchar(255) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `notes` text,
  `place` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_moyentries_event_id` (`event_id`),
  CONSTRAINT `moyentries_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moyentries`
--

LOCK TABLES `moyentries` WRITE;
/*!40000 ALTER TABLE `moyentries` DISABLE KEYS */;
INSERT INTO `moyentries` VALUES (59,6,'kaviraj',55555.00,'    ','tiruchengode','2025-03-07 07:02:49','2025-03-07 07:03:17'),(60,6,'Lakshmi Devi',5555.00,'    ','Chennai','2025-03-07 07:03:01','2025-03-07 07:03:01'),(61,6,'Ramesh',5555.00,'ponnu vedu home','salem','2025-03-07 08:42:06','2025-03-07 08:42:31');
/*!40000 ALTER TABLE `moyentries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `idx_users_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$2a$10$XKR6QZYkXoXnwP3JaLzQe.1Ym1oNTY4LzX5JZxW1rh9Uh8YDUTHPS','Admin User','2025-02-26 10:40:01','2025-02-26 10:40:01'),(2,'newuser','$2a$10$8wK/XUv.4DoZ.5GI0Aam6eS4xDZrVFHMnzctBJomHtHyNMUSq7i/.','role','2025-02-27 06:54:17','2025-02-27 06:54:17');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-08 11:00:16
