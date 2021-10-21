--#1 AFTER INSERT
create TRIGGER Trigger_1 
ON comment AFTER INSERT
AS
DECLARE @y INT
BEGIN
  SELECT @y = [id_post] FROM inserted
  UPDATE [dbo].[post]
  SET [views_post] = [views_post] + 1
  WHERE [ID_post] = @y
END


select * from [dbo].[post] where [ID_post] = 5

insert [dbo].[comment]
values
(4, 5, '2020-11-11 12:00:00')

--количество просмотров увеличиваетс€ на 1, при комментировании записи
select * from [dbo].[post] where [ID_post] = 5
go


--#1 AFTER DELETE
CREATE TRIGGER Trigger_2
	ON [dbo].[comment]
	after  DELETE
	AS
BEGIN
DECLARE @idP int;
	SELECT @idP = [id_post] FROM deleted;
	UPDATE [dbo].[post]
	SET [views_post] = [views_post] - 1
	WHERE [ID_post] = @idP;

	DELETE FROM [dbo].[comment] where [id_post] = @idP;
END


select * from [dbo].[post] where [ID_post] = 5

DELETE FROM [dbo].[comment]
	WHERE [id_post] = 5

select * from [dbo].[post] where [ID_post] = 5

go



--є1 AFTER UPDATE
CREATE TABLE blogger_arhiv
(
ID_blogger int,
Name_blogger nvarchar(50),
date_of_birth datetime,
registration_date datetime,
language_blogger nvarchar(50)
);
go

CREATE TRIGGER Trigger_3
	ON [dbo].[post]
	AFTER UPDATE 
AS
BEGIN

	DECLARE @id1 INT, @id2 INT, @N nvarchar (50), @B datetime, @R datetime, @L nvarchar (50);
	SELECT @id1 = [id_blogger] FROM inserted;
	SELECT @id2 = [id_blogger] FROM deleted;	

	select @N = [Name_blogger] from [dbo].[blogger] where [id_blogger] = @id2;
	select @B = [date_of_birth] from [dbo].[blogger] where [id_blogger] = @id2;
	select @R = [registration_date] from [dbo].[blogger] where [id_blogger] = @id2;
	select @L = [language_blogger] from [dbo].[blogger] where [id_blogger] = @id2;

	UPDATE [dbo].[post] SET [id_blogger] = @id1
		WHERE [id_blogger] = @id2;

	INSERT blogger_arhiv
	values (@id2, @N, @B, @R, @L)
END


select * from blogger
select * from blogger_arhiv

UPDATE [dbo].[post]
SET [id_blogger] = 1
where [id_blogger] = 3


select * from blogger
select * from blogger_arhiv
select * from post
go



-------------------------------------------
--#2 INSTEAD OF insert

CREATE VIEW post_view_6  
AS   
SELECT [Name_post], [content], p.[id_blogger], [Name_blogger], [language_blogger]
FROM [dbo].[post] p   
JOIN [dbo].[blogger] b ON b.[ID_blogger] = p.[id_blogger]
go

CREATE TRIGGER Trigger_4
	ON post_view_6
	INSTEAD OF insert
	AS
BEGIN
	DECLARE @NameB NVARCHAR(50), @cont NVARCHAR(50), @NameP NVARCHAR(50), @lan NVARCHAR(50), @ID int;
	SELECT @NameB = [Name_blogger] FROM Inserted;
	SELECT @cont = [content] FROM Inserted;
	SELECT @NameP = [Name_post] FROM Inserted;
	SELECT @lan = [language_blogger] FROM Inserted;
 begin
	INSERT INTO [dbo].[blogger]([Name_blogger], [language_blogger])
	VALUES (@NameB, @lan);
	SELECT @ID = [ID_blogger] FROM [dbo].[blogger]
		WHERE [Name_blogger] = @NameB
	INSERT INTO [dbo].[post] ([content], [Name_post], [id_blogger])
	VALUES (@cont, @NameP, @ID)
end
END


select * from post_view_6

INSERT INTO post_view_6
VALUES 
('5142', 'к1', 1,'»ванов »ван', 'рус')
go

--добавилось в представление и в базовые таблицы
select * from post_view_6
select * from [dbo].[blogger]
select * from [dbo].[post]
go

--#2 INSTEAD OF UPDATE 

CREATE TRIGGER Trigger_6
	ON post_view_6
	INSTEAD OF UPDATE 
AS
BEGIN
	IF(Update([Name_blogger]) or Update([id_blogger]))  
	BEGIN  
		RAISERROR('ѕол€ не могут быть изменены', 16, 10)  
		RETURN  
	END
	
	DECLARE @con1 VARCHAR(50), @con2 VARCHAR(50);
	SELECT @con1 = [content] FROM Inserted;
	SELECT @con2 = [content] FROM Deleted;
	UPDATE [dbo].[post] SET [content] = @con1
		WHERE [content] = @con2;
END

select * from post_view_6
select * from [dbo].[post]

UPDATE post_view_6 SET [content] = 'к2'
WHERE [content] = 'к1';

UPDATE post_view_6 SET [Name_blogger] = 'njkhuh'
WHERE [content] = 'к2'

--изменилось в представлении и в базовой таблице поста
select * from post_view_6
select * from [dbo].[post]
go

--#2 INSTEAD OF DELETE

CREATE TRIGGER Trigger_5
	ON post_view_6
	INSTEAD OF DELETE
AS 
BEGIN
	DECLARE @id INT, @FIO VARCHAR(50);
	SELECT @FIO = [Name_blogger] FROM deleted;
	SELECT @id = [ID_blogger] FROM [dbo].[blogger] WHERE [Name_blogger] = @FIO;

	DELETE FROM [dbo].[post]
		WHERE  [id_blogger] = @id;
	DELETE FROM [dbo].[blogger] WHERE [ID_blogger] = @id;
END

select * from post_view_6
select * from [dbo].[blogger]
select * from [dbo].[post]

DELETE FROM post_view_6
	WHERE [Name_blogger] = '»ванов »ван'


--удалилась строка из представлени€ и базовых таблиц
select * from post_view_6
select * from [dbo].[blogger]
select * from [dbo].[post]
go
