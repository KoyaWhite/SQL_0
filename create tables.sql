/*
База программного обеспечения

Типовые объекты предметной области (сущности):  Программный продукт (ПП),  Поставщик.

Связи объектов
<Программный продукт>   M  ------ N  < Поставщик >
Атрибуты сущностей:
Программный продукт
?	Код ПП,
?	Наименование ПП,
?	№ версии,
?	Год выпуска,
?	Разработчик,
?	Адрес сайта разработчика,
?	Место нахождения дистрибутива (Unicode до 100 символов).

Поставщик (продавец)
?	Код поставщика,
?	Наименование поставщика,
?	Адрес сайта поставщика

Связь < Программный продукт >   M  ------ N  < Поставщик >
  имеет атрибуты: 
?	Дата покупки,
?	Количество инсталляций,
?	Цена.

*/
USE [db_IDZ_Kozlov_v5]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE if exists Sells
DROP TABLE if exists PP
DROP TABLE if exists Seller

CREATE TABLE PP(
	[PP_code] int NOT NULL 
		CONSTRAINT [product_id] PRIMARY KEY CLUSTERED,
	[PP_name] varchar(40) NOT NULL,
	[Version] varchar(10) NOT NULL DEFAULT ('1.0'),
	[Dev_date] datetime NOT NULL,
	[Developer] varchar(40) NOT NULL,
	[Site_of_dev] varchar(40) NULL DEFAULT 'unknown',
	[Place] nvarchar(100) NULL DEFAULT 'unknown',
	) ON FIRST_GROUP

CREATE TABLE Seller(
	[S_code] int  NOT NULL 
		CONSTRAINT [seller_id] PRIMARY KEY CLUSTERED,
	[S_name] varchar(40) NOT NULL,
	[S_site] varchar(40) NULL DEFAULT 'unknown'
	) ON SECOND_GROUP

CREATE TABLE Sells (
	[PP_code] int NOT NULL CONSTRAINT [FK_PP] REFERENCES [dbo].[PP] ([PP_code]),
	[S_code] int NOT NULL CONSTRAINT [FK_S] REFERENCES [dbo].[Seller] ([S_code]),
	[buy_time] datetime NOT NULL DEFAULT (GETDATE()),
	[installations] int NULL DEFAULT '0',
	[Price] money  NOT NULL DEFAULT ('0'),
	CONSTRAINT [Sells_con] PRIMARY KEY CLUSTERED(PP_code, S_code)
	) ON SECOND_GROUP
GO

SET DATEFORMAT dmy
INSERT INTO PP (PP_code, PP_name, Version, Dev_date, Developer, Place) VALUES
	(1111,'Windows 7',DEFAULT,'22/07/2009','Microsoft','USA'),
	(1321,'Office 2016',DEFAULT,'01/01/2016','Microsoft','USA'),
	(1231,'Skype',DEFAULT,'01/8/2009','Microsoft','USA'),
	(1345,'Visual Studio',DEFAULT,'1/1/1997','Microsoft','USA'),
	(6511,'MS SQL SERVER',DEFAULT,'24/4/1989','Microsoft','USA'),
	(1121,'Windows 7','v2.1','22/07/2018','Microsoft','USA'),
	(1122,'Windows 10',DEFAULT,'29/07/2015','Microsoft','USA'),
	(2211,'Nod32',DEFAULT,'01/11/1987','Eset','Slovensko'),
	(3311,'CCleaner','5.50.6911','23/09/2003','Piriform Limited','UK'),
	(3131,'Speccy','1.32.740','20/11/2009','Piriform Limited','UK'),
	(3421,'Defraggler','2.22.995','21/03/2007','Piriform Limited','UK'),
	(6930,'Recuva','1.53.1087','6/7/2007','Piriform Limited','UK');

INSERT INTO Seller (S_code, S_name) VALUES
	(11,'Microsoft Store'),
	(22,'Open access'),
	(33,'DNS'),
	(44,'Not an Open access'),
	(55,'Tech store'),
	(66,'OS seller'),
	(77,'Pyrate.BY'),
	(88,'Eset store'),
	(99,'Freeware'),
	(101,'Unknown');

INSERT INTO Sells (PP_code, S_code, buy_time, installations, Price) VALUES
	(1111,11,'2/10/2010',1256000,3500),
	(1122,11,'1/8/2015',980000 ,7250),
	(1321,101,'1/8/2016',750000 ,2050),
	(1231,66,'5/8/2009',230000 ,0),
	(1345,55,'1/2/1997',42000 ,1100),
	(6511,99,'1/5/1989',37000 ,0),
	(1121,88,'1/8/2018',5000000 ,777),
	(3311,77,'13/12/1988',264000 ,0),
	(3131,22,'22/11/2009',112000 ,35000),
	(3421,44,'1/4/2007',48000 ,0),
	(6930,22,'1/9/2007',3050 ,0),
	(2211,33,'22/10/2004',117000 ,980);
	
SELECT * FROM PP
SELECT * FROM Sells
SELECT * FROM Seller




