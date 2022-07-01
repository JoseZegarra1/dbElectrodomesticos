USE master 
GO
DROP DATABASE IF EXISTS dbElectrodomesticos 
GO

CREATE DATABASE dbElectrodomesticos;
GO

USE dbElectrodomesticos;
GO

CREATE TABLE CLIENTE(
CODCLI char(4) NOT NULL,
NOMCLI varchar(60) NOT NULL,
APECLI varchar(80) NOT NULL,
EMACLI varchar(80) NOT NULL,
CELCLI char(9),
DIRCLI varchar(80) NOT NULL,
ESTCLI char(1) NOT NULL,
CONSTRAINT CLIENTE_pk PRIMARY KEY(CODCLI)
);
GO

CREATE TABLE VENDEDOR(
CODVEND char(4) NOT NULL,
NOMVEND varchar(60) NOT NULL,
APEVEND varchar(80) NOT NULL,
EMAVEND varchar(80) NOT NULL,
CELVEND char(9),
DIRVEND varchar(80) NOT NULL,
ESTVEND char(1) NOT NULL,
CONSTRAINT VENDEDOR_pk PRIMARY KEY(CODVEND)
);
GO

CREATE TABLE PRODUCTO(
CODPRO char(5) NOT NULL,
DESCPRO varchar(150) NOT NULL,
CATPRO varchar(80) NOT NULL,
PREPRO varchar(80) NOT NULL,
STOCKPRO int NOT NULL,
ESTPRO char(1) NOT NULL,
CONSTRAINT Producto_pk PRIMARY KEY(CODPRO)
)
GO

CREATE TABLE PROVEEDOR(
CODPROV char(5) NOT NULL,
RAZSOCPROV varchar(90) NOT NULL,
RUCPROV char(11) NOT NULL,
EMAPROV varchar(80) NOT NULL,
ESTPROV char(1) NOT NULL,
CONSTRAINT PROVEEDOR_pk PRIMARY KEY(CODPROV)
);
GO


CREATE TABLE VENTA(
CODVEN char(5) NOT NULL,
FECVEN datetime NOT NULL,
CODCLI char(4) NOT NULL,
CODVEND char(4) NOT NULL,
ESTVEN char(1) NOT NULL,
CONSTRAINT VENTA_pk PRIMARY KEY(CODVEN)
)
GO

CREATE TABLE VENTA_DETALLE(
IDVENDET int identity (1,1) NOT NULL,
CODVEN char(5) NOT NULL,
CODPRO char(5) NOT NULL,
CANTPRO int NOT NULL,
CONSTRAINT VENTA_DETALLE_pk PRIMARY KEY(IDVENDET)
)
GO

CREATE TABLE COMPRA(
CODCOM char(5) NOT NULL,
FECCOM datetime NOT NULL,
CODPROV char(5) NOT NULL,
CODVEND char(4) NOT NULL,
ESTCOM char(1) NOT NULL,
CONSTRAINT COMPRA_pk PRIMARY KEY(CODCOM)
);
GO

CREATE TABLE COMPRA_DETALLE(
IDCOMDET int identity (1,1) NOT NULL,
CODCOM char(5) NOT NULL,
CODPRO char(5) NOT NULL,
CANTPRO int NOT NULL,
CONSTRAINT COMPRA_DETALLE_pk PRIMARY KEY(IDCOMDET)
);
GO

-- RELACION VENTA VENTA DETALLE
ALTER TABLE VENTA_DETALLE ADD CONSTRAINT VENTA_DETALLE_VENTA
    FOREIGN KEY (CODVEN)
    REFERENCES VENTA (CODVEN)
GO

-- COMPRA DETALLE PRODUCTO
ALTER TABLE COMPRA_DETALLE ADD CONSTRAINT COMPRA_DETALLE_PRODUCTO
    FOREIGN KEY (CODPRO)
    REFERENCES PRODUCTO (CODPRO);
GO

-- VENTA DETALLE PRODUCTO
ALTER TABLE VENTA_DETALLE ADD CONSTRAINT VENTA_DETALLE_PRODUCTO
    FOREIGN KEY (CODPRO)
    REFERENCES PRODUCTO (CODPRO);
GO

-- COMPRA_DETALLE - COMPRA
ALTER TABLE COMPRA_DETALLE ADD CONSTRAINT COMPRA_DETALLE_COMPRA
    FOREIGN KEY (CODCOM)
    REFERENCES COMPRA (CODCOM)
GO

-- VENTA - VENDEDOR
ALTER TABLE VENTA ADD CONSTRAINT VENTA_VENDEDOR
    FOREIGN KEY (CODVEND)
    REFERENCES VENDEDOR (CODVEND)
GO

-- VENTA - CLIENTE
ALTER TABLE VENTA ADD CONSTRAINT VENTA_CLIENTE
    FOREIGN KEY (CODCLI)
    REFERENCES CLIENTE (CODCLI)
GO

--COMPRA - VENDEDOR
ALTER TABLE COMPRA ADD CONSTRAINT COMPRA_VENDEDOR
    FOREIGN KEY (CODVEND)
    REFERENCES VENDEDOR (CODVEND)
GO

--COMPRA - PROVEEDOR
ALTER TABLE COMPRA ADD CONSTRAINT COMPRA_PROVEEDOR
    FOREIGN KEY (CODPROV)
    REFERENCES PROVEEDOR (CODPROV)
GO

insert into CLIENTE values
('CL01','Juana','Campos Ortiz','juana.campos@gmail.com','987485152','Av. Miraflores','A'),
('CL02','Sofia','Barrios Salcedo','sofia.barrios@outlook.com','','Jr. Huallaga','A'),
('CL03','Claudio','Perez Luna','claudio.perez@outlook.com','','Av. Libertadores','A'),
('CL04','Marcos','Avila Manco','marcos.avila@yahoo.com','','Calle Huallaga','A'),
('CL05','Anastasio','Salomon Inti','anastasio.salomon@gmail.com','','Jr. San Martin','A');

insert into VENDEDOR values
('VEN1','Gloria','Carrizales Paredes','gloria.carrizales@gmail.com','984574123','Calle Las Begonias','A'),
('VEN2','Sofia','Lozada Lombardi','gabriel.lozada@gmail.com','974512368','Av. Los Girasoles','A'),
('VEN3','Gilberto','Martinez Guerra','gilberto.martinez@gmail.com','','Jr. San Martin','A');

insert into PROVEEDOR values
('PRV01','LG Corportation','87542136951','informes@lg.com.pe','A'),
('PRV02','SONY','45213698741','informes@sony.com.pe','A'),
('PRV03','SAMSUNG','85321697661','informes@samsung.com.pe','A'),
('PRV04','OSTER SRL','55663214478','informes@oster.com.pe','A'),
('PRV05','ASUS','99663325478','informes@asus.com.pe','A');

insert into PRODUCTO values
('PRO01','Refrigeradora LG Side By Side','1','4149','15','A'),
('PRO02','Refrigeradora Sbs 602L','1','3599','10','A'),
('PRO03','Refrigeradora Top Mount 500 L','1','2799','8','A'),
('PRO04','TV SAMSUNG UHD 55"','1','1799','25','A'),
('PRO05','Televisor 65" LG UHD 4k ','1','2999','20','A'),
('PRO06','TV CRYSTAS UHD 55','1','2299','7','A'),
('PRO07','ASUS X415JA Core i3 10a Gen 14"','1','1099','17','A'),
('PRO08','Lenovo IdeaPad 5i Intel Core i7 14"','1','3099','10','A'),
('PRO09','Laptop HP 15-dw1085la Intel Core i3','1','1600','15','A'),
('PRO10','Galaxy A52 128GB','1','1200','25','A'),
('PRO11','Iphone 11 64gb Morado','1','2600','30','A'),
('PRO12','Poco X3 GT 5G 256GB 8GB','1','1450','20','A');


use  dbElectrodomesticos
go

CREATE PROCEDURE spVenta
    @CODVEN CHAR(5),
    @FECVEN DATETIME,
    @CODCLI CHAR(4),
    @CODVEND CHAR(4),
    @ESTVEN CHAR(1)
  
AS
BEGIN
INSERT INTO
VENTA (
	    CODVEN,
	   FECVEN,
	   CODCLI,
	   CODVEND,
	   ESTVEN)
    VALUES (
	   @CODVEN,
	   GETDATE(),
	   @CODCLI,
	   @CODVEND,
	   @ESTVEN)
 
SELECT 
	   CODVEN = @CODVEN,
	   FECVEN = @FECVEN,
	   Email = @CODCLI,
	   CODVEND =@CODVEND,
	   ESTVEN = @ESTVEN
FROM VENTA
WHERE  CODVEN = @CODVEN
END
GO
