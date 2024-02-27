#
# TABLE STRUCTURE FOR: pascode
#

DROP TABLE IF EXISTS `pascode`;

CREATE TABLE `pascode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Passcode` text NOT NULL,
  `ValidTo` datetime(6) NOT NULL,
  `Status` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

INSERT INTO `pascode` (`id`, `Passcode`, `ValidTo`, `Status`) VALUES (1, '6335cde1452894c515ef1fed11c0ae4ab7dde23274804279db12fc7ab688ed8079a7b49e96c94f2ef396d82a948f6645ccffbe2b2dcf1d3a8926a9f5a98f47f4IRm+483OyL7DaYPh43vUg5rMRHnYVVmYk6AvctfINGc=', '2023-07-14 11:20:33.000000', 1);


#
# TABLE STRUCTURE FOR: patroli
#

DROP TABLE IF EXISTS `patroli`;

CREATE TABLE `patroli` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `RecordOwnerID` varchar(55) NOT NULL,
  `KodeCheckPoint` varchar(55) NOT NULL,
  `LocationID` int(6) NOT NULL,
  `TanggalPatroli` datetime(6) NOT NULL,
  `KodeKaryawan` varchar(55) NOT NULL,
  `Koordinat` varchar(250) NOT NULL,
  `Image` text NOT NULL,
  `Catatan` varchar(255) DEFAULT NULL,
  `Rank` int(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# TABLE STRUCTURE FOR: permission
#

DROP TABLE IF EXISTS `permission`;

CREATE TABLE `permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionname` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `ico` varchar(255) DEFAULT NULL,
  `menusubmenu` varchar(255) DEFAULT NULL,
  `multilevel` bit(1) DEFAULT NULL,
  `separator` bit(1) DEFAULT NULL,
  `order` int(255) DEFAULT NULL,
  `status` bit(1) DEFAULT NULL,
  `AllowMobile` bit(1) DEFAULT NULL,
  `MobileRoute` varchar(255) DEFAULT NULL,
  `MobileLogo` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

INSERT INTO `permission` (`id`, `permissionname`, `link`, `ico`, `menusubmenu`, `multilevel`, `separator`, `order`, `status`, `AllowMobile`, `MobileRoute`, `MobileLogo`) VALUES (1, 'Master', '', 'fa-archive', '0', '1', '0', 1, '1', NULL, NULL, NULL);
INSERT INTO `permission` (`id`, `permissionname`, `link`, `ico`, `menusubmenu`, `multilevel`, `separator`, `order`, `status`, `AllowMobile`, `MobileRoute`, `MobileLogo`) VALUES (2, 'Lokasi Patroli', 'lokasi', NULL, '1', '0', '0', 2, '1', NULL, NULL, NULL);
INSERT INTO `permission` (`id`, `permissionname`, `link`, `ico`, `menusubmenu`, `multilevel`, `separator`, `order`, `status`, `AllowMobile`, `MobileRoute`, `MobileLogo`) VALUES (3, 'Titik Patroli', 'checkpoint', NULL, '1', '0', '0', 3, '1', NULL, NULL, NULL);
INSERT INTO `permission` (`id`, `permissionname`, `link`, `ico`, `menusubmenu`, `multilevel`, `separator`, `order`, `status`, `AllowMobile`, `MobileRoute`, `MobileLogo`) VALUES (4, 'Pengaturan User', NULL, NULL, '1', '0', '1', 4, '1', NULL, NULL, NULL);
INSERT INTO `permission` (`id`, `permissionname`, `link`, `ico`, `menusubmenu`, `multilevel`, `separator`, `order`, `status`, `AllowMobile`, `MobileRoute`, `MobileLogo`) VALUES (5, 'Permission', 'role', NULL, '1', '0', '0', 5, '1', NULL, NULL, NULL);
INSERT INTO `permission` (`id`, `permissionname`, `link`, `ico`, `menusubmenu`, `multilevel`, `separator`, `order`, `status`, `AllowMobile`, `MobileRoute`, `MobileLogo`) VALUES (6, 'User', 'user', NULL, '1', '0', '0', 6, '1', NULL, NULL, NULL);
INSERT INTO `permission` (`id`, `permissionname`, `link`, `ico`, `menusubmenu`, `multilevel`, `separator`, `order`, `status`, `AllowMobile`, `MobileRoute`, `MobileLogo`) VALUES (7, 'Review Patroli', 'review', 'fa-laptop', '0', '0', '0', 7, '1', NULL, NULL, NULL);
INSERT INTO `permission` (`id`, `permissionname`, `link`, `ico`, `menusubmenu`, `multilevel`, `separator`, `order`, `status`, `AllowMobile`, `MobileRoute`, `MobileLogo`) VALUES (8, 'Laporan', '', 'fa-file-text-o', '0', '1', '0', 8, '0', NULL, NULL, NULL);
INSERT INTO `permission` (`id`, `permissionname`, `link`, `ico`, `menusubmenu`, `multilevel`, `separator`, `order`, `status`, `AllowMobile`, `MobileRoute`, `MobileLogo`) VALUES (9, 'Laporan Patroli', NULL, NULL, '8', '0', '0', 9, '0', NULL, NULL, NULL);
INSERT INTO `permission` (`id`, `permissionname`, `link`, `ico`, `menusubmenu`, `multilevel`, `separator`, `order`, `status`, `AllowMobile`, `MobileRoute`, `MobileLogo`) VALUES (10, 'Security', 'security', NULL, '1', '0', '0', 3, '1', NULL, NULL, NULL);


#
# TABLE STRUCTURE FOR: permissionrole
#

DROP TABLE IF EXISTS `permissionrole`;

CREATE TABLE `permissionrole` (
  `roleid` int(11) NOT NULL,
  `permissionid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

INSERT INTO `permissionrole` (`roleid`, `permissionid`) VALUES (1, 1);
INSERT INTO `permissionrole` (`roleid`, `permissionid`) VALUES (1, 2);
INSERT INTO `permissionrole` (`roleid`, `permissionid`) VALUES (1, 3);
INSERT INTO `permissionrole` (`roleid`, `permissionid`) VALUES (1, 4);
INSERT INTO `permissionrole` (`roleid`, `permissionid`) VALUES (1, 5);
INSERT INTO `permissionrole` (`roleid`, `permissionid`) VALUES (1, 6);
INSERT INTO `permissionrole` (`roleid`, `permissionid`) VALUES (1, 7);
INSERT INTO `permissionrole` (`roleid`, `permissionid`) VALUES (1, 8);
INSERT INTO `permissionrole` (`roleid`, `permissionid`) VALUES (1, 9);
INSERT INTO `permissionrole` (`roleid`, `permissionid`) VALUES (1, 10);
INSERT INTO `permissionrole` (`roleid`, `permissionid`) VALUES (2, 1);
INSERT INTO `permissionrole` (`roleid`, `permissionid`) VALUES (2, 3);
INSERT INTO `permissionrole` (`roleid`, `permissionid`) VALUES (2, 7);


#
# TABLE STRUCTURE FOR: roles
#

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

INSERT INTO `roles` (`id`, `rolename`) VALUES (1, 'Super Admin');
INSERT INTO `roles` (`id`, `rolename`) VALUES (2, 'Admin');
INSERT INTO `roles` (`id`, `rolename`) VALUES (3, 'Security');


#
# TABLE STRUCTURE FOR: tcheckpoint
#

DROP TABLE IF EXISTS `tcheckpoint`;

CREATE TABLE `tcheckpoint` (
  `KodeCheckPoint` varchar(55) NOT NULL,
  `NamaCheckPoint` varchar(255) NOT NULL,
  `Keterangan` varchar(255) DEFAULT NULL,
  `LocationID` int(6) NOT NULL,
  `RecordOwnerID` varchar(55) NOT NULL,
  PRIMARY KEY (`KodeCheckPoint`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# TABLE STRUCTURE FOR: tcompany
#

DROP TABLE IF EXISTS `tcompany`;

CREATE TABLE `tcompany` (
  `KodePartner` varchar(55) NOT NULL,
  `NamaPartner` varchar(255) NOT NULL,
  `AlamatTagihan` varchar(255) NOT NULL,
  `NoTlp` varchar(12) NOT NULL,
  `NoHP` varchar(255) NOT NULL,
  `NIKPIC` varchar(255) NOT NULL,
  `NamaPIC` varchar(255) NOT NULL,
  `CreatedOn` datetime(6) NOT NULL,
  `CreatedBy` varchar(255) NOT NULL,
  `LastUpdatedOn` datetime DEFAULT NULL,
  `LastUpdatedBy` varchar(55) DEFAULT NULL,
  `tempStore` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`KodePartner`),
  KEY `idxKodePartner` (`KodePartner`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# TABLE STRUCTURE FOR: tlokasipatroli
#

DROP TABLE IF EXISTS `tlokasipatroli`;

CREATE TABLE `tlokasipatroli` (
  `id` int(55) NOT NULL AUTO_INCREMENT,
  `NamaArea` varchar(255) NOT NULL,
  `AlamatArea` varchar(255) DEFAULT NULL,
  `Keterangan` varchar(255) DEFAULT NULL,
  `RecordOwnerID` varchar(55) NOT NULL,
  `StartPatroli` time(6) NOT NULL,
  `IntervalPatroli` int(6) NOT NULL,
  `IntervalType` varchar(255) NOT NULL,
  `EndPatroli` time(6) NOT NULL,
  `Toleransi` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idxArea` (`RecordOwnerID`,`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# TABLE STRUCTURE FOR: tsecurity
#

DROP TABLE IF EXISTS `tsecurity`;

CREATE TABLE `tsecurity` (
  `NIK` varchar(55) NOT NULL,
  `NamaSecurity` varchar(255) NOT NULL,
  `JoinDate` date NOT NULL,
  `LocationID` int(11) NOT NULL,
  `Status` int(1) NOT NULL,
  `RecordOwnerID` varchar(55) NOT NULL,
  `tempEncrypt` text NOT NULL,
  PRIMARY KEY (`NIK`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# TABLE STRUCTURE FOR: userrole
#

DROP TABLE IF EXISTS `userrole`;

CREATE TABLE `userrole` (
  `userid` int(11) NOT NULL,
  `roleid` int(11) DEFAULT NULL,
  PRIMARY KEY (`userid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

INSERT INTO `userrole` (`userid`, `roleid`) VALUES (1, 1);
INSERT INTO `userrole` (`userid`, `roleid`) VALUES (2, 3);
INSERT INTO `userrole` (`userid`, `roleid`) VALUES (3, 2);


#
# TABLE STRUCTURE FOR: users
#

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(75) DEFAULT NULL,
  `nama` varchar(75) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `createdby` varchar(255) DEFAULT NULL,
  `createdon` datetime DEFAULT NULL,
  `HakAkses` int(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `verified` bit(1) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `browser` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `RecordOwnerID` varchar(55) DEFAULT NULL,
  `AreaUser` varchar(55) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idUserID` (`id`,`username`,`RecordOwnerID`,`AreaUser`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

INSERT INTO `users` (`id`, `username`, `nama`, `password`, `createdby`, `createdon`, `HakAkses`, `token`, `verified`, `ip`, `browser`, `email`, `phone`, `RecordOwnerID`, `AreaUser`) VALUES (1, 'manager', 'AIS SYSTEM', '43ccdfe93ef6be87f4f41801a97a921a5af93260ac23433f9c3b4213dccc271ccd86efbe98bacf700f2cbb3e0a6b75c3d6c0eab486eb4d710abc7a10047fea41O4vHOjZA/dcmPfp2N8O+mO1v+ric5AIA86kuXkHWqCE=', 'AUTO', '2023-07-06 16:07:15', NULL, NULL, '0', NULL, NULL, NULL, NULL, 'CL0001', '');
INSERT INTO `users` (`id`, `username`, `nama`, `password`, `createdby`, `createdon`, `HakAkses`, `token`, `verified`, `ip`, `browser`, `email`, `phone`, `RecordOwnerID`, `AreaUser`) VALUES (2, '40001', 'Prasetyo Aji Wibowo', '08c2abdf5f355dd99e0bd5a522aaf33f34c218fc66a6081c87eac2d15a488b2397623d4864740432323e712eebdf05dc94996d5ac6f9790aadd0290b2b1121a6rluW9NwHpb6h0B7flaWJ7EzdPzQm31CWO++leUz4lro=', 'AUTO', '2023-07-07 22:00:32', NULL, NULL, '0', NULL, NULL, NULL, NULL, 'CL0001', '2');
INSERT INTO `users` (`id`, `username`, `nama`, `password`, `createdby`, `createdon`, `HakAkses`, `token`, `verified`, `ip`, `browser`, `email`, `phone`, `RecordOwnerID`, `AreaUser`) VALUES (3, 'admin', 'admin', '5aaee1cf7e3bfdf721e843016ba74b826ccbae063078b19216ca4378086926ae56097c3000905cd02ae4182f47efaeae3fcf1af91397c0436c37d95bc7647f20+NZD5suwmtSnc386E+xHuehMrq+uaJm734WUV6YTpzY=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 'CL0001', '4');


