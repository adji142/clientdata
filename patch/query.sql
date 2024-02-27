CREATE TABLE `patroli`.`guestlog`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `Tanggal` date NOT NULL,
  `TglMasuk` date NOT NULL,
  `TglKeluar` date NULL,
  `ImageIn` text NOT NULL,
  `ImageOut` text NULL,
  `RecordOwnerID` varchar(55) NOT NULL,
  `LocationID` int NULL,
  `Keterangan` varchar(255) NULL,
  `CreatedAt` datetime(6) NOT NULL,
  `LastUpdatedAt` datetime(6) NULL,
  PRIMARY KEY (`id`)
);