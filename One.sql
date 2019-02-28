/*1.	����� ���������� Transact-SQL ��� �������� ������ � ����������� ��������. ��� ���������� �������� (��� ��) �������� � ����������. ������ � ������� � ����������� �������� ������ ��������� ������, ����������� ��� � ������������. ���� � ���������� ������ ��������� �������, �� ������ � ���������� ���� ���������� �������.*/

USE db_IDZ_Kozlov_v5
GO

DECLARE @code int,
		@i int;

SET @code = 1111;	--���������� � ����� ��
SET @i = (SELECT S_code FROM Sells WHERE PP_code=@code) 
--���������� � ����� ����������� ��� ���������� ��

DELETE FROM Sells WHERE PP_code=@code
DELETE FROM PP WHERE PP_code=@code
--�������� �� � id=@code �� ������� ������ � ������� � ��
IF ((SELECT COUNT(*) FROM Sells WHERE PP_code=@code)<1) begin
	ALTER TABLE Sells DROP CONSTRAINT Sells_con
	DELETE FROM Seller WHERE S_code = @i
	ALTER TABLE Sells ADD CONSTRAINT Sells_con PRIMARY KEY CLUSTERED(PP_code, S_code)
end
--���� � ���������� ������ ��������� �������, �� ������ � ���������� ���� ���������
SELECT * FROM PP
SELECT * FROM Seller