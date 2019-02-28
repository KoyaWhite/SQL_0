/*5.	Напишите процедуру, которая по заданным параметрами коду  или наименованию ПП вычисляет среднее время (число суток) использования продукта до текущей даты. В поле «Наименование ПП» данные могут быть заданы и большими и маленькими буквами. При отсутствии указанного ПП или нескольких продуктах с заданным названием процедура возвращает NULL. Кроме того, процедура возвращает список из 10 наиболее используемых программ. Наиболее используемыми считаются являются программы с наибольшим суммарным количеством инсталляций.*/

USE db_IDZ_Kozlov_v5
GO

CREATE PROCEDURE GetDays @name varchar(40) as
declare @date varchar(10)
if (isnumeric(@name)=0) begin --если был получен ID НЕ в цифровом формате, то
	IF (SELECT COUNT(*) FROM PP WHERE  PP_name = @name) = 1 --ищется по Имени
	--Если такая строка одна, то выполняется
		BEGIN
			SET @date = (SELECT DATEDIFF(d, (SELECT Dev_date FROM PP WHERE PP_name = @name), GETDATE()))
			PRINT 'Количество дней использования '+@name+' со дня создания: '+ @date
		END
	ELSE PRINT 'NULL' --иначе выводится NULL
end
else begin --Иначе по ID
	IF (SELECT COUNT(*) FROM PP WHERE  PP_code = cast (@name as int)) = 1 
		BEGIN
			SET @date = (SELECT DATEDIFF(d, (SELECT Dev_date FROM PP WHERE PP_code = @name), GETDATE()))
			PRINT 'Количество дней использования продукта с id = '+(CAST(@name AS varchar))+' со дня создания: '+ @date
		END
	ELSE PRINT 'NULL'
end

SELECT * FROM PP WHERE PP_code IN (
	SELECT TOP(10) PP_code FROM Sells ORDER BY installations DESC);
GO

execute GetDays 'WinDowS 10';
GO