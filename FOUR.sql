/*4.	Напишите скрипт для удаления программного продукта, получившего новый код. Вместе с записью о ПП должны удаляться связанные с ней зависимые записи.*/

USE db_IDZ_Kozlov_v5
GO

DECLARE @id int = 1122;

SELECT * FROM PP
SELECT * FROM Sells

DELETE FROM Sells WHERE PP_code=@id
DELETE FROM PP WHERE PP_code=@id

SELECT * FROM PP
SELECT * FROM Sells
