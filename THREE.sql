/* 3. C������� ���������, ������� �������� ��������� ���� ������������ �������� (��� ��). ������ � ����� �������� ����� �������� ����������� ���������*/

USE db_IDZ_Kozlov_v5
GO

CREATE PROCEDURE ReplaceID @oldID int, @newID int as
ALTER TABLE Sells DROP CONSTRAINT FK_PP
ALTER TABLE PP DROP CONSTRAINT product_id
ALTER TABLE Sells DROP CONSTRAINT Sells_con
--�������� ������-������
UPDATE Sells SET PP_code = @newID WHERE PP_code = @oldID
UPDATE PP SET PP_code = @newID WHERE PP_code=@oldID
--������ �������� ID � ���� ��������
ALTER TABLE PP ADD CONSTRAINT product_id PRIMARY KEY (PP_code)
ALTER TABLE Sells ADD CONSTRAINT Sells_con PRIMARY KEY CLUSTERED(PP_code, S_code)
ALTER TABLE Sells ADD CONSTRAINT FK_PP FOREIGN KEY (PP_code) REFERENCES PP (PP_code);
--���������� �����
GO
--|--
SELECT * FROM PP
exec ReplaceID 1111, 1112
SELECT * FROM PP