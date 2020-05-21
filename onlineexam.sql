-- MySQL dump 10.13  Distrib 8.0.19, for Linux (x86_64)
--
-- Host: 114.116.240.232    Database: onlineexam
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `administrators`
--

DROP TABLE IF EXISTS `administrators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administrators` (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrators`
--

LOCK TABLES `administrators` WRITE;
/*!40000 ALTER TABLE `administrators` DISABLE KEYS */;
INSERT INTO `administrators` VALUES ('lollipop','10010');
/*!40000 ALTER TABLE `administrators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `examrecord`
--

DROP TABLE IF EXISTS `examrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `examrecord` (
  `user_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `exam_description_id` int NOT NULL,
  `total_score` int DEFAULT NULL,
  `obtain_score` int DEFAULT NULL,
  KEY `exam_description_id` (`exam_description_id`) USING BTREE,
  CONSTRAINT `examrecord_ibfk_1` FOREIGN KEY (`exam_description_id`) REFERENCES `exams_description` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examrecord`
--

LOCK TABLES `examrecord` WRITE;
/*!40000 ALTER TABLE `examrecord` DISABLE KEYS */;
INSERT INTO `examrecord` VALUES ('201615210409',10,100,50),('201615210409',11,100,35),('201615210409',12,100,45);
/*!40000 ALTER TABLE `examrecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exams_description`
--

DROP TABLE IF EXISTS `exams_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exams_description` (
  `id` int NOT NULL AUTO_INCREMENT,
  `exam_description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `exam_time` int DEFAULT '30',
  PRIMARY KEY (`exam_description`,`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exams_description`
--

LOCK TABLES `exams_description` WRITE;
/*!40000 ALTER TABLE `exams_description` DISABLE KEYS */;
INSERT INTO `exams_description` VALUES (11,'英语六级',30),(10,'英语四级',25),(12,'英语考试',15);
/*!40000 ALTER TABLE `exams_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `exam_description_id` int NOT NULL,
  `question` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `options` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `correct_answer` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `min_score` decimal(5,0) DEFAULT NULL,
  `type` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `exam_description_id` (`exam_description_id`) USING BTREE,
  CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`exam_description_id`) REFERENCES `exams_description` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (60,10,'Which is used as a magnifying glass?','A）Plane mirror@B）Concave mirror@C）Converging lens@D）Diverging lens','C',5,'choice'),(61,10,'In a water lifting electric pump, we convert ____','A）Kinetic energy into Electrical energy@B）Kinetic energy into Potential energy@C）Electrical energy into Kinetic energy@D）Electrical energy into Potential energy','C',5,'choice'),(62,10,'Mica is used in electrical appliances such as electric iron because mica is _____','A）a good conductor of heat but a bad conductor of electricity@B）a bad conductor of heat but a good conductor of electricity@C）a good conductor of heat as well as electricity@D）a bad conductor of heat as well as electricity','A',5,'choice'),(63,10,'Intensity of sound has ____','A）an object existence@B）a subject existence@C）no existence@D）both subjective and objective existence','A',5,'choice'),(64,10,'One should not connect a number of electrical appliances to the same power socket because _____','A）this can damage the appliances due to overloading@B）this can damage the domestic wiring due to overloading@C）this can damage the electrical meter@D）the appliance will not get full voltage','B',5,'choice'),(65,10,'Identify the vector quantity from the following _____','A）Heat@B）Angular momentum@C）Time@D）Work','B',5,'choice'),(66,10,'Nuclear sizes are expressed in a unit named ______','A）Fermi@B）angstrom@C）newton@D）tesla','A',5,'choice'),(67,10,'The absorption of ink by blotting paper involves _____','A）viscosity of ink@B）capillary action phenomenon@C）diffusion of ink through the blotting@D）siphon action','B',5,'choice'),(68,10,'When a current carrying conductor is placed above a magnetic needle, what is the maximum deflection that can be produced?','A）45°@B）90°@C）180°@D）360°','B',5,'choice'),(69,10,'Which one of the following scales of temperature does not have a negative value?','A）Celsius@B）Kelvin@C）Fahrenheit@D）Reaumar','C',5,'choice'),(70,10,'We did the research as good as we could,however,it did not turn out to be satisfactory.','True@False','True',5,'judgement'),(71,10,'It was about 600 years ago that the first clock with a face and an hour hand was made.','True@False','False',5,'judgement'),(72,10,'We live on the earth.','True@False','True',5,'judgement'),(73,10,'When crossing the street,watch the singal light.The red light is on. Stop.The green light is on. Go ahead','True@False','True',5,'judgement'),(74,10,'If you do more practice,you will get a good exam.','True@False','True',5,'judgement'),(75,10,'If you wish to remain healthy,you should drink several glasses of the water every day.','True@False','True',5,'judgement'),(76,10,'Since their beginning,human survival has depended on their interaction with the environment.','True@False','False',5,'judgement'),(77,10,'Since their beginning,human survival has depended on their interaction with the environment.','True@False','True',5,'judgement'),(78,10,'It was about 600 years ago that the first clock with a face and an hour hand was made.','True@False','True',5,'judgement'),(79,10,'We did the research as good as we could; however,it did not turn out to be satisfactory.','True@False','False',5,'judgement'),(80,11,'Which is used as a magnifying glass?','A）Plane mirror@B）Concave mirror@C）Converging lens@D）Diverging lens','C',5,'choice'),(81,11,'In a water lifting electric pump, we convert ____','A）Kinetic energy into Electrical energy@B）Kinetic energy into Potential energy@C）Electrical energy into Kinetic energy@D）Electrical energy into Potential energy','C',5,'choice'),(82,11,'Mica is used in electrical appliances such as electric iron because mica is _____','A）a good conductor of heat but a bad conductor of electricity@B）a bad conductor of heat but a good conductor of electricity@C）a good conductor of heat as well as electricity@D）a bad conductor of heat as well as electricity','A',5,'choice'),(83,11,'Intensity of sound has ____','A）an object existence@B）a subject existence@C）no existence@D）both subjective and objective existence','A',5,'choice'),(84,11,'One should not connect a number of electrical appliances to the same power socket because _____','A）this can damage the appliances due to overloading@B）this can damage the domestic wiring due to overloading@C）this can damage the electrical meter@D）the appliance will not get full voltage','B',5,'choice'),(85,11,'Identify the vector quantity from the following _____','A）Heat@B）Angular momentum@C）Time@D）Work','B',5,'choice'),(86,11,'Nuclear sizes are expressed in a unit named ______','A）Fermi@B）angstrom@C）newton@D）tesla','A',5,'choice'),(87,11,'The absorption of ink by blotting paper involves _____','A）viscosity of ink@B）capillary action phenomenon@C）diffusion of ink through the blotting@D）siphon action','B',5,'choice'),(88,11,'When a current carrying conductor is placed above a magnetic needle, what is the maximum deflection that can be produced?','A）45°@B）90°@C）180°@D）360°','B',5,'choice'),(89,11,'Which one of the following scales of temperature does not have a negative value?','A）Celsius@B）Kelvin@C）Fahrenheit@D）Reaumar','C',5,'choice'),(90,11,'We did the research as good as we could,however,it did not turn out to be satisfactory.','True@False','True',5,'judgement'),(91,11,'It was about 600 years ago that the first clock with a face and an hour hand was made.','True@False','False',5,'judgement'),(92,11,'We live on the earth.','True@False','True',5,'judgement'),(93,11,'When crossing the street,watch the singal light.The red light is on. Stop.The green light is on. Go ahead','True@False','True',5,'judgement'),(94,11,'If you do more practice,you will get a good exam.','True@False','True',5,'judgement'),(95,11,'If you wish to remain healthy,you should drink several glasses of the water every day.','True@False','True',5,'judgement'),(96,11,'Since their beginning,human survival has depended on their interaction with the environment.','True@False','False',5,'judgement'),(97,11,'Since their beginning,human survival has depended on their interaction with the environment.','True@False','True',5,'judgement'),(98,11,'It was about 600 years ago that the first clock with a face and an hour hand was made.','True@False','True',5,'judgement'),(99,11,'We did the research as good as we could; however,it did not turn out to be satisfactory.','True@False','False',5,'judgement'),(100,12,'Which is used as a magnifying glass?','A）Plane mirror@B）Concave mirror@C）Converging lens@D）Diverging lens','C',5,'choice'),(101,12,'In a water lifting electric pump, we convert ____','A）Kinetic energy into Electrical energy@B）Kinetic energy into Potential energy@C）Electrical energy into Kinetic energy@D）Electrical energy into Potential energy','C',5,'choice'),(102,12,'Mica is used in electrical appliances such as electric iron because mica is _____','A）a good conductor of heat but a bad conductor of electricity@B）a bad conductor of heat but a good conductor of electricity@C）a good conductor of heat as well as electricity@D）a bad conductor of heat as well as electricity','A',5,'choice'),(103,12,'Intensity of sound has ____','A）an object existence@B）a subject existence@C）no existence@D）both subjective and objective existence','A',5,'choice'),(104,12,'One should not connect a number of electrical appliances to the same power socket because _____','A）this can damage the appliances due to overloading@B）this can damage the domestic wiring due to overloading@C）this can damage the electrical meter@D）the appliance will not get full voltage','B',5,'choice'),(105,12,'Identify the vector quantity from the following _____','A）Heat@B）Angular momentum@C）Time@D）Work','B',5,'choice'),(106,12,'Nuclear sizes are expressed in a unit named ______','A）Fermi@B）angstrom@C）newton@D）tesla','A',5,'choice'),(107,12,'The absorption of ink by blotting paper involves _____','A）viscosity of ink@B）capillary action phenomenon@C）diffusion of ink through the blotting@D）siphon action','B',5,'choice'),(108,12,'When a current carrying conductor is placed above a magnetic needle, what is the maximum deflection that can be produced?','A）45°@B）90°@C）180°@D）360°','B',5,'choice'),(109,12,'Which one of the following scales of temperature does not have a negative value?','A）Celsius@B）Kelvin@C）Fahrenheit@D）Reaumar','C',5,'choice'),(110,12,'We did the research as good as we could,however,it did not turn out to be satisfactory.','True@False','True',5,'judgement'),(111,12,'It was about 600 years ago that the first clock with a face and an hour hand was made.','True@False','False',5,'judgement'),(112,12,'We live on the earth.','True@False','True',5,'judgement'),(113,12,'When crossing the street,watch the singal light.The red light is on. Stop.The green light is on. Go ahead','True@False','True',5,'judgement'),(114,12,'If you do more practice,you will get a good exam.','True@False','True',5,'judgement'),(115,12,'If you wish to remain healthy,you should drink several glasses of the water every day.','True@False','True',5,'judgement'),(116,12,'Since their beginning,human survival has depended on their interaction with the environment.','True@False','False',5,'judgement'),(117,12,'Since their beginning,human survival has depended on their interaction with the environment.','True@False','True',5,'judgement'),(118,12,'It was about 600 years ago that the first clock with a face and an hour hand was made.','True@False','True',5,'judgement'),(119,12,'We did the research as good as we could; however,it did not turn out to be satisfactory.','True@False','False',5,'judgement');
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachers`
--

DROP TABLE IF EXISTS `teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teachers` (
  `id` varchar(100) NOT NULL,
  `password` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachers`
--

LOCK TABLES `teachers` WRITE;
/*!40000 ALTER TABLE `teachers` DISABLE KEYS */;
INSERT INTO `teachers` VALUES ('t_1001','10010'),('t_1002','10010'),('t_1003','10010'),('t_1004','10010'),('t_1005','10010'),('t_1006','10010'),('t_1007','10010'),('t_1008','10010'),('t_1009','10010'),('t_1010','10010'),('t_1011','10011');
/*!40000 ALTER TABLE `teachers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachers_information`
--

DROP TABLE IF EXISTS `teachers_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teachers_information` (
  `id` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `sex` char(10) DEFAULT NULL,
  KEY `fk_teacher_information_1_idx` (`id`),
  CONSTRAINT `fk_teacher_information_1` FOREIGN KEY (`id`) REFERENCES `teachers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachers_information`
--

LOCK TABLES `teachers_information` WRITE;
/*!40000 ALTER TABLE `teachers_information` DISABLE KEYS */;
INSERT INTO `teachers_information` VALUES ('t_1001','Jack','男'),('t_1002','Mike','男'),('t_1003','Mary','女'),('t_1004','John','男'),('t_1005','Mence','女'),('t_1006','Record','女'),('t_1007','Jack','男'),('t_1008','Tony','男'),('t_1009','Tom','男'),('t_1010','Hotdog','男'),('t_1011','Super','男');
/*!40000 ALTER TABLE `teachers_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('201615210401','10010'),('201615210402','10010'),('201615210403','10010'),('201615210404','10010'),('201615210405','10010'),('201615210406','10010'),('201615210407','10010'),('201615210408','10010'),('201615210409','10010'),('201615210410','10010'),('201615210411','10010'),('201615210412','10010'),('201615210413','10010'),('201615210414','10010'),('201615210415','10010');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_information`
--

DROP TABLE IF EXISTS `users_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_information` (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sex` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '未知',
  `exam_reason` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '未知',
  `picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '../image/UserImage.jpg',
  KEY `id` (`id`) USING BTREE,
  CONSTRAINT `users_information_ibfk_1` FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_information`
--

LOCK TABLES `users_information` WRITE;
/*!40000 ALTER TABLE `users_information` DISABLE KEYS */;
INSERT INTO `users_information` VALUES ('201615210409','Jayden','男','考六级','../image/邓紫棋.jpg'),('201615210401','Daniel','男','考四级','../Images/UserImage.jpg'),('201615210402','Tyler','男','考雅思','../Images/UserImage.jpg'),('201615210403','Emma','女','考六级','../Images/UserImage.jpg'),('201615210404','Ava','女','考四级','../Images/UserImage.jpg'),('201615210405','Kayla','女','考雅思','../Images/UserImage.jpg'),('201615210406','Aiden','女','考托福','../Images/UserImage.jpg'),('201615210407','Brandon','男','考六级','../Images/UserImage.jpg'),('201615210408','David','男','考托福','../Images/UserImage.jpg'),('201615210410','Sofia','女','考四级','../Images/UserImage.jpg'),('201615210411','Megan','女','考六级','../Images/UserImage.jpg'),('201615210412','Luke','男','考托福','../Images/UserImage.jpg'),('201615210413','John','男','考四级','../Images/UserImage.jpg'),('201615210414','Super','男','考六级','../image/UserImage.jpg'),('201615210415','Jony','男','考六级','../image/UserImage.jpg');
/*!40000 ALTER TABLE `users_information` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-30 20:48:38
