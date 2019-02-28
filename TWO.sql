/*2.	Ќапишите запрос, который возвращает все сведени€ о поставщиках, чьи продукты используютс€ дольше (куплены раньше), чем среднее дата покупки продукта по всей базе.*/

USE db_IDZ_Kozlov_v5
GO

SELECT * FROM Seller WHERE S_code IN (
	SELECT S_code FROM Sells WHERE buy_time < (
		SELECT CAST(AVG(CAST(buy_time AS INT)) AS DATETIME) FROM Sells))