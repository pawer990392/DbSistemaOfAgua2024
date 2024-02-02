CREATE DATABASE SistemasCobroAgua2024
USE SistemasCobroAgua2024

CREATE TABLE rol (
idRol       INTEGER NOT NULL IDENTITY(1,1),
description VARCHAR(40) NOT NULL,
statusRol   BIT NOT NULL DEFAULT 1,
date_create DATE NOT NULL,
date_modifity DATE NOT NULL,
CONSTRAINT pk_rol PRIMARY KEY(IdRol)
);
CREATE TABLE users (
idUser INTEGER IDENTITY(1,1),
idRol INTEGER NOT NULL,
UserName VARCHAR(40) NOT NULL,
Password text NOT NULL,
name VARCHAR(60) NOT NULL,
lastNameP VARCHAR(60) NOT NULL,
lastNameM VARCHAR(60) NOT NULL,
Phone VARCHAR(10) NOT NULL,
createUser INTEGER NOT NULL,
createDate DATETIME NOT NULL,
editUser   INTEGER NOT NULL,
editDate   DATETIME NOT NULL,
statusUsers BIT NOT NULL DEFAULT 1,
CONSTRAINT pk_users PRIMARY KEY(idUser),
CONSTRAINT fk_userRol FOREIGN KEY (idRol) REFERENCES rol (idRol),
);
CREATE TABLE services (
idservices  INTEGER IDENTITY(1,1),
description	VARCHAR(100) NOT NULL,
cost        DECIMAL NOT NULL,
statusServices BIT NOT NULL DEFAULT 1,
createUser INTEGER NOT NULL,
createDate DATETIME NOT NULL,
editUser   INTEGER NOT NULL,
editDate   DATETIME NOT NULL,
CONSTRAINT pk_Services PRIMARY KEY(idservices)
);
CREATE TABLE settlement(
	idSettlement INTEGER NOT NULL IDENTITY(1,1),
	name         VARCHAR(100) NOT NULL,
	createUser INTEGER NOT NULL,
	createDate DATETIME NOT NULL,
	editUser   INTEGER NOT NULL,
	editDate   DATETIME NOT NULL,
	CONSTRAINT pk_idSettlement PRIMARY KEY(idSettlement)
);
CREATE TABLE street(
	idstreet INTEGER NOT NULL IDENTITY(1,1),
	idSettlement INTEGER NOT NULL,
	nameStreet VARCHAR(100) NOT NULL,
	createUser INTEGER NOT NULL,
	createDate DATETIME NOT NULL,
	editUser   INTEGER NOT NULL,
	editDate   DATETIME NOT NULL,
	CONSTRAINT pk_street PRIMARY KEY(idstreet),
	CONSTRAINT fk_settlement FOREIGN KEY (idSettlement) REFERENCES settlement (idSettlement)
);

CREATE TABLE statusToma (
idStatusToma INTEGER IDENTITY(1,1),
description VARCHAR(40) NOT NULL,
statusToma BIT NOT NULL DEFAULT 1,
createUser INTEGER NOT NULL,
createDate DATETIME NOT NULL,
editUser   INTEGER NOT NULL,
editDate   DATETIME NOT NULL,
CONSTRAINT pk_statusToma PRIMARY KEY(idStatusToma)
);

CREATE TABLE tarifa (
idTarifa INTEGER NOT NULL IDENTITY(1,1),
description VARCHAR(200) NOT NULL,
cost DECIMAL NOT NULL,
createUser INTEGER NOT NULL,
createDate DATETIME NOT NULL,
editUser   INTEGER NOT NULL,
editDate   DATETIME NOT NULL,
statusTarifa BIT NOT NULL default 1
CONSTRAINT pk_tarifa PRIMARY KEY(idTarifa)
);

CREATE TABLE sanction (
idSanction INTEGER IDENTITY(1,1),
description	varchar(100) NOT NULL,
cost DECIMAL NOT NULL,
createUser INTEGER NOT NULL,
createDate DATETIME NOT NULL,
editUser   INTEGER NOT NULL,
editDate   DATETIME NOT NULL,
statusSancion bit default 1 NOT NULL
CONSTRAINT pk_idSanction PRIMARY KEY(idSanction)
);

CREATE TABLE cargo(
   idCargo INTEGER NOT NULL IDENTITY(1,1),
   description VARCHAR(80) NOT NULL,
   createUser INTEGER NOT NULL,
   createDate DATETIME NOT NULL,
   editUser   INTEGER NOT NULL,
   editDate   DATETIME NOT NULL,
   statusCargos BIT NOT NULL DEFAULT 1,
   CONSTRAINT pk_cargo PRIMARY KEY(idCargo)
);

 CREATE TABLE representative(
idRepresentative INTEGER NOT NULL IDENTITY(1,1),
idCargo INTEGER NOT NULL,
name VARCHAR(60) NOT NULL,
lastNameP VARCHAR(60) NOT NULL,
lastNameM VARCHAR(60) NOT NULL,
createUser INTEGER NOT NULL,
createDate DATETIME NOT NULL,
editUser   INTEGER NOT NULL,
editDate   DATETIME NOT NULL,
statusRepresentative BIT NOT NULL DEFAULT 1,
CONSTRAINT pk_representative PRIMARY KEY(idRepresentative),
CONSTRAINT fk_cargo FOREIGN KEY (idCargo) REFERENCES cargo(idCargo)
);

CREATE TABLE consumer (
idConsumer INTEGER NOT NULL IDENTITY(1,1),
idstreet INTEGER NOT NULL,
numberExt INTEGER NOT NULL,
numberInt VARCHAR(5) NULL DEFAULT '/',
name VARCHAR(60) NOT NULL,
lastNameP VARCHAR(60) NOT NULL,
lastNameM VARCHAR(60) NOT NULL,
typeGender  CHAR(1) NOT NULL,
phone VARCHAR(10) NOT NULL, 
descripcion VARCHAR(300) NULL DEFAULT '/',
createUser INTEGER NOT NULL,
createDate DATETIME NOT NULL,
editUser   INTEGER NOT NULL,
editDate   DATETIME NOT NULL,
CONSTRAINT pk_Consumer PRIMARY KEY(idConsumer),
CONSTRAINT fk_consumerStreet FOREIGN KEY (idstreet) REFERENCES street (idstreet)
);
CREATE TABLE contract(
idContract INTEGER NOT NULL IDENTITY(1,1),
idConsumer INTEGER NOT NULL,
idservices INTEGER NOT NULL,
idTarifa   INTEGER NOT NULL, 
createUser INTEGER NOT NULL,
createDate DATETIME NOT NULL,
editUser   INTEGER NOT NULL,
editDate   DATETIME NOT NULL,
CONSTRAINT pk_Contract PRIMARY KEY(idContract),
CONSTRAINT pk_ContractConsumer FOREIGN KEY (idConsumer) REFERENCES consumer (idConsumer),
CONSTRAINT pk_ContractServices FOREIGN KEY (idservices) REFERENCES services (idservices),
CONSTRAINT pk_ContractTarifa FOREIGN KEY (idTarifa) REFERENCES tarifa (idTarifa)
);	
CREATE TABLE toma (
idToma INTEGER IDENTITY(1,1),
idContract INTEGER NOT NULL,
idSettlement INTEGER NOT NULL,
idstreet INTEGER NOT NULL,
idTarifa INTEGER NOT NULL,
idStatusToma INTEGER NOT NULL,
descripcionToma VARCHAR(250),
createUser INTEGER NOT NULL,
createDate DATETIME NOT NULL,
editUser   INTEGER NOT NULL,
editDate   DATETIME NOT NULL,
CONSTRAINT pk_toma PRIMARY KEY(idToma),
CONSTRAINT pk_tomaContracto FOREIGN KEY (idContract) REFERENCES contract (idContract),
CONSTRAINT pk_tomaColonia FOREIGN KEY (idSettlement) REFERENCES settlement (idSettlement),
CONSTRAINT pk_fkContriStreet FOREIGN KEY(idstreet) REFERENCES street(idstreet),
CONSTRAINT pk_contriTarifa FOREIGN KEY (idTarifa) REFERENCES tarifa (idTarifa),
CONSTRAINT pk_tomastatusToma FOREIGN KEY (idStatusToma) REFERENCES statusToma (idStatusToma)
);

CREATE TABLE months(
idMonth INTEGER NOT NULL IDENTITY(1,1),
nameMonth VARCHAR(15) NOT NULL UNIQUE,
CONSTRAINT pk_Month PRIMARY KEY(idMonth)
);

CREATE TABLE voucher(
idVoucher INTEGER NOT NULL IDENTITY(1,1),
idToma INTEGER NOT NULL,
amountPay DECIMAL(9,2) NOT NULL,
yearPagado INTEGER NOT NULL,
createUser INTEGER NOT NULL,
createDate DATETIME NOT NULL,
editUser   INTEGER NOT NULL,
editDate   DATETIME NOT NULL,
CONSTRAINT pk_voucher PRIMARY KEY(idVoucher),
CONSTRAINT fk_voucherTomas FOREIGN KEY (idToma) REFERENCES toma (idToma)
);

CREATE TABLE voucher_meses(
   idvoucher  INTEGER NOT NULL,
   idMonth    INTEGER NOT NULL,
   CONSTRAINT pk_voucherMonth PRIMARY KEY(idvoucher,idMonth),
   CONSTRAINT fk_voucher_detail FOREIGN KEY (idvoucher) REFERENCES voucher (idvoucher),
   CONSTRAINT fk_detailMonth FOREIGN KEY (idMonth) REFERENCES months (idMonth)
);

CREATE TABLE debts(
idDebts INTEGER NOT NULL IDENTITY(1,1),
idToma INTEGER NOT NULL,
idSanction INTEGER NOT NULL,
idexpiredMonth INTEGER NOT NULL,
expiredYear INTEGER NOT NULL,
createDebts DATETIME NOT NULL,
statusPay BIT NOT NULL DEFAULT 0,
CONSTRAINT pk_idDebts PRIMARY KEY(idDebts),
CONSTRAINT fk_DebtsToma FOREIGN KEY (idToma) REFERENCES toma (idToma),
CONSTRAINT fk_DebtsSanction FOREIGN KEY (idSanction) REFERENCES sanction (idSanction),
CONSTRAINT fk_DebtsExpireMonth FOREIGN KEY (idexpiredMonth) REFERENCES months (idMonth)
);

CREATE TABLE voucher_debts(
	   idVoucher INTEGER NOT NULL, 
	   idDebts INTEGER NOT NULL,
	   debtsPaidDate DATETIME NOT NULL,
	   CONSTRAINT pk_voucherDebts PRIMARY KEY(idVoucher,idDebts),
	   CONSTRAINT fk_voucherDetail FOREIGN KEY (idVoucher) REFERENCES voucher (idVoucher),
	   CONSTRAINT fk_debtsDetail FOREIGN KEY (idDebts) REFERENCES debts (idDebts)
);

CREATE TABLE additionalToma (
idAdditionalToma INTEGER NOT NULL IDENTITY(1,1),
idToma INTEGER NOT NULL,
idConsumer INTEGER NOT NULL,
idTarifa INTEGER NOT NULL,
idStatusToma INTEGER NOT NULL,
descriptionToma VARCHAR(250) DEFAULT 'S/C', 
createUser INTEGER NOT NULL,
createDate DATETIME NOT NULL,
editUser   INTEGER NOT NULL,
editDate   DATETIME NOT NULL,
CONSTRAINT pk_additionalTomaToma PRIMARY KEY(idAdditionalToma),
CONSTRAINT pk_additionalToma FOREIGN KEY (idToma) REFERENCES toma (idToma),
CONSTRAINT pk_additionalTomaConsumer FOREIGN KEY (idConsumer) REFERENCES consumer (idConsumer),
CONSTRAINT pk_additionalTomaTarifa FOREIGN KEY (idTarifa) REFERENCES tarifa (idTarifa),
CONSTRAINT pk_additionalTomatatusToma FOREIGN KEY (idStatusToma) REFERENCES statusToma (idStatusToma)
);