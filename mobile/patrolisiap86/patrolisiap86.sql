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

 Date: 16/10/2023 15:45:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for absensi
-- ----------------------------
DROP TABLE IF EXISTS `absensi`;
CREATE TABLE `absensi`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `RecordOwnerID` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `LocationID` int(11) NOT NULL,
  `KodeKaryawan` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `KoordinatIN` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ImageIN` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `KoordinatOUT` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ImageOUT` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `Tanggal` date NOT NULL,
  `Shift` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Checkin` datetime(6) NOT NULL,
  `CheckOut` datetime(6) NOT NULL,
  `CreatedOn` datetime(6) NOT NULL,
  `UpdatedOn` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of absensi
-- ----------------------------
INSERT INTO `absensi` VALUES (1, 'CL0001', 1, '10002', '-7.5569647,110.886366', 'IN10002-CL000120230906 16235.png', '-7.5569412,110.8863386', 'OUT10002-CL000120230906 16261.png', '2023-09-06', '1', '2023-09-06 16:23:57.139043', '2023-09-06 16:26:17.303113', '2023-09-06 16:23:57.139102', '2023-09-06 16:26:17');
INSERT INTO `absensi` VALUES (3, 'CL0001', 1, '10002', '-7.5570764,110.8864377', 'IN10002-CL000120230907 16254.png', '-7.5570428,110.8863956', 'OUT10002-CL000120230907 16262.png', '2023-09-07', '1', '2023-09-07 16:25:40.275218', '2023-09-07 16:26:28.673187', '2023-09-07 16:25:40.275311', '2023-09-07 16:26:28');

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pascode
-- ----------------------------
INSERT INTO `pascode` VALUES (1, '6335cde1452894c515ef1fed11c0ae4ab7dde23274804279db12fc7ab688ed8079a7b49e96c94f2ef396d82a948f6645ccffbe2b2dcf1d3a8926a9f5a98f47f4IRm+483OyL7DaYPh43vUg5rMRHnYVVmYk6AvctfINGc=', '2023-07-14 11:20:33.000000', 0);
INSERT INTO `pascode` VALUES (2, '42e70ada9ee900006ffa13527b99abebda9468f9772fd32b5080d74087bdf46e759cf733bd44b4b323eca8ee5c5ebb0b52be1ae6f149e30a5f9434d219b0834fMtq0XLGg9gBVzAMrfukZhGDrLI8v1Rhm/3D0yvTGsNo=', '2023-07-19 10:13:58.000000', 0);
INSERT INTO `pascode` VALUES (3, '8bbad4d647c50b2debf567b8fcc31578ca9941e79dd5c661d951a81bbcffa18e5d4ee63c979f9ed3fa0a72faa3b5b5b2af48ab4bd348c068f070af5c52741225RV0ZfWnWqAnfvB62wt6FvtbWpYd8yVksoQSe0TUQ/IY=', '1970-01-01 01:00:00.000000', 0);
INSERT INTO `pascode` VALUES (4, 'a7a16f71fa3f049045ac6030c8aa90fd2616d9638f8c1fbe15ad822c42eb9e6c4994c450030f901282ffda89a740700a52e1d23986f83af181478b26e655f302G3Laeh1NodI8No15KfH31OUX2J8THL0Nsns3v1Lcrsk=', '1970-01-01 01:00:00.000000', 0);
INSERT INTO `pascode` VALUES (5, '3c92263675538b5238abf5feb586dd8a64adde0ab3097aac1333d241ae64abf59bb860be24eaa2a7a9a8e822b962e9b08ebe148a0510d9efb02a9f0eb8a9c594txNdwkJIUvlnySz9XL5zu/oKqj9xu03x6IhrjSZwmmY=', '2023-09-25 00:00:00.000000', 0);

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
  `Shift` int(6) NOT NULL,
  `ShiftJadwal` int(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of patroli
-- ----------------------------
INSERT INTO `patroli` VALUES (1, 'CL0001', 'CP0001', 1, '2023-09-06 15:19:51.360987', '10002', '-7.5570391,110.8864556', 'scaled_1fafb941-984d-4590-9b51-a5ad5ea4c09d4266256757822224532.jpg', 'test', 0, 1, 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `permission` VALUES (11, 'Review Absensi', 'reviewabsen', 'fa-clock-o', '0', b'0', b'0', 10, b'1', NULL, NULL, NULL);

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
INSERT INTO `permissionrole` VALUES (2, 1);
INSERT INTO `permissionrole` VALUES (2, 3);
INSERT INTO `permissionrole` VALUES (2, 7);
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
INSERT INTO `permissionrole` VALUES (1, 11);

-- ----------------------------
-- Table structure for pricingtable
-- ----------------------------
DROP TABLE IF EXISTS `pricingtable`;
CREATE TABLE `pricingtable`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `PricingName` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NormalPrice` decimal(10, 2) NOT NULL,
  `DiscPrice` decimal(10, 2) NOT NULL,
  `DiscPercent` decimal(10, 2) NOT NULL,
  `PriceTerm` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Status` int(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pricingtable
-- ----------------------------
INSERT INTO `pricingtable` VALUES (1, 'BASIC', 300000.00, 0.00, 0.00, 'Unlimited User', 1);
INSERT INTO `pricingtable` VALUES (2, 'PAKET LENGKAP', 450000.00, 0.00, 0.00, 'Unlimited User', 1);
INSERT INTO `pricingtable` VALUES (3, 'TERLARIS', 450000.00, 135000.00, 30.00, 'Unlimited User\r\nMinimal Subscribe 12 Bulan', 1);

-- ----------------------------
-- Table structure for pricingterm
-- ----------------------------
DROP TABLE IF EXISTS `pricingterm`;
CREATE TABLE `pricingterm`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `PriceID` int(11) NOT NULL,
  `FiturDesc` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Allowed` int(1) NOT NULL COMMENT '1: Yes 0 :No',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pricingterm
-- ----------------------------
INSERT INTO `pricingterm` VALUES (1, 1, 'Akses Web Admin', 1);
INSERT INTO `pricingterm` VALUES (2, 1, 'Akses Review Patroli', 1);
INSERT INTO `pricingterm` VALUES (3, 1, 'Multi Site', 1);
INSERT INTO `pricingterm` VALUES (4, 1, 'Free Maintain', 1);
INSERT INTO `pricingterm` VALUES (5, 1, 'Unlimited User', 1);
INSERT INTO `pricingterm` VALUES (6, 1, 'Unlimited Checkpoint', 1);
INSERT INTO `pricingterm` VALUES (7, 1, 'Integrasi Absensi Deteksi Wajah', 0);
INSERT INTO `pricingterm` VALUES (8, 2, 'Akses Web Admin', 1);
INSERT INTO `pricingterm` VALUES (9, 2, 'Akses Review Patroli', 1);
INSERT INTO `pricingterm` VALUES (10, 2, 'Multi Site', 1);
INSERT INTO `pricingterm` VALUES (11, 2, 'Free Maintain', 1);
INSERT INTO `pricingterm` VALUES (12, 2, 'Unlimited User', 1);
INSERT INTO `pricingterm` VALUES (13, 2, 'Unlimited Checkpoint', 1);
INSERT INTO `pricingterm` VALUES (14, 2, 'Integrasi Absensi Deteksi Wajah', 1);
INSERT INTO `pricingterm` VALUES (15, 3, 'Akses Web Admin', 1);
INSERT INTO `pricingterm` VALUES (16, 3, 'Akses Review Patroli', 1);
INSERT INTO `pricingterm` VALUES (17, 3, 'Multi Site', 1);
INSERT INTO `pricingterm` VALUES (18, 3, 'Free Maintain', 1);
INSERT INTO `pricingterm` VALUES (19, 3, 'Unlimited User', 1);
INSERT INTO `pricingterm` VALUES (20, 3, 'Unlimited Checkpoint', 1);
INSERT INTO `pricingterm` VALUES (21, 3, 'Integrasi Absensi Deteksi Wajah', 1);

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
-- Table structure for sos
-- ----------------------------
DROP TABLE IF EXISTS `sos`;
CREATE TABLE `sos`  (
  `id` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `RecordOwnerID` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `LocationID` int(11) NOT NULL,
  `KodeKaryawan` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Comment` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Image1` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Image2` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Image3` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Koordinat` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `SubmitDate` datetime(0) NOT NULL,
  `VoiceNote` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sos
-- ----------------------------
INSERT INTO `sos` VALUES ('25d94f9f-3ace-41e6-ba66-6b9016a65b9e', 'CL0001', 1, '10001', '', '', '', '', '', '2023-08-27 21:21:36', '');
INSERT INTO `sos` VALUES ('2ba2031f-5a0c-4c8f-b061-e01653f25580', 'CL0001', 1, '10001', 'test', 'scaled_50cbf9dc-58ef-4620-b463-abe2ff50317b6672347739330804546.jpg', '', '', '37.4219983,-122.084', '2023-08-27 21:29:17', '');
INSERT INTO `sos` VALUES ('2e1c277e-fb79-4f0d-88f3-eab25f311612', 'CL0001', 1, '10001', '', 'scaled_50cbf9dc-58ef-4620-b463-abe2ff50317b6672347739330804546.jpg', '', '', '37.4219983,-122.084', '0000-00-00 00:00:00', '');
INSERT INTO `sos` VALUES ('36004d3b-4a88-4a0a-91fb-99fdd1206eeb', 'CL0001', 1, '10001', '', '', '', '', '', '2023-08-26 10:56:41', '');
INSERT INTO `sos` VALUES ('4e1f5812-42c2-4852-bb67-f093c9f5286a', 'CL0001', 1, '10001', 'hanya test saja', 'scaled_0f3f4915-e383-453d-b3f0-1db867129f153610401172486982835.jpg', 'scaled_0159d3a2-6c62-4f9e-83f6-a75b2d3e6c3a5075205920110002597.jpg', 'scaled_9186e2e4-4978-4d63-a59f-d114350b2bb18143695232328591163.jpg', '-7.5570723,110.8864349', '2023-08-29 15:37:10', '');
INSERT INTO `sos` VALUES ('5033c958-0c41-42a8-80ec-118f4d97fb9c', 'CL0001', 1, '10001', 'test', 'scaled_b59bb63d-2764-4bd4-ab22-79a4685647fa9151316881577538198.jpg', 'scaled_dce909c6-d87a-4fa7-a63e-5228929687436673286431836581426.jpg', '', '37.4219983,-122.084', '2023-08-29 14:36:15', '');
INSERT INTO `sos` VALUES ('5d65dc29-c93b-4993-81cc-5dd2d8e789bf', 'CL0001', 1, '10001', '', '', '', '', '', '2023-08-25 15:02:17', '');
INSERT INTO `sos` VALUES ('6a3f1553-c46c-47a4-8f71-89a16e14bebb', 'CL0001', 1, '10001', '', '', '', '', '', '2023-08-27 21:24:17', '');
INSERT INTO `sos` VALUES ('72b2db93-2930-455e-bdcc-d99f5a1a594a', 'CL0001', 1, '10001', '', '', '', '', '', '2023-08-25 21:42:06', '');
INSERT INTO `sos` VALUES ('79f7f306-4d17-4830-9ac1-45243e31bf02', 'CL0001', 1, '10001', '', '', '', '', '', '2023-08-26 10:47:33', '');
INSERT INTO `sos` VALUES ('924c7def-a0e2-4697-bfb5-afb98d5834a6', 'CL0001', 1, '10001', '', '', '', '', '', '2023-08-27 21:31:49', '');
INSERT INTO `sos` VALUES ('92be762b-67a4-433f-b7a1-0a86a830e09e', 'CL0001', 1, '10001', '', '', '', '', '', '2023-08-26 10:50:31', '');
INSERT INTO `sos` VALUES ('937a6067-bd5d-4657-9bd0-f061da17e5a3', 'CL0001', 1, '10001', '', '', '', '', '', '2023-08-27 21:22:46', '');
INSERT INTO `sos` VALUES ('99c04e1b-b671-4422-b6c4-9d4c2b0564d4', 'CL0001', 1, '10001', '', '', '', '', '', '2023-08-26 10:47:07', '');
INSERT INTO `sos` VALUES ('9d0dbe05-f9f4-4c08-ac20-725f3f2d92d5', 'CL0001', 1, '10002', 'TEST SAJA', 'scaled_c94c0760-efcd-4a84-ba4c-7824ef2880891301379685331094902.jpg', 'scaled_cc25d9cc-05cb-4abf-8af1-14072d97be011617177721198579679.jpg', '', '37.4219983,-122.084', '2023-08-29 15:38:41', '');
INSERT INTO `sos` VALUES ('adc7f387-ee1f-4a83-996e-9e4ce6be7d59', 'CL0001', 1, '10001', '', '', '', '', '', '2023-08-27 21:34:09', '');
INSERT INTO `sos` VALUES ('b95dad3d-93b1-427c-bfed-44b8664c986a', 'CL0001', 1, '10001', '', '', '', '', '', '2023-08-26 10:57:43', '');
INSERT INTO `sos` VALUES ('ba9d0a61-1fb2-4a62-bd3c-c6f6bc641a00', 'CL0001', 1, '10001', '', '', '', '', '', '2023-08-27 21:26:03', '');
INSERT INTO `sos` VALUES ('c2ea8c3d-aaf1-4486-85b7-f4d7f6b55322', 'CL0001', 1, '10001', '', '', '', '', '', '2023-08-25 21:44:36', '');
INSERT INTO `sos` VALUES ('c5149032-e9f0-4642-b4b5-0fa83bf880b7', 'CL0001', 1, '10001', '', '', '', '', '', '2023-08-26 10:51:09', '');
INSERT INTO `sos` VALUES ('d8a9ca4c-f756-47ba-8895-54e96961c27f', 'CL0001', 1, '10001', '', '', '', '', '', '2023-08-27 21:23:55', '');
INSERT INTO `sos` VALUES ('f0b2a5f2-f23e-4b59-ada6-de78e8efb087', 'CL0001', 1, '10001', '', 'scaled_bdf78be5-c745-4d92-973e-35e8cc34d650303480280597921717.jpg', '', '', '37.4219983,-122.084', '0000-00-00 00:00:00', '');

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
INSERT INTO `tcheckpoint` VALUES ('CP0001', 'LOkasi 1', 'test', 1, 'CL0001');
INSERT INTO `tcheckpoint` VALUES ('CP0002', 'LOkasi 2', 'test', 1, 'CL0001');

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
INSERT INTO `tcompany` VALUES ('CL0001', 'AIS SYSTEM', 'SOLO', '+62813250582', '081325058258', '123123', 'Prasetyo Aji Wibowo', '2023-07-18 10:15:58.000000', 'AIS SYSTEM', NULL, NULL, 'a4e02866dbc21c10bd842c47ba3655c54305620d34e7dedd5fe66210919e1eab9f4ad6a42306b9ff72d94df4fbe9654d2d091be5dd8103e70193752cb5f17428Ed6j9QkeubnsGcflczqCUVazpvijx69P3yYZhyuWfKw=');

-- ----------------------------
-- Table structure for tjadwal
-- ----------------------------
DROP TABLE IF EXISTS `tjadwal`;
CREATE TABLE `tjadwal`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `RecordOwnerID` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Tanggal` date NOT NULL,
  `NIK` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Jadwal` int(6) NOT NULL,
  `StatusKehadiran` int(6) NULL DEFAULT NULL COMMENT '-1 : OFF, -2 : Izin, -3 : Alpha',
  `Keterangan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `CreatedBy` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `CreatedOn` datetime(6) NOT NULL,
  `LastUpdatedBy` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `LastUpdatedOn` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tjadwal
-- ----------------------------
INSERT INTO `tjadwal` VALUES (4, 'CL0001', '2023-09-04', '10002', 3, -1, '', '6', '2023-09-04 04:57:39.000000', NULL, NULL);
INSERT INTO `tjadwal` VALUES (5, 'CL0001', '2023-09-05', '10002', 3, -1, '', '6', '2023-09-05 04:49:15.000000', NULL, NULL);
INSERT INTO `tjadwal` VALUES (6, 'CL0001', '2023-09-06', '10002', 1, -1, '', '6', '2023-09-06 09:54:24.000000', NULL, NULL);
INSERT INTO `tjadwal` VALUES (7, 'CL0001', '2023-09-07', '10002', 1, -1, '', '6', '2023-09-07 11:19:10.000000', NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tlokasipatroli
-- ----------------------------
INSERT INTO `tlokasipatroli` VALUES (1, 'PT ANGKASA PURA', 'MERAK BANTEN', 'test', 'CL0001', '07:00:00.000000', 2, 'HOUR', '15:00:00.000000', '15');
INSERT INTO `tlokasipatroli` VALUES (2, 'PT XYZ', 'SOLO', 'test', 'CL0001', '00:00:00.000000', 2, 'HOUR', '00:00:00.000000', '15');

-- ----------------------------
-- Table structure for tpaymentmethod
-- ----------------------------
DROP TABLE IF EXISTS `tpaymentmethod`;
CREATE TABLE `tpaymentmethod`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `NamaMetode` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ExternalCode` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `BiayaAdminRp` double(16, 2) NOT NULL,
  `BiayaAdminPersen` double(16, 2) NULL DEFAULT NULL,
  `JenisVerifikasi` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NomorRekeningPembayaran` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaPemilikRekening` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `SotingIndex` int(255) NOT NULL,
  `Tutorial` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Active` int(255) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tpaymentmethod
-- ----------------------------
INSERT INTO `tpaymentmethod` VALUES (1, 'Virtual Account BCA', 'bca', 1500.00, 0.00, 'AUTO', '', '', 0, '', 1);
INSERT INTO `tpaymentmethod` VALUES (2, 'Virtual Account BNI', 'bni', 0.00, 1.50, 'AUTO', '', '', 1, '', 1);
INSERT INTO `tpaymentmethod` VALUES (3, 'Transfer Manual BCA', '', 0.00, 0.00, 'MANUAL', '123456', 'AJI', 2, '', 1);

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
  `Shift` int(6) NOT NULL,
  `Image` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  PRIMARY KEY (`NIK`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tsecurity
-- ----------------------------
INSERT INTO `tsecurity` VALUES ('10001', 'Sujarwao', '2023-07-19', 1, 1, 'CL0001', '4f9a1891299bc00c2ce283521218423185c649a69a8c98b078cc0417333234d4f71e5b33e0689490925b145da16caf9324f89ef61882be10b414371f5e4c5782+TFgIWbNibUo/LCuDu5NDmJD/sP4HXBgibwqd4VzEHA=', 1, NULL);
INSERT INTO `tsecurity` VALUES ('10002', 'Sutoyo', '2023-08-25', 1, 1, 'CL0001', '549e19140cf54ba601014159377c41118bb64b26204a4a33ab14c715a08be4af56ca940ac44acfd629b7a42435348c60c4ee73f1d9c54aaec0247a1d990ab1a2NGi1TjrQHzgQR4quoerUnW1L42PZX9I5+To8FF3TrOw=', 1, 'data:image/jpeg;base64,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');

-- ----------------------------
-- Table structure for tshift
-- ----------------------------
DROP TABLE IF EXISTS `tshift`;
CREATE TABLE `tshift`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `NamaShift` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `MulaiBekerja` time(6) NOT NULL,
  `SelesaiBekerja` time(6) NOT NULL,
  `IntervalPatroli` int(6) NOT NULL,
  `IntervalType` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Toleransi` int(6) NOT NULL,
  `RecordOwnerID` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `LocationID` int(11) NOT NULL,
  `GantiHari` int(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tshift
-- ----------------------------
INSERT INTO `tshift` VALUES (1, 'Pagi', '08:00:00.000000', '20:00:00.000000', 2, 'HOUR', 15, 'CL0001', 1, 0);
INSERT INTO `tshift` VALUES (3, 'malam', '20:00:00.000000', '08:00:00.000000', 2, 'HOUR', 15, 'CL0001', 1, 1);

-- ----------------------------
-- Table structure for tstatuskehadiran
-- ----------------------------
DROP TABLE IF EXISTS `tstatuskehadiran`;
CREATE TABLE `tstatuskehadiran`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Nama` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tstatuskehadiran
-- ----------------------------
INSERT INTO `tstatuskehadiran` VALUES (1, 'OFF');
INSERT INTO `tstatuskehadiran` VALUES (2, 'IZIN');
INSERT INTO `tstatuskehadiran` VALUES (3, 'ALPHA');

-- ----------------------------
-- Table structure for userrole
-- ----------------------------
DROP TABLE IF EXISTS `userrole`;
CREATE TABLE `userrole`  (
  `userid` int(11) NOT NULL,
  `roleid` int(11) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of userrole
-- ----------------------------
INSERT INTO `userrole` VALUES (1, 1);
INSERT INTO `userrole` VALUES (2, 3);
INSERT INTO `userrole` VALUES (3, 2);
INSERT INTO `userrole` VALUES (1, 1);
INSERT INTO `userrole` VALUES (2, 1);
INSERT INTO `userrole` VALUES (3, 1);
INSERT INTO `userrole` VALUES (6, 1);
INSERT INTO `userrole` VALUES (7, 3);
INSERT INTO `userrole` VALUES (8, 3);
INSERT INTO `userrole` VALUES (9, 3);

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
  `UserToken` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idUserID`(`id`, `username`, `RecordOwnerID`, `AreaUser`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'manager', 'AIS SYSTEM', '43ccdfe93ef6be87f4f41801a97a921a5af93260ac23433f9c3b4213dccc271ccd86efbe98bacf700f2cbb3e0a6b75c3d6c0eab486eb4d710abc7a10047fea41O4vHOjZA/dcmPfp2N8O+mO1v+ric5AIA86kuXkHWqCE=', 'AUTO', '2023-07-06 16:07:15', NULL, NULL, b'0', NULL, NULL, NULL, NULL, '', '', NULL);
INSERT INTO `users` VALUES (2, '40001', 'Prasetyo Aji Wibowo', '08c2abdf5f355dd99e0bd5a522aaf33f34c218fc66a6081c87eac2d15a488b2397623d4864740432323e712eebdf05dc94996d5ac6f9790aadd0290b2b1121a6rluW9NwHpb6h0B7flaWJ7EzdPzQm31CWO++leUz4lro=', 'AUTO', '2023-07-07 22:00:32', NULL, NULL, b'0', NULL, NULL, NULL, NULL, '', '2', NULL);
INSERT INTO `users` VALUES (3, 'admin', 'admin', '5aaee1cf7e3bfdf721e843016ba74b826ccbae063078b19216ca4378086926ae56097c3000905cd02ae4182f47efaeae3fcf1af91397c0436c37d95bc7647f20+NZD5suwmtSnc386E+xHuehMrq+uaJm734WUV6YTpzY=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '', '4', NULL);
INSERT INTO `users` VALUES (6, 'manager', 'AIS SYSTEM', 'a4e02866dbc21c10bd842c47ba3655c54305620d34e7dedd5fe66210919e1eab9f4ad6a42306b9ff72d94df4fbe9654d2d091be5dd8103e70193752cb5f17428Ed6j9QkeubnsGcflczqCUVazpvijx69P3yYZhyuWfKw=', 'AUTO', '2023-07-18 15:15:58', NULL, NULL, b'0', NULL, NULL, NULL, NULL, 'CL0001', '', NULL);
INSERT INTO `users` VALUES (7, '10001', 'Sujarwao', '4f9a1891299bc00c2ce283521218423185c649a69a8c98b078cc0417333234d4f71e5b33e0689490925b145da16caf9324f89ef61882be10b414371f5e4c5782+TFgIWbNibUo/LCuDu5NDmJD/sP4HXBgibwqd4VzEHA=', 'AUTO', '2023-07-19 20:39:17', NULL, NULL, b'0', NULL, NULL, NULL, NULL, 'CL0001', '1', 'eKPX1qOLScy_IVFsuhwghb:APA91bEePXLSA06DuxvTT9GMgxQrt6xwng1orV4mjqtZt9MWZRBo5ovI8xPWPoHDxixMX8y1B8lplfT0NH9tc7OMVT4cx9kijMnYfgPhP0cfaWBdbwj5_c9Kd7Y38YysK4p5NeexfPIZ');
INSERT INTO `users` VALUES (9, '10002', 'Sutoyo', '89ff0a38d8bb82cc2440a9758d98788acfd455c566703ad9940676a4596b7d7bb6175f3a7f969018f12223e60df153ba5aee7f865097cf0fb6eac71c1538c772JmMD1gEoSRqdnf/gE5tfyluu7GrQ9Fgro40TDOUEEQs=', 'AUTO', '2023-08-25 14:05:13', NULL, NULL, b'0', NULL, NULL, NULL, NULL, 'CL0001', '1', 'dZRN-SQeTcGiQjcUQg8Uw8:APA91bF_VBcENCzK3rztWCsy5O3wmdzd-vVwhYRNXqfFBI48ew4TQUk9asnjX0Vhk94bR_zljI0Q7Kcynws9H6lUSEzjv90bdcvbri1zhx6vLur76yZ_DI8teN5tDb17SC7DRanisB2x');

-- ----------------------------
-- Function structure for fn_createIDDayName
-- ----------------------------
DROP FUNCTION IF EXISTS `fn_createIDDayName`;
delimiter ;;
CREATE FUNCTION `fn_createIDDayName`(`Tanggal` date)
 RETURNS varchar(55) CHARSET latin1
BEGIN
	#Routine body goes here...
	SET @DayName = '';
	SET @idDayName = '';
	
	SELECT DAYNAME(Tanggal) into @DayName;
	
	IF @DayName = 'Sunday' THEN set @idDayName= 'Minggu'; END IF;	
	IF @DayName = 'Monday' THEN set @idDayName= 'Senin'; END IF;	
	IF @DayName = 'Tuesday' THEN set @idDayName= 'Selasa'; END IF;	
	IF @DayName = 'Wednesday' THEN set @idDayName= 'Rabu'; END IF;	
	IF @DayName = 'Thursday' THEN set @idDayName= 'Kamis'; END IF;	
	IF @DayName = 'Friday' THEN set @idDayName= 'Jumat'; END IF;	
	IF @DayName = 'Saturday' THEN set @idDayName= 'Sabtu'; END IF;	
	RETURN @idDayName;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for fn_CreateSchedule
-- ----------------------------
DROP PROCEDURE IF EXISTS `fn_CreateSchedule`;
delimiter ;;
CREATE PROCEDURE `fn_CreateSchedule`(IN `Shift` int)
BEGIN
-- 	DECLARE B INT;  
	DECLARE jamfix DATETIME;
	SET @jmlLoop = 0;
	SET @intervaltime = 0;
	SET @Toleransi = 0;
-- 	SET @Time as TIME;
-- 	DECLARE jamfix TIME DEFAULT TIME(NOW());
	
	drop temporary table if exists temp;
	
	SELECT 
		TIMESTAMPDIFF(HOUR,CONCAT(DATE(NOW()), ' ', MulaiBekerja),
	CASE WHEN GantiHari = 1 THEN DATE_ADD(CONCAT(DATE(NOW()), ' ', SelesaiBekerja), INTERVAL 1 day) ELSE CONCAT(DATE(NOW()), ' ', SelesaiBekerja) END
	), 
		a.IntervalPatroli, 
		a.Toleransi,
		CONCAT(DATE(NOW()), ' ', MulaiBekerja)
	INTO @jmlLoop,@intervaltime, @Toleransi , jamfix
	FROM tshift a where a.id = Shift;
	
-- 	SELECT TIMESTAMPDIFF(HOUR,MulaiBekerja,SelesaiBekerja) FROM tshift WHERE id = Shift;
	create temporary table temp(Jadwal TIME, idx int);
	
	SET @Counter = 0;
	
-- 	SELECT @jmlLoop / @intervaltime, @Counter;
	WHILE @Counter < (@jmlLoop / @intervaltime) +1 DO
		INSERT INTO temp
		VALUES(TIME(jamfix), @Counter);
		
		SELECT TIMESTAMPADD(HOUR,@intervaltime,jamfix) INTO jamfix;
		
		SET @Counter = @Counter + 1;
	END WHILE;
	
-- 	SELECT * from temp;
-- 	SELECT @jmlLoop;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for fn_ReadReview
-- ----------------------------
DROP PROCEDURE IF EXISTS `fn_ReadReview`;
delimiter ;;
CREATE PROCEDURE `fn_ReadReview`(IN `TglAwal` DATE, IN TglAkhir DATE, IN RecordOwnerID VARCHAR(55), IN KodeKaryawan VARCHAR(55), IN LocationID VARCHAR(55))
BEGIN
-- 	DECLARE B INT;  
	DECLARE jamfix DATETIME;
	DECLARE cursor_ID INT;
	DECLARE cursor_location INT;
  DECLARE done INT ;
	DECLARE cursor_i CURSOR FOR SELECT x.id, x.LocationID FROM tshift x where x.RecordOwnerID = RecordOwnerID AND (x.LocationID = LocationID OR LocationID = '');
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	drop temporary table if exists temp;
	create temporary table temp(Jadwal TIME, idx int, shiftid int, LocationID int);
	
	SET @jmlLoop = 0;
	SET @intervaltime = 0;
	SET @Toleransi = 0;
-- 	SET @Time as TIME;
-- 	DECLARE jamfix TIME DEFAULT TIME(NOW());
-- 	SELECT * FROM tshift x where x.RecordOwnerID = RecordOwnerID AND x.LocationID = LocationID;
	OPEN cursor_i;
	
	read_loop: LOOP
		FETCH cursor_i INTO cursor_ID, cursor_location;

-- 			SELECT cursor_ID;
			-- 			Done
			IF done THEN
				LEAVE read_loop;
			END IF;
			
			SELECT 
				TIMESTAMPDIFF(HOUR,CONCAT(DATE(NOW()), ' ', MulaiBekerja), CASE WHEN GantiHari = 1 THEN DATE_ADD(CONCAT(DATE(NOW()), ' ', SelesaiBekerja), INTERVAL 1 day) ELSE CONCAT(DATE(NOW()), ' ', SelesaiBekerja) END
	), 
				a.IntervalPatroli, 
				a.Toleransi,
				CONCAT(DATE(NOW()), ' ', MulaiBekerja)
			INTO @jmlLoop,@intervaltime, @Toleransi , jamfix
			FROM tshift a where a.id = cursor_ID AND a.LocationID = cursor_location;
			
-- 			SELECT * FROM tshift where id = cursor_ID;
			SET @Counter = 0;
			
		-- 	SELECT @jmlLoop / @intervaltime, @Counter;
			WHILE @Counter < (@jmlLoop / @intervaltime) +1 DO
				INSERT INTO temp
				VALUES(TIME(jamfix), @Counter,cursor_ID,cursor_location);
				
				SELECT TIMESTAMPADD(HOUR,@intervaltime,jamfix) INTO jamfix;
				
				SET @Counter = @Counter + 1;
			END WHILE;
			
			
		END LOOP;
		CLOSE cursor_i;
	
		
		SELECT 
				a.id,
				c.NamaArea				AS NamaLokasi,
				d.NamaSecurity,
				b.NamaCheckPoint,
				a.Koordinat,
				a.Image,
				a.Catatan,
				DATE_FORMAT(a.TanggalPatroli,'%d/%m/%Y') TanggalPatroli,
				e.Jadwal JamJadwal,
				DATE_FORMAT(a.TanggalPatroli,'%H:%i:%S') JamAktual,
				CONCAT('00:',f.Toleransi,':00') Toleransi,
				a.Shift,
				f.NamaShift,
				f.GantiHari
			FROM patroli a
			LEFT JOIN tcheckpoint b on a.KodeCheckPoint = b.KodeCheckPoint and a.RecordOwnerID = b.RecordOwnerID AND a.LocationID = b.LocationID
			LEFT JOIN tlokasipatroli c on a.LocationID = c.id AND a.RecordOwnerID = c.RecordOwnerID
			LEFT JOIN tsecurity d on a.KodeKaryawan = d.NIK = a.RecordOwnerID = d.RecordOwnerID
			LEFT JOIN temp e on a.Rank = e.idx AND a.Shift = e.shiftid AND a.LocationID = e.LocationID
			LEFT JOIN tshift f on a.Shift = f.id and a.RecordOwnerID = f.RecordOwnerID
			WHERE DATE(a.TanggalPatroli) BETWEEN TglAwal AND TglAkhir
			AND a.RecordOwnerID = RecordOwnerID
			AND (a.LocationID = LocationID or LocationID = '')
			AND (a.KodeKaryawan = KodeKaryawan or KodeKaryawan = '')
			ORDER BY a.TanggalPatroli;
-- 	SELECT * from temp;
-- 	SELECT @jmlLoop;
END
;;
delimiter ;

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

-- ----------------------------
-- Triggers structure for table tsecurity
-- ----------------------------
DROP TRIGGER IF EXISTS `trgDeleteUser`;
delimiter ;;
CREATE TRIGGER `trgDeleteUser` AFTER DELETE ON `tsecurity` FOR EACH ROW BEGIN
	DELETE FROM users WHERE username = OLD.NIK;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
