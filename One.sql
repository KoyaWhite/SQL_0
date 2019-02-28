/*1.	Набор операторов Transact-SQL для удаления записи о программном продукте. Код удаляемого продукта (Код ПП) задается в переменной. Вместе с записью о программном продукте должны удаляться записи, связывающие его с поставщиками. Если у поставщика удален последний продукт, то запись о поставщике тоже необходимо удалить.*/

USE db_IDZ_Kozlov_v5
GO

DECLARE @code int,
		@i int;

SET @code = 1111;	--переменная с Кодом ПП
SET @i = (SELECT S_code FROM Sells WHERE PP_code=@code) 
--переменная с Кодом Поставщиком для выбранного ПП

DELETE FROM Sells WHERE PP_code=@code
DELETE FROM PP WHERE PP_code=@code
--удаление ПП с id=@code из таблицы связей и таблицы с ПП
IF ((SELECT COUNT(*) FROM Sells WHERE PP_code=@code)<1) begin
	ALTER TABLE Sells DROP CONSTRAINT Sells_con
	DELETE FROM Seller WHERE S_code = @i
	ALTER TABLE Sells ADD CONSTRAINT Sells_con PRIMARY KEY CLUSTERED(PP_code, S_code)
end
--Если у поставщика удален последний продукт, то запись о поставщике тоже удаляется
SELECT * FROM PP
SELECT * FROM Seller