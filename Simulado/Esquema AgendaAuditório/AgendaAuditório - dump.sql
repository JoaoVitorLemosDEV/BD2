-- MariaDB dump 10.19  Distrib 10.5.18-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: agendaauditorio
-- ------------------------------------------------------
-- Server version	8.3.0

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
-- Table structure for table `administrador`
--

DROP TABLE IF EXISTS `administrador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `administrador` (
  `codAdm` tinyint unsigned NOT NULL,
  `nome` varchar(200) NOT NULL,
  `login` varchar(20) NOT NULL,
  `senha` varchar(20) NOT NULL,
  PRIMARY KEY (`codAdm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrador`
--

LOCK TABLES `administrador` WRITE;
/*!40000 ALTER TABLE `administrador` DISABLE KEYS */;
INSERT INTO `administrador` VALUES (1,'Pablo Freire Matos','pablo','matos'),(2,'Liojes de Oliveira Carneiro','Liojes','Carneiro');
/*!40000 ALTER TABLE `administrador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipamento`
--

DROP TABLE IF EXISTS `equipamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipamento` (
  `tombo` tinyint unsigned NOT NULL,
  `nome` varchar(200) NOT NULL,
  `status` enum('disponível','não disponível') NOT NULL,
  `dataHoraAtualizacaoStatus` datetime NOT NULL,
  `codAdm` tinyint unsigned NOT NULL,
  PRIMARY KEY (`tombo`),
  KEY `codAdm` (`codAdm`),
  CONSTRAINT `equipamento_ibfk_1` FOREIGN KEY (`codAdm`) REFERENCES `administrador` (`codAdm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipamento`
--

LOCK TABLES `equipamento` WRITE;
/*!40000 ALTER TABLE `equipamento` DISABLE KEYS */;
INSERT INTO `equipamento` VALUES (1,'Data Show','disponível','2024-10-08 17:30:48',1),(2,'Lousa Digital','disponível','2024-10-08 17:30:48',1),(3,'Microfone','disponível','2024-10-08 17:30:48',1),(4,'Caixa de Som','não disponível','2024-10-08 17:30:48',1),(5,'Quadro Branco','não disponível','2024-10-08 17:30:48',2),(6,'Notebook','disponível','2024-10-08 17:30:48',1);
/*!40000 ALTER TABLE `equipamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipamentoreservado`
--

DROP TABLE IF EXISTS `equipamentoreservado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipamentoreservado` (
  `codReserva` smallint unsigned NOT NULL,
  `tombo` tinyint unsigned NOT NULL,
  PRIMARY KEY (`tombo`,`codReserva`),
  KEY `codReserva` (`codReserva`),
  CONSTRAINT `equipamentoreservado_ibfk_1` FOREIGN KEY (`tombo`) REFERENCES `equipamento` (`tombo`),
  CONSTRAINT `equipamentoreservado_ibfk_2` FOREIGN KEY (`codReserva`) REFERENCES `reservaauditorio` (`codReserva`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipamentoreservado`
--

LOCK TABLES `equipamentoreservado` WRITE;
/*!40000 ALTER TABLE `equipamentoreservado` DISABLE KEYS */;
INSERT INTO `equipamentoreservado` VALUES (1,1),(1,2),(1,3),(2,1),(2,3),(3,1),(3,2),(3,3),(4,1),(4,2),(4,3),(7,1),(8,2),(12,1),(13,2),(14,3),(17,6);
/*!40000 ALTER TABLE `equipamentoreservado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservaauditorio`
--

DROP TABLE IF EXISTS `reservaauditorio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservaauditorio` (
  `codReserva` smallint unsigned NOT NULL,
  `motivo` varchar(200) NOT NULL,
  `horaFinal` time NOT NULL,
  `horaInicial` time NOT NULL,
  `status` enum('solicitado','reservado','cancelado') NOT NULL,
  `data` date NOT NULL,
  `dataHoraSolicitacao` datetime NOT NULL,
  `siape` tinyint unsigned DEFAULT NULL,
  PRIMARY KEY (`codReserva`),
  KEY `siape` (`siape`),
  CONSTRAINT `reservaauditorio_ibfk_1` FOREIGN KEY (`siape`) REFERENCES `servidor` (`siape`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservaauditorio`
--

LOCK TABLES `reservaauditorio` WRITE;
/*!40000 ALTER TABLE `reservaauditorio` DISABLE KEYS */;
INSERT INTO `reservaauditorio` VALUES (1,'Reserva Pessoal','12:00:00','10:00:00','reservado','2024-12-05','2024-10-08 00:00:00',1),(2,'Reserva Pessoal','18:00:00','14:00:00','reservado','2024-12-05','2024-10-08 00:00:00',1),(3,'Reserva Pessoal','12:00:00','08:00:00','reservado','2024-12-06','2024-10-08 00:00:00',1),(4,'Reserva Pessoal','18:00:00','14:00:00','reservado','2024-12-06','2024-10-08 17:30:48',2),(5,'Reserva Pessoal','18:00:00','08:00:00','reservado','2024-12-07','2024-10-08 17:30:48',2),(6,'Reserva Pessoal','11:00:00','08:00:00','solicitado','2024-12-10','2024-10-08 17:30:48',NULL),(7,'Reserva Pessoal','10:00:00','08:00:00','reservado','2024-12-09','2024-10-08 17:30:48',4),(8,'Reserva Pessoal','10:00:00','08:00:00','reservado','2024-12-12','2024-10-08 17:30:48',4),(9,'Reserva Pessoal','10:00:00','08:00:00','reservado','2024-12-13','2024-10-08 17:30:48',4),(10,'Reserva Pessoal','10:00:00','08:00:00','reservado','2024-12-14','2024-10-08 17:30:48',4),(11,'Reserva Pessoal','10:00:00','08:00:00','reservado','2024-12-15','2024-10-08 17:30:48',4),(12,'Reserva Pessoal','18:00:00','14:00:00','reservado','2024-12-19','2024-10-08 17:30:48',5),(13,'Reserva Pessoal','18:00:00','14:00:00','reservado','2024-12-20','2024-10-08 17:30:48',5),(14,'Reserva Pessoal','18:00:00','14:00:00','reservado','2024-12-21','2024-10-08 17:30:48',5),(15,'Reserva Pessoal','18:00:00','14:00:00','reservado','2024-12-22','2024-10-08 17:30:48',5),(16,'Reserva Pessoal','18:00:00','14:00:00','reservado','2024-12-22','2024-10-08 17:30:48',5),(17,'Reserva Pessoal','15:30:00','13:30:00','reservado','2024-12-23','2024-10-08 17:30:48',1);
/*!40000 ALTER TABLE `reservaauditorio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servidor`
--

DROP TABLE IF EXISTS `servidor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servidor` (
  `siape` tinyint unsigned NOT NULL,
  `nome` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  PRIMARY KEY (`siape`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servidor`
--

LOCK TABLES `servidor` WRITE;
/*!40000 ALTER TABLE `servidor` DISABLE KEYS */;
INSERT INTO `servidor` VALUES (1,'Marcélia Porto Rocha','murilo@gmail.com'),(2,'Gutemberg Júnior','gutemberg@hotmail.com'),(3,'Paulo Zainer de Oliveira Barbosa','paulo@gmail.com'),(4,'José Roberto Azevedo','zeazevedo@gmail.com'),(5,'Carlos Matheus Rodrigues','carmatro@gmail.com');
/*!40000 ALTER TABLE `servidor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servidortelefone`
--

DROP TABLE IF EXISTS `servidortelefone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servidortelefone` (
  `siape` tinyint unsigned NOT NULL,
  `telefone` char(11) NOT NULL,
  PRIMARY KEY (`telefone`,`siape`),
  KEY `siape` (`siape`),
  CONSTRAINT `servidortelefone_ibfk_1` FOREIGN KEY (`siape`) REFERENCES `servidor` (`siape`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servidortelefone`
--

LOCK TABLES `servidortelefone` WRITE;
/*!40000 ALTER TABLE `servidortelefone` DISABLE KEYS */;
INSERT INTO `servidortelefone` VALUES (1,'77988112622'),(1,'77999984511'),(2,'77988554355'),(2,'77991657844'),(2,'77998552233'),(3,'77988445566');
/*!40000 ALTER TABLE `servidortelefone` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-08 17:36:11
