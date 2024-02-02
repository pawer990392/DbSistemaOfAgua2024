CREATE DATABASE SistemasCobroAgua
USE SistemasCobroAgua
--cremos las tablas fuertes
CREATE TABLE rol (
idRol       INTEGER NOT NULL IDENTITY(1,1),
description VARCHAR(40) NOT NULL,
statusRol   BIT NOT NULL DEFAULT 1,
date_create DATE NOT NULL,
date_modifity DATE NOT NULL,
CONSTRAINT pk_rol PRIMARY KEY(IdRol)
);

--Insermos Datos
INSERT INTO rol (description,date_create,date_modifity) 
	   VALUES('Adminisrador',GETDATE(),GETDATE()),('Usuario',GETDATE(),GETDATE());

--Tabla  Usuarios
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
----Insertamos Datos
INSERT INTO users(idRol,UserName,Password,name,lastNameP,lastNameM,Phone,createUser,createDate,editUser,editDate)
	   VALUES(1,'Miguel5673','Manchas123','Mario','Delgado','Martinez','2381813540',1,GETDATE(),1,GETDATE()),
             (2,'cuevas9985','cuevas123','Armando','Perez','Moteo','2382050491',1,GETDATE(),1,GETDATE());

--SELECT * FROM users

--Tabla Servicio Contratado
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
--Insertamos Datos
INSERT INTO services (description,cost,createUser,createDate,editUser,editDate)
	   VALUES('Agua Potable',1000,1,GETDATE(),1,GETDATE()),('Drenaje',1100,1,GETDATE(),1,GETDATE());

--TABLA Calle 
CREATE TABLE settlement(
	idSettlement INTEGER NOT NULL IDENTITY(1,1),
	name         VARCHAR(100) NOT NULL,
	createUser INTEGER NOT NULL,
	createDate DATETIME NOT NULL,
	editUser   INTEGER NOT NULL,
	editDate   DATETIME NOT NULL,
	CONSTRAINT pk_idSettlement PRIMARY KEY(idSettlement)
);

--INSERTAR DATOS
INSERT INTO Settlement(name,createUser,createDate,editUser,editDate)
                   VALUES('Reforma',1,GETDATE(),1,GETDATE()),('Niños Hereos',1,GETDATE(),1,GETDATE()),('Santiago Tula',1,GETDATE(),1,GETDATE()),
				   ('Arcardia',2,GETDATE(),1,GETDATE()),('Francisco Villa',2,GETDATE(),2,GETDATE());

--select * from Settlement
--select * from street
--TABLA CALLE Settlement
CREATE TABLE street(
	idstreet INTEGER NOT NULL IDENTITY(1,1),
	idSettlement INTEGER NOT NULL,
	nameStreet VARCHAR(100) NOT NULL,
	createUser INTEGER NOT NULL,
	createDate DATETIME NOT NULL,
	editUser   INTEGER NOT NULL,
	editDate   DATETIME NOT NULL,
	CONSTRAINT pk_street PRIMARY KEY(idstreet),
	CONSTRAINT fk_settlement FOREIGN KEY (idSettlement) REFERENCES settlement (idSettlement),
);

INSERT INTO street(idSettlement,nameStreet,createUser,createDate,editUser,editDate)VALUES
						  (5,'20 de noviembre',1,GETDATE(),1,GETDATE()),(5,'Alvaro Obregon',2,GETDATE(),1,GETDATE()),
						  (5,'Lic. Benito Juarez',2,GETDATE(),1,GETDATE()),(5,'15 de Septiembre',1,GETDATE(),1,GETDATE()),
						  (3,'Leona Vicario',2,GETDATE(),1,GETDATE()),(3,'Calle las Flores',1,GETDATE(),1,GETDATE()),
						  (3,'Las Palmas',1,GETDATE(),1,GETDATE()),
						  (3,'Calle 40 Oriente',2,GETDATE(),1,GETDATE());

 ----Tabla Status de Toma
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

--INSERTAMOS DATOS
INSERT INTO statusToma (description,createUser,createDate,editUser,editDate) 
		VALUES('Pasivo',2,GETDATE(),1,GETDATE()),('Activo',1,GETDATE(),1,GETDATE());


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

INSERT INTO tarifa (description,cost,createUser,createDate,editUser,editDate)
	   VALUES('Domestico',50,1,GETDATE(),1,GETDATE()),('Riego',80,1,GETDATE(),1,GETDATE());

--Tabla Sanciones
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
INSERT INTO sanction (description,cost,createUser,createDate,editUser,editDate)
	   VALUES('Desperdicio de Agua',500,1,GETDATE(),1,GETDATE()),('Pago Vencido',500,1,GETDATE(),1,GETDATE());

--TABLA CARGOS
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

INSERT INTO cargo(description,createUser,createDate,editUser,editDate) 
							VALUES('Presidente de Comite',1,GETDATE(),1,GETDATE()),
							('Secretaria',1,GETDATE(),1,GETDATE()),
							('Tesorera',1,GETDATE(),1,GETDATE());


--CREAR TABLA representative
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
--Insert table representative
INSERT INTO representative(idCargo,name,lastNameP,lastNameM,createUser,createDate,editUser,editDate)
						  VALUES(1,'Felipe','Rodriguez','Castillo',1,GETDATE(),1,GETDATE()),
								(2,'Guillermina','Valencia','Hernandez',1,GETDATE(),1,GETDATE()),
								(3,'Martha','Merino','Pioquinto',1,GETDATE(),1,GETDATE());

--Table Contribuyente
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

--Insertamos Datos
INSERT INTO consumer (idstreet,numberExt,numberInt,name,lastNameP,lastNameM,typeGender,phone,descripcion,createUser,createDate,editUser,editDate)
VALUES (4,231,'','Perla Rocio','Mendez','Mejiaz','F','2375674567','Es un saguna verde',1,GETDATE(),1,GETDATE()),
	   (2,185,'A','Armando','Mendez','Sanchez','M','2389876543','Frente la tortilleria Ramos',1,GETDATE(),1,GETDATE()),
	   (2,185,'','Rodrigo','Perez','Martinez','M','2381813540','Es a alado de una balconeria llamado Emmamnuel',1,GETDATE(),1,GETDATE()),
	   (8,254,'C','Maria Fernanda','Cuevas','Solis','M','2374567544','A lado de un nieveria',1,GETDATE(),1,GETDATE());

--Tabla Contracto
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

--insert table contract
INSERT INTO contract (idConsumer,idservices,idTarifa,createUser,createDate,editUser,editDate)
       VALUES(3,2,1,1,GETDATE(),1,GETDATE()),(4,1,2,1,GETDATE(),1,GETDATE());

--SELECT * FROM contract

--Tabla Toma
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



--INSERTAR DATOS TABLA TOMA DE AGUA
INSERT INTO toma (idContract,idSettlement,idstreet,idTarifa,idStatusToma,descripcionToma,createUser,createDate,editUser,editDate)
		VALUES (1,5,1,1,2,'',1,GETDATE(),1,GETDATE()),
			   (1,5,3,2,2,'',1,GETDATE(),1,GETDATE()),
			   (2,3,6,1,2,'',1,GETDATE(),1,GETDATE());

---TABLA MESES
--CREATE CATALOGO MESES
CREATE TABLE months(
idMonth INTEGER NOT NULL IDENTITY(1,1),
nameMonth VARCHAR(15) NOT NULL UNIQUE,
CONSTRAINT pk_Month PRIMARY KEY(idMonth)
);
--INSERTAR TABLA MESES
INSERT INTO months(nameMonth)VALUES('Enero'),('Febrero'),('Marzo'),('Abril'),
										('Mayo'),('Junio'),('Julio'),('Agosto'),
										('Septiembre'),('Octubre'),('Noviembre'),('Diciembre');



-------TABLA RECIBO
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


--insrt voucher
INSERT INTO voucher(idToma,amountPay,yearPagado,createUser,createDate,editUser,editDate) VALUES(1,150.00,2018,1,GETDATE(),1,GETDATE());
INSERT INTO voucher(idToma,amountPay,yearPagado,createUser,createDate,editUser,editDate) VALUES(1,200.00,2018,1,GETDATE(),1,GETDATE());
INSERT INTO voucher(idToma,amountPay,yearPagado,createUser,createDate,editUser,editDate) VALUES(2,200.00,2019,1,GETDATE(),1,GETDATE());
INSERT INTO voucher(idToma,amountPay,yearPagado,createUser,createDate,editUser,editDate) VALUES(1,200.00,2019,1,GETDATE(),1,GETDATE());
INSERT INTO voucher(idToma,amountPay,yearPagado,createUser,createDate,editUser,editDate) VALUES(3,300.00,2020,1,GETDATE(),1,GETDATE());
INSERT INTO voucher(idToma,amountPay,yearPagado,createUser,createDate,editUser,editDate) VALUES(1,500.00,2021,1,GETDATE(),1,GETDATE());

CREATE TABLE voucher_meses(
   idvoucher  INTEGER NOT NULL,
   idMonth    INTEGER NOT NULL,
   CONSTRAINT pk_voucherMonth PRIMARY KEY(idvoucher,idMonth),
   CONSTRAINT fk_voucher_detail FOREIGN KEY (idvoucher) REFERENCES voucher (idvoucher),
   CONSTRAINT fk_detailMonth FOREIGN KEY (idMonth) REFERENCES months (idMonth),
);

Insert INTO voucher_meses (idvoucher,idMonth)Values (1,1),(1,2),(1,3);
Insert INTO voucher_meses (idvoucher,idMonth)Values (2,4),(2,5),(2,6),(2,7);
Insert INTO voucher_meses (idvoucher,idMonth)Values (3,7),(3,8),(3,9),(3,10);
Insert INTO voucher_meses (idvoucher,idMonth)Values (4,6),(4,7),(4,8),(4,9);
Insert INTO voucher_meses (idvoucher,idMonth)Values (5,2),(5,3),(5,4),(5,5),(5,6),(5,7);
Insert INTO voucher_meses (idvoucher,idMonth)Values (6,2),(6,3),(6,4),(6,5),(6,6),(6,7),(6,8),(6,9),(6,10),(6,11);


select * from voucher_meses

----------------------------Hast aqui me quedo ya esta perfecto esto 

--CREATE TABLE Adeudos
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
CONSTRAINT fk_DebtsExpireMonth FOREIGN KEY (idexpiredMonth) REFERENCES months (idMonth),
);

--Insert Into Adeudos
INSERT INTO debts(idToma,idSanction,idexpiredMonth,expiredYear,createDebts)VALUES(1,2,8,2018,GETDATE());
INSERT INTO debts(idToma,idSanction,idexpiredMonth,expiredYear,createDebts)VALUES(1,2,9,2018,GETDATE());

select * from debts


--CREATE TABLE Recibo Detalles adeudos
CREATE TABLE voucher_debts(
	   idVoucher INTEGER NOT NULL, 
	   idDebts INTEGER NOT NULL,
	   debtsPaidDate DATETIME NOT NULL,
	   CONSTRAINT pk_voucherDebts PRIMARY KEY(idVoucher,idDebts),
	   CONSTRAINT fk_voucherDetail FOREIGN KEY (idVoucher) REFERENCES voucher (idVoucher),
	   CONSTRAINT fk_debtsDetail FOREIGN KEY (idDebts) REFERENCES debts (idDebts),
);



INSERT INTO voucher_debts (idVoucher,idDebts,debtsPaidDate)VALUES(1,1,GETDATE());

----TOMAS ADICIONALES UNA PARTE DOS

--Tabla Toma Adicionales
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

--Insettar Toma Adicionales
INSERT INTO additionalToma(idToma,idConsumer,idTarifa,idStatusToma,descriptionToma,createUser,createDate,editUser,editDate)
						VALUES(1,4,1,1,'',1,GETDATE(),1,GETDATE());


SELECT * FROM additionalToma










