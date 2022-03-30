-- MariaDB dump 10.19  Distrib 10.4.24-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: doctor
-- ------------------------------------------------------
-- Server version	10.4.24-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `doctor_availabilities`
--

DROP TABLE IF EXISTS `doctor_availabilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctor_availabilities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doctor_id` int(11) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `no_of_patients` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UniqueDoctorId` (`doctor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_availabilities`
--

LOCK TABLES `doctor_availabilities` WRITE;
/*!40000 ALTER TABLE `doctor_availabilities` DISABLE KEYS */;
INSERT INTO `doctor_availabilities` VALUES (1,1,'06:00:00','08:00:00',5),(2,2,'06:00:00','08:00:00',5);
/*!40000 ALTER TABLE `doctor_availabilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_time_slots`
--

DROP TABLE IF EXISTS `doctor_time_slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctor_time_slots` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doctor_id` int(11) NOT NULL,
  `doctor_availability_id` int(11) NOT NULL,
  `slot_start_time` time NOT NULL,
  `slot_end_time` time NOT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_availabilities_fk` (`doctor_availability_id`),
  CONSTRAINT `doctor_availabilities_fk` FOREIGN KEY (`doctor_availability_id`) REFERENCES `doctor_availabilities` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_time_slots`
--

LOCK TABLES `doctor_time_slots` WRITE;
/*!40000 ALTER TABLE `doctor_time_slots` DISABLE KEYS */;
INSERT INTO `doctor_time_slots` VALUES (1,1,1,'06:00:00','06:24:00'),(2,1,1,'06:24:00','06:48:00'),(3,1,1,'06:48:00','07:12:00'),(4,1,1,'07:12:00','07:36:00'),(5,1,1,'07:36:00','08:00:00'),(6,2,2,'06:00:00','06:24:00'),(7,2,2,'06:24:00','06:48:00'),(8,2,2,'06:48:00','07:12:00'),(9,2,2,'07:12:00','07:36:00'),(10,2,2,'07:36:00','08:00:00');
/*!40000 ALTER TABLE `doctor_time_slots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_booking_slots`
--

DROP TABLE IF EXISTS `patient_booking_slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_booking_slots` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `doctor_time_slot_id` int(11) NOT NULL,
  `appointment_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_doctor_time_slot` (`doctor_time_slot_id`),
  CONSTRAINT `fk_doctor_time_slot` FOREIGN KEY (`doctor_time_slot_id`) REFERENCES `doctor_time_slots` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_booking_slots`
--

LOCK TABLES `patient_booking_slots` WRITE;
/*!40000 ALTER TABLE `patient_booking_slots` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_booking_slots` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-30 10:54:33
