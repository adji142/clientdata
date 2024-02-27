/*
 Navicat Premium Data Transfer

 Source Server         : AISServer
 Source Server Type    : MySQL
 Source Server Version : 100240
 Source Host           : localhost:3306
 Source Schema         : epaymentsys

 Target Server Type    : MySQL
 Target Server Version : 100240
 File Encoding         : 65001

 Date: 27/06/2023 20:31:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bukukas
-- ----------------------------
DROP TABLE IF EXISTS `bukukas`;
CREATE TABLE `bukukas`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `TglTransaksi` date NOT NULL,
  `TglPencatatan` datetime(6) NOT NULL,
  `KodeAkun` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Keterangan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `UangMasuk` double(16, 2) NOT NULL,
  `UangKeluar` double(16, 2) NOT NULL,
  `BaseNum` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `BaseLine` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bukukas
-- ----------------------------

-- ----------------------------
-- Table structure for pembayarandetail
-- ----------------------------
DROP TABLE IF EXISTS `pembayarandetail`;
CREATE TABLE `pembayarandetail`  (
  `NoTransaksi` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `LineNumber` int(11) NOT NULL,
  `KodeItemTagihan` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaItemTagihan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Jumlah` double(16, 2) NOT NULL,
  `BaseNum` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `BaseLine` int(11) NOT NULL
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pembayarandetail
-- ----------------------------

-- ----------------------------
-- Table structure for pembayaranheader
-- ----------------------------
DROP TABLE IF EXISTS `pembayaranheader`;
CREATE TABLE `pembayaranheader`  (
  `NoTransaksi` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `TglTransaksi` date NOT NULL,
  `TglPencatatan` datetime(6) NOT NULL,
  `Keterangan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `CreatedBy` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `CreatedOn` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`NoTransaksi`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pembayaranheader
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
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, 'Pengaturan User', '', 'fa-adjust', '0', b'1', b'0', 1, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (2, 'Level User', 'role', '', '1', b'0', b'0', 2, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (3, 'User', 'user', '', '1', b'0', b'0', 3, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (4, 'Master Data', '', 'fa-archive', '0', b'1', b'0', 4, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (5, 'Jurusan', 'jurusan', ' ', '4', b'0', b'0', 5, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (6, 'Kelas', 'kelas', '', '4', b'0', b'0', 6, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (7, 'Siswa', 'siswa', '', '4', b'0', b'0', 7, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (8, 'Keuangan', '', ' ', '4', b'0', b'1', 8, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (9, 'Pos Keuangan', 'poskeu', ' ', '4', b'0', b'0', 9, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (10, 'Jenis Tagihan Siswa', 'jenistagihan', '', '4', b'0', b'0', 10, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (11, 'Transaksi', '', 'fa-pencil', '0', b'1', b'0', 11, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (12, 'Tagihan Siswa', 'tagihan', '', '11', b'0', b'0', 12, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (13, 'Pembayaran Siswa', 'pembayaran', ' ', '11', b'0', b'0', 13, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (14, 'Keuangan', '', ' ', '11', b'0', b'1', 14, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (15, 'Buku Kas', 'bukukas', '', '11', b'0', b'0', 15, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (16, 'Laporan', '', 'fa-file', '0', b'1', b'0', 16, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (17, 'Laporan Pembayaran Siswa', 'viewpembayaran', '', '16', b'1', b'0', 17, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (18, 'Laporan Keuangan', 'viewkeuangan', '', '16', b'1', b'0', 18, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (19, 'Profile', 'profile', 'fa-user', '0', b'0', b'0', 19, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (20, 'Tagihan', 'tagihansiswa', 'fa-list', '0', b'0', b'0', 20, b'1', NULL, NULL, NULL);

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
INSERT INTO `permissionrole` VALUES (1, 11);
INSERT INTO `permissionrole` VALUES (1, 12);
INSERT INTO `permissionrole` VALUES (1, 13);
INSERT INTO `permissionrole` VALUES (1, 14);
INSERT INTO `permissionrole` VALUES (1, 15);
INSERT INTO `permissionrole` VALUES (1, 16);
INSERT INTO `permissionrole` VALUES (1, 17);
INSERT INTO `permissionrole` VALUES (1, 18);
INSERT INTO `permissionrole` VALUES (4, 19);
INSERT INTO `permissionrole` VALUES (4, 20);
INSERT INTO `permissionrole` VALUES (5, 11);
INSERT INTO `permissionrole` VALUES (5, 12);
INSERT INTO `permissionrole` VALUES (5, 13);
INSERT INTO `permissionrole` VALUES (5, 16);
INSERT INTO `permissionrole` VALUES (5, 17);

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'Admin');
INSERT INTO `roles` VALUES (4, 'Siswa');
INSERT INTO `roles` VALUES (5, 'Tata Usaha');

-- ----------------------------
-- Table structure for tagihandetail
-- ----------------------------
DROP TABLE IF EXISTS `tagihandetail`;
CREATE TABLE `tagihandetail`  (
  `NoTransaksi` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `LineNumber` int(11) NOT NULL,
  `KodeItemTagihan` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaItemTagihan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `JumlahTagihan` double(16, 2) NOT NULL,
  `LastUpdatedOn` datetime(0) NULL DEFAULT NULL,
  `LastUpdatedBy` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tagihandetail
-- ----------------------------

-- ----------------------------
-- Table structure for tagihanheader
-- ----------------------------
DROP TABLE IF EXISTS `tagihanheader`;
CREATE TABLE `tagihanheader`  (
  `NoTransaksi` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `TglTransaksi` date NOT NULL,
  `TglPencatatan` datetime(0) NOT NULL,
  `TglTagihan` date NOT NULL,
  `TglJatuhTempo` date NOT NULL,
  `TahunAjaran` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NISSiswa` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaSiswa` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Keterangan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `LastUpdatedOn` datetime(0) NULL DEFAULT NULL,
  `LastUpdatedBy` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`NoTransaksi`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tagihanheader
-- ----------------------------

-- ----------------------------
-- Table structure for tjenistagihan
-- ----------------------------
DROP TABLE IF EXISTS `tjenistagihan`;
CREATE TABLE `tjenistagihan`  (
  `KodeTagihan` int(11) NOT NULL AUTO_INCREMENT,
  `NamaTagihan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `KodePosKeuangan` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`KodeTagihan`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tjenistagihan
-- ----------------------------
INSERT INTO `tjenistagihan` VALUES (2, 'SPP Bulanan', '1001');
INSERT INTO `tjenistagihan` VALUES (3, 'Tagihan Seragam', '1002');
INSERT INTO `tjenistagihan` VALUES (4, 'Tagihan Buku LKS', '1004');

-- ----------------------------
-- Table structure for tjurusan
-- ----------------------------
DROP TABLE IF EXISTS `tjurusan`;
CREATE TABLE `tjurusan`  (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `NamaJurusan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tjurusan
-- ----------------------------
INSERT INTO `tjurusan` VALUES (1, 'Teknik Kendaraan Ringan');
INSERT INTO `tjurusan` VALUES (2, 'Teknik Komputer dan Jaringan');

-- ----------------------------
-- Table structure for tkelas
-- ----------------------------
DROP TABLE IF EXISTS `tkelas`;
CREATE TABLE `tkelas`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `NamaKelas` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tkelas
-- ----------------------------
INSERT INTO `tkelas` VALUES (1, 'XI');
INSERT INTO `tkelas` VALUES (2, 'XI-1');
INSERT INTO `tkelas` VALUES (3, 'XI-2');
INSERT INTO `tkelas` VALUES (4, 'XII');
INSERT INTO `tkelas` VALUES (5, 'XII-1');
INSERT INTO `tkelas` VALUES (6, 'XII-2');

-- ----------------------------
-- Table structure for tposkeuangan
-- ----------------------------
DROP TABLE IF EXISTS `tposkeuangan`;
CREATE TABLE `tposkeuangan`  (
  `KodePosKeuangan` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaPos` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `JenisPos` int(11) NOT NULL COMMENT '1:Masuk, 0: Keluar',
  PRIMARY KEY (`KodePosKeuangan`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tposkeuangan
-- ----------------------------
INSERT INTO `tposkeuangan` VALUES ('1001', 'Penerimaan SPP', 1);
INSERT INTO `tposkeuangan` VALUES ('1002', 'Penerimaan Seragam', 1);
INSERT INTO `tposkeuangan` VALUES ('1003', 'Gaji Guru', 0);
INSERT INTO `tposkeuangan` VALUES ('1004', 'Penerimaan Uang Buku LKS', 1);
INSERT INTO `tposkeuangan` VALUES ('1005', 'Pengeluaran Sosial', 0);

-- ----------------------------
-- Table structure for tsiswa
-- ----------------------------
DROP TABLE IF EXISTS `tsiswa`;
CREATE TABLE `tsiswa`  (
  `NIS` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaSiswa` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `AlamatSiswa` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaWali` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Kelas` int(11) NOT NULL,
  `Jurusan` int(11) NOT NULL,
  `TempatLahir` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `TglLahir` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `NoTlpSiswa` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `NoTlpWali` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Email` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `TahunAngkatan` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `SaldoTagihanSiswa` double(16, 0) NULL DEFAULT NULL,
  PRIMARY KEY (`NIS`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tsiswa
-- ----------------------------
INSERT INTO `tsiswa` VALUES ('1058', 'ADIT HARI RAMADHAN', 'Wonorejo, Wonorejo, Kalijambe ', '', 4, 2, 'PURBALINGGA', '2006-10-09', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1059', 'ANANDA SHOFIYATUL NAKHYA', 'Pereng, Pakel, Andong', '', 4, 2, 'Boyolali', '2006-04-28', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1060', 'ANGGITA PUTRI ZULAEKA', 'Kendal, Pulutan, Nogosari', '', 4, 2, 'BOYOLALI', '2005-01-20', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1061', 'AZZAHRA BINTANG PRADANA PUTRI', 'Jetis, Ketitang, Nogosari', '', 4, 2, 'Sragen', '2006-05-03', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1062', 'BELLA AINUR ROFIAH', 'Pakel, Pakel, Andong', '', 4, 2, 'BOYOLALI', '2006-11-25', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1064', 'CHELSEA AFRIYANI', 'Pereng, Pakel, Andong', '', 4, 2, 'Boyolali', '2006-04-29', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1065', 'CHINTYA PUTRI SAMIRA', 'Blumbang, Saren, Kalijambe', '', 4, 2, 'SRAGEN', '2006-11-28', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1066', 'CUT MILA', 'Pulorejo, Pulutan, Nogosari', '', 4, 2, 'CIMAHI', '2006-07-30', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1067', 'ELYANI NURLITA ARISTAWATI', 'Jetak, Gondangrawe, Andong', '', 4, 2, 'Boyolali', '2006-07-05', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1068', 'ERIKA DIAN NUR ANGGRAINI', 'Sendangsari, Wonorejo, Kalijambe', '', 4, 2, 'Sragen', '2005-03-31', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1069', 'FEBRIANI NUR AFIFAH', 'Gumukrejo, Gondangrawe, Andong', '', 4, 2, 'BOYOLALI', '2006-02-12', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1070', 'ISNA ARIYANTI', 'Pereng, Pakel, Andong', '', 4, 2, 'Boyolali', '2006-02-13', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1071', 'LILIK RAHMAWATI', 'Tegalsari, Wonorejo,Kalijambe', '', 4, 2, 'Sragen', '2013-12-31', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1072', 'SUCI ANGGRAINI', 'Guwosari, Jebres, Surakarta', '', 5, 1, 'Sragen', '2006-01-05', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1073', 'ABI PRATAMA NUR DIANSYAH', 'Rejosari, Donoyudan, Kalijambe', '', 5, 1, 'Sragen', '2006-01-12', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1074', 'ADITYA PRATAMA', 'Mencil, Pulutan, Nogosari', '', 5, 1, 'Tangerang', '2006-09-07', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1075', 'AFIN HENDRI PURNOMO', 'Blumbang, Saren, Kalijambe', '', 5, 1, 'SRAGEN', '2006-03-14', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1076', 'AGUS TAUFIKUR ROHMAN', 'Sendangsari, Wonorejo, Kalijambe', '', 5, 1, 'Sragen', '2006-05-03', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1077', 'AHMAD ZAZID BASTOMI', 'Pereng, Pakel, Andong', '', 5, 1, 'BOYOLALI', '2006-01-06', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1078', 'ALFI DAHLIA RAHMAWATI', 'Pereng, Pakel, Andong', '', 5, 1, 'Boyolali', '2007-12-09', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1079', 'AMELIA PUTRI FITRIANI', 'Blagungan, Donoyudan, Kalijambe', '', 5, 1, 'Sragen', '2004-12-18', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1081', 'ARIF RIDWAN', 'Mojosari, Pulutan, Nogosari', '', 5, 1, 'BOYOLALI', '2006-03-10', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1082', 'BAGAS ILHAM FIRMANSYAH', 'Ngleri, Keden, Kalijambe', '', 5, 1, 'Sragen', '2005-10-20', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1084', 'DAVA ABIMANYU PUTRA', 'Mojokembang, Keden, kalijambe', '', 5, 1, 'TANGERANG', '2006-07-21', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1086', 'DHEA RISKA DESTA RINA', 'Krajan, Karangmojo, Klego', '', 5, 1, 'Boyolali', '2006-12-20', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1087', 'FATIR FAUZI SAPUTRA', 'Pereng, Pakel, Andong', '', 5, 1, 'Boyolali', '2006-12-31', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1088', 'FEVI ARTIA NAILA SARI', 'Kedungwaru, geneng, Miri', '', 5, 1, 'Sragen', '2006-02-24', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1090', 'IBNU ARSI ANGGARA', 'Pereng, Pakel, Andong', '', 5, 1, 'BOYOLALI', '2008-12-09', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1091', 'IQRA PUTRA RAMADHANI', 'Duren, Wonorejo, Kalijambe', '', 5, 1, 'Sragen', '2006-10-10', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1092', 'IVAN FREDY PRASETYO', 'Plosorejo, Kalimacan, Kalijambe', '', 5, 1, 'Sragen', '2006-03-18', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1093', 'JUAN DECO IBRAHIM AZIZ', 'Pelem, Geneng, Miri', '', 5, 1, 'BEKASI', '2006-02-13', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1094', 'MUH.HAIKAL YUNUS', 'Sambirembe, Sambirembe, Kalijambe', '', 5, 1, 'Sragen', '2006-02-22', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1095', 'MUHAMMAD AZAM', 'Pakel, Pakel, Andong', '', 5, 1, 'Boyolali', '2006-04-11', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1097', 'MUHAMMAD HAIKAL PAJERI', 'Blagungrejo, Wonorejo, Kalijambe', '', 5, 1, 'SRAGEN', '2006-04-06', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1098', 'MUHAMMAD MUKHLISIN', 'Pereng, Pakel, Andong', '', 5, 1, 'Boyolali', '2006-01-18', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1099', 'MUHAMMAD WAHYUDDIN SUBHAN', 'Pulutan, Pulutan, Nogosari', '', 5, 1, 'Jakarta', '2006-05-16', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1100', 'MUHAMMAD YUDA PRASETYO', 'Blumbang, Saren, Kalijambe', '', 5, 1, 'SRAGEN', '2005-11-13', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1101', 'NABILA SETIAWATI', 'Drugan, Trobayan, Kalijambe', '', 5, 1, 'Sragen', '2005-09-09', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1102', 'NAYLA SASKYA KHAIRANI', 'Blagungan, Donoyudan, Kalijambe', '', 5, 1, 'Sragen', '2006-08-25', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1103', 'NOVA CATUR ARDIANSYAH', 'Alasmalang, Gondangrawe, Andong', '', 5, 1, 'BOYOLALI', '2006-11-24', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1104', 'RAHMAT KHALIL RIYADI', 'Tegalsari, Wonorejo,Kalijambe', '', 5, 1, 'Sragen', '2006-07-19', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1105', 'RIAN ANGGA SAPUTRA', 'Pomahan, pulutan, Nogosari', '', 5, 1, 'BOYOLALI', '2005-12-10', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1106', 'RIO ADJIE PAMUNGKAS', 'Jipangan, Trobayan, Kalijambe', '', 5, 1, 'Jakarta', '2004-11-09', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1107', 'SAFARUDIN', 'Grumbuldowo, Sambirembe, Kalijambe', '', 5, 1, 'Sragen', '2006-03-17', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1108', 'SIGID PRIANTO', 'Pereng, Pakel, Andong', '', 5, 1, 'Boyolali', '2007-02-12', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1109', 'ADITIA DUWI SAPUTRO', 'Cumpleng, Saren, Kalijambe', '', 6, 1, 'Sragen', '2003-10-18', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1110', 'ADITIYA FAHRI AKBAR', 'Randugede, Pulutan, Nogosari', '', 6, 1, 'BOYOLALI', '2005-12-16', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1111', 'AGUS SANTOSO', 'Jayan, Saren, Kalijambe', '', 6, 1, 'Sragen', '2005-05-08', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1112', 'ARDI KURNIAWAN', 'Pomahan, pulutan, Nogosari', '', 6, 1, 'BOYOLALI', '2005-11-10', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1113', 'BAGAS RAFIUD DARAJAD', 'Rejosari, Donoyudan, Kalijambe', '', 6, 1, 'Sragen', '2005-03-29', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1114', 'DANISWARA', 'Tegalsari, Wonorejo,Kalijambe', '', 6, 1, 'Sragen', '2005-09-23', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1115', 'DIKA ARIS WIDIANTO', 'Blagungrejo, Wonorejo, Kalijambe', '', 6, 1, 'SRAGEN', '2005-11-20', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1117', 'EPRIL DWI SATRIYO', 'Pakel, Pakel, Andong', '', 6, 1, 'BOYOLALI', '2005-04-10', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1118', 'FAJAR ICHTIAR NAZIL', 'Wonorejo, Wonorejo, Kalijambe ', '', 6, 1, 'Sragen', '2006-08-31', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1119', 'GIGIH HARTANTO', 'Randugede, Pulutan, Nogosari', '', 6, 1, 'BOYOLALI', '2006-02-19', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1120', 'IKHSAN ZAENAL ARIFIN', 'Butuh, Wonorejo, Kalijambe', '', 6, 1, 'Sragen', '2006-03-07', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1121', 'ILHAM HAPPY HANAFI', 'Tegalrejo, Wonorejo, Kalijambe', '', 6, 1, 'Sragen', '2006-04-13', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1122', 'IRFAN ADITYA PRATAMA', 'Blagungrejo, Wonorejo, Kalijambe', '', 6, 1, 'Sragen', '2005-09-05', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1123', 'IRGITA LEO PUTRA PRATAMA', 'Wonorejo, Wonorejo, Kalijambe ', '', 6, 1, 'Sragen', '2006-07-12', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1124', 'JAGAT ENGGAR KUSUMA', 'Losari, Pulutan, Nogosari', '', 6, 1, 'Boyolali', '2006-09-21', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1125', 'KHAFIDL NUR FAUZAN', 'Kedungwaru, Wonorejo, Kalijambe', '', 6, 1, 'Sragen', '2006-08-21', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1126', 'KHOIRUL RAHMAD RIFAI', 'Cumpleng, Saren, Kalijambe', '', 6, 1, 'Sragen', '2005-07-10', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1127', 'MUHAMMAD KURNIAWAN NUR FATHONI', 'Tegalrejo, Donoyudan, Kalijambe', '', 6, 1, 'Sragen', '2006-01-25', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1128', 'MUHAMMAD RAHMAWAN NUR FAUZI', 'Tegalrejo, Donoyudan, Kalijambe', '', 6, 1, 'Sragen', '2006-01-25', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1129', 'MUHAMMAD ADITYA NUGROHO', 'Randualas, Pulutan, Nogosari', '', 6, 1, 'BOYOLALI', '2005-12-08', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1131', 'MUHAMMAD RIDWAN', 'Mojokembang, Keden, kalijambe', '', 6, 1, 'Sragen', '2006-08-22', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1132', 'MUHAMMAD SIDIQ', 'Loning, Pulutan ,Nogosari', '', 6, 1, 'BOYOLALI', '2005-05-17', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1133', 'NICO EKA ARYANSYAH', 'Rejosari, Donoyudan, Kalijambe', '', 6, 1, 'Sragen', '2006-06-08', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1134', 'NUGROHO SIDIK MAULANA IBRAHIM', 'Jeruk Manis, Wonorejo, Kalijambe', '', 6, 1, 'SRAGEN', '2006-05-17', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1135', 'NUR HARYANTO', 'Mencil, Pulutan, Nogosari', '', 6, 1, 'Boyolali', '2005-12-13', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1136', 'RAFFA AJIE SAPUTRA', 'Tegalsari, Wonorejo,Kalijambe', '', 6, 1, 'Sragen', '2006-11-09', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1137', 'RESNO DANU RAMADANI', 'Gumukrejo, Gondangrawe, Andong', '', 6, 1, 'BOYOLALI', '2006-10-30', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1138', 'ROBI DAMA PRAKOSO', 'Sendangsari, Wonorejo, Kalijambe', '', 6, 1, 'Sragen', '2006-01-21', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1140', 'SRI RANGGA BAYU NUGROHO', 'Butuh, Wonorejo, Kalijambe', '', 6, 1, 'Sragen', '2005-11-28', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1141', 'TRI WINARNO', 'Plosorejo, Pulutan, nogosari', '', 6, 1, 'Karanganyar', '2005-08-16', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1142', 'TRIA ALFATAH', 'Nyaen, Trobayan, Kalijambe', '', 6, 1, 'Sragen', '2005-08-10', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1143', 'YAZID MUHROM AZZACKY', 'Grumbuldowo, Sambirembe, Kalijambe', '', 6, 1, 'SRAGEN', '2006-01-31', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1144', 'YAZIN ISMAEL', 'Beran, Donoyudan, Kalijambe', '', 6, 1, 'Sragen', '2006-02-06', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1145', 'YUSUF NAJARUDIN', 'Gumukrejo, Gondangrawe, Andong', '', 6, 1, 'BOYOLALI', '2006-03-18', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1146', 'YUSUP RAMADANI', 'Mojosari, Pulutan, Nogosari', '', 6, 1, 'BOYOLALI', '2005-11-01', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1147', 'ANGGUN', 'Derepan, Donoyudan, Kalijambe', '', 4, 2, 'SRAGEN', '2006-08-26', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1149', 'AHMAD SAFII MUNANDAR', 'Jetak, Gondangrawe, Andong', '', 5, 1, 'BOYOLALI', '2006-06-15', NULL, NULL, NULL, '2021', NULL);
INSERT INTO `tsiswa` VALUES ('1150', 'ADI SAPUTRO', 'Tegalsari, Wonorejo,Kalijambe', '', 2, 1, 'Sragen', '2007-08-19', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1151', 'ALDI PRATAMA', 'Pelem, Geneng, Miri', '', 2, 1, 'Sragen', '2007-02-16', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1152', 'ANDIKA BAYU SEPTIAN', 'Karangnongko, sambirembe, Kalijambe', '', 2, 1, 'Sragen', '2007-09-01', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1153', 'ANGGUN SANGGARWATI', '', '', 2, 1, NULL, NULL, NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1154', 'ARYO AJI WIBOWO', 'Wonorejo, Wonorejo, Kalijambe ', '', 2, 1, 'Sragen', '2007-04-07', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1155', 'BAGUS AJI WICAKSONO', 'Plosorejo, Sempu, Andong', '', 2, 1, 'Boyolali', '2007-06-13', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1156', 'BAYU SAPUTRA', 'Blumbang, Saren, Kalijambe', '', 2, 1, 'Sragen', '2006-11-29', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1157', 'FADILA NURUL HIDAYAH', 'Kedungwaru, Geneng, Miri', '', 2, 1, 'Klaten', '2006-12-26', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1158', 'FAUZI HASAN TRI WIBOWO', 'Tegalrejo, Donoyudan,Kalijambe', '', 2, 1, 'Sragen', '2006-12-20', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1159', 'FIKI FERDIANSYAH', 'Pelem, Geneng, Miri', '', 2, 1, 'Sragen', '2007-08-08', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1160', 'FIRDAUS SAPUTRA KS', 'Plosorejo, Kalimacan, Kalijambe', '', 2, 1, 'Sragen', '2006-09-03', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1161', 'IFTANA FIDWA ARBA', 'Kalijambe, Krikilan, Kalijambe', '', 2, 1, 'Sragen', '2008-01-16', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1162', 'JEFRI AZHAR HAZWAN', 'Beran, Donoyudan, Kalijambe', '', 2, 1, 'Sragen', '2007-07-17', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1163', 'LUKFY AL AZIZ', 'Rejosari, Donoyudan, Kalijambe', '', 2, 1, 'Sragen', '2006-10-03', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1165', 'LUTFIA EKA RAHMA ANDINI', 'Bendosari, Donoyudan, Kalijambe', '', 2, 1, 'Sragen', '2007-04-07', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1167', 'MUHAMMAD HANAFI AL FARIZI', 'Plawar, Saren, Kalijambe', '', 2, 1, 'Sragen', '2007-05-17', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1168', 'MUHAMMAD HUSNI MUBAROK', 'Randusari, Keden, Kalijambe', '', 2, 1, 'Jakarta', '2006-01-11', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1171', 'MUHAMMAD VERY ADITYA', 'Jengglong, Sempu, Andong', '', 2, 1, 'Boyolali', '2007-01-09', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1172', 'NISA DWI PURWANTI', 'Kedungwaru, Geneng, Miri', '', 2, 1, 'Sragen', '2007-05-05', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1173', 'QUROTUL QOIS', 'Mojokembang, Keden, kalijambe', '', 2, 1, 'SRAGEN', '2008-12-23', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1174', 'RAFLY ADE SETYAWAN', 'Jengglong, Sempu, Andong', '', 2, 1, 'BOYOLALI', '2006-12-13', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1175', 'RANGGA WIDYA PUTRA', 'Ngleri, Keden, Kalijambe', '', 2, 1, 'Sragen', '2007-06-26', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1177', 'RIANDA AKBAR SODIQ', 'Karangnongko, sambirembe, Kalijambe', '', 2, 1, 'SRAGEN', '2007-06-30', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1178', 'RIZKI AKBAR ASSIDIK', 'Saren, Saren, Kalijambe', '', 2, 1, 'SRAGEN', '2007-04-15', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1179', 'ROHMAD WAHYU ROMADHON', 'Blagungan, Donoyudan, Kalijambe', '', 2, 1, 'Sragen', '2007-01-14', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1180', 'RYAN RAFA\'EL', 'Keden wetan, Keden, Kalijambe', '', 2, 1, 'SRAGEN', '2006-08-11', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1181', 'SLAMET WAHYU RAMADHAN', 'Wonosari, Sambirembe, Kalijambe', '', 2, 1, 'SRAGEN', '2007-09-17', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1182', 'SYAFRUDIN ZAKI', 'Gondangrawe, Andong', '', 2, 1, 'BOYOLALI', '2007-07-27', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1183', 'YOGA TRI SAPUTRA', 'Sanggrahan, Pulutan, Nogosari', '', 2, 1, 'BOYOLALI', '2007-01-10', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1184', 'ABDUL HAKIM', 'Mojokembang, Keden, kalijambe', '', 3, 1, 'SRAGEN', '2008-05-03', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1185', 'ABI DWI PRADANA', 'Pakel, Pakel, Andong', '', 3, 1, 'Boyolali', '2006-08-01', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1186', 'ADE CANDY SATRIYA', 'Blagungrejo, Wonorejo, Kalijambe', '', 3, 1, 'SRAGEN', '2007-06-22', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1187', 'ADITYA AGUNG MUSTOFA', 'Tegalrejo, Donoyudan, Kalijambe', '', 3, 1, 'SRAGEN', '2006-12-22', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1188', 'ADITYA PAMUNGKAS', 'Nyaen, Trobayan, Kalijambe', '', 3, 1, 'SRAGEN', '2007-08-05', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1189', 'AGU LAKSA KUSUMA MUKTI PRATAMA', 'Muncar, Pakel, Andong', '', 3, 1, 'Boyolali', '2007-01-04', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1190', 'ANDI FEBRIYANTO', 'Jatirejo, Sempu, Andong', '', 3, 1, 'BOYOLALI', '2007-02-22', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1192', 'ARIYA LINTANG SETYAYUDA', 'Pokokrajan, Pulutan, Nogosari', '', 3, 1, 'Boyolali', '2007-05-15', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1193', 'ARIZAL SHOFIYAN SYAH', 'Dawung, Sempu, Andong', '', 3, 1, 'BOYOLALI', '2006-01-04', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1194', 'BAGAS ABDI PRATAMA', 'Keden kulon, Keden, Kalijambe', '', 3, 1, 'SRAGEN', '2007-12-01', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1195', 'DONI EKO PRASETYO', 'Butuh, Wonorejo, Kalijambe', '', 3, 1, 'Sragen', '2007-05-03', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1196', 'EXSEL VALENTINO', 'Sendang, Bukuran, Kalijambe', '', 3, 1, 'SRAGEN', '2008-01-13', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1197', 'FIANDRA HAFIZH SAPUTRA', 'Karangnongko, sambirembe, Kalijambe', '', 3, 1, 'SRAGEN', '2007-07-25', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1198', 'FIKRI SATRIYA DIRGANTARA', '', '', 3, 1, NULL, NULL, NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1199', 'GADING SATRIA KENCANA', 'Blagungrejo, Wonorejo, Kalijambe', '', 3, 1, 'Sragen', '2006-07-14', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1200', 'GALANG PUTRA PRASETYA', '', '', 3, 1, NULL, NULL, NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1201', 'GIBRAN AZRIEL FAHREZA BUDIATAMA', 'Pakel, Pakel, Andong', '', 3, 1, 'SUKOHARJO', '2006-11-10', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1202', 'HIBRA YUDIRA RAHMADANI', 'Kedungwaru, Geneng, Miri', '', 3, 1, 'Sragen', '2007-10-02', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1203', 'ILHAM', 'Gondangrejo, Pulutan, Nogosari', '', 3, 1, 'Jepara', '2006-12-27', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1204', 'ILHAM RIKO PRATAMA', 'Pakel, Pakel, Andong', '', 3, 1, 'BOYOLALI', '2006-07-24', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1205', 'JUNI SAPUTRA', 'Cumpleng, Saren, Kalijambe', '', 3, 1, 'SRAGEN', '2007-06-06', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1206', 'KURNIAWAN DWI YULIANTO', 'Randualas, Pulutan, Nogosari', '', 3, 1, 'KLATEN', '2006-07-24', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1207', 'MUHAMMAD AGUNG HERMAWAN', 'Karangturi, Banaran, Kalijambe', '', 3, 1, 'SRAGEN', '2007-01-18', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1208', 'MUHAMMAD FAJAR KURNIAWAN', 'Pomahan, pulutan, Nogosari', '', 3, 1, 'BOYOLALI', '2007-05-06', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1209', 'OKTA DIKI PRASETYA', 'Kedungwaru, Geneng, Miri', '', 3, 1, 'Sragen', '2006-10-24', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1210', 'RAJIEV GANDHI GIBRAN', 'Rejosari, Donoyudan, Kalijambe', '', 3, 1, 'SRAGEN', '2006-08-29', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1211', 'REZA PUTRA LASMANA MUKTI', 'Butuh, Wonorejo, Kalijambe', '', 3, 1, 'Boyolali', '2007-03-05', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1212', 'RIYAN AJI SAPUTRA', 'Sendangsari, Wonorejo, Kalijambe', '', 3, 1, 'Sragen', '2007-05-04', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1213', 'RIFA PRATAMA RAMADHAN', 'Wonosari, Sambirembe, Kalijambe', '', 3, 1, 'SRAGEN', '2006-10-16', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1214', 'RIO ARIYANTO', 'Grumbuldowo, Sambirembe, Kalijambe', '', 3, 1, 'SURAKARTA', '2009-03-01', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1215', 'SATRIA BAGUS FEBRIYAN', 'Pereng, Pakel, Andong', '', 3, 1, 'Boyolali', '2007-02-01', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1216', 'SHERIL DWI KURNIAWAN', 'Kedungwaru, Geneng, Miri', '', 3, 1, 'Sragen', '2007-03-19', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1217', 'TEGAR DWI ARDIANSYAH', 'Loning, Pulutn ,Nogosari', '', 3, 1, 'BOYOLALI', '2006-06-21', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1218', 'VIUS PAPUNDHOPO', 'Sendangsari, Wonorejo, Kalijambe', '', 3, 1, 'Sragen', '2006-09-08', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1219', 'AISYAH NUR AINI', 'Sanggrahan, Pulutan, Nogosari', '-', 1, 2, 'Boyolali', '2007-11-10', '-', '-', '-', '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1220', 'ASRI JIHAN VEMIGI', 'Ngleri, Keden, Kalijambe', '', 1, 2, 'Sragen', '2006-11-05', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1221', 'ASYIFATUL MUNAWAROH', 'Bendosari, Donoyudan, Kalijambe', '', 1, 2, 'SRAGEN', '2006-10-18', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1222', 'AZZAHRA AISSHAFANI', 'Gumukrejo, Gondangrawe, Andong', '', 1, 2, 'BOYOLALI', '2006-09-11', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1223', 'AZ-ZAHRA OKTA ROMADHONI', 'Ngembat, Beji, Andong', '', 1, 2, 'SURAKARTA', '2006-10-04', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1224', 'DIAH AYU ASHARI', 'Kedungwaru, Wonorejo, Kalijambe', '', 1, 2, 'Sragen', '2007-01-21', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1225', 'FAAT ZUYYIN ERA', 'Kedokan, Klego, Klego', '', 1, 2, 'Boyolali', '2007-07-12', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1226', 'FANESYA AMELIA', 'Pulutan, Pulutan, Nogosari', '', 1, 2, 'BOYOLALI', '2007-02-28', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1227', 'FRISCA DIAN ANGELINA', 'Mencil, Pulutan, Nogosari', '', 1, 2, 'BOYOLALI', '2007-02-09', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1228', 'IQBAL BAGUS SETYADHI', 'Derasan, Sempu, Andong', '', 1, 2, 'BOYOLALI', '2008-05-01', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1229', 'LEOTA PUTRI CESYA ALTA SYAH', 'Bendosari, Donoyudan, Kalijambe', '', 1, 2, 'SRAGEN', '2007-04-01', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1230', 'MIFTAKHUL KHOIRIYAH', 'Rejosari, Donoyudan, Kalijambe', '', 1, 2, 'SRAGEN', '2007-03-25', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1231', 'NABILA FITRIANI', 'Plawar, Saren, Kalijambe', '', 1, 2, 'Jakarta', '2006-11-10', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1232', 'NEFIKA RIA MARETA', 'Beran, Donoyudan, Kalijambe', '', 1, 2, 'Sragen', '2007-03-23', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1233', 'NEYSA AVANDA AFILYANTI', 'Tegalrejo, Donoyudan, Kalijambe', '', 1, 2, 'Sragen', '2007-01-17', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1234', 'RANITA LILI JULITA', 'Randusari, Keden, Kalijambe', '', 1, 2, 'SRAGEN', '2007-07-04', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1235', 'RENDI MAULAN PRATAMA', 'Derasan, Sempu, Andong', '', 1, 2, 'BOYOLALI', '2007-05-18', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1236', 'SABILA FITRIANA', 'Plawar, Saren, Kalijambe', '', 1, 2, 'Jakarta', '2006-11-10', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1237', 'SABILLA ISTIQOMAH', 'Kalangan, Ngembatpadas, Gemolong', '', 1, 2, 'Sragen', '2007-05-05', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1238', 'SELLA SETYANINGSIH', 'Kedungwaru, Wonorejo, Kalijambe', '', 1, 2, 'Sragen', '2006-11-25', NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1239', 'LINA FAZA AMELIA', '', '', 2, 1, NULL, NULL, NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1240', 'FELLA ZULFA EKA LESTARI', '', '', 2, 1, NULL, NULL, NULL, NULL, NULL, '2022', NULL);
INSERT INTO `tsiswa` VALUES ('1242', 'AURILIA PUTRI PRAMUDITA', '', '', 1, 2, NULL, NULL, NULL, NULL, NULL, '2022', NULL);

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
INSERT INTO `userrole` VALUES (14, 1);
INSERT INTO `userrole` VALUES (43, 2);
INSERT INTO `userrole` VALUES (45, 4);
INSERT INTO `userrole` VALUES (46, 5);
INSERT INTO `userrole` VALUES (47, 4);
INSERT INTO `userrole` VALUES (48, 4);
INSERT INTO `userrole` VALUES (49, 4);
INSERT INTO `userrole` VALUES (52, 1);
INSERT INTO `userrole` VALUES (53, 4);
INSERT INTO `userrole` VALUES (54, 4);
INSERT INTO `userrole` VALUES (55, 4);
INSERT INTO `userrole` VALUES (56, 4);
INSERT INTO `userrole` VALUES (57, 4);
INSERT INTO `userrole` VALUES (58, 4);
INSERT INTO `userrole` VALUES (59, 4);
INSERT INTO `userrole` VALUES (60, 4);
INSERT INTO `userrole` VALUES (61, 4);
INSERT INTO `userrole` VALUES (62, 4);
INSERT INTO `userrole` VALUES (63, 4);
INSERT INTO `userrole` VALUES (64, 4);
INSERT INTO `userrole` VALUES (65, 4);
INSERT INTO `userrole` VALUES (66, 4);
INSERT INTO `userrole` VALUES (67, 4);
INSERT INTO `userrole` VALUES (68, 4);
INSERT INTO `userrole` VALUES (69, 4);
INSERT INTO `userrole` VALUES (70, 4);
INSERT INTO `userrole` VALUES (71, 4);
INSERT INTO `userrole` VALUES (72, 4);
INSERT INTO `userrole` VALUES (73, 4);
INSERT INTO `userrole` VALUES (74, 4);
INSERT INTO `userrole` VALUES (75, 4);
INSERT INTO `userrole` VALUES (76, 4);
INSERT INTO `userrole` VALUES (77, 4);
INSERT INTO `userrole` VALUES (78, 4);
INSERT INTO `userrole` VALUES (79, 4);
INSERT INTO `userrole` VALUES (80, 4);
INSERT INTO `userrole` VALUES (81, 4);
INSERT INTO `userrole` VALUES (82, 4);
INSERT INTO `userrole` VALUES (83, 4);
INSERT INTO `userrole` VALUES (84, 4);
INSERT INTO `userrole` VALUES (85, 4);
INSERT INTO `userrole` VALUES (86, 4);
INSERT INTO `userrole` VALUES (87, 4);
INSERT INTO `userrole` VALUES (88, 4);
INSERT INTO `userrole` VALUES (89, 4);
INSERT INTO `userrole` VALUES (90, 4);
INSERT INTO `userrole` VALUES (91, 4);
INSERT INTO `userrole` VALUES (92, 4);
INSERT INTO `userrole` VALUES (93, 4);
INSERT INTO `userrole` VALUES (94, 4);
INSERT INTO `userrole` VALUES (95, 4);
INSERT INTO `userrole` VALUES (96, 4);
INSERT INTO `userrole` VALUES (97, 4);
INSERT INTO `userrole` VALUES (98, 4);
INSERT INTO `userrole` VALUES (99, 4);
INSERT INTO `userrole` VALUES (100, 4);
INSERT INTO `userrole` VALUES (101, 4);
INSERT INTO `userrole` VALUES (102, 4);
INSERT INTO `userrole` VALUES (103, 4);
INSERT INTO `userrole` VALUES (104, 4);
INSERT INTO `userrole` VALUES (105, 4);
INSERT INTO `userrole` VALUES (106, 4);
INSERT INTO `userrole` VALUES (107, 4);
INSERT INTO `userrole` VALUES (108, 4);
INSERT INTO `userrole` VALUES (109, 4);
INSERT INTO `userrole` VALUES (110, 4);
INSERT INTO `userrole` VALUES (111, 4);
INSERT INTO `userrole` VALUES (112, 4);
INSERT INTO `userrole` VALUES (113, 4);
INSERT INTO `userrole` VALUES (114, 4);
INSERT INTO `userrole` VALUES (115, 4);
INSERT INTO `userrole` VALUES (116, 4);
INSERT INTO `userrole` VALUES (117, 4);
INSERT INTO `userrole` VALUES (118, 4);
INSERT INTO `userrole` VALUES (119, 4);
INSERT INTO `userrole` VALUES (120, 4);
INSERT INTO `userrole` VALUES (121, 4);
INSERT INTO `userrole` VALUES (122, 4);
INSERT INTO `userrole` VALUES (123, 4);
INSERT INTO `userrole` VALUES (124, 4);
INSERT INTO `userrole` VALUES (125, 4);
INSERT INTO `userrole` VALUES (126, 4);
INSERT INTO `userrole` VALUES (127, 4);
INSERT INTO `userrole` VALUES (128, 4);
INSERT INTO `userrole` VALUES (129, 4);
INSERT INTO `userrole` VALUES (130, 4);
INSERT INTO `userrole` VALUES (131, 4);
INSERT INTO `userrole` VALUES (132, 4);
INSERT INTO `userrole` VALUES (133, 4);
INSERT INTO `userrole` VALUES (134, 4);
INSERT INTO `userrole` VALUES (135, 4);
INSERT INTO `userrole` VALUES (136, 4);
INSERT INTO `userrole` VALUES (137, 4);
INSERT INTO `userrole` VALUES (138, 4);
INSERT INTO `userrole` VALUES (139, 4);
INSERT INTO `userrole` VALUES (140, 4);
INSERT INTO `userrole` VALUES (141, 4);
INSERT INTO `userrole` VALUES (142, 4);
INSERT INTO `userrole` VALUES (143, 4);
INSERT INTO `userrole` VALUES (144, 4);
INSERT INTO `userrole` VALUES (145, 4);
INSERT INTO `userrole` VALUES (146, 4);
INSERT INTO `userrole` VALUES (147, 4);
INSERT INTO `userrole` VALUES (148, 4);
INSERT INTO `userrole` VALUES (149, 4);
INSERT INTO `userrole` VALUES (150, 4);
INSERT INTO `userrole` VALUES (151, 4);
INSERT INTO `userrole` VALUES (152, 4);
INSERT INTO `userrole` VALUES (153, 4);
INSERT INTO `userrole` VALUES (154, 4);
INSERT INTO `userrole` VALUES (155, 4);
INSERT INTO `userrole` VALUES (156, 4);
INSERT INTO `userrole` VALUES (157, 4);
INSERT INTO `userrole` VALUES (158, 4);
INSERT INTO `userrole` VALUES (159, 4);
INSERT INTO `userrole` VALUES (160, 4);
INSERT INTO `userrole` VALUES (161, 4);
INSERT INTO `userrole` VALUES (162, 4);
INSERT INTO `userrole` VALUES (163, 4);
INSERT INTO `userrole` VALUES (164, 4);
INSERT INTO `userrole` VALUES (165, 4);
INSERT INTO `userrole` VALUES (166, 4);
INSERT INTO `userrole` VALUES (167, 4);
INSERT INTO `userrole` VALUES (168, 4);
INSERT INTO `userrole` VALUES (169, 4);
INSERT INTO `userrole` VALUES (170, 4);
INSERT INTO `userrole` VALUES (171, 4);
INSERT INTO `userrole` VALUES (172, 4);
INSERT INTO `userrole` VALUES (173, 4);
INSERT INTO `userrole` VALUES (174, 4);
INSERT INTO `userrole` VALUES (175, 4);
INSERT INTO `userrole` VALUES (176, 4);
INSERT INTO `userrole` VALUES (177, 4);
INSERT INTO `userrole` VALUES (178, 4);
INSERT INTO `userrole` VALUES (179, 4);
INSERT INTO `userrole` VALUES (180, 4);
INSERT INTO `userrole` VALUES (181, 4);
INSERT INTO `userrole` VALUES (182, 4);
INSERT INTO `userrole` VALUES (183, 4);
INSERT INTO `userrole` VALUES (184, 4);
INSERT INTO `userrole` VALUES (185, 4);
INSERT INTO `userrole` VALUES (186, 4);
INSERT INTO `userrole` VALUES (187, 4);
INSERT INTO `userrole` VALUES (188, 4);
INSERT INTO `userrole` VALUES (189, 4);
INSERT INTO `userrole` VALUES (190, 4);
INSERT INTO `userrole` VALUES (191, 4);
INSERT INTO `userrole` VALUES (192, 4);
INSERT INTO `userrole` VALUES (193, 4);
INSERT INTO `userrole` VALUES (194, 4);
INSERT INTO `userrole` VALUES (195, 4);
INSERT INTO `userrole` VALUES (196, 4);
INSERT INTO `userrole` VALUES (197, 4);
INSERT INTO `userrole` VALUES (198, 4);
INSERT INTO `userrole` VALUES (199, 4);
INSERT INTO `userrole` VALUES (200, 4);
INSERT INTO `userrole` VALUES (201, 4);
INSERT INTO `userrole` VALUES (202, 4);
INSERT INTO `userrole` VALUES (203, 4);
INSERT INTO `userrole` VALUES (204, 4);
INSERT INTO `userrole` VALUES (205, 4);
INSERT INTO `userrole` VALUES (206, 4);
INSERT INTO `userrole` VALUES (207, 4);
INSERT INTO `userrole` VALUES (208, 4);
INSERT INTO `userrole` VALUES (209, 4);
INSERT INTO `userrole` VALUES (210, 4);
INSERT INTO `userrole` VALUES (211, 4);
INSERT INTO `userrole` VALUES (212, 4);
INSERT INTO `userrole` VALUES (213, 4);
INSERT INTO `userrole` VALUES (214, 4);
INSERT INTO `userrole` VALUES (215, 4);
INSERT INTO `userrole` VALUES (216, 4);
INSERT INTO `userrole` VALUES (217, 4);
INSERT INTO `userrole` VALUES (218, 4);
INSERT INTO `userrole` VALUES (219, 4);
INSERT INTO `userrole` VALUES (220, 4);
INSERT INTO `userrole` VALUES (221, 4);
INSERT INTO `userrole` VALUES (222, 4);
INSERT INTO `userrole` VALUES (223, 4);
INSERT INTO `userrole` VALUES (224, 4);
INSERT INTO `userrole` VALUES (225, 4);
INSERT INTO `userrole` VALUES (226, 4);
INSERT INTO `userrole` VALUES (227, 4);
INSERT INTO `userrole` VALUES (228, 4);
INSERT INTO `userrole` VALUES (229, 4);
INSERT INTO `userrole` VALUES (230, 4);
INSERT INTO `userrole` VALUES (231, 4);
INSERT INTO `userrole` VALUES (232, 4);
INSERT INTO `userrole` VALUES (233, 4);
INSERT INTO `userrole` VALUES (234, 4);
INSERT INTO `userrole` VALUES (235, 4);
INSERT INTO `userrole` VALUES (236, 4);
INSERT INTO `userrole` VALUES (237, 4);
INSERT INTO `userrole` VALUES (238, 4);
INSERT INTO `userrole` VALUES (239, 4);
INSERT INTO `userrole` VALUES (240, 4);
INSERT INTO `userrole` VALUES (241, 4);
INSERT INTO `userrole` VALUES (242, 4);
INSERT INTO `userrole` VALUES (243, 4);
INSERT INTO `userrole` VALUES (244, 4);
INSERT INTO `userrole` VALUES (245, 4);
INSERT INTO `userrole` VALUES (246, 4);
INSERT INTO `userrole` VALUES (247, 4);
INSERT INTO `userrole` VALUES (248, 4);
INSERT INTO `userrole` VALUES (249, 4);
INSERT INTO `userrole` VALUES (250, 4);
INSERT INTO `userrole` VALUES (251, 4);
INSERT INTO `userrole` VALUES (252, 4);
INSERT INTO `userrole` VALUES (253, 4);
INSERT INTO `userrole` VALUES (254, 4);
INSERT INTO `userrole` VALUES (255, 4);
INSERT INTO `userrole` VALUES (256, 4);
INSERT INTO `userrole` VALUES (257, 4);
INSERT INTO `userrole` VALUES (258, 4);
INSERT INTO `userrole` VALUES (259, 4);
INSERT INTO `userrole` VALUES (260, 4);
INSERT INTO `userrole` VALUES (261, 4);
INSERT INTO `userrole` VALUES (262, 4);
INSERT INTO `userrole` VALUES (263, 4);
INSERT INTO `userrole` VALUES (264, 4);
INSERT INTO `userrole` VALUES (265, 4);
INSERT INTO `userrole` VALUES (266, 4);
INSERT INTO `userrole` VALUES (267, 4);
INSERT INTO `userrole` VALUES (268, 4);
INSERT INTO `userrole` VALUES (269, 4);
INSERT INTO `userrole` VALUES (270, 4);
INSERT INTO `userrole` VALUES (271, 4);
INSERT INTO `userrole` VALUES (272, 4);
INSERT INTO `userrole` VALUES (273, 4);
INSERT INTO `userrole` VALUES (274, 4);
INSERT INTO `userrole` VALUES (275, 4);
INSERT INTO `userrole` VALUES (276, 4);
INSERT INTO `userrole` VALUES (277, 4);
INSERT INTO `userrole` VALUES (278, 4);
INSERT INTO `userrole` VALUES (279, 4);
INSERT INTO `userrole` VALUES (280, 4);
INSERT INTO `userrole` VALUES (281, 4);
INSERT INTO `userrole` VALUES (282, 4);
INSERT INTO `userrole` VALUES (283, 4);
INSERT INTO `userrole` VALUES (284, 4);
INSERT INTO `userrole` VALUES (285, 4);
INSERT INTO `userrole` VALUES (286, 4);
INSERT INTO `userrole` VALUES (287, 4);
INSERT INTO `userrole` VALUES (288, 4);

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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 289 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (14, 'admin', 'admin', 'a9bdd47d7321d4089b3b00561c9c621848bd6f6e2f745a53d54913d613789c23945b66de6ded1eb336a7d526f9349a9d964d6f6c3a40e2ac90b4b16c0121f7895Xg53McbkyQ/NmW60Sf4cu3wJsi/8cyZXxeXV7g6b04=', 'mnl', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (43, 'operator', 'Operator', 'a9bdd47d7321d4089b3b00561c9c621848bd6f6e2f745a53d54913d613789c23945b66de6ded1eb336a7d526f9349a9d964d6f6c3a40e2ac90b4b16c0121f7895Xg53McbkyQ/NmW60Sf4cu3wJsi/8cyZXxeXV7g6b04=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (44, 'admin', 'admin', 'a9bdd47d7321d4089b3b00561c9c621848bd6f6e2f745a53d54913d613789c23945b66de6ded1eb336a7d526f9349a9d964d6f6c3a40e2ac90b4b16c0121f7895Xg53McbkyQ/NmW60Sf4cu3wJsi/8cyZXxeXV7g6b04=', 'mnl', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (46, 'bety', 'Bety Rosiana, S.Pd', '5982e27c4e86aa7be2ed461d3b26b1747a259d84c2258e067e6b56e8704fa833730d293fa262c31681c7564d1257432a8647966d244bb02b76784ff34005ec4ascjaVHTySjNdbOgymZCjgTzD8wySNjdEEj14CVs4fmA=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO `users` VALUES (121, '1219', 'AISYAH NUR AINI', '15d1ee116284b85e5de3e00564518367fe994de7', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (122, '1220', 'ASRI JIHAN VEMIGI', '7173e41e4de7a780906fada68a682817c8803ed2', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (123, '1221', 'ASYIFATUL MUNAWAROH', '22a366e578fc19525be71b6b3013ef8cc5cb1a74', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (124, '1242', 'AURILIA PUTRI PRAMUDITA', 'beebbcfb1d05a761dcc753bd9ba606039b817ff4', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (125, '1222', 'AZZAHRA AISSHAFANI', '5aab0703d8e504fd68b829dcfed270c59f51e23f', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (126, '1223', 'AZ-ZAHRA OKTA ROMADHONI', '297beb01dd21c5a2aad009da6abb91d4bc0fdc6d', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (127, '1224', 'DIAH AYU ASHARI', '4fd505f8aeed956f068c4ce57bfc30a6131b7c79', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (128, '1225', 'FAAT ZUYYIN ERA', '1d32238496df5ae1c9e06aa818f82ca7fac99cd1', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (129, '1226', 'FANESYA AMELIA', '59e221a4758b17362bdeae901c5a8f58057468b2', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (130, '1227', 'FRISCA DIAN ANGELINA', '29f4d7bd70c46fd3b021272cb02151499cc6fda1', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (131, '1228', 'IQBAL BAGUS SETYADHI', '2a94b50a655ce6b38f78ca33a4b95e39f0521b89', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (132, '1229', 'LEOTA PUTRI CESYA ALTA SYAH', '430d53392925e841ef2daa3c47dadd8de98241f0', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (133, '1230', 'MIFTAKHUL KHOIRIYAH', '6a62415b43a0268f38f117f076dce135705d7895', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (134, '1231', 'NABILA FITRIANI', 'c348c1794df04a0473a11234389e74a236833822', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (135, '1232', 'NEFIKA RIA MARETA', 'd6a9450dc08555d6ecfaf7162e5267f401e6dd9a', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (136, '1233', 'NEYSA AVANDA AFILYANTI', '416f8f6e105370e7b9d0fd983141f00b613477f8', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (137, '1234', 'RANITA LILI JULITA', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (138, '1235', 'RENDI MAULAN PRATAMA', 'ac1ab23d6288711be64a25bf13432baf1e60b2bd', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (139, '1236', 'SABILA FITRIANA', '229be39e04f960e46d8a64cadc8b4534e6bfc364', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (140, '1237', 'SABILLA ISTIQOMAH', '757578fbf23ffa4d748e0800dd7c424a46feb0cc', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (141, '1238', 'SELLA SETYANINGSIH', 'b5507c7ca8cfa4c51b7c97843e5e4525ed1ad06d', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (142, '1150', 'ADI SAPUTRO', 'e9a20a4af61c91b0232679bc583058b278fb2926', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (143, '1151', 'ALDI PRATAMA', 'ca59bcd3da4daac52f3fcfdc0ab963f65cf421bc', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (144, '1152', 'ANDIKA BAYU SEPTIAN', '827ac818d422f57b93682a8478afa2d4f026513d', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (145, '1153', 'ANGGUN SANGGARWATI', 'd27c5a6872d7c57d29ef416866e2aa92eae10018', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (146, '1154', 'ARYO AJI WIBOWO', '93e35532e8c27da7267d6a073da0d909da11a4ed', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (147, '1155', 'BAGUS AJI WICAKSONO', '1955bfd4523499c91e72d5c446d0d74cccaa5275', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (148, '1156', 'BAYU SAPUTRA', '54f9c5db018042c5624c67dc1de588c11164e3ac', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (149, '1157', 'FADILA NURUL HIDAYAH', '30b601f0cbe127b082649fe6fcd93fa86c798107', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (150, '1158', 'FAUZI HASAN TRI WIBOWO', '9bd7909ea32c89f68e82ed0cbe1f30a2e1d72b1c', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (151, '1240', 'FELLA ZULFA EKA LESTARI', '042338d46c2028808f298dec735dc7adf0c162f6', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (152, '1159', 'FIKI FERDIANSYAH', '0fb0a8a62cbe899f9c109e5ccf6d5f3b35e33f38', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (153, '1160', 'FIRDAUS SAPUTRA KS', 'dc1e5e97b303462f6c9a009994f17fb83d9f7624', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (154, '1161', 'IFTANA FIDWA ARBA', '25c65868b540200530fe4d75eb95a9a92c0c76ce', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (155, '1162', 'JEFRI AZHAR HAZWAN', '4080612570be15e797c5dae4449e556f77faa2fa', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (156, '1239', 'LINA FAZA AMELIA', 'c60d81f35d8be966fa0437e43f1feff777c6e121', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (157, '1163', 'LUKFY AL AZIZ', '736cca45634b541786a2049311bc717ecbd88d60', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (158, '1165', 'LUTFIA EKA RAHMA ANDINI', '4a4ab45448022f0c738fe9e310148ea1eb7f856b', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (159, '1167', 'MUHAMMAD HANAFI AL FARIZI', 'f8997252c6e5ae3d950b736e1a81160a2e937a7f', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (160, '1168', 'MUHAMMAD HUSNI MUBAROK', '1ff73fddc94ef96b107787b28b5a5c931b3c761b', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (161, '1171', 'MUHAMMAD VERY ADITYA', 'aa0e9f704b12a27af259750f79b22f99efdb68c5', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (162, '1172', 'NISA DWI PURWANTI', 'e41c8fd8d6da74a91fc96008280baea77725b5a7', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (163, '1173', 'QUROTUL QOIS', 'a739eb585292be58c99962fd287acafb1a459b72', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (164, '1174', 'RAFLY ADE SETYAWAN', 'be98fbb5fef1a2a7ce8be317fcbce6b1912024c3', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (165, '1175', 'RANGGA WIDYA PUTRA', '566ee6d19fef04459d959b08349d6c07b3a309a2', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (166, '1177', 'RIANDA AKBAR SODIQ', 'b7553c6080f116f0115b1f080e03484b98292d8b', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (167, '1178', 'RIZKI AKBAR ASSIDIK', '64784bedd53258d0152783e812438f26f69da48c', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (168, '1179', 'ROHMAD WAHYU ROMADHON', '4f2b344c5268b61fb41f14c640aeaf89bb7ae6d7', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (169, '1180', 'RYAN RAFA\'EL', '5527e76c85e5b71c6defa5f0099519b1d67b4627', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (170, '1181', 'SLAMET WAHYU RAMADHAN', '3c4840cf1e3a9541b48135f0467d4846df6e2781', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (171, '1182', 'SYAFRUDIN ZAKI', '1eb904b6d0c2a41af59e2d1fdd0e10624d94c81a', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (172, '1183', 'YOGA TRI SAPUTRA', '599e9ef3575ae3622fe4bc5b1b01c3705a7e848c', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (173, '1184', 'ABDUL HAKIM', '4f221ee9a76b15f3f2737e7344ca4453902fb586', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (174, '1185', 'ABI DWI PRADANA', '02ef6a4d5e9b6440ee4513baf40746cb8e872fe4', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (175, '1186', 'ADE CANDY SATRIYA', '3ac0b1284201deeda8488a82e2b9b8c11e5d51b4', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (176, '1187', 'ADITYA AGUNG MUSTOFA', '709c7dbb3799c8cc779706c907513661df268cbc', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (177, '1188', 'ADITYA PAMUNGKAS', 'de81d9d9c77a733524fab8bcc691f1ebd5a69f6e', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (178, '1189', 'AGU LAKSA KUSUMA MUKTI PRATAMA', 'fdc01209f90eda589f0453b7e29e0114923ecd8b', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (179, '1190', 'ANDI FEBRIYANTO', '87a58831a3f052f220a9e6dff87a7cad0d1052ab', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (180, '1192', 'ARIYA LINTANG SETYAYUDA', '0aec17ce3bff113e1c7c16e9d9dcaf90bf590974', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (181, '1193', 'ARIZAL SHOFIYAN SYAH', '8350495d0f4c30922ea04e171519892a303ea929', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (182, '1194', 'BAGAS ABDI PRATAMA', '83ec73d69436a58d7bd6ba448a17c1aa22d950c8', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (183, '1195', 'DONI EKO PRASETYO', 'd79dfd7857cc923493f1d7e34186cf7e04ec9d41', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (184, '1196', 'EXSEL VALENTINO', '316b44139a9742cfca5f9c640c47f008f6b73c1b', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (185, '1197', 'FIANDRA HAFIZH SAPUTRA', '80658c64f144849de7740bf64d7ca5a88ef951b6', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (186, '1198', 'FIKRI SATRIYA DIRGANTARA', '3b928622f8479780e1593e188d5315edb7d6f786', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (187, '1199', 'GADING SATRIA KENCANA', '4b7af5bd2d1026517f203f379e660fe2337a3e33', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (188, '1200', 'GALANG PUTRA PRASETYA', '73ee4958bdb5a056029ebd39b8abbaa3dbc0f333', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (189, '1201', 'GIBRAN AZRIEL FAHREZA BUDIATAMA', '88308d640f3031b16b0e9c4663716c0cb7169e50', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (190, '1202', 'HIBRA YUDIRA RAHMADANI', 'b17f4787f2799f2665e5f119fc2f47d569212c4c', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (191, '1203', 'ILHAM', '3744112af469898c7603fbe21d80b5b5640a34b5', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (192, '1204', 'ILHAM RIKO PRATAMA', '78ae9f6e6a12a1af3c5a87f0f649f73aa2b4c7be', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (193, '1205', 'JUNI SAPUTRA', 'b74e9cad775d997fc742b45e1ba7bd5295d63d13', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (194, '1206', 'KURNIAWAN DWI YULIANTO', '8334918da76533b5c14f235f374e327c95035aa3', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (195, '1207', 'MUHAMMAD AGUNG HERMAWAN', 'd0a54d25d6d76d15daa175979eda75cd9fd411b3', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (196, '1208', 'MUHAMMAD FAJAR KURNIAWAN', '898d99d62e92c4485fff43391cec7c59e4fe7d12', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (197, '1209', 'OKTA DIKI PRASETYA', 'b1d2e166d988e74123924d7bff9cd30a63aff067', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (198, '1210', 'RAJIEV GANDHI GIBRAN', '7c7b84eeaec18233e982d101637ab2a4033c6fb0', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (199, '1211', 'REZA PUTRA LASMANA MUKTI', '17e89c359872f5659b5d7892ba8e52821c93eef3', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (200, '1212', 'RIYAN AJI SAPUTRA', '618dcdfb0cd9ae4481164961c4796dd8e3930c8d', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (201, '1213', 'RIFA PRATAMA RAMADHAN', '09cad82f43c6fcf04357b175cdf4763a3daf9a89', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (202, '1214', 'RIO ARIYANTO', 'fe025dc13e5c9ab0d0625cae795d5cb0a0444b1d', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (203, '1215', 'SATRIA BAGUS FEBRIYAN', '3f15b9957ade0433fc133bede90851e29476e9b9', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (204, '1216', 'SHERIL DWI KURNIAWAN', 'e816958259e39339ddc56994e959aa56ef874f92', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (205, '1217', 'TEGAR DWI ARDIANSYAH', '76fbdd2b2ea23e13a5b1dbcf7900b3d92134f3a1', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (206, '1218', 'VIUS PAPUNDHOPO', '7f1426a678c0021bbbf19eb1d7d6353054809224', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (207, '1058', 'ADIT HARI RAMADHAN', '6185b6dc968a9507570a4bcf063dd40be8d62989', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (208, '1059', 'ANANDA SHOFIYATUL NAKHYA', '2b669c9296380e84b1308058c9c5e6917a9510e9', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (209, '1060', 'ANGGITA PUTRI ZULAEKA', '02f84308fab673d8332e1ab780a8ade20987e925', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (210, '1147', 'ANGGUN', '0104cf3b45056589309effd4d0889e430018b490', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (211, '1061', 'AZZAHRA BINTANG PRADANA PUTRI', '415d2e4353963c539961c46ad289844f4093ba96', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (212, '1062', 'BELLA AINUR ROFIAH', 'f69e508a40c73a21d4d2b63aaa03339fe7dbd165', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (213, '1064', 'CHELSEA AFRIYANI', '76a9e39fc0fb7fefce78c4940c4aa5468c8c8df4', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (214, '1065', 'CHINTYA PUTRI SAMIRA', '3c19eb2961d9d449e857615c28aa47615562bc87', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (215, '1066', 'CUT MILA', 'dc543d2abbb092d676b4e412354e0d2e0d7bf91b', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (216, '1067', 'ELYANI NURLITA ARISTAWATI', '418e19155782fc7f12ced8332c8ed025aec227a5', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (217, '1068', 'ERIKA DIAN NUR ANGGRAINI', 'b77fb0e4f8c1ae7d38d10a6c3333722cba42b1ab', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (218, '1069', 'FEBRIANI NUR AFIFAH', '2b9a620b52d24fbdc2b34fb350a34367af53f3c8', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (219, '1070', 'ISNA ARIYANTI', 'cad61ca1c4fbad3be96e27e0b1ecd5de3b4d5c25', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (220, '1071', 'LILIK RAHMAWATI', '2ce518699373ae57c7868a65c4c16d869de5e99b', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (221, '1072', 'SUCI ANGGRAINI', '6b4142e2e97b851a319b0fcab23709b40e3fc19f', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (222, '1073', 'ABI PRATAMA NUR DIANSYAH', '2b348a807fba80c79943ffd86758097907a6af79', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (223, '1074', 'ADITYA PRATAMA', '1c602ebc50cdb2284e1383ee41edcfe2344b11b5', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (224, '1075', 'AFIN HENDRI PURNOMO', '69981d3a5bbf8a2ba25db9541830318a04450ec5', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (225, '1076', 'AGUS TAUFIKUR ROHMAN', '8d25b4c973c5dafa021036664b080a79e0bb69a0', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (226, '1149', 'AHMAD SAFII MUNANDAR', '0f23eb04fa3d66bce3cb03de0629ac1b4fd32bbb', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (227, '1077', 'AHMAD ZAZID BASTOMI', 'bab750c63a16012fe1e06fd51c0f4954fb54b098', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (228, '1078', 'ALFI DAHLIA RAHMAWATI', '09203a0b810d0c054f3f15d6db42aa850bea9174', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (229, '1079', 'AMELIA PUTRI FITRIANI', '05fa2de99c48086b28d6e7a491a75f6f313af79d', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (230, '1081', 'ARIF RIDWAN', 'a874f83e95a94266c7d2856a7cbb42ee5af2e01a', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (231, '1082', 'BAGAS ILHAM FIRMANSYAH', '662791b56c06d86d3c0cb16e8163662dd014fd9f', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (232, '1084', 'DAVA ABIMANYU PUTRA', 'ec99f53e14fdfe8dbd7ffc6455a4b4cf46e5c609', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (233, '1086', 'DHEA RISKA DESTA RINA', '8d4f80df0d37819cde3e3d2bb9982d111ebac97c', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (234, '1087', 'FATIR FAUZI SAPUTRA', '07f97cc68eebf81afcd32f6fc0aad7e1f17e0c00', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (235, '1088', 'FEVI ARTIA NAILA SARI', '831376f92ed066e803751a5a0c0ecd90a104915a', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (236, '1090', 'IBNU ARSI ANGGARA', 'befa2b19820da7401dbf672069d4af99a040c200', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (237, '1091', 'IQRA PUTRA RAMADHANI', '789ef3d6e1196152c1e7ccadc639c306254a305e', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (238, '1092', 'IVAN FREDY PRASETYO', '14b21325096dd31c90a39900a910122c4d9fe3d9', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (239, '1093', 'JUAN DECO IBRAHIM AZIZ', '27b37cbcd1da7b04f8f78c990fe964c5804e0506', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (240, '1094', 'MUH.HAIKAL YUNUS', 'd3a3c101936b93dbf9eb710e611c2cf58c806137', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (241, '1095', 'MUHAMMAD AZAM', '1f6ae7aaf57c91eff8b09946b2fdf0abd67ac2cf', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (242, '1097', 'MUHAMMAD HAIKAL PAJERI', '9d9859ef101e69d0b68952447676060a3591dc47', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (243, '1098', 'MUHAMMAD MUKHLISIN', '9ae17b153a32567d1646caa8c4010174c30ac349', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (244, '1099', 'MUHAMMAD WAHYUDDIN SUBHAN', '0200320ae3bc247e747ef93e3259bc29ddf53392', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (245, '1100', 'MUHAMMAD YUDA PRASETYO', 'b124524c4b1ade45d1deecbcdef614fadb3ec205', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (246, '1101', 'NABILA SETIAWATI', '551220deeb362077f5df356bdebaf94f34f93f0c', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (247, '1102', 'NAYLA SASKYA KHAIRANI', '7c9fe6831f52e30e0ede4f8c54fd9bba673e8d8b', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (248, '1103', 'NOVA CATUR ARDIANSYAH', 'e0837d45b42d05c84938a39fde34641ff3bc328d', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (249, '1104', 'RAHMAT KHALIL RIYADI', 'a6990ed96e2c5acac92acdcc3f83ba4e2893ad76', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (250, '1105', 'RIAN ANGGA SAPUTRA', '7cb3f42379df52fb7c22a44c27399c3177bd99d2', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (251, '1106', 'RIO ADJIE PAMUNGKAS', '9b42c60dfb2b5a8e1c588b0ec793752aa4f299f3', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (252, '1107', 'SAFARUDIN', 'fee8346a5a401a9c314846811346613d2ddf998c', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (253, '1108', 'SIGID PRIANTO', '282c0a20f0520a152c89d8c0489426c0668ca495', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (254, '1109', 'ADITIA DUWI SAPUTRO', '2f70e239c7a5d80384275be451075e4cb7125e9e', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (255, '1110', 'ADITIYA FAHRI AKBAR', '533958a2148aa8a3466fa3a8340d51e28294f41d', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (256, '1111', 'AGUS SANTOSO', '011c945f30ce2cbafc452f39840f025693339c42', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (257, '1112', 'ARDI KURNIAWAN', '7161a2409087e392cf68559ddac9f1b64b07510c', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (258, '1113', 'BAGAS RAFIUD DARAJAD', '3ca192bd7558780793444f73366c58d60c9d7775', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (259, '1114', 'DANISWARA', '870f1bf229da5eb26e5e5a7c1d69d9451fa7906a', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (260, '1115', 'DIKA ARIS WIDIANTO', '04b69e5006d308a60f286c6d87138324d3c745c6', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (261, '1117', 'EPRIL DWI SATRIYO', 'e6ba73dc9533e190c71bfc3877414870457f1533', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (262, '1118', 'FAJAR ICHTIAR NAZIL', 'fbaacb960902382e4f6c96f2d8f225c24eecadb4', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (263, '1119', 'GIGIH HARTANTO', 'cedf5ccd8253fb636743d0248d10bcc0f11c8edf', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (264, '1120', 'IKHSAN ZAENAL ARIFIN', '1592af7e76a7114b4f9beea0be4746f59ada13a6', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (265, '1121', 'ILHAM HAPPY HANAFI', '784e9240155834852dff458a730cceb50229df32', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (266, '1122', 'IRFAN ADITYA PRATAMA', '00fd4b4549a1094aae926ef62e9dbd3cdcc2e456', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (267, '1123', 'IRGITA LEO PUTRA PRATAMA', 'cf7579954ba3792f6a40044c32f28fb62b10863f', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (268, '1124', 'JAGAT ENGGAR KUSUMA', 'ff33a8f10515011cba0d191ae58f7f9a4dd7a3e1', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (269, '1125', 'KHAFIDL NUR FAUZAN', '5bbd5046c9b461ca6f1549f3f39c240a9c5702f9', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (270, '1126', 'KHOIRUL RAHMAD RIFAI', 'e83f7664870c1105727dd99353d0bfa01b2450b5', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (271, '1129', 'MUHAMMAD ADITYA NUGROHO', '6a08d626bc555a03f727670d5b358610a093cfb5', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (272, '1127', 'MUHAMMAD KURNIAWAN NUR FATHONI', '2e5a616a2cb3b91852eafe6c9f29c186cc2efd2e', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (273, '1128', 'MUHAMMAD RAHMAWAN NUR FAUZI', 'f0a3865870d476fd2019497ce810af59b1f3581b', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (274, '1131', 'MUHAMMAD RIDWAN', 'eeb8f1dbcd3eedab645d5ab893d199d494579bf3', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (275, '1132', 'MUHAMMAD SIDIQ', '081be7c370bf9e7b4c6e696276c1b2d57623b26b', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (276, '1133', 'NICO EKA ARYANSYAH', '91d5e6728240dd7edc866732c15a56a934cf0a97', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (277, '1134', 'NUGROHO SIDIK MAULANA IBRAHIM', '23e24d90c6975b633f20329226281e642e52ab03', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (278, '1135', 'NUR HARYANTO', 'ad5955c8503631249178de05628e1434aad35af0', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (279, '1136', 'RAFFA AJIE SAPUTRA', '3aec82c18ccca37a61500a2c658e353667387d9d', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (280, '1137', 'RESNO DANU RAMADANI', '4b3dd95e69e77efeaa3844fd6f6f6ffc5c3bd3f1', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (281, '1138', 'ROBI DAMA PRAKOSO', '071819749594ed380380dca6aed0f24e25cc9269', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (282, '1140', 'SRI RANGGA BAYU NUGROHO', '715e82fa3b623c04f4eb343985dbbe7555a0be99', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (283, '1141', 'TRI WINARNO', '5378c3d8a9417d31d1abdb3da9ffb909420656eb', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (284, '1142', 'TRIA ALFATAH', '619b7f2c7440776e5362a04735de28763ff332d8', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (285, '1143', 'YAZID MUHROM AZZACKY', 'bc4d45844d467b9fbd27dcd0b41fe52d229884c3', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (286, '1144', 'YAZIN ISMAEL', '4b19229e380e9ca29673fdb967fd09cdcf4b5b44', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (287, '1145', 'YUSUF NAJARUDIN', 'be69557045e8d95f6c5bc62bea729b2e4bc50a7c', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (288, '1146', 'YUSUP RAMADANI', 'b25b748a59d8b6b5b5ae3e9d985289e795c874ed', 'AUTO', '2023-06-27 20:31:28', NULL, NULL, b'0', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Function structure for fnGetMonthName
-- ----------------------------
DROP FUNCTION IF EXISTS `fnGetMonthName`;
delimiter ;;
CREATE FUNCTION `fnGetMonthName`(`Bulan` int)
 RETURNS varchar(55) CHARSET latin1
BEGIN
	#Routine body goes here...
	SET @NamaBulan = '';
	SET @NamaBulan = (SELECT CASE WHEN Bulan = 1 THEN 'Januari' ELSE 
		CASE WHEN Bulan = 2 THEN 'Februari' ELSE 
			CASE WHEN Bulan = 3 THEN 'Maret' ELSE 
				CASE WHEN Bulan = 4 THEN 'April' ELSE 
					CASE WHEN Bulan = 5 THEN 'Mei' ELSE 
						CASE WHEN Bulan = 6 THEN 'Juni' ELSE 
							CASE WHEN Bulan = 7 THEN 'Juli' ELSE 
								CASE WHEN Bulan = 8 THEN 'Agustus' ELSE 
									CASE WHEN Bulan = 9 THEN 'September' ELSE 
										CASE WHEN Bulan = 10 THEN 'Oktober' ELSE 
											CASE WHEN Bulan = 11 THEN 'November' ELSE 
												CASE WHEN Bulan = 12 THEN 'Desember' ELSE '' END
											END
										END
									END
								END
							END
						END 
					END
				END
			END
		END
	END);
	RETURN @NamaBulan;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for f_terbilang
-- ----------------------------
DROP FUNCTION IF EXISTS `f_terbilang`;
delimiter ;;
CREATE FUNCTION `f_terbilang`(angka BIGINT)
 RETURNS text CHARSET latin1
BEGIN
-- @rgiapratama - 2017
    DECLARE v_result TEXT;
    CALL p_terbilang(angka, v_result);
    RETURN REPLACE(v_result,'  ',' ');
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for p_terbilang
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_terbilang`;
delimiter ;;
CREATE PROCEDURE `p_terbilang`(IN angka bigint, OUT retval TEXT)
BEGIN
  -- @rgiapratama - 2017
    DECLARE tmp1 TEXT;
    DECLARE tmp2 TEXT;
     
    SET max_sp_recursion_depth := 20;
 
    IF(angka = 0) THEN
        SET retval = '';
  ELSEIF(angka < 12) THEN
        SET retval = ELT(angka,'satu','dua','tiga','empat','lima','enam','tujuh','delapan','sembilan','sepuluh','sebelas');
  ELSEIF (angka < 20) THEN
        CALL p_terbilang((angka-10),tmp1);
        SET retval = CONCAT(tmp1,' belas');
  ELSEIF (angka < 100) THEN
        CALL p_terbilang(FLOOR(angka/10),tmp1);
        CALL p_terbilang((angka%10),tmp2);
        SET retval = CONCAT(tmp1,' puluh ',tmp2);
  ELSEIf (angka < 200) THEN
        CALL p_terbilang((angka-100),tmp1);
        SET retval = CONCAT('seratus ',tmp1);
  ELSEIF (angka < 1000) THEN
        CALL p_terbilang(FLOOR(angka/100),tmp1);
        CALL p_terbilang((angka%100),tmp2);
        SET retval = CONCAT(tmp1,' ratus ',tmp2);
  ELSEIF (angka < 2000) THEN
        CALL p_terbilang((angka-1000),tmp1);
        SET retval = CONCAT('seribu ',tmp1);
  ELSEIF (angka < 1000000) THEN
        CALL p_terbilang(FLOOR(angka/1000),tmp1);
        CALL p_terbilang((angka%1000),tmp2);
        SET retval = CONCAT(tmp1,' ribu ',tmp2);
  ELSEIF (angka < 1000000000) THEN
        CALL p_terbilang(FLOOR(angka/1000000),tmp1);
        CALL p_terbilang((angka%1000000),tmp2);
        SET retval = CONCAT(tmp1,' juta ',tmp2);
  ELSEIF (angka < 1000000000000) THEN
        CALL p_terbilang(FLOOR(angka/1000000000),tmp1);
        CALL p_terbilang((angka%1000000000),tmp2);
        SET retval = CONCAT(tmp1,' milyar ',tmp2);
  ELSE SET retval = 'GIA';
  END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for vsp_show_buku_kas
-- ----------------------------
DROP PROCEDURE IF EXISTS `vsp_show_buku_kas`;
delimiter ;;
CREATE PROCEDURE `vsp_show_buku_kas`(IN `TglAwal` date,IN `TglAkhir` date)
BEGIN
	SELECT * FROM (
		SELECT 
			'99'							KodeAkun,
			'SALDO AWAL'			NamaPos,
			''								Reff,
			'2023-06-01'			TglTransaksi,
			'2023-06-01' 			TglPencatatan,
			''								Keterangan,
			COALESCE(SUM(a.UangMasuk - a.UangKeluar),0) SaldoAwal,
			0 Pemasukan,
			0 Pengeluaran
		FROM bukukas a
		LEFT JOIN tposkeuangan b on a.KodeAkun = b.KodePosKeuangan
		WHERE a.TglTransaksi < TglAwal
		UNION ALL
		SELECT 
			a.KodeAkun,
			d.NamaPos,
			a.BaseNum,
			a.TglTransaksi,
			a.TglPencatatan,
			CONCAT(d.NamaPos, ' - ', COALESCE(e.NamaSiswa,''), ' Bulan ', fnGetMonthName(MONTH(a.TglTransaksi)),' ', YEAR(a.TglTransaksi),' # ', a.Keterangan) Keterangan,
			0 SaldoAwal,
			a.UangMasuk,
			a.UangKeluar
		FROM bukukas a
		LEFT JOIN pembayarandetail b on a.BaseNum = b.NoTransaksi and a.BaseLine = b.LineNumber
		LEFT JOIN tagihandetail c on c.NoTransaksi = b.BaseNum and c.LineNumber = b.BaseLine
		LEFT JOIN tposkeuangan d on a.KodeAkun = d.KodePosKeuangan
		LEFT JOIN tagihanheader e on c.NoTransaksi = e.NoTransaksi
		WHERE a.TglTransaksi BETWEEN TglAwal AND TglAkhir
	)x ORDER BY x.TglPencatatan;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table pembayarandetail
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_AddBukuKas`;
delimiter ;;
CREATE TRIGGER `trg_AddBukuKas` AFTER INSERT ON `pembayarandetail` FOR EACH ROW BEGIN
	INSERT INTO bukukas
	SELECT 
		0,
		c.TglTransaksi,
		c.TglPencatatan,
		b.KodePosKeuangan,
		c.Keterangan,
		a.Jumlah,
		0,
		a.NoTransaksi,
		a.LineNumber
	FROM pembayarandetail a
	LEFT JOIN tjenistagihan b on a.KodeItemTagihan = b.KodeTagihan
	LEFT JOIN pembayaranheader c on a.NoTransaksi = c.NoTransaksi
	WHERE a.NoTransaksi = NEW.NoTransaksi;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table tsiswa
-- ----------------------------
DROP TRIGGER IF EXISTS `trgAddUser`;
delimiter ;;
CREATE TRIGGER `trgAddUser` AFTER INSERT ON `tsiswa` FOR EACH ROW BEGIN
	INSERT into users(username, nama, `password`, CreatedBy, CreatedOn,verified)
	VALUE
	(NEW.NIS,NEW.NamaSiswa,SHA1(NEW.NIS),'AUTO',NOW(),0);
	INSERT into userrole
	SELECT id, 4 FROM users where username = NEW.NIS;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
