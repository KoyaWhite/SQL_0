/*4.	�������� ������ ��� �������� ������������ ��������, ����������� ����� ���. ������ � ������� � �� ������ ��������� ��������� � ��� ��������� ������.*/

USE db_IDZ_Kozlov_v5
GO

DECLARE @id int = 1122;

SELECT * FROM PP
SELECT * FROM Sells

DELETE FROM Sells WHERE PP_code=@id
DELETE FROM PP WHERE PP_code=@id

SELECT * FROM PP
SELECT * FROM Sells
