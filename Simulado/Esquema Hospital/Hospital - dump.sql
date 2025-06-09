-- MySQL dump 10.13  Distrib 8.4.5, for Win64 (x86_64)
--
-- Host: localhost    Database: hospital
-- ------------------------------------------------------
-- Server version	8.4.5

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `consulta`
--

DROP TABLE IF EXISTS `consulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consulta` (
  `codigo_consulta` int unsigned NOT NULL AUTO_INCREMENT,
  `data_hora_consulta_prevista` datetime NOT NULL,
  `data_hora_consulta_realizada` datetime DEFAULT NULL,
  `hipotese_diagnostica` varchar(15) NOT NULL,
  `valor_consulta` decimal(6,2) unsigned NOT NULL,
  `tipo_exame` enum('Ecocardiograma','Eletrocardiograma','Mapa','Holter') NOT NULL,
  `status` enum('Aguardando','Realizada','Cancelada') NOT NULL,
  `crm_medico` varchar(20) NOT NULL,
  `cpf_paciente` char(11) NOT NULL,
  PRIMARY KEY (`codigo_consulta`),
  KEY `FK_Consulta_2` (`crm_medico`),
  KEY `FK_Consulta_3` (`cpf_paciente`),
  CONSTRAINT `FK_Consulta_2` FOREIGN KEY (`crm_medico`) REFERENCES `medico` (`crm_medico`),
  CONSTRAINT `FK_Consulta_3` FOREIGN KEY (`cpf_paciente`) REFERENCES `paciente` (`cpf_paciente`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consulta`
--

LOCK TABLES `consulta` WRITE;
/*!40000 ALTER TABLE `consulta` DISABLE KEYS */;
INSERT INTO `consulta` VALUES (1,'2025-05-15 00:08:18',NULL,'CID-10',250.00,'Mapa','Aguardando','52814-BA','70012582026'),(2,'2025-05-15 02:08:18',NULL,'CID-10',340.00,'Ecocardiograma','Aguardando','56671-BA','36421404324'),(3,'2025-05-14 14:08:18',NULL,'CID-10',450.00,'Eletrocardiograma','Aguardando','81317-BA','18287261414'),(4,'2025-05-14 07:08:18',NULL,'CID-10',250.00,'Mapa','Aguardando','24483-BA','52810074160'),(5,'2025-05-14 20:08:18',NULL,'CID-10',450.00,'Eletrocardiograma','Aguardando','1519-BA','99371913606'),(6,'2025-05-14 12:08:18',NULL,'CID-10',500.00,'Holter','Aguardando','2145-BA','53995208690'),(7,'2025-05-14 08:08:18',NULL,'CID-10',500.00,'Holter','Aguardando','111224-BA','82355308136'),(8,'2025-05-17 11:08:18',NULL,'CID-10',500.00,'Holter','Aguardando','2009-BA','57986655500'),(9,'2025-05-18 11:08:18',NULL,'CID-10',450.00,'Eletrocardiograma','Aguardando','2009-BA','22066908533'),(10,'2025-05-19 11:08:18',NULL,'CID-10',450.00,'Eletrocardiograma','Aguardando','2009-BA','43715462264'),(11,'2025-05-20 11:08:18',NULL,'CID-10',250.00,'Mapa','Aguardando','2009-BA','27290064275'),(12,'2025-05-21 11:08:18',NULL,'CID-10',340.00,'Ecocardiograma','Aguardando','2009-BA','69542994133'),(13,'2025-05-22 11:08:18',NULL,'CID-10',340.00,'Ecocardiograma','Aguardando','2009-BA','19884746559'),(14,'2025-05-23 11:08:18',NULL,'CID-10',250.00,'Mapa','Aguardando','2009-BA','26691268040'),(15,'2025-05-22 11:08:18',NULL,'CID-10',250.00,'Mapa','Aguardando','2009-BA','27290064275'),(16,'2025-05-21 11:08:18',NULL,'CID-10',500.00,'Holter','Aguardando','2009-BA','43715462264'),(17,'2025-05-20 11:08:18',NULL,'CID-10',340.00,'Ecocardiograma','Aguardando','2009-BA','26257895812'),(18,'2025-05-17 11:08:18',NULL,'CID-10',500.00,'Holter','Aguardando','1519-BA','27290064275'),(19,'2025-05-18 11:08:18',NULL,'CID-10',450.00,'Eletrocardiograma','Aguardando','111224-BA','99371913606'),(20,'2025-05-19 11:08:18',NULL,'CID-10',450.00,'Eletrocardiograma','Aguardando','1519-BA','36421404324'),(21,'2025-05-20 11:08:18',NULL,'CID-10',250.00,'Mapa','Aguardando','1519-BA','26257895812'),(22,'2025-05-21 11:08:18',NULL,'CID-10',340.00,'Ecocardiograma','Aguardando','1519-BA','99371913606'),(23,'2025-05-22 11:08:18',NULL,'CID-10',340.00,'Ecocardiograma','Aguardando','1519-BA','57374639155'),(24,'2025-05-23 11:08:18',NULL,'CID-10',250.00,'Mapa','Aguardando','1519-BA','36421404324'),(25,'2025-05-22 11:08:18',NULL,'CID-10',250.00,'Mapa','Aguardando','1519-BA','70012582026'),(26,'2025-05-21 11:08:18',NULL,'CID-10',500.00,'Holter','Aguardando','1519-BA','90031946968'),(27,'2025-05-20 11:08:18',NULL,'CID-10',340.00,'Ecocardiograma','Aguardando','1519-BA','27834150111'),(28,'2025-05-17 11:08:18',NULL,'CID-10',500.00,'Holter','Aguardando','24483-BA','18287261414'),(29,'2025-05-18 11:08:18',NULL,'CID-10',450.00,'Eletrocardiograma','Aguardando','111224-BA','22066908533'),(30,'2025-05-19 11:08:18',NULL,'CID-10',450.00,'Eletrocardiograma','Aguardando','52814-BA','26257895812'),(31,'2025-05-20 11:08:18',NULL,'CID-10',250.00,'Mapa','Aguardando','52814-BA','52810074160'),(32,'2025-05-21 11:08:18',NULL,'CID-10',340.00,'Ecocardiograma','Aguardando','52814-BA','70012582026'),(33,'2025-05-22 11:08:18',NULL,'CID-10',340.00,'Ecocardiograma','Aguardando','52814-BA','27290064275'),(34,'2025-05-23 11:08:18',NULL,'CID-10',250.00,'Mapa','Aguardando','52814-BA','55946513060'),(35,'2025-05-22 11:08:18',NULL,'CID-10',250.00,'Mapa','Aguardando','52814-BA','14672391191'),(36,'2025-05-21 11:08:18',NULL,'CID-10',500.00,'Holter','Aguardando','52814-BA','84556550700'),(38,'2025-05-17 11:08:18',NULL,'CID-10',500.00,'Holter','Aguardando','24483-BA','27290064275'),(39,'2025-05-18 11:08:18',NULL,'CID-10',450.00,'Eletrocardiograma','Aguardando','3593-BA','99371913606'),(40,'2025-05-19 11:08:18',NULL,'CID-10',450.00,'Eletrocardiograma','Aguardando','3593-BA','36421404324'),(41,'2025-05-20 11:08:18',NULL,'CID-10',250.00,'Mapa','Aguardando','3593-BA','26257895812'),(42,'2025-05-21 11:08:18',NULL,'CID-10',340.00,'Ecocardiograma','Aguardando','3593-BA','99371913606'),(43,'2025-05-22 11:08:18',NULL,'CID-10',340.00,'Ecocardiograma','Aguardando','3593-BA','57374639155'),(44,'2025-05-23 11:08:18',NULL,'CID-10',250.00,'Mapa','Aguardando','3593-BA','36421404324'),(45,'2025-05-22 11:08:18',NULL,'CID-10',250.00,'Mapa','Aguardando','3593-BA','70012582026'),(46,'2025-05-21 11:08:18',NULL,'CID-10',500.00,'Holter','Aguardando','3593-BA','90031946968'),(48,'2025-04-11 11:08:18','2025-04-11 12:08:18','CID-10',500.00,'Holter','Aguardando','111224-BA','34708543603'),(49,'2025-04-10 11:08:18','2025-04-10 12:08:18','CID-10',450.00,'Eletrocardiograma','Aguardando','13086-BA','27290064275'),(50,'2025-04-09 11:08:18','2025-04-09 13:08:18','CID-10',450.00,'Eletrocardiograma','Aguardando','14102-BA','26691268040'),(51,'2025-04-08 11:08:18','2025-04-08 15:08:18','CID-10',250.00,'Mapa','Aguardando','1519-BA','55946513060'),(52,'2025-04-02 11:08:18','2025-04-02 14:08:18','CID-10',340.00,'Ecocardiograma','Aguardando','2145-BA','19884746559'),(53,'2025-04-14 11:08:18','2025-04-14 13:08:18','CID-10',340.00,'Ecocardiograma','Realizada','92343-BA','57986655500'),(54,'2025-04-13 11:08:18','2025-04-13 14:08:18','CID-10',250.00,'Mapa','Realizada','92343-BA','84556550700'),(55,'2025-04-12 11:08:18','2025-04-12 12:08:18','CID-10',250.00,'Mapa','Realizada','111224-BA','14672391191'),(56,'2025-04-11 11:08:18','2025-04-11 15:08:18','CID-10',500.00,'Holter','Realizada','111224-BA','56027904038'),(57,'2025-04-10 11:08:18','2025-04-10 12:08:18','CID-10',340.00,'Ecocardiograma','Realizada','111224-BA','90031946968'),(58,'2025-04-09 11:08:18','2025-04-09 13:08:18','CID-10',500.00,'Holter','Realizada','81317-BA','22066908533'),(59,'2025-04-08 11:08:18','2025-04-08 13:08:18','CID-10',450.00,'Eletrocardiograma','Realizada','81317-BA','98921247408'),(60,'2025-04-07 11:08:18','2025-04-07 15:08:18','CID-10',450.00,'Eletrocardiograma','Realizada','81317-BA','27834150111'),(61,'2025-04-06 11:08:18','2025-04-06 14:08:18','CID-10',250.00,'Mapa','Realizada','24483-BA','82355308136'),(62,'2025-04-05 11:08:18','2025-04-05 17:08:18','CID-10',340.00,'Ecocardiograma','Realizada','24483-BA','43715462264'),(63,'2025-04-04 11:08:18','2025-04-04 15:08:18','CID-10',340.00,'Ecocardiograma','Realizada','24483-BA','97905125890'),(64,'2025-04-03 11:08:18','2025-04-03 12:08:18','CID-10',250.00,'Mapa','Realizada','1519-BA','78590339092'),(65,'2025-04-02 11:08:18','2025-04-02 13:08:18','CID-10',250.00,'Mapa','Realizada','1519-BA','57374639155'),(66,'2025-04-01 11:08:18','2025-04-01 11:43:18','CID-10',500.00,'Holter','Realizada','1519-BA','23174747333'),(67,'2025-03-31 11:08:18','2025-03-31 11:58:18','CID-10',340.00,'Ecocardiograma','Realizada','2145-BA','53995208690'),(68,'2025-04-13 11:08:18','2025-04-13 12:08:18','CID-10',450.00,'Eletrocardiograma','Realizada','14102-BA','27834150111'),(69,'2025-04-01 11:08:18','2025-04-01 12:08:18','CID-10',250.00,'Mapa','Realizada','14102-BA','82355308136'),(70,'2025-04-11 11:08:18','2025-04-11 13:08:18','CID-10',340.00,'Ecocardiograma','Realizada','14102-BA','43715462264'),(71,'2025-04-02 11:08:18','2025-04-02 15:08:18','CID-10',340.00,'Ecocardiograma','Realizada','13086-BA','97905125890'),(72,'2025-04-10 11:08:18','2025-04-10 14:08:18','CID-10',250.00,'Mapa','Realizada','13086-BA','78590339092'),(73,'2025-03-30 11:08:18','2025-03-30 13:08:18','CID-10',250.00,'Mapa','Realizada','13086-BA','57374639155'),(74,'2025-04-01 11:08:18','2025-04-01 12:08:18','CID-10',450.00,'Eletrocardiograma','Realizada','24483-BA','27834150111'),(75,'2025-03-31 11:08:18','2025-03-31 14:08:18','CID-10',450.00,'Eletrocardiograma','Realizada','24483-BA','82355308136'),(76,'2025-03-27 11:08:18','2025-03-27 13:08:18','CID-10',450.00,'Eletrocardiograma','Realizada','24483-BA','43715462264'),(77,'2025-03-26 11:08:18','2025-03-26 15:08:18','CID-10',450.00,'Eletrocardiograma','Realizada','24483-BA','97905125890'),(78,'2025-04-07 11:08:18','2025-04-07 14:08:18','CID-10',450.00,'Eletrocardiograma','Realizada','24483-BA','27834150111'),(79,'2025-04-05 11:08:18','2025-04-05 17:08:18','CID-10',450.00,'Eletrocardiograma','Realizada','24483-BA','57986655500'),(80,'2025-03-24 11:08:18','2025-03-24 18:08:18','CID-10',450.00,'Eletrocardiograma','Realizada','24483-BA','26691268040'),(81,'2025-04-11 11:08:18','2025-04-11 12:08:18','CID-10',450.00,'Eletrocardiograma','Realizada','24483-BA','19884746559'),(82,'2025-03-30 11:08:18','2025-03-30 11:24:18','CID-10',450.00,'Eletrocardiograma','Realizada','24483-BA','43715462264'),(83,'2025-04-09 11:08:18','2025-04-09 11:18:18','CID-10',450.00,'Eletrocardiograma','Realizada','24483-BA','70012582026'),(84,'2025-03-22 11:08:18','2025-03-22 11:18:18','CID-10',450.00,'Eletrocardiograma','Realizada','24483-BA','27290064275'),(85,'2024-05-16 11:08:18','2024-05-16 12:08:18','CID-10',250.00,'Mapa','Cancelada','24483-BA','70012582026'),(86,'2023-05-16 11:08:18','2023-05-16 20:08:18','CID-10',340.00,'Ecocardiograma','Cancelada','111224-BA','26257895812'),(87,'2024-05-16 11:08:18','2024-05-16 13:08:18','CID-10',450.00,'Eletrocardiograma','Cancelada','111224-BA','57374639155'),(88,'2023-03-16 11:08:18','2023-03-16 15:08:18','CID-10',500.00,'Holter','Cancelada','2145-BA','82355308136'),(89,'2025-01-16 11:08:18','2025-01-16 14:08:18','CID-10',340.00,'Ecocardiograma','Cancelada','3593-BA','14672391191'),(90,'2023-03-16 11:08:18','2023-03-16 17:08:18','CID-10',250.00,'Mapa','Cancelada','2009-BA','19884746559'),(91,'2023-03-16 11:08:18','2023-03-16 18:08:18','CID-10',500.00,'Holter','Cancelada','1519-BA','26691268040'),(92,'2024-08-16 11:08:18','2024-08-16 12:08:18','CID-10',340.00,'Ecocardiograma','Cancelada','2009-BA','19884746559'),(93,'2024-10-16 11:08:18','2024-10-17 03:08:18','CID-10',500.00,'Holter','Cancelada','1469-BA','43715462264'),(94,'2024-08-16 11:08:18','2024-08-16 13:08:18','CID-10',250.00,'Mapa','Cancelada','52814-BA','70012582026'),(95,'2025-01-16 11:08:18','2025-01-16 21:08:18','CID-10',340.00,'Ecocardiograma','Cancelada','52814-BA','55946513060'),(96,'2024-10-16 11:08:18','2024-10-16 16:08:18','CID-10',450.00,'Eletrocardiograma','Cancelada','1519-BA','19884746559'),(97,'2025-01-16 11:08:18','2025-01-16 21:08:18','CID-10',500.00,'Holter','Cancelada','1469-BA','27290064275'),(98,'2024-11-16 11:08:18','2024-08-16 14:08:18','CID-10',340.00,'Ecocardiograma','Cancelada','92343-BA','14672391191'),(99,'2025-02-16 11:08:18','2024-11-16 21:08:18','CID-10',500.00,'Holter','Cancelada','1519-BA','69542994133'),(100,'2025-04-16 11:08:18','2025-04-16 12:08:18','CID-10',500.00,'Holter','Cancelada','92343-BA','27290064275');
/*!40000 ALTER TABLE `consulta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `docente`
--

DROP TABLE IF EXISTS `docente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docente` (
  `crm_docente` varchar(20) NOT NULL,
  `titulacao` enum('Doutor','Assistente','Livre-docente','Titular') NOT NULL,
  PRIMARY KEY (`crm_docente`),
  CONSTRAINT `FK_Docente_2` FOREIGN KEY (`crm_docente`) REFERENCES `medico` (`crm_medico`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `docente`
--

LOCK TABLES `docente` WRITE;
/*!40000 ALTER TABLE `docente` DISABLE KEYS */;
INSERT INTO `docente` VALUES ('111224-BA','Doutor'),('56671-BA','Livre-docente'),('81317-BA','Livre-docente'),('92343-BA','Titular');
/*!40000 ALTER TABLE `docente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionario` (
  `cpf_funcionario` char(11) NOT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `telefone` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`cpf_funcionario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionario`
--

LOCK TABLES `funcionario` WRITE;
/*!40000 ALTER TABLE `funcionario` DISABLE KEYS */;
INSERT INTO `funcionario` VALUES ('42147555290','Rafael Mário Galvão','32995835074'),('95133231296','Isis Caroline Farias','32998213420');
/*!40000 ALTER TABLE `funcionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laudo`
--

DROP TABLE IF EXISTS `laudo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laudo` (
  `codigo_consulta` int unsigned NOT NULL,
  `codigo_laudo` int unsigned NOT NULL,
  `data_hora_registro` datetime NOT NULL,
  `resultado` varchar(255) NOT NULL,
  `conclusao` varchar(255) DEFAULT NULL,
  `status` enum('Provisório','Definitivo') NOT NULL,
  `crm_docente` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`codigo_laudo`,`codigo_consulta`),
  KEY `FK_Laudo_2` (`codigo_consulta`),
  KEY `FK_Laudo_3` (`crm_docente`),
  CONSTRAINT `FK_Laudo_2` FOREIGN KEY (`codigo_consulta`) REFERENCES `consulta` (`codigo_consulta`) ON DELETE CASCADE,
  CONSTRAINT `FK_Laudo_3` FOREIGN KEY (`crm_docente`) REFERENCES `docente` (`crm_docente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laudo`
--

LOCK TABLES `laudo` WRITE;
/*!40000 ALTER TABLE `laudo` DISABLE KEYS */;
INSERT INTO `laudo` VALUES (67,1,'2025-05-15 11:08:18','Lorem','Lorem Ipsum','Definitivo',NULL),(66,2,'2025-05-14 11:08:18','Etiam varius velit','Quisque feugiat nibh in laoreet venenatis.','Definitivo',NULL),(65,3,'2025-05-13 11:08:18','Aenean in diam e','pharetra, sem orci imperdiet','Definitivo',NULL),(64,4,'2025-05-12 11:08:18','Curabitur vel sodales ','tae nisi sagittis vehicula. Fu','Definitivo',NULL),(63,5,'2025-05-11 11:08:18','Nunc egestas ultricies e','t scelerisque ac no','Definitivo',NULL),(62,6,'2025-05-10 11:08:18','equat metus lacus','augue sodal','Definitivo',NULL),(68,7,'2025-04-16 11:08:18','finibus. Maec','c eu enim. Maec','Provisório',NULL),(69,8,'2025-04-26 11:08:18','pien, maximus vitae finibus sed','augue sodal','Provisório',NULL),(70,9,'2025-04-16 11:08:18','rnare metus, vel tin','on metus. Duis ornare cursus elit,','Provisório',NULL),(71,10,'2024-05-16 11:08:18','odio. Aenean tempor ex non mag','it amet justo auctor malesuada. Mauris ves','Definitivo','92343-BA'),(72,11,'2024-08-16 11:08:18','equat metus lacus','arius diam, ut vulpu','Definitivo','56671-BA'),(73,12,'2025-01-16 11:08:18','ndit. Nam a semper arcu, nec fer','rius diam, ut vulput','Definitivo','111224-BA'),(74,13,'2024-06-16 11:08:18','Lorem','Lorem Ipsum','Definitivo','92343-BA'),(75,14,'2023-06-16 11:08:18','Etiam varius velit','Quisque feugiat nibh in laoreet venenatis.','Definitivo','92343-BA'),(76,15,'2024-06-16 11:08:18','Aenean in diam e','pharetra, sem orci imperdiet','Definitivo','56671-BA'),(77,16,'2023-04-16 11:08:18','Curabitur vel sodales ','tae nisi sagittis vehicula. Fu','Definitivo','56671-BA'),(78,17,'2025-02-16 11:08:18','Nunc egestas ultricies e','t scelerisque ac no','Definitivo','56671-BA'),(79,18,'2023-04-16 11:08:18','equat metus lacus','augue sodal','Definitivo','81317-BA'),(80,19,'2023-04-16 11:08:18','Lorem','Lorem Ipsum','Definitivo','81317-BA'),(81,20,'2024-09-16 11:08:18','Curabitur vel sodales ','tae nisi sagittis vehicula. Fu','Definitivo','92343-BA'),(82,21,'2024-11-16 11:08:18','Etiam varius velit','Quisque feugiat nibh in laoreet venenatis.','Definitivo','92343-BA'),(83,22,'2024-09-16 11:08:18','Nunc egestas ultricies e','t scelerisque ac no','Definitivo','92343-BA'),(84,23,'2025-02-16 11:08:18','Aenean in diam e','pharetra, sem orci imperdiet','Definitivo','81317-BA');
/*!40000 ALTER TABLE `laudo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medico`
--

DROP TABLE IF EXISTS `medico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medico` (
  `crm_medico` varchar(20) NOT NULL,
  `nome_completo` varchar(255) NOT NULL,
  `salario` decimal(7,2) unsigned NOT NULL,
  `hierarquia` enum('Médico','Residente','Docente') NOT NULL,
  PRIMARY KEY (`crm_medico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medico`
--

LOCK TABLES `medico` WRITE;
/*!40000 ALTER TABLE `medico` DISABLE KEYS */;
INSERT INTO `medico` VALUES ('111224-BA','Igor Marcelo Peixoto',9700.00,'Docente'),('13086-BA','Iago Nelson Alexandre de Paula',5000.00,'Residente'),('14102-BA','Kevin Alexandre Sebastião Galvão',5000.00,'Residente'),('1469-BA','Abel Martin Marquez',6000.00,'Médico'),('1519-BA','Márcio Ryan Figueiredo',6000.00,'Médico'),('2009-BA','Elaine Isabelle das Neves',6000.00,'Médico'),('2145-BA','André Gabriel Anthony Viana',6000.00,'Médico'),('24483-BA','Eloá Larissa Emanuelly Rezende',5000.00,'Residente'),('3593-BA','Manoel César Peixoto',6000.00,'Médico'),('52814-BA','Luiz Manuel Baptista',7000.00,'Médico'),('56671-BA','Bernardo Francisco Rafael Fogaça',9700.00,'Docente'),('7168-BA','Michelle Cabral Silva',9000.00,'Médico'),('81317-BA','Pedro Heitor da Mata',9700.00,'Docente'),('92343-BA','Marcela Cecília Kamilly Bernardes',9700.00,'Docente');
/*!40000 ALTER TABLE `medico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paciente`
--

DROP TABLE IF EXISTS `paciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paciente` (
  `cpf_paciente` char(11) NOT NULL,
  `nome_completo` varchar(255) NOT NULL,
  `data_nascimento` date NOT NULL,
  `cor` enum('Branco','Preto','Pardo','Amarelo','Indígena') NOT NULL,
  `sexo` enum('Masculino','Feminino') NOT NULL,
  PRIMARY KEY (`cpf_paciente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paciente`
--

LOCK TABLES `paciente` WRITE;
/*!40000 ALTER TABLE `paciente` DISABLE KEYS */;
INSERT INTO `paciente` VALUES ('14672391191','Patrícia Larissa Gabriela da Luz','1988-03-15','Indígena','Feminino'),('18287261414','Isadora Manuela Farias','1962-10-21','Pardo','Feminino'),('19884746559','Sandra Raimunda Almada','1974-07-08','Indígena','Feminino'),('22066908533','Heloisa Melissa Regina Teixeira','1966-05-14','Amarelo','Feminino'),('23174747333','Maya Rayssa Ferreira','1966-09-11','Branco','Feminino'),('26257895812','Renato Rodrigo da Conceição','1987-07-27','Pardo','Masculino'),('26691268040','Martin Márcio Nathan Moraes','2005-01-13','Preto','Masculino'),('27290064275','Clara Maitê Melissa Farias','2013-09-24','Amarelo','Feminino'),('27834150111','Alexandre Edson Corte Real','1989-02-18','Pardo','Masculino'),('34708543603','Alexandre Diogo Murilo Castro','1961-06-06','Branco','Masculino'),('36421404324','Marcos Fábio Aparício','2015-01-07','Preto','Feminino'),('43715462264','Igor Henry da Mota','1996-07-16','Amarelo','Masculino'),('52810074160','Guilherme Francisco Heitor Rezende','1972-07-01','Amarelo','Masculino'),('53995208690','Brenda Stella Alícia Araújo','1993-09-07','Preto','Feminino'),('55946513060','Márcia Lúcia Alves','1964-04-27','Pardo','Feminino'),('56027904038','Maitê Bruna Luzia Farias','1977-05-11','Amarelo','Masculino'),('57374639155','Gabriel Alexandre dos Santos','1987-07-19','Preto','Masculino'),('57986655500','Rosângela Betina Nunes','1966-03-07','Amarelo','Feminino'),('69542994133','Priscila Cláudia Isabelle Gomes','2003-08-18','Preto','Feminino'),('70012582026','Brenda Olivia Ferreira','1948-07-20','Branco','Feminino'),('78590339092','Eduardo Carlos Castro','2003-10-16','Branco','Masculino'),('82355308136','Alice Mariane Assunção','2006-03-07','Indígena','Feminino'),('84556550700','Vitória Luiza Francisca Souza','1947-05-12','Branco','Feminino'),('90031946968','Felipe Cauã Lucca da Silva','1985-05-01','Preto','Masculino'),('97905125890','Erick Theo Anthony Alves','2017-01-14','Pardo','Masculino'),('98921247408','Luzia Daniela Silvana Almeida','1976-04-17','Indígena','Feminino'),('99371913606','Vicente Thiago Vicente dos Santos','1943-08-02','Indígena','Masculino');
/*!40000 ALTER TABLE `paciente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagamento`
--

DROP TABLE IF EXISTS `pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagamento` (
  `cpf_funcionario` char(11) NOT NULL,
  `crm_medico` varchar(20) NOT NULL,
  `mes_referencia` tinyint unsigned NOT NULL,
  `ano_referencia` year NOT NULL,
  `data_hora` datetime DEFAULT NULL,
  `honorario` decimal(6,2) unsigned NOT NULL,
  PRIMARY KEY (`cpf_funcionario`,`crm_medico`,`mes_referencia`,`ano_referencia`),
  KEY `FK_Pagamento_2` (`crm_medico`),
  CONSTRAINT `FK_Pagamento_1` FOREIGN KEY (`cpf_funcionario`) REFERENCES `funcionario` (`cpf_funcionario`),
  CONSTRAINT `FK_Pagamento_2` FOREIGN KEY (`crm_medico`) REFERENCES `medico` (`crm_medico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagamento`
--

LOCK TABLES `pagamento` WRITE;
/*!40000 ALTER TABLE `pagamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `pagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `residente`
--

DROP TABLE IF EXISTS `residente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `residente` (
  `crm_residente` varchar(20) NOT NULL,
  `especialidade` varchar(50) NOT NULL,
  `data_inicio_residencia` date NOT NULL,
  `data_fim_residencia` date DEFAULT NULL,
  PRIMARY KEY (`crm_residente`,`especialidade`),
  CONSTRAINT `FK_Residente_1` FOREIGN KEY (`crm_residente`) REFERENCES `medico` (`crm_medico`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `residente`
--

LOCK TABLES `residente` WRITE;
/*!40000 ALTER TABLE `residente` DISABLE KEYS */;
INSERT INTO `residente` VALUES ('13086-BA','Holter','2023-05-16',NULL),('14102-BA','Mapa','2025-02-16',NULL),('1519-BA','Mapa','2021-05-16','2024-08-16'),('24483-BA','Eletrocardiograma','2022-02-16',NULL);
/*!40000 ALTER TABLE `residente` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-16 11:10:46
