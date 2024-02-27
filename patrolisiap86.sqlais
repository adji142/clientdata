/*
 Navicat Premium Data Transfer

 Source Server         : AISServer
 Source Server Type    : MySQL
 Source Server Version : 100240
 Source Host           : localhost:3306
 Source Schema         : patrolisiap86

 Target Server Type    : MySQL
 Target Server Version : 100240
 File Encoding         : 65001

 Date: 13/07/2023 16:01:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for pascode
-- ----------------------------
DROP TABLE IF EXISTS `pascode`;
CREATE TABLE `pascode`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Passcode` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ValidTo` datetime(6) NOT NULL,
  `Status` int(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pascode
-- ----------------------------

-- ----------------------------
-- Table structure for patroli
-- ----------------------------
DROP TABLE IF EXISTS `patroli`;
CREATE TABLE `patroli`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `RecordOwnerID` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `KodeCheckPoint` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `LocationID` int(6) NOT NULL,
  `TanggalPatroli` datetime(6) NOT NULL,
  `KodeKaryawan` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Koordinat` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Image` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Catatan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Rank` int(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of patroli
-- ----------------------------

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionname` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `link` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ico` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `menusubmenu` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `multilevel` bit(1) NULL DEFAULT NULL,
  `separator` bit(1) NULL DEFAULT NULL,
  `order` int(255) NULL DEFAULT NULL,
  `status` bit(1) NULL DEFAULT NULL,
  `AllowMobile` bit(1) NULL DEFAULT NULL,
  `MobileRoute` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `MobileLogo` int(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, 'Master', '', 'fa-archive', '0', b'1', b'0', 1, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (2, 'Lokasi Patroli', 'lokasi', NULL, '1', b'0', b'0', 2, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (3, 'Titik Patroli', 'checkpoint', NULL, '1', b'0', b'0', 3, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (4, 'Pengaturan User', NULL, NULL, '1', b'0', b'1', 4, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (5, 'Permission', 'role', NULL, '1', b'0', b'0', 5, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (6, 'User', 'user', NULL, '1', b'0', b'0', 6, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (7, 'Review Patroli', 'review', 'fa-laptop', '0', b'0', b'0', 7, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (8, 'Laporan', '', 'fa-file-text-o', '0', b'1', b'0', 8, b'0', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (9, 'Laporan Patroli', NULL, NULL, '8', b'0', b'0', 9, b'0', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (10, 'Security', 'security', NULL, '1', b'0', b'0', 3, b'1', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for permissionrole
-- ----------------------------
DROP TABLE IF EXISTS `permissionrole`;
CREATE TABLE `permissionrole`  (
  `roleid` int(11) NOT NULL,
  `permissionid` int(11) NOT NULL
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permissionrole
-- ----------------------------
INSERT INTO `permissionrole` VALUES (1, 1);
INSERT INTO `permissionrole` VALUES (1, 2);
INSERT INTO `permissionrole` VALUES (1, 3);
INSERT INTO `permissionrole` VALUES (1, 4);
INSERT INTO `permissionrole` VALUES (1, 5);
INSERT INTO `permissionrole` VALUES (1, 6);
INSERT INTO `permissionrole` VALUES (1, 7);
INSERT INTO `permissionrole` VALUES (1, 8);
INSERT INTO `permissionrole` VALUES (1, 9);
INSERT INTO `permissionrole` VALUES (1, 10);
INSERT INTO `permissionrole` VALUES (2, 1);
INSERT INTO `permissionrole` VALUES (2, 3);
INSERT INTO `permissionrole` VALUES (2, 7);

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'Super Admin');
INSERT INTO `roles` VALUES (2, 'Admin');
INSERT INTO `roles` VALUES (3, 'Security');

-- ----------------------------
-- Table structure for tcheckpoint
-- ----------------------------
DROP TABLE IF EXISTS `tcheckpoint`;
CREATE TABLE `tcheckpoint`  (
  `KodeCheckPoint` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaCheckPoint` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Keterangan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `LocationID` int(6) NOT NULL,
  `RecordOwnerID` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`KodeCheckPoint`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tcheckpoint
-- ----------------------------

-- ----------------------------
-- Table structure for tcompany
-- ----------------------------
DROP TABLE IF EXISTS `tcompany`;
CREATE TABLE `tcompany`  (
  `KodePartner` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaPartner` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `AlamatTagihan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NoTlp` varchar(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NoHP` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NIKPIC` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaPIC` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `CreatedOn` datetime(6) NOT NULL,
  `CreatedBy` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `LastUpdatedOn` datetime(0) NULL DEFAULT NULL,
  `LastUpdatedBy` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tempStore` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`KodePartner`) USING BTREE,
  INDEX `idxKodePartner`(`KodePartner`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tcompany
-- ----------------------------

-- ----------------------------
-- Table structure for tlokasipatroli
-- ----------------------------
DROP TABLE IF EXISTS `tlokasipatroli`;
CREATE TABLE `tlokasipatroli`  (
  `id` int(55) NOT NULL AUTO_INCREMENT,
  `NamaArea` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `AlamatArea` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Keterangan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `RecordOwnerID` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `StartPatroli` time(6) NOT NULL,
  `IntervalPatroli` int(6) NOT NULL,
  `IntervalType` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `EndPatroli` time(6) NOT NULL,
  `Toleransi` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idxArea`(`RecordOwnerID`, `id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tlokasipatroli
-- ----------------------------

-- ----------------------------
-- Table structure for tsecurity
-- ----------------------------
DROP TABLE IF EXISTS `tsecurity`;
CREATE TABLE `tsecurity`  (
  `NIK` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaSecurity` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `JoinDate` date NOT NULL,
  `LocationID` int(11) NOT NULL,
  `Status` int(1) NOT NULL,
  `RecordOwnerID` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tempEncrypt` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`NIK`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tsecurity
-- ----------------------------

-- ----------------------------
-- Table structure for userrole
-- ----------------------------
DROP TABLE IF EXISTS `userrole`;
CREATE TABLE `userrole`  (
  `userid` int(11) NOT NULL,
  `roleid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`userid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of userrole
-- ----------------------------
INSERT INTO `userrole` VALUES (1, 1);
INSERT INTO `userrole` VALUES (2, 3);
INSERT INTO `userrole` VALUES (3, 2);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(75) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama` varchar(75) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `createdby` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `createdon` datetime(0) NULL DEFAULT NULL,
  `HakAkses` int(255) NULL DEFAULT NULL,
  `token` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `verified` bit(1) NULL DEFAULT NULL,
  `ip` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `browser` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `RecordOwnerID` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `AreaUser` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idUserID`(`id`, `username`, `RecordOwnerID`, `AreaUser`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'manager', 'AIS SYSTEM', '43ccdfe93ef6be87f4f41801a97a921a5af93260ac23433f9c3b4213dccc271ccd86efbe98bacf700f2cbb3e0a6b75c3d6c0eab486eb4d710abc7a10047fea41O4vHOjZA/dcmPfp2N8O+mO1v+ric5AIA86kuXkHWqCE=', 'AUTO', '2023-07-06 16:07:15', NULL, NULL, b'0', NULL, NULL, NULL, NULL, 'CL0001', '');
INSERT INTO `users` VALUES (2, '40001', 'Prasetyo Aji Wibowo', '08c2abdf5f355dd99e0bd5a522aaf33f34c218fc66a6081c87eac2d15a488b2397623d4864740432323e712eebdf05dc94996d5ac6f9790aadd0290b2b1121a6rluW9NwHpb6h0B7flaWJ7EzdPzQm31CWO++leUz4lro=', 'AUTO', '2023-07-07 22:00:32', NULL, NULL, b'0', NULL, NULL, NULL, NULL, 'CL0001', '2');
INSERT INTO `users` VALUES (3, 'admin', 'admin', '5aaee1cf7e3bfdf721e843016ba74b826ccbae063078b19216ca4378086926ae56097c3000905cd02ae4182f47efaeae3fcf1af91397c0436c37d95bc7647f20+NZD5suwmtSnc386E+xHuehMrq+uaJm734WUV6YTpzY=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'CL0001', '4');

-- ----------------------------
-- Triggers structure for table tcompany
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_addUser`;
delimiter ;;
CREATE TRIGGER `trg_addUser` AFTER INSERT ON `tcompany` FOR EACH ROW BEGIN
	INSERT into users(username, nama, `password`, CreatedBy, CreatedOn,verified,RecordOwnerID,AreaUser)
	VALUE
	('manager',NEW.NamaPartner,NEW.tempStore,'AUTO',NOW(),0,NEW.KodePartner,'');
	INSERT into userrole
	SELECT id, 1 FROM users where RecordOwnerID = NEW.KodePartner;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table tsecurity
-- ----------------------------
DROP TRIGGER IF EXISTS `trgAddUser`;
delimiter ;;
CREATE TRIGGER `trgAddUser` AFTER INSERT ON `tsecurity` FOR EACH ROW BEGIN
	INSERT into users(username, nama, `password`, CreatedBy, CreatedOn,verified,RecordOwnerID, AreaUser)
	VALUE
	(NEW.NIK,NEW.NamaSecurity,NEW.tempEncrypt,'AUTO',NOW(),0, NEW.RecordOwnerID, NEW.LocationID);
	INSERT into userrole
	SELECT id, 3 FROM users where username = NEW.NIK;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
