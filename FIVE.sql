/*5.	�������� ���������, ������� �� �������� ����������� ����  ��� ������������ �� ��������� ������� ����� (����� �����) ������������� �������� �� ������� ����. � ���� ������������� �ϻ ������ ����� ���� ������ � �������� � ���������� �������. ��� ���������� ���������� �� ��� ���������� ��������� � �������� ��������� ��������� ���������� NULL. ����� ����, ��������� ���������� ������ �� 10 �������� ������������ ��������. �������� ������������� ��������� �������� ��������� � ���������� ��������� ����������� �����������.*/

USE db_IDZ_Kozlov_v5
GO

CREATE PROCEDURE GetDays @name varchar(40) as
declare @date varchar(10)
if (isnumeric(@name)=0) begin --���� ��� ������� ID �� � �������� �������, ��
	IF (SELECT COUNT(*) FROM PP WHERE  PP_name = @name) = 1 --������ �� �����
	--���� ����� ������ ����, �� �����������
		BEGIN
			SET @date = (SELECT DATEDIFF(d, (SELECT Dev_date FROM PP WHERE PP_name = @name), GETDATE()))
			PRINT '���������� ���� ������������� '+@name+' �� ��� ��������: '+ @date
		END
	ELSE PRINT 'NULL' --����� ��������� NULL
end
else begin --����� �� ID
	IF (SELECT COUNT(*) FROM PP WHERE  PP_code = cast (@name as int)) = 1 
		BEGIN
			SET @date = (SELECT DATEDIFF(d, (SELECT Dev_date FROM PP WHERE PP_code = @name), GETDATE()))
			PRINT '���������� ���� ������������� �������� � id = '+(CAST(@name AS varchar))+' �� ��� ��������: '+ @date
		END
	ELSE PRINT 'NULL'
end

SELECT * FROM PP WHERE PP_code IN (
	SELECT TOP(10) PP_code FROM Sells ORDER BY installations DESC);
GO

execute GetDays 'WinDowS 10';
GO