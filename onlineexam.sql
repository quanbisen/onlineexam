/*
 Navicat Premium Data Transfer

 Source Server         : Learn
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3306
 Source Schema         : onlineexam

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 18/06/2019 16:28:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for administrators
-- ----------------------------
DROP TABLE IF EXISTS `administrators`;
CREATE TABLE `administrators`  (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of administrators
-- ----------------------------
INSERT INTO `administrators` VALUES ('Lollipop', '10010');

-- ----------------------------
-- Table structure for examrecord
-- ----------------------------
DROP TABLE IF EXISTS `examrecord`;
CREATE TABLE `examrecord`  (
  `user_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `exam_description_id` int(11) NOT NULL,
  `total_score` int(5) NULL DEFAULT NULL,
  `obtain_score` int(5) NULL DEFAULT NULL,
  INDEX `exam_description_id`(`exam_description_id`) USING BTREE,
  CONSTRAINT `examrecord_ibfk_1` FOREIGN KEY (`exam_description_id`) REFERENCES `exams_description` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of examrecord
-- ----------------------------
INSERT INTO `examrecord` VALUES ('201615210409', 10, 100, 50);
INSERT INTO `examrecord` VALUES ('201615210409', 11, 100, 35);
INSERT INTO `examrecord` VALUES ('201615210409', 12, 100, 45);

-- ----------------------------
-- Table structure for exams_description
-- ----------------------------
DROP TABLE IF EXISTS `exams_description`;
CREATE TABLE `exams_description`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `exam_time` int(10) NULL DEFAULT 30,
  PRIMARY KEY (`exam_description`, `id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exams_description
-- ----------------------------
INSERT INTO `exams_description` VALUES (11, '英语六级', 30);
INSERT INTO `exams_description` VALUES (10, '英语四级', 25);
INSERT INTO `exams_description` VALUES (12, '英语考试', 15);

-- ----------------------------
-- Table structure for questions
-- ----------------------------
DROP TABLE IF EXISTS `questions`;
CREATE TABLE `questions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_description_id` int(10) NOT NULL,
  `question` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `options` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `correct_answer` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `min_score` decimal(5, 0) NULL DEFAULT NULL,
  `type` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `exam_description_id`(`exam_description_id`) USING BTREE,
  CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`exam_description_id`) REFERENCES `exams_description` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 80 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of questions
-- ----------------------------
INSERT INTO `questions` VALUES (60, 10, 'Which is used as a magnifying glass?', 'A）Plane mirror@B）Concave mirror@C）Converging lens@D）Diverging lens', 'C', 5, 'choice');
INSERT INTO `questions` VALUES (61, 10, 'In a water lifting electric pump, we convert ____', 'A）Kinetic energy into Electrical energy@B）Kinetic energy into Potential energy@C）Electrical energy into Kinetic energy@D）Electrical energy into Potential energy', 'C', 5, 'choice');
INSERT INTO `questions` VALUES (62, 10, 'Mica is used in electrical appliances such as electric iron because mica is _____', 'A）a good conductor of heat but a bad conductor of electricity@B）a bad conductor of heat but a good conductor of electricity@C）a good conductor of heat as well as electricity@D）a bad conductor of heat as well as electricity', 'A', 5, 'choice');
INSERT INTO `questions` VALUES (63, 10, 'Intensity of sound has ____', 'A）an object existence@B）a subject existence@C）no existence@D）both subjective and objective existence', 'A', 5, 'choice');
INSERT INTO `questions` VALUES (64, 10, 'One should not connect a number of electrical appliances to the same power socket because _____', 'A）this can damage the appliances due to overloading@B）this can damage the domestic wiring due to overloading@C）this can damage the electrical meter@D）the appliance will not get full voltage', 'B', 5, 'choice');
INSERT INTO `questions` VALUES (65, 10, 'Identify the vector quantity from the following _____', 'A）Heat@B）Angular momentum@C）Time@D）Work', 'B', 5, 'choice');
INSERT INTO `questions` VALUES (66, 10, 'Nuclear sizes are expressed in a unit named ______', 'A）Fermi@B）angstrom@C）newton@D）tesla', 'A', 5, 'choice');
INSERT INTO `questions` VALUES (67, 10, 'The absorption of ink by blotting paper involves _____', 'A）viscosity of ink@B）capillary action phenomenon@C）diffusion of ink through the blotting@D）siphon action', 'B', 5, 'choice');
INSERT INTO `questions` VALUES (68, 10, 'When a current carrying conductor is placed above a magnetic needle, what is the maximum deflection that can be produced?', 'A）45°@B）90°@C）180°@D）360°', 'B', 5, 'choice');
INSERT INTO `questions` VALUES (69, 10, 'Which one of the following scales of temperature does not have a negative value?', 'A）Celsius@B）Kelvin@C）Fahrenheit@D）Reaumar', 'C', 5, 'choice');
INSERT INTO `questions` VALUES (70, 10, 'We did the research as good as we could,however,it did not turn out to be satisfactory.', 'True@False', 'True', 5, 'judgement');
INSERT INTO `questions` VALUES (71, 10, 'It was about 600 years ago that the first clock with a face and an hour hand was made.', 'True@False', 'False', 5, 'judgement');
INSERT INTO `questions` VALUES (72, 10, 'We live on the earth.', 'True@False', 'True', 5, 'judgement');
INSERT INTO `questions` VALUES (73, 10, 'When crossing the street,watch the singal light.The red light is on. Stop.The green light is on. Go ahead', 'True@False', 'True', 5, 'judgement');
INSERT INTO `questions` VALUES (74, 10, 'If you do more practice,you will get a good exam.', 'True@False', 'True', 5, 'judgement');
INSERT INTO `questions` VALUES (75, 10, 'If you wish to remain healthy,you should drink several glasses of the water every day.', 'True@False', 'True', 5, 'judgement');
INSERT INTO `questions` VALUES (76, 10, 'Since their beginning,human survival has depended on their interaction with the environment.', 'True@False', 'False', 5, 'judgement');
INSERT INTO `questions` VALUES (77, 10, 'Since their beginning,human survival has depended on their interaction with the environment.', 'True@False', 'True', 5, 'judgement');
INSERT INTO `questions` VALUES (78, 10, 'It was about 600 years ago that the first clock with a face and an hour hand was made.', 'True@False', 'True', 5, 'judgement');
INSERT INTO `questions` VALUES (79, 10, 'We did the research as good as we could; however,it did not turn out to be satisfactory.', 'True@False', 'False', 5, 'judgement');
INSERT INTO `questions` VALUES (80, 11, 'Which is used as a magnifying glass?', 'A）Plane mirror@B）Concave mirror@C）Converging lens@D）Diverging lens', 'C', 5, 'choice');
INSERT INTO `questions` VALUES (81, 11, 'In a water lifting electric pump, we convert ____', 'A）Kinetic energy into Electrical energy@B）Kinetic energy into Potential energy@C）Electrical energy into Kinetic energy@D）Electrical energy into Potential energy', 'C', 5, 'choice');
INSERT INTO `questions` VALUES (82, 11, 'Mica is used in electrical appliances such as electric iron because mica is _____', 'A）a good conductor of heat but a bad conductor of electricity@B）a bad conductor of heat but a good conductor of electricity@C）a good conductor of heat as well as electricity@D）a bad conductor of heat as well as electricity', 'A', 5, 'choice');
INSERT INTO `questions` VALUES (83, 11, 'Intensity of sound has ____', 'A）an object existence@B）a subject existence@C）no existence@D）both subjective and objective existence', 'A', 5, 'choice');
INSERT INTO `questions` VALUES (84, 11, 'One should not connect a number of electrical appliances to the same power socket because _____', 'A）this can damage the appliances due to overloading@B）this can damage the domestic wiring due to overloading@C）this can damage the electrical meter@D）the appliance will not get full voltage', 'B', 5, 'choice');
INSERT INTO `questions` VALUES (85, 11, 'Identify the vector quantity from the following _____', 'A）Heat@B）Angular momentum@C）Time@D）Work', 'B', 5, 'choice');
INSERT INTO `questions` VALUES (86, 11, 'Nuclear sizes are expressed in a unit named ______', 'A）Fermi@B）angstrom@C）newton@D）tesla', 'A', 5, 'choice');
INSERT INTO `questions` VALUES (87, 11, 'The absorption of ink by blotting paper involves _____', 'A）viscosity of ink@B）capillary action phenomenon@C）diffusion of ink through the blotting@D）siphon action', 'B', 5, 'choice');
INSERT INTO `questions` VALUES (88, 11, 'When a current carrying conductor is placed above a magnetic needle, what is the maximum deflection that can be produced?', 'A）45°@B）90°@C）180°@D）360°', 'B', 5, 'choice');
INSERT INTO `questions` VALUES (89, 11, 'Which one of the following scales of temperature does not have a negative value?', 'A）Celsius@B）Kelvin@C）Fahrenheit@D）Reaumar', 'C', 5, 'choice');
INSERT INTO `questions` VALUES (90, 11, 'We did the research as good as we could,however,it did not turn out to be satisfactory.', 'True@False', 'True', 5, 'judgement');
INSERT INTO `questions` VALUES (91, 11, 'It was about 600 years ago that the first clock with a face and an hour hand was made.', 'True@False', 'False', 5, 'judgement');
INSERT INTO `questions` VALUES (92, 11, 'We live on the earth.', 'True@False', 'True', 5, 'judgement');
INSERT INTO `questions` VALUES (93, 11, 'When crossing the street,watch the singal light.The red light is on. Stop.The green light is on. Go ahead', 'True@False', 'True', 5, 'judgement');
INSERT INTO `questions` VALUES (94, 11, 'If you do more practice,you will get a good exam.', 'True@False', 'True', 5, 'judgement');
INSERT INTO `questions` VALUES (95, 11, 'If you wish to remain healthy,you should drink several glasses of the water every day.', 'True@False', 'True', 5, 'judgement');
INSERT INTO `questions` VALUES (96, 11, 'Since their beginning,human survival has depended on their interaction with the environment.', 'True@False', 'False', 5, 'judgement');
INSERT INTO `questions` VALUES (97, 11, 'Since their beginning,human survival has depended on their interaction with the environment.', 'True@False', 'True', 5, 'judgement');
INSERT INTO `questions` VALUES (98, 11, 'It was about 600 years ago that the first clock with a face and an hour hand was made.', 'True@False', 'True', 5, 'judgement');
INSERT INTO `questions` VALUES (99, 11, 'We did the research as good as we could; however,it did not turn out to be satisfactory.', 'True@False', 'False', 5, 'judgement');
INSERT INTO `questions` VALUES (100, 12, 'Which is used as a magnifying glass?', 'A）Plane mirror@B）Concave mirror@C）Converging lens@D）Diverging lens', 'C', 5, 'choice');
INSERT INTO `questions` VALUES (101, 12, 'In a water lifting electric pump, we convert ____', 'A）Kinetic energy into Electrical energy@B）Kinetic energy into Potential energy@C）Electrical energy into Kinetic energy@D）Electrical energy into Potential energy', 'C', 5, 'choice');
INSERT INTO `questions` VALUES (102, 12, 'Mica is used in electrical appliances such as electric iron because mica is _____', 'A）a good conductor of heat but a bad conductor of electricity@B）a bad conductor of heat but a good conductor of electricity@C）a good conductor of heat as well as electricity@D）a bad conductor of heat as well as electricity', 'A', 5, 'choice');
INSERT INTO `questions` VALUES (103, 12, 'Intensity of sound has ____', 'A）an object existence@B）a subject existence@C）no existence@D）both subjective and objective existence', 'A', 5, 'choice');
INSERT INTO `questions` VALUES (104, 12, 'One should not connect a number of electrical appliances to the same power socket because _____', 'A）this can damage the appliances due to overloading@B）this can damage the domestic wiring due to overloading@C）this can damage the electrical meter@D）the appliance will not get full voltage', 'B', 5, 'choice');
INSERT INTO `questions` VALUES (105, 12, 'Identify the vector quantity from the following _____', 'A）Heat@B）Angular momentum@C）Time@D）Work', 'B', 5, 'choice');
INSERT INTO `questions` VALUES (106, 12, 'Nuclear sizes are expressed in a unit named ______', 'A）Fermi@B）angstrom@C）newton@D）tesla', 'A', 5, 'choice');
INSERT INTO `questions` VALUES (107, 12, 'The absorption of ink by blotting paper involves _____', 'A）viscosity of ink@B）capillary action phenomenon@C）diffusion of ink through the blotting@D）siphon action', 'B', 5, 'choice');
INSERT INTO `questions` VALUES (108, 12, 'When a current carrying conductor is placed above a magnetic needle, what is the maximum deflection that can be produced?', 'A）45°@B）90°@C）180°@D）360°', 'B', 5, 'choice');
INSERT INTO `questions` VALUES (109, 12, 'Which one of the following scales of temperature does not have a negative value?', 'A）Celsius@B）Kelvin@C）Fahrenheit@D）Reaumar', 'C', 5, 'choice');
INSERT INTO `questions` VALUES (110, 12, 'We did the research as good as we could,however,it did not turn out to be satisfactory.', 'True@False', 'True', 5, 'judgement');
INSERT INTO `questions` VALUES (111, 12, 'It was about 600 years ago that the first clock with a face and an hour hand was made.', 'True@False', 'False', 5, 'judgement');
INSERT INTO `questions` VALUES (112, 12, 'We live on the earth.', 'True@False', 'True', 5, 'judgement');
INSERT INTO `questions` VALUES (113, 12, 'When crossing the street,watch the singal light.The red light is on. Stop.The green light is on. Go ahead', 'True@False', 'True', 5, 'judgement');
INSERT INTO `questions` VALUES (114, 12, 'If you do more practice,you will get a good exam.', 'True@False', 'True', 5, 'judgement');
INSERT INTO `questions` VALUES (115, 12, 'If you wish to remain healthy,you should drink several glasses of the water every day.', 'True@False', 'True', 5, 'judgement');
INSERT INTO `questions` VALUES (116, 12, 'Since their beginning,human survival has depended on their interaction with the environment.', 'True@False', 'False', 5, 'judgement');
INSERT INTO `questions` VALUES (117, 12, 'Since their beginning,human survival has depended on their interaction with the environment.', 'True@False', 'True', 5, 'judgement');
INSERT INTO `questions` VALUES (118, 12, 'It was about 600 years ago that the first clock with a face and an hour hand was made.', 'True@False', 'True', 5, 'judgement');
INSERT INTO `questions` VALUES (119, 12, 'We did the research as good as we could; however,it did not turn out to be satisfactory.', 'True@False', 'False', 5, 'judgement');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('201615210401', '10010');
INSERT INTO `users` VALUES ('201615210402', '10010');
INSERT INTO `users` VALUES ('201615210403', '10010');
INSERT INTO `users` VALUES ('201615210404', '10010');
INSERT INTO `users` VALUES ('201615210405', '10010');
INSERT INTO `users` VALUES ('201615210406', '10010');
INSERT INTO `users` VALUES ('201615210407', '10010');
INSERT INTO `users` VALUES ('201615210408', '10010');
INSERT INTO `users` VALUES ('201615210409', '10010');
INSERT INTO `users` VALUES ('201615210410', '10010');
INSERT INTO `users` VALUES ('201615210411', '10010');
INSERT INTO `users` VALUES ('201615210412', '10010');
INSERT INTO `users` VALUES ('201615210413', '10010');

-- ----------------------------
-- Table structure for users_information
-- ----------------------------
DROP TABLE IF EXISTS `users_information`;
CREATE TABLE `users_information`  (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sex` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '未知',
  `exam_reason` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '未知',
  `picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '../Images/UserImage.jpg',
  INDEX `id`(`id`) USING BTREE,
  CONSTRAINT `users_information_ibfk_1` FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users_information
-- ----------------------------
INSERT INTO `users_information` VALUES ('201615210409', 'Jayden', '男', '考六级', '../Images/史迪仔.jpg');
INSERT INTO `users_information` VALUES ('201615210401', 'Daniel', '男', '考四级', '../Images/UserImage.jpg');
INSERT INTO `users_information` VALUES ('201615210402', 'Tyler', '男', '考雅思', '../Images/UserImage.jpg');
INSERT INTO `users_information` VALUES ('201615210403', 'Emma', '女', '考六级', '../Images/UserImage.jpg');
INSERT INTO `users_information` VALUES ('201615210404', 'Ava', '女', '考四级', '../Images/UserImage.jpg');
INSERT INTO `users_information` VALUES ('201615210405', 'Kayla', '女', '考雅思', '../Images/UserImage.jpg');
INSERT INTO `users_information` VALUES ('201615210406', 'Aiden', '男', '考托福', '../Images/UserImage.jpg');
INSERT INTO `users_information` VALUES ('201615210407', 'Brandon', '男', '考六级', '../Images/UserImage.jpg');
INSERT INTO `users_information` VALUES ('201615210408', 'David', '男', '考托福', '../Images/UserImage.jpg');
INSERT INTO `users_information` VALUES ('201615210410', 'Sofia', '女', '考四级', '../Images/UserImage.jpg');
INSERT INTO `users_information` VALUES ('201615210411', 'Megan', '女', '考六级', '../Images/UserImage.jpg');
INSERT INTO `users_information` VALUES ('201615210412', 'Luke', '男', '考托福', '../Images/UserImage.jpg');
INSERT INTO `users_information` VALUES ('201615210413', 'John', '男', '考四级', '../Images/UserImage.jpg');

SET FOREIGN_KEY_CHECKS = 1;
